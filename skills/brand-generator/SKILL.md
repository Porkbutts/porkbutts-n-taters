---
name: brand-generator
description: >
  Generate unique, ownable brand names with available domain names. Conducts a
  structured discovery interview about the product, vision, and positioning, then
  generates candidate names using linguistic construction patterns, filters for
  trademark and phonetic safety, checks domain availability via whois, and delivers
  a shortlist of vetted name + domain pairs. Use when user wants to name a product,
  company, SaaS app, or side project, or when they say "help me name", "brand name",
  "find a domain", "name my startup", "product naming", or "what should I call this".
---

# Brand Namer

Generate unique brand names with verified-available domains through structured discovery and linguistic construction.

## Workflow

### Phase 1: Discovery Interview

Conduct a focused interview to understand the product before generating any names. Ask these questions across 1-2 messages (do not overwhelm with all at once):

**Round 1 — Core understanding:**
- What does the product/company do in one sentence?
- Who is the target user?
- What category is this — a tool, platform, AI agent, marketplace, or consulting brand?

**Round 2 — Strategic constraints:**
- Will this expand beyond its current scope? (Determines how abstract the name should be)
- What trust level is needed? (Career/finance/legal = serious tone; consumer/social = more flexibility)
- What tone do you want? (e.g., technical, warm, minimal, bold, playful)
- Any words or themes to avoid?
- Preferred domain TLD? (.com ideal, .ai and .co acceptable)

Do NOT proceed to name generation until discovery is complete.

### Phase 2: Name Generation

Read [references/naming-framework.md](references/naming-framework.md) for construction patterns, phonetic rules, risk filters, and the quality scoring matrix.

Generate **20-25 candidate names** by:

1. **Brainstorm semantic roots on the fly** — Do NOT rely on a static word list. Derive novel roots from the product's specific domain using: metaphors, foreign language fragments (Latin, Greek, Japanese, etc.), cross-domain analogies, phoneme invention, and abbreviation blends. Aim for roots that are *not* common English dictionary words.
2. **Apply construction patterns** (root + suffix, truncation, blending, vowel shifts, letter removal, partial root blends)
3. **Apply phonetic rules** — 2-4 syllables, one obvious pronunciation, passes phone test
4. **Pre-filter for novelty** — Before any domain check, reject candidates that are recognizable English words, obvious brand roots, or that you estimate are highly likely to be taken (e.g., "fitly", "formio", "pathly")

### Phase 3: Domain Verification

Check domains for **all surviving candidates in a single batch** using the bundled script:

```bash
scripts/check_domain.sh name1.com name1.ai name1.co name2.com name2.ai name2.co ...
```

Pass all candidates × all TLDs (.com, .ai, .co) in one call. Reject candidates where all reasonable TLDs are taken.

### Phase 4: Score & Web Validate Survivors

Only now score and validate — don't waste effort on names with no available domains.

1. **Score each surviving candidate** on the 6-dimension quality matrix (reject below 20/30)
2. **Web validate** the top scorers via WebSearch (batch 3-4 searches in parallel):
   - No dominant company on SERP page 1 for the name
   - Not a medical/pharma term
   - Not a foreign-language profanity
   - No obvious trademark conflicts in the same industry
   - Reject any name that surfaces conflicts

### Phase 5: Present Shortlist

Present 3-5 finalists in this format:

```
## [Name] — [domain.tld]

- **What it evokes:** [brief description of the associations]
- **Score:** [X/30] (Distinctiveness / Pronounceability / Memorability / Flexibility / Legal Safety / Brandability)
- **Domain status:** Available ([tld])
- **Risk notes:** [any minor concerns or "Clean"]
```

After presenting, ask the user which direction resonates and offer to:
- Refine around a favorite
- Generate more in a specific style
- Run deeper validation (USPTO TESS, Crunchbase, GitHub, LinkedIn, social handles)

### Phase 6: Deep Validation (on request)

When the user narrows to 1-2 finalists, run deeper checks via WebSearch:
- `"[name]" site:crunchbase.com`
- `"[name]" site:github.com`
- `"[name]" site:linkedin.com/company`
- `"[name]" trademark software`
- `"@[name]" twitter` / `"@[name]" instagram`

Report findings and confirm the final selection is clear.
