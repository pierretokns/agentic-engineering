#!/bin/bash

# Setup script for obra/superpowers
# Clones repo and moves .claude content additively

set -euo pipefail

echo "⚡ Setting up obra/superpowers..."

# Create temp directory
TEMP_DIR=$(mktemp -d)

# Clone repository
echo "📥 Cloning repository..."
git clone https://github.com/obra/superpowers.git "$TEMP_DIR"

# Create .claude directory if it doesn't exist
mkdir -p .claude

# Move .claude-plugin directory
if [[ -d "$TEMP_DIR/.claude-plugin" ]]; then
    if [[ -d ".claude/.claude-plugin" ]]; then
        echo "⚠️  .claude/.claude-plugin already exists, skipping"
    else
        echo "📁 Moving .claude-plugin to .claude/"
        mv "$TEMP_DIR/.claude-plugin" .claude/
    fi
fi

# Move skills directory
if [[ -d "$TEMP_DIR/skills" ]]; then
    if [[ -d ".claude/skills" ]]; then
        echo "📁 Merging skills into existing .claude/skills/"
        cp -r "$TEMP_DIR/skills"/* .claude/skills/
    else
        echo "📁 Moving skills to .claude/"
        mv "$TEMP_DIR/skills" .claude/
    fi
fi

# Move commands directory
if [[ -d "$TEMP_DIR/commands" ]]; then
    if [[ -d ".claude/commands" ]]; then
        echo "📁 Merging commands into existing .claude/commands/"
        mkdir -p .claude/commands/obra
        cp -r "$TEMP_DIR/commands"/* .claude/commands/obra/
    else
        echo "📁 Moving commands to .claude/"
        mv "$TEMP_DIR/commands" .claude/
    fi
fi

# Move hooks directory
if [[ -d "$TEMP_DIR/hooks" ]]; then
    if [[ -d ".claude/hooks" ]]; then
        echo "📁 Merging hooks into existing .claude/hooks/"
        mkdir -p .claude/hooks/obra
        cp -r "$TEMP_DIR/hooks"/* .claude/hooks/obra/
    else
        echo "📁 Moving hooks to .claude/"
        mv "$TEMP_DIR/hooks" .claude/
    fi
fi

# Move agents directory if exists
if [[ -d "$TEMP_DIR/agents" ]]; then
    if [[ -d ".claude/agents" ]]; then
        echo "📁 Merging agents into existing .claude/agents/"
        mkdir -p .claude/agents/obra
        cp -r "$TEMP_DIR/agents"/* .claude/agents/obra/
    else
        echo "📁 Moving agents to .claude/"
        mv "$TEMP_DIR/agents" .claude/
    fi
fi

# Clean up cloned repository
echo "🧹 Cleaning up..."
rm -rf "$TEMP_DIR"

echo "✅ obra/superpowers setup complete!"
echo "📋 Skills installed: $(find .claude/skills -maxdepth 1 -type d 2>/dev/null | wc -l)"
echo "📋 Commands installed: $(ls .claude/commands/ 2>/dev/null | wc -l)"
echo ""
echo "Usage:"
echo "  claude"
echo "  /commands"
echo "  skill:skill-name"
