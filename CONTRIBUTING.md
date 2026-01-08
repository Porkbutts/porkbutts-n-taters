# Contributing

<!--
  TEMPLATE: Customize this guide for your project's contribution workflow.
  This template is designed for projects where both humans and AI agents contribute.
-->

> **Template Notice**: This is a placeholder. Customize this guide for your project.

Thank you for your interest in contributing to this project!

## Table of Contents

- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [For AI Agents](#for-ai-agents)
- [Code Standards](#code-standards)
- [Submitting Changes](#submitting-changes)
- [Getting Help](#getting-help)

## Getting Started

### Prerequisites

<!-- List required tools and versions -->
- Tool 1 (version X.X+)
- Tool 2 (version X.X+)

### Setup

```bash
# Clone the repository
git clone https://github.com/your-org/your-repo.git
cd your-repo

# Install dependencies
# npm install / pip install -r requirements.txt / go mod download

# Run tests to verify setup
# npm test / pytest / go test ./...
```

## Development Workflow

1. **Check existing issues** - Look for open issues or create a new one
2. **Create a branch** - Use descriptive branch names: `feature/add-auth`, `fix/login-bug`
3. **Make changes** - Follow the code standards below
4. **Test your changes** - Ensure all tests pass
5. **Submit a PR** - Use the PR template and link related issues

## For AI Agents

When contributing as an AI agent (Claude, Copilot, etc.):

### Before Starting Work

1. Read `.claude/CLAUDE.md` for project-specific instructions
2. Review relevant documentation in `docs/`:
   - `10-prd.md` for product requirements
   - `30-tech-design.md` for architectural decisions
   - `40-backlog.md` for context on the work item
3. Check `docs/decisions.md` for important architectural decisions

### Task Workflow

1. If a task specification exists in `docs/tasks/`, follow it precisely
2. Implement according to acceptance criteria
3. Write tests as specified
4. Update `CHANGELOG.md` with notable changes
5. Create atomic commits with clear messages

### Guidelines

- **Ask before assuming** - If requirements are unclear, ask for clarification
- **Stay in scope** - Don't add features not requested
- **Maintain traceability** - Reference issue numbers in commits
- **Document decisions** - Update `docs/decisions.md` for significant choices

## Code Standards

### General Principles

- Write clear, self-documenting code
- Follow existing patterns in the codebase
- Keep functions focused and reasonably sized
- Handle errors appropriately

### Commit Messages

Use clear, descriptive commit messages:

```
feat: add user authentication endpoint

- Implement JWT-based auth
- Add login and logout routes
- Include rate limiting

Fixes #123
```

Prefixes: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

### Testing

- Write tests for new functionality
- Ensure existing tests pass
- Aim for meaningful coverage, not just high numbers

## Submitting Changes

### Pull Request Process

1. Update documentation if needed
2. Add tests for new functionality
3. Ensure CI passes
4. Fill out the PR template completely
5. Request review from appropriate team members

### Review Process

- Address reviewer feedback promptly
- Keep discussions constructive
- Squash commits if requested

## Getting Help

- **Questions**: Open a discussion or issue
- **Bugs**: Use the bug report template
- **Features**: Use the feature request template

<!-- Add contact information or links to community channels -->
