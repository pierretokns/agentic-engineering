#!/bin/bash

# Setup script for ruvnet/claude-flow
# Clones repo and moves .claude content additively

set -euo pipefail

echo "🏗️ Setting up ruvnet/claude-flow..."

# Create temp directory
TEMP_DIR=$(mktemp -d)

# Clone repository
echo "📥 Cloning repository..."
git clone https://github.com/ruvnet/claude-flow.git "$TEMP_DIR"

# Create .claude directory if it doesn't exist
mkdir -p .claude

# Move .claude content
if [[ -d "$TEMP_DIR/.claude" ]]; then
    echo "📁 Moving .claude content..."

    # Move agents into their own subdirectory to avoid conflicts
    if [[ -d "$TEMP_DIR/.claude/agents" ]]; then
        if [[ -d ".claude/agents" ]]; then
            echo "📁 Merging claude-flow agents into existing .claude/agents/"
            mkdir -p .claude/agents/claude-flow
            cp -r "$TEMP_DIR/.claude/agents"/* .claude/agents/claude-flow/
        else
            echo "📁 Moving .claude/agents/"
            mkdir -p .claude/agents
            mv "$TEMP_DIR/.claude/agents" .claude/
        fi
    fi

    # Move other .claude content with prefixes to avoid conflicts
    for item in settings.json config.json optimized-settings.json statusline-command.sh test-reasoningbank-hooks.sh; do
        if [[ -e "$TEMP_DIR/.claude/$item" ]]; then
            if [[ -e ".claude/flow-$item" ]]; then
                echo "⚠️  .claude/flow-$item already exists, skipping"
            else
                echo "📁 Moving .claude/$item as flow-$item"
                mv "$TEMP_DIR/.claude/$item" ".claude/flow-$item"
                # Make shell scripts executable
                if [[ "$item" == *.sh ]]; then
                    chmod +x ".claude/flow-$item"
                fi
            fi
        fi
    done
fi

# Move main CLAUDE.md to parent directory
if [[ -f "$TEMP_DIR/CLAUDE.md" ]]; then
    if [[ -f "CLAUDE_flow.md" ]]; then
        echo "⚠️  CLAUDE_flow.md already exists, skipping"
    else
        echo "📁 Moving CLAUDE.md as CLAUDE_flow.md"
        mv "$TEMP_DIR/CLAUDE.md" "CLAUDE_flow.md"
    fi
fi

# Clean up cloned repository
echo "🧹 Cleaning up..."
rm -rf "$TEMP_DIR"

echo "✅ ruvnet/claude-flow setup complete!"
echo "📋 Agents installed: $(find .claude/agents -name "*.md" 2>/dev/null | wc -l)"
echo ""
echo "Usage:"
echo "  claude"
echo "  /agents"
echo "  @flow-coder help me implement this feature"
