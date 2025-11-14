#!/bin/bash

# Setup script for ciign/agentic-engineering
# Clones repo, runs setup, then cleans up

set -euo pipefail

echo "🚀 Setting up ciign/agentic-engineering agents..."

# Clone repository
echo "📥 Cloning repository..."
git clone https://github.com/ciign/agentic-engineering.git

# Move the setup script one directory up
echo "📁 Moving setup script..."
mv agentic-engineering/setup-claude-agents.sh .

# Create .claude directory if it doesn't exist
mkdir -p .claude

# Run the setup script
echo "🔧 Running ciign setup script..."
bash setup-claude-agents.sh

# Clean up cloned repository
echo "🧹 Cleaning up..."
rm -rf agentic-engineering

echo "✅ ciign/agentic-engineering setup complete!"
echo "📋 Agents installed: $(ls .claude/agents/ 2>/dev/null | wc -l)"
echo ""
echo "Usage:"
echo "  claude"
echo "  /agents"
echo "  @agent-name your-request"