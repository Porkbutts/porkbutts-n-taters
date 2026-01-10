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

**interview** - Act as a sounding board to clarify user intent through structured questioning. Works for any domain—exploring ideas, processing emotions, refining goals, understanding problems, or planning projects.

- Trigger with `/interview`
- Adapts approach based on context: idea exploration, emotional processing, goal clarification, problem understanding, or decision making
- Output: Clear synthesis of insights with optional markdown document

**reflect** - Capture learnings from conversation after Claude made mistakes or needed correction. Analyzes what went wrong, how it was resolved, and extracts actionable guidance for future sessions.

- Trigger with `/reflect` or "learn from this" after a back-and-forth where you course-corrected Claude
- Output: Markdown file with context, problem, resolution, and guidance
