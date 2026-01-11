# Integration Guide Template

Structure for `docs/integration-guide.md`.

**Code policy:** This guide is for Claude to read during implementation. Claude already knows standard APIs and patterns.

Do NOT include:
- Full schemas or SQL CREATE statements
- Standard API call syntax (e.g., `supabase.auth.signInWithOAuth()`)
- JSX/component boilerplate
- Well-documented library patterns

DO include (as brief notes, not full code):
- Specialized queries (PostGIS spatial syntax)
- Security rules (RLS policies - who can read/write what)
- Non-obvious gotchas (e.g., "requires dev build, not Expo Go")
- Platform-specific config locations (e.g., "needs API key in AndroidManifest.xml")

---

# Integration Guide: Replacing Stubs with Real Implementations

## Overview

| Stub | Current Behavior | Production Replacement |
|------|------------------|------------------------|
| [Each stubbed dependency] | [What the stub does] | [Real integration from PRD] |

## [Dependency Name]

**Current stub:** File path and function names
**Behavior:** What it returns/does now

**To integrate:**
1. Files to modify (stub file → production location)
2. Key transformations (describe, don't show code)
3. Non-obvious patterns to use (only if specialized - e.g., PostGIS spatial queries, RLS patterns)
4. New dependencies to install (if any)

*Repeat for each stub*

---

## Environment Variables

List variables needed for production (names only, no values).

## Migration Order

Order dependencies logically (e.g., database before features that need it).

## Verification

After each integration, confirm:
- Existing flows still work
- Error states handled
- Loading states display correctly
