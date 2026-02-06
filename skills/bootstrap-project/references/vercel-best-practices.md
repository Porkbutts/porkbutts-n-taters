# Vercel Best Practices

Install Vercel's community-maintained agent skills for Claude Code:

```bash
npx add-skill vercel-labs/agent-skills
```

This adds Vercel-specific guidance for Next.js, deployment, and framework best practices. Run this command in the project root.

## What It Provides

The skill adds Vercel's recommended patterns covering:
- Next.js App Router conventions
- Server Components and Server Actions
- Edge runtime usage
- Image optimization
- Caching and ISR patterns
- Deployment configuration

## When to Apply

Apply Vercel best practices when the project uses:
- Next.js (any version, especially App Router)
- Vercel as the deployment platform
- Any Vercel framework (SvelteKit, Nuxt, Remix on Vercel)

If the project does not use Vercel or Next.js, skip this step and inform the user.
