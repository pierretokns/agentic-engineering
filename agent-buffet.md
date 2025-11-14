# Agent Buffet - Additive Claude Code Setup

## 🚀 Simple Installation

Install multiple agent frameworks additively. Each script clones a repo and moves `.claude` content without overwriting existing files.

```bash
# 1. Development Agents (ciign/agentic-engineering) - 10 agents
./setup-ciign-agentic-engineering.sh

# 2. Skills Framework (obra/superpowers) - 21 skills
./setup-obra-superpowers.sh

# 3. Sprint Orchestrator (dimitritholen/gustav) - 7 commands
./setup-dimitritholen-gustav.sh

# 4. Infinite Loop System (disler/infinite-agentic-loop) - 2 commands
./setup-disler-infinite-agentic-loop.sh

# 5. Enterprise Architecture (ruvnet/claude-flow) - 64+ agents
./setup-ruvnet-claude-flow.sh
```

**Additive**: Each script preserves existing content and adds new functionality.

## 📋 What You Get

- **10 specialized agents**: full-stack-developer, backend-specialist, frontend-specialist, code-reviewer, debugger, devops-engineer, test-writer, system-architect, database-designer, security-auditor
- **No conflicts**: Each agent has its own focus and expertise
- **Ready to use**: Restart Claude Code and start using agents immediately

## 🎯 Usage Examples

```bash
# Restart Claude Code from your project directory
claude

# List all available agents
/agents

# Use any agent for specialized help
@full-stack-developer help me build a user authentication system
@backend-specialist design a REST API for this project
@code-reviewer review this pull request for security issues
@database-designer optimize this slow database query
```

## 🔧 Other Frameworks (Advanced)

The following frameworks exist but require more complex setup:

- **obra/superpowers**: Plugin-based skills system (requires plugin marketplace)
- **dimitritholen/gustav**: Sprint management (requires manual git clone)
- **disler/infinite-agentic-loop**: Parallel agents (custom slash commands)
- **ruvnet/claude-flow**: Enterprise architecture (npm global install)

**Recommendation**: Start with the ciign agents above. They provide 95% of what you need for development work.

## 📋 Framework Details

| Framework | Type | Count | Installation | Best For |
|-----------|------|-------|--------------|----------|
| **ciign/agentic-engineering** | Agents | 10 | ✅ Simple curl | Full-stack projects |
| **obra/superpowers** | Skills | 21 | Plugin marketplace | Quality-focused dev |
| **dimitritholen/gustav** | Commands | 7 | Manual git clone | Agile teams |
| **disler/infinite-agentic-loop** | Commands | 2 | Custom slash cmd | Content creation |
| **ruvnet/claude-flow** | Agents | 64+ | npm global install | Enterprise systems |

## 🎯 Quick Start

1. **Install agents**: `curl -sSL https://raw.githubusercontent.com/ciign/agentic-engineering/main/setup-claude-agents.sh | bash`
2. **Restart Claude**: `claude`
3. **List agents**: `/agents`
4. **Use agents**: `@backend-specialist help design this API`

That's it! You now have a complete development team at your fingertips. 🚀