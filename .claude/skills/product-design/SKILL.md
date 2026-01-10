---
name: product-design
description: Design MVPs for web, mobile, and SaaS applications through adaptive interviews that achieve buildable clarity. Use when a user wants to define, scope, or document an application idea, or when they mention MVP, product requirements, PRD, app idea, or need help turning a concept into something implementable.
---

# Product Design

Interview users to extract implementation-ready requirements, then produce a PRD with enough detail to build with minimal ambiguity.

## Interview Workflow

### Phase 1: Core Concept (always)

Start here. Get the essential shape of the product.

1. **What is it?** One sentence describing what the app does
2. **Who uses it?** Primary user roles (2-4 max for MVP)
3. **Core actions?** What can each role do? (aim for 3-5 key actions per role)
4. **Platform?** Web, mobile, both? Any platform constraints?

Exit when: You can explain the app to someone in 30 seconds.

### Phase 2: User Scenarios (always)

For each role, define concrete scenarios at the feature level.

For each key action, ask:
- "Walk me through exactly what happens when [role] does [action]"
- "What information do they need to see? What do they input?"
- "What happens after? Where do they end up?"

Probe for edge cases:
- "What if [input is missing/invalid]?"
- "What if [user cancels midway]?"
- "Are there limits? (max items, required fields, etc.)"

Exit when: You could sketch every screen and know what each button does.

### Phase 3: Technical Context (adaptive)

Ask only what's relevant. Skip if not applicable.

| Topic | When to ask | Key questions |
|-------|-------------|---------------|
| **Auth** | Multi-user apps | Login method? Social auth? Roles/permissions? |
| **Integrations** | Mentioned or implied | Which services? What data flows between? |
| **Data** | Complex relationships | What are the core entities? How do they relate? |
| **Payments** | Transactional apps | Payment provider? Subscription vs one-time? |
| **Notifications** | User engagement needed | Email? Push? What triggers them? |
| **Files/Media** | Content-heavy apps | Upload types? Size limits? Storage needs? |

Exit when: No technical unknowns that would block implementation.

### Phase 4: Scope Boundaries (always)

Explicitly define the MVP boundary.

Ask:
- "What's the one thing this MVP absolutely must do well?"
- "What features are you tempted to include but could wait for v2?"
- "Any hard constraints? (timeline, budget, must use X technology)"

Create explicit IN/OUT lists. Push back on scope creep:
- "That sounds like a v2 feature. For MVP, could we [simpler alternative]?"

Exit when: Clear line between MVP and future work.

### Interview Principles

**Go deeper when:**
- Answer is vague ("users can manage their stuff")
- Multiple interpretations possible
- Edge cases not addressed
- Implementation would require guessing

**Move on when:**
- Answer is concrete and specific
- You could write the code/design the screen
- Edge cases covered or explicitly deferred

**Phrase questions as:**
- "Walk me through..." (gets concrete steps)
- "What exactly happens when..." (forces specificity)
- "Show me an example of..." (grounds in reality)
- "What if..." (surfaces edge cases)

## PRD Template

After the interview, produce this document:

```markdown
# [Product Name] - MVP PRD

## Overview
[2-3 sentences: what it is, who it's for, core value proposition]

## Roles
| Role | Description | Key Permissions |
|------|-------------|-----------------|
| [Role 1] | [Who they are] | [What they can do] |

## User Scenarios

### [Scenario Name]
**Role:** [Which role]
**Goal:** [What they're trying to accomplish]

**Flow:**
1. [Step with specific UI/action]
2. [Next step]
3. [Outcome]

**Edge Cases:**
- [Edge case]: [How it's handled]

**Acceptance Criteria:**
- [ ] [Specific, testable criterion]
- [ ] [Another criterion]

[Repeat for each scenario]

## Scope

### In Scope (MVP)
- [Feature/capability 1]
- [Feature/capability 2]

### Out of Scope (Future)
- [Deferred feature 1] - [brief reason why deferred]
- [Deferred feature 2]

## Technical Context

### Platform
[Web/Mobile/Both - any specific requirements]

### Integrations
| Service | Purpose | Data Flow |
|---------|---------|-----------|
| [Service] | [Why needed] | [What data, which direction] |

### Key Entities
[Only if helpful - brief description of core data objects and relationships]

### Constraints
- [Any technical constraints, required technologies, etc.]

## Open Questions
- [Any unresolved items that need answers before/during implementation]
```

## Workflow Summary

```
START
  │
  ▼
┌─────────────────────────┐
│ Phase 1: Core Concept   │ ◄── Always. Get the 30-second pitch.
└──────────┬──────────────┘
           │
           ▼
┌─────────────────────────┐
│ Phase 2: User Scenarios │ ◄── Always. Could you sketch every screen?
└──────────┬──────────────┘
           │
           ▼
┌─────────────────────────┐
│ Phase 3: Technical Ctx  │ ◄── Adaptive. Only relevant topics.
└──────────┬──────────────┘
           │
           ▼
┌─────────────────────────┐
│ Phase 4: Scope Boundary │ ◄── Always. Clear MVP vs future line.
└──────────┬──────────────┘
           │
           ▼
┌─────────────────────────┐
│ Generate PRD            │
└─────────────────────────┘
```

## Exit Criteria

Ready to produce PRD when ALL are true:
- [ ] Can explain the app in 30 seconds
- [ ] Could sketch every screen for MVP
- [ ] Know what every button/action does
- [ ] Edge cases addressed or explicitly deferred
- [ ] Clear MVP boundary established
- [ ] No technical unknowns that block implementation
