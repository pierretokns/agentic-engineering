#!/bin/bash

# setup-disler-infinite-agentic-loop.sh
# Setup script for the infinite-agentic-loop repository
# Downloads and configures .claude/ directory structure from https://github.com/disler/infinite-agentic-loop

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# Configuration
REPO_URL="https://github.com/disler/infinite-agentic-loop"
RAW_BASE_URL="https://raw.githubusercontent.com/disler/infinite-agentic-loop/main"
CLAUDE_DIR=".claude"
COMMANDS_DIR="${CLAUDE_DIR}/commands"

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to download file with fallback
download_file() {
    local url="$1"
    local output="$2"
    local description="$3"

    log_info "Downloading ${description}..."

    if command_exists curl; then
        if ! curl -fsSL "$url" -o "$output"; then
            log_error "Failed to download ${description} using curl"
            return 1
        fi
    elif command_exists wget; then
        if ! wget -qO "$output" "$url"; then
            log_error "Failed to download ${description} using wget"
            return 1
        fi
    else
        log_error "Neither curl nor wget is available. Please install one of them."
        return 1
    fi

    log_success "Downloaded ${description}"
}

# Function to create directory structure
create_directory_structure() {
    log_info "Creating directory structure..."

    if [[ -d "$CLAUDE_DIR" ]]; then
        log_warning "Directory ${CLAUDE_DIR} already exists. Creating backup..."
        mv "$CLAUDE_DIR" "${CLAUDE_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    mkdir -p "$COMMANDS_DIR"
    log_success "Created directory structure: ${CLAUDE_DIR}/"
}

# Function to verify download
verify_file() {
    local file_path="$1"
    local description="$2"

    if [[ ! -f "$file_path" ]]; then
        log_error "${description} was not created at ${file_path}"
        return 1
    fi

    if [[ ! -s "$file_path" ]]; then
        log_error "${description} is empty at ${file_path}"
        return 1
    fi

    log_success "${description} verified"
    return 0
}

# Function to create settings.json
create_settings_json() {
    local settings_file="${CLAUDE_DIR}/settings.json"

    log_info "Creating settings.json..."

    cat > "$settings_file" << 'EOF'
{
  "permissions": {
    "allow": ["Write", "MultiEdit", "Edit", "Bash"],
    "deny": []
  }
}
EOF

    if verify_file "$settings_file" "settings.json"; then
        log_success "settings.json created successfully"
    else
        log_error "Failed to create settings.json"
        return 1
    fi
}

# Function to create infinite.md command
create_infinite_command() {
    local infinite_file="${COMMANDS_DIR}/infinite.md"

    log_info "Creating infinite.md command..."

    cat > "$infinite_file" << 'EOF'
# INFINITE AGENTIC LOOP COMMAND

Think deeply about this infinite generation task. You are about to embark on a sophisticated iterative creation process.

## Variables:
spec_file: $ARGUMENTS
output_dir: $ARGUMENTS
count: $ARGUMENTS

## ARGUMENTS PARSING:
Parse the following arguments from "$ARGUMENTS":
- spec_file - Path to the markdown specification file
- output_dir - Directory where iterations will be saved
- count - Number of iterations (1-N or "infinite")

## PHASE 1: SPECIFICATION ANALYSIS
Read and deeply understand the specification file at spec_file. This file defines:
- What type of content to generate
- The format and structure requirements
- Any specific parameters or constraints
- The intended evolution pattern between iterations

Think carefully about the spec's intent and how each iteration should build upon previous work.

## PHASE 2: OUTPUT DIRECTORY RECONNAISSANCE
Thoroughly analyze the output_dir to understand the current state:
- List all existing files and their naming patterns
- Identify the highest iteration number currently present
- Analyze the content evolution across existing iterations
- Understand the trajectory of previous generations
- Determine what gaps or opportunities exist for new iterations

## PHASE 3: ITERATION STRATEGY
Based on the spec analysis and existing iterations:
- Determine the starting iteration number (highest existing + 1)
- Plan how each new iteration will be unique and evolutionary
- Consider how to build upon previous iterations while maintaining novelty
- If count is "infinite", prepare for continuous generation until context limits

## PHASE 4: PARALLEL AGENT COORDINATION
Deploy multiple Sub Agents to generate iterations in parallel for maximum efficiency and creative diversity:

### Sub-Agent Distribution Strategy:
- For count 1-5: Launch all agents simultaneously
- For count 6-20: Launch in batches of 5 agents to manage coordination
- For "infinite": Launch waves of 3-5 agents, monitoring context and spawning new waves

### Agent Assignment Protocol:
Each Sub Agent receives:
- Spec Context: Complete specification file analysis
- Directory Snapshot: Current state of output_dir at launch time
- Iteration Assignment: Specific iteration number (starting_number + agent_index)
- Uniqueness Directive: Explicit instruction to avoid duplicating concepts from existing iterations
- Quality Standards: Detailed requirements from the specification

### Agent Task Specification:
TASK: Generate iteration [NUMBER] for [SPEC_FILE] in [OUTPUT_DIR]

You are Sub Agent [X] generating iteration [NUMBER].

CONTEXT:
- Specification: [Full spec analysis]
- Existing iterations: [Summary of current output_dir contents]
- Your iteration number: [NUMBER]
- Assigned creative direction: [Specific innovation dimension to explore]

REQUIREMENTS:
1. Read and understand the specification completely
2. Analyze existing iterations to ensure your output is unique
3. Generate content following the spec format exactly
4. Focus on [assigned innovation dimension] while maintaining spec compliance
5. Create file with exact name pattern specified
6. Ensure your iteration adds genuine value and novelty

DELIVERABLE: Single file as specified, with unique innovative content

### Parallel Execution Management:
- Launch all assigned Sub Agents simultaneously using Task tool
- Monitor agent progress and completion
- Handle any agent failures by reassigning iteration numbers
- Ensure no duplicate iteration numbers are generated
- Collect and validate all completed iterations

## PHASE 5: INFINITE MODE ORCHESTRATION
For infinite generation mode, orchestrate continuous parallel waves:

### Wave-Based Generation:
1. Wave Planning: Determine next wave size (3-5 agents) based on context capacity
2. Agent Preparation: Prepare fresh context snapshots for each new wave
3. Progressive Sophistication: Each wave should explore more advanced innovation dimensions
4. Context Monitoring: Track total context usage across all agents and main orchestrator
5. Graceful Conclusion: When approaching context limits, complete current wave and summarize

### Infinite Execution Cycle:
WHILE context_capacity > threshold:
 1. Assess current output_dir state
 2. Plan next wave of agents (size based on remaining context)
 3. Assign increasingly sophisticated creative directions
 4. Launch parallel Sub Agent wave
 5. Monitor wave completion
 6. Update directory state snapshot
 7. Evaluate context capacity remaining
 8. If sufficient capacity: Continue to next wave
 9. If approaching limits: Complete final wave and summarize

### Progressive Sophistication Strategy:
- Wave 1: Basic functional replacements with single innovation dimension
- Wave 2: Multi-dimensional innovations with enhanced interactions
- Wave 3: Complex paradigm combinations with adaptive behaviors
- Wave N: Revolutionary concepts pushing the boundaries of the specification

### Context Optimization:
- Each wave uses fresh agent instances to avoid context accumulation
- Main orchestrator maintains lightweight state tracking
- Progressive summarization of completed iterations to manage context
- Strategic pruning of less essential details in later waves

## EXECUTION PRINCIPLES:

### Quality & Uniqueness:
- Each iteration must be genuinely unique and valuable
- Build upon previous work while introducing novel elements
- Maintain consistency with the original specification
- Ensure proper file organization and naming

### Parallel Coordination:
- Deploy Sub Agents strategically to maximize creative diversity
- Assign distinct innovation dimensions to each agent to avoid overlap
- Coordinate timing to prevent file naming conflicts
- Monitor all agents for successful completion and quality

### Scalability & Efficiency:
- Think deeply about the evolution trajectory across parallel streams
- For infinite mode, optimize for maximum valuable output before context exhaustion
- Use wave-based generation to manage context limits intelligently
- Balance parallel speed with quality and coordination overhead

### Agent Management:
- Provide each Sub Agent with complete context and clear assignments
- Handle agent failures gracefully with iteration reassignment
- Ensure all parallel outputs integrate cohesively with the overall progression

## ULTRA-THINKING DIRECTIVE:
Before beginning generation, engage in extended thinking about:

### Specification & Evolution:
- The deeper implications of the specification
- How to create meaningful progression across iterations
- What makes each iteration valuable and unique
- How to balance consistency with innovation

### Parallel Strategy:
- Optimal Sub Agent distribution for the requested count
- How to assign distinct creative directions to maximize diversity
- Wave sizing and timing for infinite mode
- Context management across multiple parallel agents

### Coordination Challenges:
- How to prevent duplicate concepts across parallel streams
- Strategies for ensuring each agent produces genuinely unique output
- Managing file naming and directory organization with concurrent writes
- Quality control mechanisms for parallel outputs

### Infinite Mode Optimization:
- Wave-based generation patterns for sustained output
- Progressive sophistication strategies across multiple waves
- Context capacity monitoring and graceful conclusion planning
- Balancing speed of parallel generation with depth of innovation

### Risk Mitigation:
- Handling agent failures and iteration reassignment
- Ensuring coherent overall progression despite parallel execution
- Managing context window limits across the entire system
- Maintaining specification compliance across all parallel outputs

Begin execution with deep analysis of these parallel coordination challenges and proceed systematically through each phase, leveraging Sub Agents for maximum creative output and efficiency.
EOF

    if verify_file "$infinite_file" "infinite.md command"; then
        log_success "infinite.md command created successfully"
    else
        log_error "Failed to create infinite.md command"
        return 1
    fi
}

# Function to create prime.md command
create_prime_command() {
    local prime_file="${COMMANDS_DIR}/prime.md"

    log_info "Creating prime.md command..."

    cat > "$prime_file" << 'EOF'
Context Window Prime

RUN:
git ls-files

READ:
README.md
ai_docs/claude_code_fresh_tutorials.md
EOF

    if verify_file "$prime_file" "prime.md command"; then
        log_success "prime.md command created successfully"
    else
        log_error "Failed to create prime.md command"
        return 1
    fi
}

# Function to create README for the setup
create_readme() {
    local readme_file="README_infinite_agentic_loop.md"

    log_info "Creating README file..."

    cat > "$readme_file" << 'EOF'
# Infinite Agentic Loop Setup

This directory has been configured with the Infinite Agentic Loop commands from the [disler/infinite-agentic-loop](https://github.com/disler/infinite-agentic-loop) repository.

## Available Commands

### `/infinite`
The main infinite agentic loop command that enables sophisticated iterative creation using parallel Sub Agents.

**Usage:**
```
/infinite spec_file.md output_directory count
```

**Parameters:**
- `spec_file`: Path to the markdown specification file
- `output_dir`: Directory where iterations will be saved
- `count`: Number of iterations (1-N or "infinite")

**Features:**
- Specification analysis and understanding
- Directory reconnaissance to understand existing state
- Parallel agent coordination for maximum efficiency
- Wave-based generation for infinite mode
- Progressive sophistication across iterations
- Quality assurance and uniqueness validation

### `/prime`
Context window priming command that prepares the environment.

**Features:**
- Lists all git tracked files
- Reads key documentation files
- Prepares context for agentic operations

## Getting Started

1. Create a specification file defining what you want to generate
2. Create an output directory for the iterations
3. Run the infinite command:
   ```
   /infinite my_spec.md ./output 5
   ```

## Examples

**Single Generation:**
```
/infinite blog_post_spec.md ./posts 1
```

**Small Batch:**
```
/infinite code_spec.md ./solutions 5
```

**Large Batch:**
```
/infinite design_spec.md ./designs 20
```

**Infinite Mode:**
```
/infinite creative_spec.md ./artwork infinite
```

## Repository Information

- Original Repository: https://github.com/disler/infinite-agentic-loop
- Tutorial: [Infinite Agentic Loop with Claude Code](https://youtu.be/9ipM_vDwflI)
- Creator: IndyDevDan

## Permissions

The setup includes the following permissions in `.claude/settings.json`:
- Write
- MultiEdit
- Edit
- Bash

These permissions are required for the infinite agentic loop to function properly.
EOF

    if verify_file "$readme_file" "README file"; then
        log_success "README file created successfully"
    else
        log_error "Failed to create README file"
        return 1
    fi
}

# Function to display final setup information
display_setup_info() {
    log_success "=== Infinite Agentic Loop Setup Complete ==="
    echo
    echo "What has been created:"
    echo "  📁 .claude/"
    echo "    📄 settings.json - Claude permissions configuration"
    echo "    📁 commands/"
    echo "      📄 infinite.md - Main infinite agentic loop command"
    echo "      📄 prime.md - Context window priming command"
    echo "  📄 README_infinite_agentic_loop.md - Usage documentation"
    echo
    echo "Available commands:"
    echo "  /infinite <spec_file> <output_dir> <count> - Generate iterations"
    echo "  /prime - Prime context window"
    echo
    echo "Example usage:"
    echo "  /infinite spec.md ./output 5"
    echo "  /infinite creative.md ./artwork infinite"
    echo
    echo "Original repository: ${REPO_URL}"
    echo "Tutorial: https://youtu.be/9ipM_vDwflI"
    echo
    log_success "Setup completed successfully! You can now use the infinite agentic loop commands."
}

# Main execution function
main() {
    log_info "Starting Infinite Agentic Loop setup..."
    log_info "Repository: ${REPO_URL}"

    # Check dependencies
    if ! command_exists curl && ! command_exists wget; then
        log_error "Neither curl nor wget is available. Please install one of them and try again."
        exit 1
    fi

    # Create directory structure
    if ! create_directory_structure; then
        log_error "Failed to create directory structure"
        exit 1
    fi

    # Create configuration files
    if ! create_settings_json; then
        log_error "Failed to create settings.json"
        exit 1
    fi

    if ! create_infinite_command; then
        log_error "Failed to create infinite.md command"
        exit 1
    fi

    if ! create_prime_command; then
        log_error "Failed to create prime.md command"
        exit 1
    fi

    if ! create_readme; then
        log_error "Failed to create README"
        exit 1
    fi

    # Display final information
    display_setup_info
}

# Script entry point
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi