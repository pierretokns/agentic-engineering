#!/bin/bash

# setup-dimitritholen-gustav.sh
#
# Setup script for Gustav - Sprint orchestration framework for Claude Code
# Downloads and installs Gustav commands from https://github.com/dimitritholen/gustav
#
# Usage: ./setup-dimitritholen-gustav.sh

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO="dimitritholen/gustav"
BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}"
CLAUDE_DIR=".claude"
COMMANDS_DIR="${CLAUDE_DIR}/commands"
GUSTAV_DIR="${COMMANDS_DIR}/gustav"
UTILS_DIR="${GUSTAV_DIR}/utils"

# Function to print colored output
print_status() {
    echo -e "${BLUE}📋 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Function to display Gustav banner
show_gustav_banner() {
    cat << 'EOF'
●
 ██████   ██    ██  ███████  ████████   █████   ██    ██
██        ██    ██  ██          ██     ██   ██  ██    ██
██   ███  ██    ██  ███████     ██     ███████  ██    ██
██    ██  ██    ██       ██     ██     ██   ██   ██  ██
 ██████    ██████   ███████     ██     ██   ██    ████

                A sprint orchestrator
                ---------------------

EOF
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to create directory if it doesn't exist
ensure_directory() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        print_success "Created directory: $dir"
    fi
}

# Function to download file with error handling
download_file() {
    local url="$1"
    local output="$2"
    local description="$3"

    print_status "Downloading $description..."

    if command_exists curl; then
        if curl -fsSL "$url" -o "$output"; then
            print_success "Downloaded: $description"
            return 0
        else
            print_error "Failed to download: $description"
            return 1
        fi
    elif command_exists wget; then
        if wget -q "$url" -O "$output"; then
            print_success "Downloaded: $description"
            return 0
        else
            print_error "Failed to download: $description"
            return 1
        fi
    else
        print_error "Neither curl nor wget is available. Please install one of them."
        return 1
    fi
}

# Function to verify file was downloaded and is not empty
verify_file() {
    local file="$1"
    local description="$2"

    if [ ! -f "$file" ]; then
        print_error "$description not found after download"
        return 1
    fi

    if [ ! -s "$file" ]; then
        print_error "$description is empty after download"
        return 1
    fi

    return 0
}

# Function to check if repository is accessible
check_repository() {
    print_status "Checking repository accessibility..."

    if curl -fsSL "https://api.github.com/repos/${REPO}" >/dev/null 2>&1; then
        print_success "Repository is accessible"
        return 0
    else
        print_error "Repository is not accessible. Check internet connection and repository name."
        return 1
    fi
}

# Function to install main command files
install_command_files() {
    print_status "Installing Gustav command files..."

    # List of main command files
    local commands=(
        "planner.md"
        "executor.md"
        "enhance.md"
        "validator.md"
        "velocity.md"
        "audit.md"
        "help.md"
    )

    local download_count=0
    local total_files=${#commands[@]}

    for cmd in "${commands[@]}"; do
        local url="${BASE_URL}/.claude/commands/gustav/${cmd}"
        local output="${GUSTAV_DIR}/${cmd}"

        if download_file "$url" "$output" "command file: $cmd"; then
            if verify_file "$output" "$cmd"; then
                download_count=$((download_count + 1))
            fi
        fi
    done

    print_success "Downloaded $download_count/$total_files command files"

    if [ $download_count -eq $total_files ]; then
        return 0
    else
        print_warning "Some command files failed to download"
        return 1
    fi
}

# Function to install utility Python files
install_utility_files() {
    print_status "Installing Gustav utility files..."

    # List of utility files
    local utilities=(
        "utils/dependency_analyzer.py"
        "utils/enhance_cli.py"
        "utils/executor_cli.py"
        "utils/json_updater.py"
        "utils/research_integrator.py"
        "utils/task_inserter.py"
        "utils/test_enhance_system.py"
        "utils/velocity_cli.py"
    )

    local download_count=0
    local total_files=${#utilities[@]}

    for util in "${utilities[@]}"; do
        local url="${BASE_URL}/.claude/commands/gustav/${util}"
        local output="${GUSTAV_DIR}/${util}"

        if download_file "$url" "$output" "utility file: $util"; then
            if verify_file "$output" "$util"; then
                # Make Python files executable
                if [[ "$util" == *.py ]]; then
                    chmod +x "$output"
                fi
                download_count=$((download_count + 1))
            fi
        fi
    done

    print_success "Downloaded $download_count/$total_files utility files"

    if [ $download_count -eq $total_files ]; then
        return 0
    else
        print_warning "Some utility files failed to download"
        return 1
    fi
}

# Function to verify installation
verify_installation() {
    print_status "Verifying installation..."

    local required_commands=(
        "${GUSTAV_DIR}/planner.md"
        "${GUSTAV_DIR}/executor.md"
        "${GUSTAV_DIR}/enhance.md"
        "${GUSTAV_DIR}/validator.md"
        "${GUSTAV_DIR}/velocity.md"
        "${GUSTAV_DIR}/audit.md"
        "${GUSTAV_DIR}/help.md"
    )

    local required_utilities=(
        "${UTILS_DIR}/executor_cli.py"
        "${UTILS_DIR}/json_updater.py"
        "${UTILS_DIR}/dependency_analyzer.py"
    )

    local missing_files=()

    # Check command files
    for cmd in "${required_commands[@]}"; do
        if [ ! -f "$cmd" ] || [ ! -s "$cmd" ]; then
            missing_files+=("$cmd")
        fi
    done

    # Check utility files
    for util in "${required_utilities[@]}"; do
        if [ ! -f "$util" ] || [ ! -s "$util" ]; then
            missing_files+=("$util")
        fi
    done

    if [ ${#missing_files[@]} -eq 0 ]; then
        print_success "All required files installed successfully"
        return 0
    else
        print_error "Missing or empty files:"
        for file in "${missing_files[@]}"; do
            echo "  - $file"
        done
        return 1
    fi
}

# Function to show usage information
show_usage() {
    echo
    print_success "Gustav commands installed successfully!"
    echo
    echo "Available commands:"
    echo "  /gustav:planner <PRD PATH>     - Create sprint plan from PRD"
    echo "  /gustav:executor [task-id]      - Execute tasks or specific task"
    echo "  /gustav:enhance [description]   - Add features to existing sprint"
    echo "  /gustav:validator [milestone]   - Validate milestone completion"
    echo "  /gustav:velocity [sprint-id]    - Analyze sprint performance"
    echo "  /gustav:audit [scope]           - Security compliance scan"
    echo "  /gustav:help                    - Show help information"
    echo
    echo "Quick Start:"
    echo "  1. Create a Product Requirements Document (PRD)"
    echo "  2. Run: /gustav:planner <PRD PATH>"
    echo "  3. Run: /gustav:executor"
    echo "  4. Validate milestones: /gustav:validator"
    echo "  5. Monitor progress: /gustav:velocity"
    echo
    echo "For more information, visit: https://github.com/dimitritholen/gustav"
    echo
}

# Function to cleanup on error
cleanup_on_error() {
    print_error "Installation failed. Cleaning up..."
    if [ -d "${GUSTAV_DIR}" ]; then
        rm -rf "${GUSTAV_DIR}"
        print_status "Removed incomplete installation directory"
    fi
}

# Check if .claude directory exists
if [[ -d ".claude" ]]; then
    print_warning ".claude directory already exists"
    read -p "Do you want to continue and potentially overwrite existing gustav commands? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Setup cancelled"
        exit 0
    fi
fi

# Main installation function
main() {
    echo
    show_gustav_banner
    print_status "Gustav Setup Script"
    print_status "==================="
    echo
    print_status "Installing Gustav sprint orchestration framework..."
    echo

    # Set up error handling
    trap cleanup_on_error ERR

    # Check prerequisites
    if ! command_exists curl && ! command_exists wget; then
        print_error "Neither curl nor wget is available. Please install one of them."
        exit 1
    fi

    # Check repository accessibility
    if ! check_repository; then
        exit 1
    fi

    # Create directory structure
    ensure_directory "$CLAUDE_DIR"
    ensure_directory "$COMMANDS_DIR"
    ensure_directory "$GUSTAV_DIR"
    ensure_directory "$UTILS_DIR"

    # Install files
    local install_success=0

    if install_command_files && install_utility_files; then
        install_success=1
    fi

    # Verify installation
    if verify_installation && [ $install_success -eq 1 ]; then
        show_usage
        print_success "Gustav installation completed successfully!"
    else
        print_error "Gustav installation failed. Please check the errors above."
        exit 1
    fi

}

# Run main function
main "$@"
