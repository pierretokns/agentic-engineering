#!/usr/bin/env bash

# setup-obra-superpowers.sh
# Setup script for obra/superpowers Claude Code plugin
# Downloads and configures the superpowers skills library

set -euo pipefail

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Configuration
readonly REPO_OWNER="obra"
readonly REPO_NAME="superpowers"
readonly REPO_URL="https://github.com/${REPO_OWNER}/${REPO_NAME}"
readonly RAW_BASE_URL="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/main"
# Remote paths (in the original repository)
readonly REMOTE_PLUGIN_DIR=".claude-plugin"
readonly REMOTE_SKILLS_DIR="skills"
readonly REMOTE_COMMANDS_DIR="commands"
readonly REMOTE_HOOKS_DIR="hooks"
# Local paths (where we want to install them)
readonly LOCAL_PLUGIN_DIR=".claude/.claude-plugin"
readonly LOCAL_SKILLS_DIR=".claude/skills"
readonly LOCAL_COMMANDS_DIR=".claude/commands"
readonly LOCAL_HOOKS_DIR=".claude/hooks"

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
handle_error() {
    local exit_code=$?
    local line_number=$1
    log_error "Script failed on line ${line_number} with exit code ${exit_code}"
    exit $exit_code
}

# Set up error trap
trap 'handle_error $LINENO' ERR

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."

    if ! command_exists curl; then
        log_error "curl is required but not installed. Please install curl and try again."
        exit 1
    fi

    if ! command_exists jq; then
        log_warning "jq is not installed. JSON parsing will be done with sed/awk instead."
    fi

    log_success "Prerequisites check completed"
}

# Create directory if it doesn't exist
ensure_directory() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        log_info "Creating directory: $dir"
        mkdir -p "$dir"
    fi
}

# Download file with curl
download_file() {
    local url="$1"
    local output="$2"
    local description="${3:-file}"

    log_info "Downloading $description: $(basename "$output")"

    if curl --fail --silent --show-error --location --output "$output" "$url"; then
        log_success "Downloaded: $(basename "$output")"
    else
        log_error "Failed to download: $url"
        return 1
    fi
}

# Download JSON file and validate
download_json() {
    local url="$1"
    local output="$2"
    local description="${3:-JSON file}"

    if ! download_file "$url" "$output" "$description"; then
        return 1
    fi

    # Basic JSON validation
    if command_exists jq; then
        if ! jq empty "$output" 2>/dev/null; then
            log_error "Downloaded file is not valid JSON: $output"
            return 1
        fi
    else
        # Basic validation without jq
        if ! grep -q '^{.*}$' "$output" 2>/dev/null; then
            log_warning "Could not validate JSON format for: $output (jq not available)"
        fi
    fi

    return 0
}

# Setup .claude-plugin directory
setup_plugin_config() {
    log_info "Setting up plugin configuration..."

    ensure_directory "$LOCAL_PLUGIN_DIR"

    # Download plugin.json
    download_json \
        "${RAW_BASE_URL}/${REMOTE_PLUGIN_DIR}/plugin.json" \
        "${LOCAL_PLUGIN_DIR}/plugin.json" \
        "plugin configuration"

    # Download marketplace.json
    download_json \
        "${RAW_BASE_URL}/${REMOTE_PLUGIN_DIR}/marketplace.json" \
        "${LOCAL_PLUGIN_DIR}/marketplace.json" \
        "marketplace configuration"

    log_success "Plugin configuration completed"
}

# List of all skills to download
readonly SKILLS=(
    "brainstorming"
    "commands"
    "condition-based-waiting"
    "defense-in-depth"
    "dispatching-parallel-agents"
    "executing-plans"
    "finishing-a-development-branch"
    "receiving-code-review"
    "requesting-code-review"
    "root-cause-tracing"
    "sharing-skills"
    "subagent-driven-development"
    "systematic-debugging"
    "test-driven-development"
    "testing-anti-patterns"
    "testing-skills-with-subagents"
    "using-git-worktrees"
    "using-superpowers"
    "verification-before-completion"
    "writing-plans"
    "writing-skills"
)

# Setup skills directory
setup_skills() {
    log_info "Setting up skills library..."

    ensure_directory "$LOCAL_SKILLS_DIR"

    local downloaded_count=0
    local total_count=${#SKILLS[@]}

    for skill in "${SKILLS[@]}"; do
        local skill_dir="${LOCAL_SKILLS_DIR}/${skill}"
        local skill_url="${RAW_BASE_URL}/${REMOTE_SKILLS_DIR}/${skill}/SKILL.md"
        local skill_file="${skill_dir}/SKILL.md"

        ensure_directory "$skill_dir"

        if download_file "$skill_url" "$skill_file" "skill: $skill"; then
            ((downloaded_count++))
        else
            log_warning "Failed to download skill: $skill"
        fi
    done

    log_success "Downloaded ${downloaded_count}/${total_count} skills"
}

# Setup commands directory
setup_commands() {
    log_info "Setting up commands..."

    ensure_directory "$LOCAL_COMMANDS_DIR"

    # List of command files to download
    local commands=(
        "brainstorm.md"
        "execute-plan.md"
        "write-plan.md"
    )

    for command in "${commands[@]}"; do
        local command_url="${RAW_BASE_URL}/${REMOTE_COMMANDS_DIR}/${command}"
        local command_file="${LOCAL_COMMANDS_DIR}/${command}"

        download_file "$command_url" "$command_file" "command: $command"
    done

    log_success "Commands setup completed"
}

# Setup hooks directory
setup_hooks() {
    log_info "Setting up hooks..."

    ensure_directory "$LOCAL_HOOKS_DIR"

    # Download hooks.json
    download_json \
        "${RAW_BASE_URL}/${REMOTE_HOOKS_DIR}/hooks.json" \
        "${LOCAL_HOOKS_DIR}/hooks.json" \
        "hooks configuration"

    # Download session-start.sh
    local session_start_url="${RAW_BASE_URL}/${REMOTE_HOOKS_DIR}/session-start.sh"
    local session_start_file="${HOOKS_DIR}/session-start.sh"

    if download_file "$session_start_url" "$session_start_file" "session start hook"; then
        # Make it executable
        chmod +x "$session_start_file"
        log_success "Made session-start.sh executable"
    fi

    log_success "Hooks setup completed"
}

# Verify installation
verify_installation() {
    log_info "Verifying installation..."

    local errors=0

    # Check plugin directory
    if [[ ! -f "${PLUGIN_DIR}/plugin.json" ]]; then
        log_error "plugin.json not found"
        ((errors++))
    fi

    if [[ ! -f "${LOCAL_PLUGIN_DIR}/marketplace.json" ]]; then
        log_error "marketplace.json not found"
        ((errors++))
    fi

    # Check skills directory
    if [[ ! -d "$LOCAL_SKILLS_DIR" ]]; then
        log_error "Skills directory not found"
        ((errors++))
    else
        local skill_count=$(find "$LOCAL_SKILLS_DIR" -name "SKILL.md" -type f | wc -l)
        if [[ $skill_count -eq 0 ]]; then
            log_error "No skill files found"
            ((errors++))
        else
            log_info "Found $skill_count skill files"
        fi
    fi

    # Check commands directory
    if [[ ! -d "$LOCAL_COMMANDS_DIR" ]]; then
        log_error "Commands directory not found"
        ((errors++))
    fi

    # Check hooks directory
    if [[ ! -f "${LOCAL_HOOKS_DIR}/hooks.json" ]]; then
        log_error "hooks.json not found"
        ((errors++))
    fi

    if [[ ! -f "${HOOKS_DIR}/session-start.sh" ]]; then
        log_error "session-start.sh not found"
        ((errors++))
    fi

    if [[ $errors -eq 0 ]]; then
        log_success "Installation verified successfully"
        return 0
    else
        log_error "Installation verification failed with $errors errors"
        return 1
    fi
}

# Print usage information
print_usage_info() {
    log_info "Installation completed!"
    echo
    echo "The obra/superpowers plugin has been installed in the current directory."
    echo
    echo "What's been installed:"
    echo "  • ${LOCAL_PLUGIN_DIR}/ - Plugin configuration files"
    echo "  • ${LOCAL_SKILLS_DIR}/ - ${#SKILLS[@]} skills for TDD, debugging, and collaboration"
    echo "  • ${LOCAL_COMMANDS_DIR}/ - Command wrappers for common tasks"
    echo "  • ${LOCAL_HOOKS_DIR}/ - Session initialization hooks"
    echo
    echo "Next steps:"
    echo "  1. Restart Claude Code or reload the current session"
    echo "  2. Use the 'Skill' tool to access any of the installed skills"
    echo "  3. Try 'skill:using-superpowers' to get started"
    echo
    echo "For more information, visit: ${REPO_URL}"
}

# Main function
main() {
    echo "Obra Superpowers Setup Script"
    echo "=============================="
    echo "This script will download and configure the obra/superpowers Claude Code plugin"
    echo

    check_prerequisites
    setup_plugin_config
    setup_skills
    setup_commands
    setup_hooks

    if verify_installation; then
        print_usage_info
    else
        log_error "Installation failed. Please check the errors above and try again."
        exit 1
    fi
}

# Run main function
main "$@"