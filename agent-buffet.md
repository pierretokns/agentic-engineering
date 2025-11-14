# Fast Claude Agents / Framework Setup

## 🚀 Installation Commands

Choose from these excellent Claude Code agent collections and frameworks:

### **🎯 Development Agents (ciign/agentic-engineering)**
Comprehensive development lifecycle agents - 10 specialized roles
```bash
curl -sSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-claude-agents.sh | bash
```
**Agents:** full-stack-developer, backend-specialist, frontend-specialist, code-reviewer, debugger, devops-engineer, test-writer, system-architect, database-designer, security-auditor

### **⚡ Skills Framework (obra/superpowers)**
Evidence-based skills system with 21 proven techniques
```bash
curl -sSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-obra-superpowers.sh | bash
```
**Skills:** brainstorming, test-driven-development, systematic-debugging, root-cause-tracing, and 17 more

### **🏃‍♂️ Sprint Orchestrator (dimitritholen/gustav)**
Agile development workflow manager with TDD methodology
```bash
curl -sSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-dimitritholen-gustav.sh | bash
```
**Commands:** /gustav:planner, /gustav:executor, /gustav:enhance, /gustav:validator, /gustav:velocity, /gustav:audit, /gustav:help

### **🔄 Infinite Loop System (disler/infinite-agentic-loop)**
Parallel agent coordination for iterative content generation
```bash
curl -sSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-disler-infinite-agentic-loop.sh | bash
```
**Commands:** /infinite, /prime - For infinite generation workflows

### **🏗️ Enterprise Architecture (ruvnet/claude-flow)**
64 specialized agents with hierarchical organization and swarm orchestration
```bash
curl -sSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-ruvnet-claude-flow.sh | bash
```
**Features:** Hybrid memory system, 25+ skills, MCP protocol integration, SPARC methodology


---

## 🧪 Testing Instructions

### Test Individual Setups
```bash
# Clear existing agents
rm -rf .claude

# Test each setup (choose one)
curl -sSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-claude-agents.sh | bash

# Verify installation
ls -la .claude/agents/
```

### Test All Together
```bash
# Clear existing setup
rm -rf .claude

# Install all frameworks
curl -sSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-claude-agents.sh | bash
curl -sSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-obra-superpowers.sh | bash
curl -sSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-dimitritholen-gustav.sh | bash
curl -sSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-disler-infinite-agentic-loop.sh | bash
curl -sSL https://raw.githubusercontent.com/pierretokns/agentic-engineering/main/setup-ruvnet-claude-flow.sh | bash

# Verify all installed
ls -la .claude/
```

### Usage After Installation
```bash
# Restart Claude Code in your project directory
claude

# List available agents/commands
/agents
/commands
```

---

## 📋 Framework Comparison

| Framework | Type | Size | Focus | Best For |
|-----------|------|------|-------|----------|
| **ciign/agentic-engineering** | Agents | 10 agents | Complete development lifecycle | Full-stack projects |
| **obra/superpowers** | Skills | 21 skills | Evidence-based techniques | Quality-focused development |
| **dimitritholen/gustav** | Commands | 7 commands | Sprint/TDD workflows | Agile teams |
| **disler/infinite-agentic-loop** | Commands | 2 commands | Parallel generation | Content creation |
| **ruvnet/claude-flow** | Agents | 64+ agents | Enterprise architecture | Large-scale systems |

Choose the framework that best matches your development needs! 🚀