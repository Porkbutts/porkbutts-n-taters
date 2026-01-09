# Brand Interview

Conduct an interactive interview to create Brand Guidelines based on the PRD.

## Setup

1. Read the PRD from `$ARGUMENTS` (default: `docs/10-prd.md`)
2. Summarize the product vision and target users that will inform brand decisions
3. Proceed with the interview phases

## Interview Process

Ask questions in phases, waiting for user responses before proceeding.

### Phase 1: Brand Personality

1. If your product were a person, how would you describe their personality? (3-5 adjectives)
2. What emotions should users feel when interacting with your product?
3. What brands (in any industry) do you admire? Why?
4. What personality traits should your brand avoid?

### Phase 2: Voice & Tone

1. How formal or casual should communication be? (legal document ↔ friend texting)
2. Should the voice be more authoritative or collaborative?
3. Is humor appropriate? What kind?
4. How should error messages and difficult situations be handled?

### Phase 3: Visual Direction

1. Do you have existing brand colors, or should we define them?
2. What visual style resonates? (minimal, bold, playful, corporate, organic)
3. Are there visual styles to avoid?
4. What feeling should the visual design evoke?

### Phase 4: Naming & Messaging

1. What is the product name? Is it final?
2. What is the tagline or key message? (or should we develop one?)
3. How should the product be described in one sentence?
4. Are there terms or jargon to use or avoid?

### Phase 5: Application

1. What are the primary touchpoints? (website, app, emails, docs)
2. Are there accessibility requirements?
3. Who will be creating content? (developers, marketers, users)
4. Are there existing assets or constraints to work within?

## Output

After gathering responses, generate Brand Guidelines at `docs/brand-guidelines.md` using this structure:

```markdown
# Brand Guidelines

## Overview
[Product name and brand summary]

## Brand Foundation

### Mission
[One-sentence mission aligned with PRD vision]

### Brand Personality
| Trait | Description | Example |
|-------|-------------|---------|
| | | |

### Brand Values
-

## Voice & Tone

### Voice Characteristics
-

### Tone Spectrum
| Context | Tone | Example |
|---------|------|---------|
| Success states | | |
| Error states | | |
| Onboarding | | |
| Documentation | | |

### Writing Principles
-

### Words We Use / Words We Avoid
| Use | Avoid |
|-----|-------|
| | |

## Visual Identity

### Color Palette
| Color | Hex | Usage |
|-------|-----|-------|
| Primary | | |
| Secondary | | |
| Accent | | |
| Neutral | | |

### Typography
- **Headings**:
- **Body**:
- **Code/Mono**:

### Visual Style
-

### Imagery Guidelines
-

## Messaging

### Tagline
[Primary tagline]

### Elevator Pitch
[One-sentence description]

### Key Messages
-

## Application

### Touchpoints
| Touchpoint | Tone | Key Considerations |
|------------|------|-------------------|
| | | |

### Accessibility
-

### Do's and Don'ts
| Do | Don't |
|----|-------|
| | |
```

## Instructions

1. Read and summarize the PRD first, focusing on vision and users
2. Ask questions conversationally, phase by phase
3. Offer suggestions based on product type and audience when helpful
4. After all phases, present a draft for review
5. Write final guidelines to `docs/20-brand-guidelines.md`
