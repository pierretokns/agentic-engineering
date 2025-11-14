# Agentic Engineering 🤖

A comprehensive collection of specialized AI agents for software development with Claude Code. These agents help you build better software faster by providing expert guidance across all aspects of development.

**Transform your development workflow with AI-powered engineering specialists.**

[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-blue.svg)](http://unlicense.org/)
[![Claude Code](https://img.shields.io/badge/Claude-Code-blueviolet)](https://docs.claude.com/en/docs/claude-code)

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/ciign/agentic-engineering.git
cd agentic-engineering

# Run the setup script
chmod +x setup-claude-agents.sh
./setup-claude-agents.sh

# Start Claude Code from your project directory
claude
```

That's it! The agents are now ready to use in your project.

## 📦 What's Included

This repository contains 10 specialized agents covering every aspect of software development:

### 🏗️ Development Agents
- **full-stack-developer** - Complete web application development from frontend to backend
- **backend-specialist** - Server-side systems, APIs, databases, and scalability
- **frontend-specialist** - User interfaces, accessibility, performance, and modern frameworks

### 🔍 Code Quality Agents
- **code-reviewer** - Comprehensive code reviews for correctness, security, and maintainability
- **debugger** - Systematic bug identification and fixing methodology
- **test-writer** - Comprehensive test suites across unit, integration, and E2E

### 🎯 Architecture & Infrastructure
- **system-architect** - Design scalable systems and make architectural decisions
- **database-designer** - Schema design, query optimization, and data modeling
- **devops-engineer** - Infrastructure, CI/CD, deployment, and monitoring

### 🔒 Security
- **security-auditor** - Identify vulnerabilities and implement security best practices

## 💡 Usage Examples

### Single Agent
```bash
# Get help from a specific agent
@full-stack-developer build a REST API with authentication

@frontend-specialist create a responsive dashboard with React

@database-designer design a schema for an e-commerce platform
```

### Multiple Agents
```bash
# Combine agents for complex tasks
@backend-specialist @database-designer create a scalable user service

@code-reviewer @security-auditor review this authentication implementation

@system-architect @devops-engineer design deployment architecture for microservices
```

### Workflow Examples
```bash
# Development workflow
@full-stack-developer implement user registration
@test-writer add tests for user registration
@code-reviewer review the implementation

# Backend development
@backend-specialist design the API architecture
@database-designer create the data model
@security-auditor review security considerations

# Debugging workflow
@debugger help me fix this race condition
@code-reviewer verify the fix is correct
@test-writer add tests to prevent regression

# DevOps workflow
@devops-engineer set up CI/CD pipeline
@system-architect review the deployment architecture
@security-auditor check for security misconfigurations
```

## 📁 Directory Structure

After running the setup script, you'll have:

```
.claude/
└── agents/
    ├── full-stack-developer.md
    ├── backend-specialist.md
    ├── frontend-specialist.md
    ├── code-reviewer.md
    ├── debugger.md
    ├── devops-engineer.md
    ├── test-writer.md
    ├── system-architect.md
    ├── database-designer.md
    └── security-auditor.md
```

## 🎨 Agent Visual Guide

Each agent has a unique color in the Claude Code UI:

| Agent | Color | Primary Focus |
|-------|-------|---------------|
| 🟣 full-stack-developer | Purple | End-to-end development |
| 🔵 backend-specialist | Blue | Server-side engineering |
| 🟢 frontend-specialist | Green | User interfaces & UX |
| 🔴 code-reviewer | Red | Code quality & reviews |
| 🟠 debugger | Orange | Bug fixing & diagnostics |
| 🟡 test-writer | Yellow | Testing strategies |
| 🟣 system-architect | Magenta | System design |
| 🟤 database-designer | Brown | Data modeling |
| 🔵 devops-engineer | Cyan | Infrastructure & deployment |
| 🔴 security-auditor | Red | Security analysis |

## 🎓 Agent Capabilities

### full-stack-developer
- Complete web application development
- Frontend + Backend + Database integration
- Modern framework expertise (React, Node.js, etc.)
- Best practices across the stack

### backend-specialist
- API design (REST, GraphQL, gRPC)
- Database optimization and scaling
- Microservices and distributed systems
- Performance and reliability patterns

### frontend-specialist
- Responsive and accessible UI development
- Modern frameworks (React, Vue, Angular)
- Performance optimization (bundle size, lazy loading)
- State management and component architecture

### code-reviewer
- Systematic code review methodology
- Security vulnerability identification
- Performance bottleneck detection
- Constructive feedback with severity levels

### debugger
- Methodical debugging approach
- Root cause analysis
- Performance profiling
- Bug prevention strategies

### test-writer
- Unit, integration, and E2E testing
- Test-driven development (TDD)
- Testing best practices and patterns
- Coverage strategies

### system-architect
- Scalable system design
- Architecture patterns (microservices, event-driven, etc.)
- Technology selection and tradeoffs
- Documentation of architectural decisions

### database-designer
- Schema design and normalization
- Query optimization
- Indexing strategies
- Migration planning

### devops-engineer
- CI/CD pipeline design
- Container orchestration (Docker, Kubernetes)
- Infrastructure as Code (Terraform, CloudFormation)
- Monitoring and observability

### security-auditor
- OWASP Top 10 vulnerability detection
- Security best practices implementation
- Penetration testing mindset
- Compliance and security standards

## 🛠️ Requirements

- [Claude Code](https://docs.claude.com/en/docs/claude-code) installed
- Bash (for the setup script) - works on:
  - macOS
  - Linux
  - Windows (Git Bash, WSL, or Cygwin)

## 📖 Best Practices

### When to Use Each Agent

**Starting a New Project**
1. `@system-architect` - Design the architecture
2. `@database-designer` - Design the data model
3. `@full-stack-developer` - Implement core features

**Building Features**
1. `@backend-specialist` or `@frontend-specialist` - Build specific layers
2. `@test-writer` - Add comprehensive tests
3. `@code-reviewer` - Review the implementation

**Fixing Issues**
1. `@debugger` - Diagnose and fix bugs
2. `@test-writer` - Add regression tests
3. `@code-reviewer` - Verify the fix

**Deployment & Operations**
1. `@devops-engineer` - Set up CI/CD and infrastructure
2. `@security-auditor` - Security review before deployment
3. `@system-architect` - Review architecture for production readiness

### Tips for Best Results

- **Be Specific**: Provide context about your project, tech stack, and requirements
- **Share Code**: Include relevant code snippets for better analysis
- **Iterate**: Ask follow-up questions to refine solutions
- **Combine Agents**: Use multiple agents for comprehensive solutions
- **Learn from Feedback**: Each agent provides educational insights

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/new-agent`)
3. **Make your changes**
4. **Test thoroughly**
5. **Commit your changes** (`git commit -m 'Add new agent for X'`)
6. **Push to the branch** (`git push origin feature/new-agent`)
7. **Open a Pull Request**

### Ideas for New Agents
- Mobile App Developer (iOS/Android)
- Data Engineer (ETL, data pipelines)
- ML/AI Engineer
- Performance Optimizer
- Documentation Writer
- Refactoring Specialist
- Accessibility Specialist
- Site Reliability Engineer

## 📄 License

This project is released into the public domain under The Unlicense. You can do whatever you want with it - no attribution required!

See the [LICENSE](LICENSE) file for details or visit [unlicense.org](https://unlicense.org).

## 🙏 Acknowledgments

- Built for use with [Claude Code](https://www.anthropic.com/claude/code)
- Inspired by best practices from the software engineering community
- Contributions and feedback from developers worldwide

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/ciign/agentic-engineering/issues)
- **Discussions**: [GitHub Discussions](https://github.com/ciign/agentic-engineering/discussions)
- **Documentation**: [Claude Code Docs](https://docs.claude.com/en/docs/claude-code)

## 🌟 Star History

If you find this useful, please consider giving it a star! ⭐

## 📊 Project Stats

![GitHub stars](https://img.shields.io/github/stars/ciign/agentic-engineering?style=social)
![GitHub forks](https://img.shields.io/github/forks/ciign/agentic-engineering?style=social)
![GitHub issues](https://img.shields.io/github/issues/ciign/agentic-engineering)
![GitHub pull requests](https://img.shields.io/github/issues-pr/ciign/agentic-engineering)

---

**Made with ❤️ for the developer community**

*Happy coding with Claude Code! 🚀*
