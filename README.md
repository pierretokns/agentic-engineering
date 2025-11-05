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
```

That's it! The agents are now ready to use in your project.

## 📦 What's Included

This repository contains 12 specialized agents covering every aspect of software development:

### 🏗️ Engineering Agents
- **Full-Stack Developer** - Complete web application development from frontend to backend
- **Backend Specialist** - Server-side systems, APIs, databases, and scalability
- **Frontend Specialist** - User interfaces, accessibility, performance, and modern frameworks
- **DevOps Engineer** - Infrastructure, CI/CD, deployment, and monitoring

### 🔍 Code Quality Agents
- **Code Reviewer** - Comprehensive code reviews for correctness, security, and maintainability
- **Debugger** - Systematic bug identification and fixing methodology
- **Refactoring Specialist** - Improve code quality and reduce technical debt

### 🎯 Architecture & Design
- **System Architect** - Design scalable systems and make architectural decisions
- **Database Designer** - Schema design, query optimization, and data modeling

### 🔒 Security & Documentation
- **Security Auditor** - Identify vulnerabilities and implement security best practices
- **Documentation Writer** - Technical documentation, APIs, guides, and tutorials
- **Test Writer** - Comprehensive test suites across unit, integration, and E2E

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

# Architecture planning
@system-architect design the overall system
@database-designer create the data model
@security-auditor review security considerations

# Code improvement
@debugger help me fix this race condition
@refactoring-specialist improve this complex function
@documentation-writer document this API
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
    ├── security-auditor.md
    ├── documentation-writer.md
    └── refactoring-specialist.md
```

## 🎓 Agent Capabilities

Each agent includes:
- **Clear Responsibilities** - Specific areas of expertise
- **Technical Knowledge** - Frameworks, tools, and best practices
- **Practical Patterns** - Code examples showing good vs. bad patterns
- **Structured Approaches** - Step-by-step methodologies
- **Communication Guidelines** - How the agent provides feedback

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
1. `@backend-specialist` or `@frontend-specialist` - Build the feature
2. `@test-writer` - Add comprehensive tests
3. `@code-reviewer` - Review the implementation

**Improving Existing Code**
1. `@debugger` - Fix bugs
2. `@refactoring-specialist` - Improve code quality
3. `@security-auditor` - Check for vulnerabilities
4. `@documentation-writer` - Update documentation

**Deployment & Operations**
1. `@devops-engineer` - Set up CI/CD and infrastructure
2. `@security-auditor` - Security review before deployment
3. `@documentation-writer` - Create runbooks and deployment docs

### Tips for Best Results

- **Be Specific**: Provide context about your project, tech stack, and requirements
- **Combine Agents**: Use multiple agents for complex tasks
- **Iterate**: Ask follow-up questions to refine solutions
- **Share Context**: Include relevant code, error messages, or architectural diagrams
- **Start Small**: Begin with one agent, then expand as needed

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
- Data Scientist / ML Engineer
- Performance Optimizer
- Accessibility Specialist
- API Designer
- Infrastructure as Code Specialist
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
