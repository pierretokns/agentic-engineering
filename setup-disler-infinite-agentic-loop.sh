#!/bin/bash

# Setup script for disler/infinite-agentic-loop
# Clones repo and moves .claude content additively

set -euo pipefail

echo "🔄 Setting up disler/infinite-agentic-loop..."

# Create temp directory
TEMP_DIR=$(mktemp -d)

# Clone repository
echo "📥 Cloning repository..."
git clone https://github.com/disler/infinite-agentic-loop.git "$TEMP_DIR"

# Create .claude directory if it doesn't exist
mkdir -p .claude

# Move .claude content
if [[ -d "$TEMP_DIR/.claude" ]]; then
    echo "📁 Moving .claude content..."
    # Move commands into their own subdirectory to avoid conflicts
    if [[ -d "$TEMP_DIR/.claude/commands" ]]; then
        if [[ -d ".claude/commands" ]]; then
            echo "📁 Merging infinite commands into existing .claude/commands/"
            mkdir -p .claude/commands/infinite
            cp -r "$TEMP_DIR/.claude/commands"/* .claude/commands/infinite/
        else
            echo "📁 Moving .claude/commands/"
            mkdir -p .claude/commands
            mv "$TEMP_DIR/.claude/commands" .claude/
        fi
    fi

    # Move other .claude content with prefixes to avoid conflicts
    for item in settings.json CLAUDE.md README.md; do
        if [[ -e "$TEMP_DIR/.claude/$item" ]]; then
            if [[ -e ".claude/infinite-$item" ]]; then
                echo "⚠️  .claude/infinite-$item already exists, skipping"
            else
                echo "📁 Moving .claude/$item as infinite-$item"
                mv "$TEMP_DIR/.claude/$item" ".claude/infinite-$item"
            fi
        fi
    done
fi

# Move main README to parent directory
if [[ -f "$TEMP_DIR/README.md" ]]; then
    if [[ -f "README_infinite.md" ]]; then
        echo "⚠️  README_infinite.md already exists, skipping"
    else
        echo "📁 Moving README as README_infinite.md"
        mv "$TEMP_DIR/README.md" "README_infinite.md"
    fi
fi

# Clean up cloned repository
echo "🧹 Cleaning up..."
rm -rf "$TEMP_DIR"

echo "✅ disler/infinite-agentic-loop setup complete!"
echo "📋 Commands installed: $(find .claude/commands -name "*.md" 2>/dev/null | wc -l)"
echo ""
echo "Usage:"
echo "  claude"
echo "  /commands"
echo "  /infinite <spec_file> <output_dir> <count>"