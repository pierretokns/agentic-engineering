#!/bin/bash

# Setup script for ciign/agentic-engineering
# Clones repo, runs setup, then cleans up

#!/bin/bash

# Setup Claude Code Agents
# This script downloads and sets up .claude agents for use with Claude Code
# Based on Jungian psychology principles for balanced team dynamics

set -e  # Exit on error

GITHUB_REPO="pierretokns/agentic-engineering"
GITHUB_BRANCH="main"
TARGET_DIR=".claude"
TEMP_DIR=$(mktemp -d)
CLEANUP_TEMP=false

echo "🤖 Setting up Claude Code Agents..."
echo ""

# Determine template location
if [ -n "${BASH_SOURCE[0]}" ]; then
    # Running as a script file
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    TEMPLATE_DIR="$SCRIPT_DIR/.claude-template"

    if [ ! -d "$TEMPLATE_DIR" ]; then
        echo "📥 Template not found locally, downloading from GitHub..."
        TEMPLATE_DIR="$TEMP_DIR/.claude-template"
        CLEANUP_TEMP=true

        # Download template directory from GitHub
        mkdir -p "$TEMPLATE_DIR"
        curl -sSL "https://api.github.com/repos/$GITHUB_REPO/contents/.claude-template?ref=$GITHUB_BRANCH" | \
            grep -o '"download_url": "[^"]*"' | \
            sed 's/"download_url": "\(.*\)"/\1/' | \
            while read url; do
                if [ -n "$url" ] && [ "$url" != "null" ]; then
                    filename=$(echo "$url" | sed "s|.*/.claude-template/||")
                    mkdir -p "$TEMPLATE_DIR/$(dirname "$filename")"
                    curl -sSL "$url" -o "$TEMPLATE_DIR/$filename"
                fi
            done
    fi
else
    # Piped from curl, download from GitHub
    echo "📥 Downloading agent templates from GitHub..."
    TEMPLATE_DIR="$TEMP_DIR/.claude-template"
    CLEANUP_TEMP=true

    # Download the entire .claude-template directory structure
    git clone --depth 1 --filter=blob:none --sparse "https://github.com/$GITHUB_REPO.git" "$TEMP_DIR/repo" 2>/dev/null
    cd "$TEMP_DIR/repo"
    git sparse-checkout set .claude-template
    mv .claude-template "$TEMPLATE_DIR"
    cd - > /dev/null
    rm -rf "$TEMP_DIR/repo"
fi

# Verify template directory exists and has content
if [ ! -d "$TEMPLATE_DIR" ] || [ -z "$(ls -A "$TEMPLATE_DIR")" ]; then
    echo "❌ Error: Failed to obtain agent templates"
    [ "$CLEANUP_TEMP" = true ] && rm -rf "$TEMP_DIR"
    exit 1
fi

echo "Setting up Claude Code agents in $(pwd)/.claude"
echo ""

# Check if .claude already exists
if [ -d "$TARGET_DIR" ]; then
    echo "⚠️  .claude directory already exists - backing up to .claude.backup"
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

# Cleanup temporary files
if [ "$CLEANUP_TEMP" = true ]; then
    rm -rf "$TEMP_DIR"
fi

echo "Happy coding! 🎉"
