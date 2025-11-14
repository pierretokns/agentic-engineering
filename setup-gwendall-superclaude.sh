#!/bin/bash

# setup-gwendall-superclaude.sh
# Installation script for SuperClaude - AI-powered GitHub workflow enhancement tool
# Repository: https://github.com/gwendall/superclaude

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Global variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SUPERCLAUDE_DIR="$SCRIPT_DIR/superclaude"
TEMP_DIR="/tmp/superclaude-setup-$$"
REPO_URL="https://github.com/gwendall/superclaude"
RAW_BASE_URL="https://raw.githubusercontent.com/gwendall/superclaude/main"

# Helper functions
print_header() {
    printf "${PURPLE}🔮 %s${NC}\n" "$1"
    echo
}

print_step() {
    printf "${BLUE}%s${NC}\n" "$1"
}

print_success() {
    printf "${GREEN}✅ %s${NC}\n" "$1"
}

print_error() {
    printf "${RED}❌ %s${NC}\n" "$1"
}

print_warning() {
    printf "${YELLOW}⚠️  %s${NC}\n" "$1"
}

print_info() {
    printf "${CYAN}ℹ️  %s${NC}\n" "$1"
}

# Cleanup function
cleanup() {
    if [[ -d "$TEMP_DIR" ]]; then
        rm -rf "$TEMP_DIR"
    fi
}

# Set trap for cleanup
trap cleanup EXIT

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Download file with curl or wget fallback
download_file() {
    local url="$1"
    local output="$2"
    local description="${3:-file}"

    print_step "Downloading $description..."

    if command_exists curl; then
        curl -fsSL "$url" -o "$output" || {
            print_error "Failed to download $description using curl"
            return 1
        }
    elif command_exists wget; then
        wget -q "$url" -O "$output" || {
            print_error "Failed to download $description using wget"
            return 1
        }
    else
        print_error "Neither curl nor wget is available. Please install one of them."
        return 1
    fi

    print_success "Downloaded $description"
}

# Check system dependencies
check_dependencies() {
    print_header "Checking System Dependencies"

    local missing_deps=()

    # Check Node.js
    if command_exists node; then
        local node_version=$(node --version)
        print_success "Node.js found: $node_version"

        # Check if version is 18+
        local node_major=$(echo "$node_version" | sed 's/v//' | cut -d. -f1)
        if [[ $node_major -lt 18 ]]; then
            print_error "Node.js version 18+ is required. Current version: $node_version"
            missing_deps+=("node-18+")
        fi
    else
        print_error "Node.js not found"
        missing_deps+=("node")
    fi

    # Check npm
    if command_exists npm; then
        local npm_version=$(npm --version)
        print_success "npm found: $npm_version"
    else
        print_error "npm not found"
        missing_deps+=("npm")
    fi

    # Check Git
    if command_exists git; then
        local git_version=$(git --version)
        print_success "Git found: $git_version"
    else
        print_error "Git not found"
        missing_deps+=("git")
    fi

    # Check Claude Code
    if command_exists claude; then
        local claude_version=$(claude --version 2>/dev/null || echo "unknown")
        print_success "Claude Code found: $claude_version"
    else
        print_warning "Claude Code not found (optional but recommended)"
        echo "  Install with: npm install -g @anthropic-ai/claude-code"
    fi

    # Check GitHub CLI (optional)
    if command_exists gh; then
        local gh_version=$(gh --version | head -1 | cut -d' ' -f3)
        print_success "GitHub CLI found: $gh_version"
    else
        print_warning "GitHub CLI not found (optional but recommended)"
        echo "  Install with: brew install gh"
    fi

    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        echo
        print_error "Missing required dependencies: ${missing_deps[*]}"
        echo
        print_info "Installation commands:"
        echo "  Node.js: https://nodejs.org/en/download/"
        echo "  macOS: brew install node"
        echo "  Ubuntu: apt install nodejs npm"
        exit 1
    fi

    echo
}

# Create directory structure
create_directories() {
    print_header "Creating Directory Structure"

    # Remove existing installation if present
    if [[ -d "$SUPERCLAUDE_DIR" ]]; then
        print_step "Removing existing SuperClaude installation..."
        rm -rf "$SUPERCLAUDE_DIR"
    fi

    # Create directories
    print_step "Creating SuperClaude directory structure..."
    mkdir -p "$SUPERCLAUDE_DIR/bin"
    mkdir -p "$SUPERCLAUDE_DIR/prompts"
    mkdir -p "$SUPERCLAUDE_DIR/docs"

    print_success "Directory structure created"
    echo
}

# Download main executable
download_executable() {
    print_header "Downloading SuperClaude Executable"

    local executable_url="$RAW_BASE_URL/bin/superclaude"
    local executable_path="$SUPERCLAUDE_DIR/bin/superclaude"

    download_file "$executable_url" "$executable_path" "main executable"

    # Make it executable
    chmod +x "$executable_path"
    print_success "Made executable: $executable_path"
    echo
}

# Download prompt templates
download_prompts() {
    print_header "Downloading AI Prompt Templates"

    local prompts=(
        "commit.md"
        "changelog.md"
        "annotation.md"
        "daily-changelog.md"
        "weekly-changelog.md"
        "monthly-changelog.md"
    )

    for prompt in "${prompts[@]}"; do
        local prompt_url="$RAW_BASE_URL/prompts/$prompt"
        local prompt_path="$SUPERCLAUDE_DIR/prompts/$prompt"

        download_file "$prompt_url" "$prompt_path" "prompt template: $prompt"
    done

    echo
}

# Download configuration files
download_config() {
    print_header "Downloading Configuration Files"

    # Download package.json
    local package_url="$RAW_BASE_URL/package.json"
    local package_path="$SUPERCLAUDE_DIR/package.json"

    download_file "$package_url" "$package_path" "package.json"

    # Download README.md
    local readme_url="$RAW_BASE_URL/README.md"
    local readme_path="$SUPERCLAUDE_DIR/README.md"

    download_file "$readme_url" "$readme_path" "README.md"

    # Download LICENSE
    local license_url="$RAW_BASE_URL/LICENSE"
    local license_path="$SUPERCLAUDE_DIR/LICENSE"

    download_file "$license_url" "$license_path" "LICENSE"

    # Download .gitignore
    local gitignore_url="$RAW_BASE_URL/.gitignore"
    local gitignore_path="$SUPERCLAUDE_DIR/.gitignore"

    download_file "$gitignore_url" "$gitignore_path" ".gitignore"

    echo
}

# Create symbolic link for global access
create_symlink() {
    print_header "Creating Global Command Link"

    local local_bin="$HOME/.local/bin"
    local symlink_path="$local_bin/superclaude"
    local target_path="$SUPERCLAUDE_DIR/bin/superclaude"

    # Create ~/.local/bin if it doesn't exist
    if [[ ! -d "$local_bin" ]]; then
        print_step "Creating $local_bin directory..."
        mkdir -p "$local_bin"
    fi

    # Remove existing symlink if present
    if [[ -L "$symlink_path" ]]; then
        print_step "Removing existing symlink..."
        rm "$symlink_path"
    fi

    # Create new symlink
    print_step "Creating symbolic link..."
    ln -s "$target_path" "$symlink_path"

    print_success "Created symlink: $symlink_path -> $target_path"
    echo
}

# Update PATH if needed
update_path() {
    print_header "Updating PATH Configuration"

    local local_bin="$HOME/.local/bin"

    # Check if ~/.local/bin is in PATH
    if echo ":$PATH:" | grep -q ":$local_bin:"; then
        print_success "$local_bin is already in PATH"
    else
        print_warning "$local_bin is not in PATH"
        print_info "Add the following to your shell profile (~/.bashrc, ~/.zshrc, etc.):"
        echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
        echo

        # Attempt to add to common shell profiles
        local profiles=("$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile")
        local updated=false

        for profile in "${profiles[@]}"; do
            if [[ -f "$profile" ]] && ! grep -q "$local_bin" "$profile"; then
                print_step "Adding PATH to $profile..."
                echo "" >> "$profile"
                echo "# Added by SuperClaude setup script" >> "$profile"
                echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$profile"
                print_success "Updated $profile"
                updated=true
                break
            fi
        done

        if [[ $updated == false ]]; then
            print_info "No shell profile found. Please manually add the PATH export."
        fi
    fi

    echo
}

# Verify installation
verify_installation() {
    print_header "Verifying Installation"

    local executable_path="$SUPERCLAUDE_DIR/bin/superclaude"
    local symlink_path="$HOME/.local/bin/superclaude"

    # Check if executable exists and is executable
    if [[ -x "$executable_path" ]]; then
        print_success "Executable found: $executable_path"
    else
        print_error "Executable not found or not executable: $executable_path"
        return 1
    fi

    # Check if symlink exists
    if [[ -L "$symlink_path" ]]; then
        print_success "Symlink found: $symlink_path"
    else
        print_warning "Symlink not found: $symlink_path"
    fi

    # Check if prompts directory exists and contains files
    local prompts_dir="$SUPERCLAUDE_DIR/prompts"
    if [[ -d "$prompts_dir" ]]; then
        local prompt_count=$(find "$prompts_dir" -name "*.md" | wc -l)
        print_success "Found $prompt_count prompt templates"
    else
        print_error "Prompts directory not found: $prompts_dir"
        return 1
    fi

    # Test the command (if available in PATH)
    if command_exists superclaude; then
        print_step "Testing superclaude command..."
        if superclaude --version >/dev/null 2>&1; then
            print_success "SuperClaude command is working"
        else
            print_warning "SuperClaude command found but may have issues"
        fi
    else
        print_warning "SuperClaude command not found in PATH (you may need to restart your shell)"
    fi

    echo
}

# Show usage instructions
show_usage_instructions() {
    print_header "Usage Instructions"

    echo "SuperClaude has been installed to: $SUPERCLAUDE_DIR"
    echo
    print_info "Basic Usage:"
    echo "  superclaude --verify     # Check dependencies and authentication"
    echo "  superclaude commit       # AI-powered commit messages"
    echo "  superclaude changelog    # Generate intelligent changelogs"
    echo "  superclaude readme       # Create comprehensive documentation"
    echo "  superclaude review       # AI code review and analysis"
    echo
    print_info "Interactive Mode:"
    echo "  superclaude commit --interactive"
    echo
    print_info "Verbose Mode (see AI thinking process):"
    echo "  superclaude commit --verbose"
    echo
    print_info "Project Integration (add to package.json):"
    echo '  {"scripts": {'
    echo '    "commit": "superclaude commit --interactive",'
    echo '    "release:prep": "superclaude changelog && superclaude readme"'
    echo '  }}'
    echo
    print_info "For more information, see:"
    echo "  $SUPERCLAUDE_DIR/README.md"
    echo "  $REPO_URL"
    echo
}

# Main installation function
main() {
    print_header "SuperClaude Installation Script"
    print_info "Installing SuperClaude from $REPO_URL"
    print_info "Installation directory: $SUPERCLAUDE_DIR"
    echo

    # Check dependencies
    check_dependencies

    # Create directories
    create_directories

    # Download components
    download_executable
    download_prompts
    download_config

    # Create global access
    create_symlink
    update_path

    # Verify installation
    verify_installation

    # Show usage instructions
    show_usage_instructions

    print_success "SuperClaude installation completed successfully! 🎉"
    echo
    print_info "Note: You may need to restart your shell or run 'source ~/.bashrc' (or ~/.zshrc) to use the 'superclaude' command."
}

# Handle script arguments
case "${1:-}" in
    --help|-h)
        echo "SuperClaude Installation Script"
        echo
        echo "Usage: $0 [OPTIONS]"
        echo
        echo "Options:"
        echo "  --help, -h     Show this help message"
        echo "  --uninstall    Remove SuperClaude installation"
        echo
        exit 0
        ;;
    --uninstall)
        print_header "Uninstalling SuperClaude"
        print_step "Removing installation directory: $SUPERCLAUDE_DIR"
        rm -rf "$SUPERCLAUDE_DIR"

        symlink_path="$HOME/.local/bin/superclaude"
        if [[ -L "$symlink_path" ]]; then
            print_step "Removing symlink: $symlink_path"
            rm "$symlink_path"
        fi

        print_success "SuperClaude uninstalled successfully"
        exit 0
        ;;
    "")
        # No arguments, run main installation
        main
        ;;
    *)
        print_error "Unknown option: $1"
        echo "Use --help for usage information"
        exit 1
        ;;
esac