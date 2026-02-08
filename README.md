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
- Posts coverage summary comments on PRs via `vitest-coverage-report-action` or `jest-coverage-comment`
- Sets up husky + lint-staged pre-commit hooks for lint, format, and typecheck
- Adds Claude Code hook guard to block `--no-verify` and prevent agents from bypassing pre-commit hooks
- Installs Vercel best practices via `npx add-skill vercel-labs/agent-skills`
- Enforces high code coverage thresholds (80%) appropriate for LLM coding agents
- Detects existing config and only adds what's missing

**task-implementation** - Implement a task end-to-end: read task spec, create git worktree, write tests (TDD), implement feature, verify coverage thresholds, update docs, push branch, and create PR.

- Triggers: "implement task 1.2.3", "work on the auth task", "build task 3.1.1"
- Reads task specs from `docs/tasks/task-<id>.md` (falls back to `docs/TASKS.md`)
- Reads `docs/PRD.md`, `docs/ARCHITECTURE.md` for context; `docs/BRAND-GUIDELINES.md` for UI work
- Strict TDD: writes failing tests first, then implements minimum code to pass
- Enforces 80% coverage thresholds (statements, branches, functions, lines)
- Handles review feedback loops (reads `## Review Feedback` section from task spec)
- Ships: commits, pushes feature branch, creates PR with `gh`

**review-pr** - Review pull requests against task specifications.

- Triggers: "review PR", "code review", "is this ready to merge", "check my PR"
- Reads task spec and branch diff, verifies acceptance criteria, audits test coverage
- Checks for correctness, security (OWASP top 10), architectural adherence, and scope creep
- Output: Structured verdict (APPROVE / REQUEST CHANGES) with evidence per criterion and a Manual QA Checklist
- Posts review findings as a comment on the PR via `gh pr comment`

**agent-orchestration** - End-to-end project orchestration from idea to implementation.

- Triggers: "build this app", "implement an MVP", or when you want full project automation
- Coordinates: product-design → architecture → task-decomposition skills
- Delegates to: task-spec-generator, task-implementer, code-reviewer, and qa-tester agents
- Per-task loop: implement → code review → fix feedback → merge
- Per-story QA: after all tasks in a story are merged, QA tests the complete user flow end-to-end
- Resumable: introspects filesystem and git state to pick up where it left off if interrupted

#### Agents

**task-implementer** - Wraps the task-implementation skill. TDD workflow in isolated git worktrees.

**code-reviewer** - Wraps the review-pr skill. Produces APPROVE/REQUEST CHANGES verdicts and writes feedback to task specs.

**qa-tester** - Wraps the qa-verification skill. Visual QA via Playwright against Vercel preview URLs. Commits screenshots to the PR branch and posts a QA report with inline images as a PR comment.

**task-spec-generator** - Generate detailed task specifications from TASKS.md, cross-referenced with PRD and Architecture docs. Creates `docs/tasks/task-<id>.md` for each task with concrete test plans (unit, integration, edge cases) and expanded acceptance criteria.
