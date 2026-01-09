# Tech Specs Interview

<!--
  Interactive interview to create a Technical Specification document.
  Uses the PRD as input to guide technology decisions.

  Usage: /tech-specs-interview [prd-file]
  Example: /tech-specs-interview docs/10-prd.md
-->

Conduct an interactive interview to create a Technical Specification document based on the PRD.

## Setup

1. Read the PRD from `$ARGUMENTS` (default: `docs/10-prd.md`)
2. Summarize the key requirements that will drive technical decisions
3. Proceed with the interview phases

## Interview Process

Ask questions in phases, waiting for user responses before proceeding.

### Phase 1: Architecture Overview

1. What type of application is this? (web app, mobile app, API, CLI, library, etc.)
2. What is the expected scale? (users, requests, data volume)
3. Are there existing systems this needs to integrate with?
4. What are the deployment requirements? (cloud, on-prem, edge, etc.)

### Phase 2: Technology Stack

1. What programming language(s) do you prefer or require?
2. What frameworks are you considering? (or should I recommend based on requirements?)
3. What database type fits your data model? (relational, document, graph, key-value)
4. Are there specific services or platforms you want to use? (AWS, GCP, Vercel, etc.)

### Phase 3: Data & Storage

1. What are the main data entities and their relationships?
2. What are the data access patterns? (read-heavy, write-heavy, real-time)
3. Are there caching requirements?
4. What are the backup and recovery requirements?

### Phase 4: Security & Auth

1. What authentication method is needed? (OAuth, JWT, API keys, SSO)
2. What authorization model? (RBAC, ABAC, simple permissions)
3. Are there compliance requirements? (GDPR, HIPAA, SOC2)
4. What data needs encryption at rest or in transit?

### Phase 5: Infrastructure & Operations

1. What is the availability requirement? (99.9%, 99.99%)
2. What monitoring and observability is needed?
3. What is the CI/CD strategy?
4. Are there cost constraints?

## Output

After gathering responses, generate the Technical Specification at `docs/30-tech-design.md` using this structure:

```markdown
# Technical Specification

## Overview
[System name and architectural summary]

## Requirements Reference
[Key requirements from PRD that drive technical decisions]

## Architecture

### System Type
[Web app, API, etc.]

### High-Level Architecture
[Description or diagram reference]

### Component Overview
| Component | Purpose | Technology |
|-----------|---------|------------|
| | | |

## Technology Stack

### Languages & Frameworks
-

### Database
- **Type**:
- **Technology**:
- **Rationale**:

### Infrastructure
- **Platform**:
- **Compute**:
- **Storage**:

### Third-Party Services
-

## Data Model

### Entities
[Key entities and relationships]

### Data Access Patterns
-

### Caching Strategy
-

## Security

### Authentication
-

### Authorization
-

### Data Protection
-

### Compliance
-

## Infrastructure

### Deployment
-

### Scaling Strategy
-

### Monitoring & Observability
-

### CI/CD Pipeline
-

## Technical Risks
| Risk | Impact | Mitigation |
|------|--------|------------|
| | | |

## Open Technical Questions
-
```

## Instructions

1. Read and summarize the PRD first
2. Ask questions conversationally, phase by phase
3. Make recommendations based on PRD requirements when appropriate
4. After all phases, present a draft for review
5. Write final spec to `docs/30-tech-design.md`
