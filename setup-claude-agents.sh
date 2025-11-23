#!/bin/bash

# Setup Claude Code Agents
# This script copies the .claude-template to .claude for use with Claude Code
# Based on Jungian psychology principles for balanced team dynamics

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/.claude-template"
TARGET_DIR=".claude"

echo "🤖 Setting up Claude Code Agents..."
echo ""

# Check if template directory exists
if [ ! -d "$TEMPLATE_DIR" ]; then
    echo "❌ Error: Template directory not found at $TEMPLATE_DIR"
    echo "   Please run this script from the agentic-engineering repository root."
    exit 1
fi

# Check if running in a git repository
if [ ! -d ".git" ]; then
    echo "⚠️  Warning: Not in a git repository. Are you sure you want to continue?"
    echo "   This script is meant to be run in your project directory."
    read -p "   Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        exit 0
    fi
fi

# Check if .claude already exists
if [ -d "$TARGET_DIR" ]; then
    echo "⚠️  .claude directory already exists!"
    read -p "   Overwrite existing agents? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Cancelled. Your existing .claude directory was not modified."
        exit 0
    fi
    echo "   Backing up existing .claude to .claude.backup..."
    rm -rf .claude.backup
    mv .claude .claude.backup
fi

# Copy template to .claude
echo "📋 Copying agent templates..."
cp -r "$TEMPLATE_DIR" "$TARGET_DIR"

# Count agents
AGENT_COUNT=$(find "$TARGET_DIR/agents" -name "*.md" -type f | wc -l | tr -d ' ')

echo ""
echo "✅ Successfully installed $AGENT_COUNT Claude Code agents!"
echo ""
echo "📊 Team Balance (Jungian Psychology):"
echo ""
echo "   🔧 WORKER AGENTS (Sensing - Practical Execution):"
echo "      • backend-specialist (blue)"
echo "      • frontend-specialist (green)"
echo "      • database-designer (brown)"
echo "      • devops-engineer (cyan)"
echo "      • full-stack-developer (purple)"
echo "      • debugger (orange)"
echo ""
echo "   🏛️  GOVERNANCE AGENTS (Quality & Direction):"
echo "      • product-owner (teal) - Intuition + Feeling"
echo "      • ux-designer (pink) - Feeling"
echo "      • system-architect (magenta) - Intuition"
echo "      • code-reviewer (red) - Thinking"
echo "      • security-auditor (red) - Thinking"
echo "      • test-writer (yellow) - Thinking"
echo ""
echo "📂 Directory structure:"
echo "   $TARGET_DIR/"
echo "   └── agents/"
for agent in "$TARGET_DIR/agents"/*.md; do
    if [ -f "$agent" ]; then
        basename "$agent" | sed 's/^/       ├── /'
    fi
done | sed '$ s/├/└/'
echo ""
echo "📖 Documentation:"
echo "   • See TEAM_ARCHITECTURE.md for team dynamics and collaboration patterns"
echo "   • Each agent includes their Jungian cognitive function and role"
echo ""
echo "🚀 Next steps:"
echo "   1. Start or restart Claude Code in this directory"
echo "   2. Use @agent-name to reference specific agents"
echo "   3. Example: '@product-owner what features should we prioritize?'"
echo "   4. Example: '@backend-specialist design an API for user authentication'"
echo ""
echo "💡 Tips:"
echo "   • Worker agents execute tasks (Sensing)"
echo "   • Governance agents provide direction and quality checks"
echo "   • Use product-owner and ux-designer for 'what to build'"
echo "   • Use system-architect for 'how to structure it'"
echo "   • Use specialists (backend, frontend, etc.) for 'building it'"
echo "   • Use reviewers (code, security, test) for 'validating quality'"
echo ""
echo "Happy coding! 🎉"
