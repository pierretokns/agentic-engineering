#!/bin/bash

# Setup script for dimitritholen/gustav
# Clones repo and moves .claude content additively

set -euo pipefail

echo "🏃‍♂️ Setting up dimitritholen/gustav..."

# Create temp directory
TEMP_DIR=$(mktemp -d)

# Clone repository
echo "📥 Cloning repository..."
git clone https://github.com/dimitritholen/gustav.git "$TEMP_DIR"

# Create .claude directory if it doesn't exist
mkdir -p .claude

# Move .claude content
if [[ -d "$TEMP_DIR/.claude" ]]; then
    echo "📁 Moving .claude content..."
    # Move commands into their own subdirectory to avoid conflicts
    if [[ -d "$TEMP_DIR/.claude/commands" ]]; then
        if [[ -d ".claude/commands" ]]; then
            echo "📁 Merging gustav commands into existing .claude/commands/"
            cp -r "$TEMP_DIR/.claude/commands"/* .claude/commands/
        else
            echo "📁 Moving .claude/commands/"
            mv "$TEMP_DIR/.claude/commands" .claude/
        fi
    fi

    # Move other .claude content
    for item in settings.json utils config.json; do
        if [[ -e "$TEMP_DIR/.claude/$item" ]]; then
            if [[ -e ".claude/gustav-$item" ]]; then
                echo "⚠️  .claude/gustav-$item already exists, skipping"
            else
                echo "📁 Moving .claude/$item as gustav-$item"
                mv "$TEMP_DIR/.claude/$item" ".claude/gustav-$item"
            fi
        fi
    done
fi

# Clean up cloned repository
echo "🧹 Cleaning up..."
rm -rf "$TEMP_DIR"

echo "✅ dimitritholen/gustav setup complete!"
echo "📋 Commands installed: $(find .claude/commands -name "*.md" 2>/dev/null | wc -l)"
echo ""
echo "Usage:"
echo "  claude"
echo "  /commands"
echo "  /gustav:planner path/to/prd.md"
