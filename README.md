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

## 🎯 Quickstart — run repo root scripts from main

Below are safe, copy-pasteable examples to run any shell script that lives in this repository root on the `main` branch. Replace <script.sh> with the script name you want to run (for example `setup-obra-superpowers.sh`). These examples use the raw GitHub URLs for the `pierretokns/agentic-engineering` repo.

Important safety note: always review downloaded scripts before running them. The "safe" pattern below downloads the script so you can inspect it first. The "quick" pattern pipes to bash directly (convenient but less safe).

Safe — download, inspect, then run:

```bash
curl -fsSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/<script.sh> -o /tmp/<script.sh>
# inspect the file (open with your editor or pager)
less /tmp/<script.sh>
# then run
bash /tmp/<script.sh>
```

Quick — pipe to bash (use with caution):

```bash
curl -fsSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/<script.sh> | bash -s -- [args]
```

Examples for scripts in this repo root (replace or add args as needed):

Safe examples

```bash
curl -fsSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-ciign-agentic-engineering.sh -o /tmp/setup-ciign-agentic-engineering.sh && less /tmp/setup-ciign-agentic-engineering.sh && bash /tmp/setup-ciign-agentic-engineering.sh

curl -fsSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-obra-superpowers.sh -o /tmp/setup-obra-superpowers.sh && less /tmp/setup-obra-superpowers.sh && bash /tmp/setup-obra-superpowers.sh

curl -fsSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-dimitritholen-gustav.sh -o /tmp/setup-dimitritholen-gustav.sh && less /tmp/setup-dimitritholen-gustav.sh && bash /tmp/setup-dimitritholen-gustav.sh

curl -fsSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-disler-infinite-agentic-loop.sh -o /tmp/setup-disler-infinite-agentic-loop.sh && less /tmp/setup-disler-infinite-agentic-loop.sh && bash /tmp/setup-disler-infinite-agentic-loop.sh

curl -fsSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-gwendall-superclaude.sh -o /tmp/setup-gwendall-superclaude.sh && less /tmp/setup-gwendall-superclaude.sh && bash /tmp/setup-gwendall-superclaude.sh

curl -fsSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-ruvnet-claude-flow.sh -o /tmp/setup-ruvnet-claude-flow.sh && less /tmp/setup-ruvnet-claude-flow.sh && bash /tmp/setup-ruvnet-claude-flow.sh
```

Quick (pipe) examples

```bash
curl -fsSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-ciign-agentic-engineering.sh | bash -s --
curl -fsSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-obra-superpowers.sh | bash -s --
curl -fsSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-dimitritholen-gustav.sh | bash -s --
curl -fsSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-disler-infinite-agentic-loop.sh | bash -s --
curl -fsSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-gwendall-superclaude.sh | bash -s --
curl -fsSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-ruvnet-claude-flow.sh | bash -s --
```

If you prefer a small helper function you can add to your shell session:

```bash
run_repo_script() { 
	script="$1"; shift
	curl -fsSL "https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/${script}" | bash -s -- "$@"
}

# usage: run_repo_script setup-obra-superpowers.sh arg1 arg2
```

Restart Claude Code as needed (example):

```bash
claude
```

You're all set — pick a script from the repo root and use either the safe or quick pattern above.
