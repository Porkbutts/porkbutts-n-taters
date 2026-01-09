# PRD Interview

Conduct an interactive interview to create a Product Requirements Document (PRD).

## Interview Process

Ask questions in phases, waiting for user responses before proceeding. Use the AskUserQuestion tool when appropriate for structured choices, and conversational questions for open-ended responses.

### Phase 1: Problem & Vision

1. What problem are you trying to solve?
2. Who experiences this problem? (target users/personas)
3. How are people currently solving this problem?
4. What is your product's vision in one sentence?

### Phase 2: Users & Context

1. Describe your primary user persona (role, goals, pain points)
2. Are there secondary users? If so, describe them
3. What is the user's environment/context when using this product?

### Phase 3: Goals & Success

1. What are the top 3 goals for this product?
2. How will you measure success? (specific metrics)
3. What does "done" look like for the initial version?

### Phase 4: Features & Requirements

1. What are the must-have features (P0)?
2. What are the nice-to-have features (P1)?
3. What is explicitly out of scope?

### Phase 5: Constraints & Risks

1. Are there technical constraints? (platforms, integrations, performance)
2. Are there business constraints? (timeline, budget, compliance)
3. What are the biggest risks or unknowns?

## Output

After gathering responses, generate the PRD document at `docs/10-prd.md` using this structure:

```markdown
# Product Requirements Document

## Overview
[Product name and one-sentence description]

## Problem Statement
[The problem being solved and why it matters]

## Target Users

### Primary Persona
- **Role**:
- **Goals**:
- **Pain Points**:

### Secondary Personas
[If applicable]

## Product Vision
[One-sentence vision statement]

## Goals & Success Metrics

### Goals
1.
2.
3.

### Success Metrics
-

## Requirements

### Must Have (P0)
- [ ]

### Nice to Have (P1)
- [ ]

### Out of Scope
-

## Constraints

### Technical
-

### Business
-

## Risks & Mitigations
| Risk | Impact | Mitigation |
|------|--------|------------|
| | | |

## Open Questions
-
```

## Instructions

1. Start with Phase 1, asking questions conversationally
2. Summarize what you heard after each phase before moving on
3. If answers are unclear, ask clarifying follow-up questions
4. After all phases, present a draft PRD for review
5. Incorporate feedback and write final PRD to `docs/10-prd.md`
