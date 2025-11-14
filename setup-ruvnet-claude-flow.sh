#!/bin/bash

# setup-ruvnet-claude-flow.sh
# Setup script for ruvnet/claude-flow repository
# Downloads and configures the complete claude-flow agent structure

set -euo pipefail

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Repository information
readonly REPO_OWNER="ruvnet"
readonly REPO_NAME="claude-flow"
readonly REPO_URL="https://github.com/${REPO_OWNER}/${REPO_NAME}"
readonly RAW_URL="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/main"

# Local directories
readonly CLAUDE_DIR=".claude"
readonly BACKUP_DIR=".claude.backup.$(date +%Y%m%d_%H%M%S)"

# List of agent directories to create
readonly AGENT_DIRS=(
    "agents/analysis"
    "agents/architecture/system-design"
    "agents/consensus"
    "agents/core"
    "agents/data/ml"
    "agents/development/backend"
    "agents/devops/ci-cd"
    "agents/documentation/api-docs"
    "agents/flow-nexus"
    "agents/github"
    "agents/goal"
    "agents/hive-mind"
    "agents/neural"
    "agents/optimization"
    "agents/reasoning"
    "agents/sparc"
    "agents/specialized/mobile"
    "agents/swarm"
    "agents/templates"
    "agents/testing"
)

# List of directories to create
readonly OTHER_DIRS=(
    "cache"
    "checkpoints"
    "commands"
    "config"
    "helpers"
    "sessions"
    "skills"
    "templates"
)

# List of config files to download
readonly CONFIG_FILES=(
    "config.json"
    "optimized-settings.json"
    "settings-checkpoint-example.json"
    "settings-checkpoint-simple.json"
    "settings-complete.json"
    "settings-enhanced.json"
    "settings-github-npx.json"
    "settings-npx-hooks.json"
    "settings.json"
    "settings.reasoningbank-example.json"
    "settings.reasoningbank-minimal.json"
    "sparc-modes.json"
)

# List of shell scripts to download
readonly SCRIPT_FILES=(
    "statusline-command.sh"
    "test-reasoningbank-hooks.sh"
)

# Core agent files
readonly CORE_AGENT_FILES=(
    "core/coder.md"
    "core/planner.md"
    "core/researcher.md"
    "core/reviewer.md"
    "core/tester.md"
)

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Error handling
error_exit() {
    log_error "$1"
    exit 1
}

# Check if required tools are available
check_dependencies() {
    local missing_deps=()

    if ! command -v curl >/dev/null 2>&1; then
        missing_deps+=("curl")
    fi

    if ! command -v jq >/dev/null 2>&1; then
        missing_deps+=("jq")
    fi

    if [ ${#missing_deps[@]} -ne 0 ]; then
        error_exit "Missing required dependencies: ${missing_deps[*]}. Please install them first."
    fi

    log_success "All dependencies are available"
}

# Create backup of existing .claude directory if it exists
create_backup() {
    if [ -d "$CLAUDE_DIR" ]; then
        log_warning "Existing .claude directory found. Creating backup at $BACKUP_DIR"
        if ! mv "$CLAUDE_DIR" "$BACKUP_DIR"; then
            error_exit "Failed to create backup of existing .claude directory"
        fi
        log_success "Backup created successfully"
    fi
}

# Download a file from GitHub
download_file() {
    local file_path="$1"
    local local_path="$2"
    local url="${RAW_URL}/${file_path}"

    log_info "Downloading: $file_path"

    if curl --fail --silent --show-error --location --create-dirs --output "$local_path" "$url"; then
        log_success "Downloaded: $local_path"
    else
        log_warning "Failed to download: $url (file may not exist)"
        return 1
    fi
}

# Create directory structure
create_directories() {
    log_info "Creating directory structure..."

    # Create main .claude directory
    if ! mkdir -p "$CLAUDE_DIR"; then
        error_exit "Failed to create .claude directory"
    fi

    # Create agent directories
    for dir in "${AGENT_DIRS[@]}"; do
        if ! mkdir -p "$CLAUDE_DIR/$dir"; then
            error_exit "Failed to create agent directory: $dir"
        fi
    done

    # Create other directories
    for dir in "${OTHER_DIRS[@]}"; do
        if ! mkdir -p "$CLAUDE_DIR/$dir"; then
            error_exit "Failed to create directory: $dir"
        fi
    done

    log_success "Directory structure created successfully"
}

# Download configuration files
download_configs() {
    log_info "Downloading configuration files..."

    for config_file in "${CONFIG_FILES[@]}"; do
        download_file ".claude/$config_file" "$CLAUDE_DIR/$config_file" || true
    done

    log_success "Configuration files downloaded"
}

# Download shell scripts
download_scripts() {
    log_info "Downloading shell scripts..."

    for script_file in "${SCRIPT_FILES[@]}"; do
        download_file ".claude/$script_file" "$CLAUDE_DIR/$script_file" || true
    done

    # Make scripts executable
    for script_file in "${SCRIPT_FILES[@]}"; do
        if [ -f "$CLAUDE_DIR/$script_file" ]; then
            chmod +x "$CLAUDE_DIR/$script_file"
            log_info "Made executable: $CLAUDE_DIR/$script_file"
        fi
    done

    log_success "Shell scripts downloaded and made executable"
}

# Download core agent files
download_core_agents() {
    log_info "Downloading core agent files..."

    for agent_file in "${CORE_AGENT_FILES[@]}"; do
        download_file ".claude/agents/$agent_file" "$CLAUDE_DIR/agents/$agent_file" || true
    done

    log_success "Core agent files downloaded"
}

# Download all agent files (attempt to download all .md files in agent directories)
download_all_agents() {
    log_info "Attempting to download all agent files..."

    # List of known agent files based on the repository structure
    local agent_files=(
        "agents/analysis/analyzer.md"
        "agents/architecture/system-design/architect.md"
        "agents/consensus/consensus-builder.md"
        "agents/data/ml/data-scientist.md"
        "agents/development/backend/backend-developer.md"
        "agents/devops/ci-cd/devops-engineer.md"
        "agents/documentation/api-docs/technical-writer.md"
        "agents/flow-nexus/flow-coordinator.md"
        "agents/github/github-specialist.md"
        "agents/goal/goal-optimizer.md"
        "agents/hive-mind/hive-coordinator.md"
        "agents/neural/neural-optimizer.md"
        "agents/optimization/performance-optimizer.md"
        "agents/reasoning/reasoning-engine.md"
        "agents/sparc/sparc-orchestrator.md"
        "agents/specialized/mobile/mobile-developer.md"
        "agents/swarm/swarm-coordinator.md"
        "agents/testing/qa-engineer.md"
    )

    for agent_file in "${agent_files[@]}"; do
        download_file ".claude/$agent_file" "$CLAUDE_DIR/$agent_file" || true
    done

    log_success "Agent files download attempted"
}

# Create a basic CLAUDE.md file if it doesn't exist
create_claude_md() {
    local claude_md_path="CLAUDE.md"

    if [ ! -f "$claude_md_path" ]; then
        log_info "Creating basic CLAUDE.md file..."

        cat > "$claude_md_path" << 'EOF'
# Claude Flow Configuration

This repository is configured with claude-flow agents and tooling.

## Available Agents

The `.claude/agents/` directory contains specialized agents for various tasks:

### Core Agents
- **coder**: Senior software engineer for code implementation
- **planner**: Project planning and architecture design
- **researcher**: Research and analysis tasks
- **reviewer**: Code review and quality assurance
- **tester**: Testing and quality assurance

### Specialized Agents
- **analysis**: Data analysis and insights
- **architecture**: System design and architecture
- **development**: Backend development
- **devops**: CI/CD and deployment
- **documentation**: Technical writing and API docs
- **github**: GitHub-specific operations
- **optimization**: Performance optimization
- **testing**: Quality assurance and testing
- And many more...

## Usage

The agents are automatically available when using Claude Code in this repository.
Each agent has specialized capabilities and can be invoked based on the task requirements.

## Configuration

Configuration files are located in `.claude/`:
- `settings.json`: Main Claude configuration
- `config.json`: Claude-flow specific configuration
- Various other settings files for different use cases

For more information, see the [claude-flow repository](https://github.com/ruvnet/claude-flow).
EOF

        log_success "Created CLAUDE.md file"
    else
        log_info "CLAUDE.md already exists, skipping creation"
    fi
}

# Verify installation
verify_installation() {
    log_info "Verifying installation..."

    # Check if .claude directory exists
    if [ ! -d "$CLAUDE_DIR" ]; then
        error_exit "Installation failed: .claude directory not found"
    fi

    # Check for key files
    local key_files=("settings.json" "config.json")
    for file in "${key_files[@]}"; do
        if [ ! -f "$CLAUDE_DIR/$file" ]; then
            log_warning "Key file not found: $CLAUDE_DIR/$file"
        fi
    done

    # Check agent directories
    local agent_count=$(find "$CLAUDE_DIR/agents" -mindepth 1 -type d | wc -l)
    log_info "Created $agent_count agent directories"

    log_success "Installation verification completed"
}

# Print summary
print_summary() {
    echo
    echo "==================================================================="
    log_success "Claude Flow setup completed successfully!"
    echo "==================================================================="
    echo
    echo "What has been set up:"
    echo "  • .claude/ directory structure with 20+ agent categories"
    echo "  • Core configuration files (settings.json, config.json, etc.)"
    echo "  • Shell scripts for status line and testing"
    echo "  • Core agent files (coder, planner, researcher, reviewer, tester)"
    echo "  • Basic CLAUDE.md documentation"
    echo
    echo "Next steps:"
    echo "  1. Review the .claude/settings.json file for configuration options"
    echo "  2. Check CLAUDE.md for usage information"
    echo "  3. Start using Claude Code with the enhanced agent capabilities"
    echo
    if [ -d "$BACKUP_DIR" ]; then
        echo "Your previous .claude directory has been backed up to:"
        echo "  $BACKUP_DIR"
        echo
    fi
    echo "Repository: $REPO_URL"
    echo "==================================================================="
}

# Main function
main() {
    echo "Claude Flow Setup Script"
    echo "========================"
    echo "Repository: $REPO_URL"
    echo

    # Check dependencies
    check_dependencies

    # Create backup if needed
    create_backup

    # Create directory structure
    create_directories

    # Download files
    download_configs
    download_scripts
    download_core_agents
    download_all_agents

    # Create documentation
    create_claude_md

    # Verify installation
    verify_installation

    # Print summary
    print_summary
}

# Run main function
main "$@"