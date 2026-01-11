# Porkbutts n' Taters

![Cow and Chicken enjoying porkbutts n' taters](assets/porkbutts-n-taters.jpg)

An opinionated collection of skills to add structured workflows to vibecoding.

*Inspired by Cow and Chicken's love of porkbutts n' taters.*

## Installation

### From GitHub

```bash
/plugin marketplace add Porkbutts/porkbutts-n-taters
/plugin install effective-design@porkbutts-n-taters
```

### For Local Development

```bash
/plugin marketplace add /path/to/this/repo
/plugin install effective-design@porkbutts-n-taters
```

Then restart Claude Code.

## Plugins

### effective-design

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

**functional-prototype** - Build working prototypes from PRDs with mock data and stubbed integrations to validate flows before full implementation.

- Triggers: "build a prototype", "functional prototype", "make a demo", "implement this PRD", "prototype this spec"
- Output: Working clickable prototype with `docs/next-steps.md` explaining how to replace stubs with real integrations
