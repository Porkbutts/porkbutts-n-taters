# Porkbutts n' Taters

![Cow and Chicken enjoying porkbutts n' taters](assets/porkbutts-n-taters.jpg)

An opinionated collection of skills to add structured workflows to vibecoding.

*Inspired by Cow and Chicken's love of porkbutts n' taters.*

## Installation

### From GitHub

```bash
/plugin marketplace add Porkbutts/porkbutts-n-taters
/plugin install vibe-coding@porkbutts-n-taters
```

### For Local Development

```bash
/plugin marketplace add /path/to/this/repo
/plugin install vibe-coding@porkbutts-n-taters
```

Then restart Claude Code.

## Plugins

### vibe-coding

Personal workflow for getting better results out of vibecoding.

#### Skills

**product-design** - Design MVPs through adaptive interviews that achieve buildable clarity. Guides you through interviewing to extract implementation-ready requirements, then produces a PRD.

- Triggers when you want to define, scope, or document an application idea
- Interview phases: Core Concept, User Scenarios, Technical Context, Scope Boundaries
- Output: Structured PRD with roles, scenarios, acceptance criteria, and technical context

**reflect** - Capture lessons from conversation after Claude made mistakes or needed correction. Frames insights as "if we were starting over" guidance for future sessions.

- Trigger with "reflect", "review our mistakes", "learn from this", or similar phrases after a back-and-forth where you course-corrected Claude
- Validates the lesson with you before writing to ensure the actual root cause is captured (not red herrings)
- Output: Dated markdown file in `~/.claude/lessons/` (e.g., `2025-01-15-expo-sdk-version.md`) with the right approach and what to avoid
- Automatically updates `~/.claude/CLAUDE.md` with a lessons table for proactive consultation during planning

**architecture** - Design technical architecture from a PRD. Transform product requirements into implementation-ready technical specs.

- Use when you want to create an architecture document, define system design, or plan technical implementation
- Reads from `docs/PRD.md` and outputs `docs/ARCHITECTURE.md`
- Includes: tech stack decisions with rationale, directory structure, key abstractions, data flow, and anti-patterns to avoid

**functional-prototype** - Build working prototypes from PRDs with mock data and stubbed integrations to validate flows before full implementation.

- Triggers: "build a prototype", "functional prototype", "make a demo", "implement this PRD", "prototype this spec"
- Output: Working clickable prototype; optionally generates `docs/integration-guide.md` (asks first) documenting how to replace stubs with real integrations

**task-decomposition** - Break down PRD and Architecture into implementable engineering tasks.

- Use when you want to create a task list, plan implementation work, or decompose features into stories and tasks
- Reads from `docs/PRD.md` and `docs/ARCHITECTURE.md`, outputs `docs/TASKS.md`
- Structure: Epics → User Stories → Atomic Tasks with acceptance criteria and test approaches

**bootstrap-project** - Bootstrap a project with CI/CD, pre-commit hooks, and framework best practices.

- Triggers: "bootstrap project", "setup CI", "add pre-commit hooks", "add husky", "project setup"
- Ensures GitHub CI workflow exists for lint, typecheck, test with coverage, and build
- Sets up husky + lint-staged pre-commit hooks for lint, format, and typecheck
- Installs Vercel best practices via `npx add-skill vercel-labs/agent-skills`
- Enforces high code coverage thresholds (80%) appropriate for LLM coding agents
- Detects existing config and only adds what's missing

**orchestrate** - End-to-end project orchestration from idea to implementation.

- Triggers: "build this app", "implement an MVP", or when you want full project automation
- Coordinates: product-design → architecture → task-decomposition skills
- Delegates to: task-spec-generator, task-implementer, and code-reviewer agents
- Resumable: introspects filesystem and git state to pick up where it left off if interrupted
- Handles parallel task execution where dependencies allow
- Verifies build and tests pass before merging each task to main

#### Agents

**task-implementer** - Implement tasks using TDD workflow. Creates git worktree, verifies build and tests pass (baseline check), then writes tests first, implements feature, and commits. Reads task specs from `docs/tasks/task-<id>.md` and handles review feedback loops.

**code-reviewer** - Review code changes against task specifications. Changes to worktree directory, verifies build and tests pass (baseline check), then performs diff, evaluates against requirements, and either approves or writes feedback to task-spec for implementer to address.

**task-spec-generator** - Generate individual task specification files from TASKS.md. Creates `docs/tasks/task-<id>.md` for each task with full context for implementers.

**qa-verification** - Human-like QA verification using Playwright MCP. Navigates the app like a user, takes screenshots at every step, and flags visual issues (modals off-screen, overlapping elements, broken layouts) even beyond acceptance criteria. Auto-selects Google accounts; pauses only for credential-based login.

- Triggers: "verify this PR", "QA this feature", "visual test", "check the UI", "screenshot test"
- Works against localhost, preview/staging, and production URLs
- Reads task specs from `docs/tasks/task-<id>.md` for acceptance criteria
- Output: QA report with acceptance criteria results + additional visual issues found
