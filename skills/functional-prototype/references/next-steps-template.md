# Next Steps Template

Use this structure when generating `docs/next-steps.md` for a prototype.

---

# Next Steps: Replacing Stubs with Real Integrations

This document describes how to replace the stubbed dependencies in this prototype with real implementations.

## Overview

| Stub | Current Behavior | Integration Needed |
|------|------------------|-------------------|
| [List each stub] | [What it does now] | [What to integrate] |

## 1. [Dependency Category: e.g., Database]

### Current Implementation
- **File**: `src/mocks/api.js` (or wherever)
- **Functions**: `getUser()`, `getPosts()`, `createPost()`
- **Behavior**: Returns data from `src/mocks/data.js`

### Integration Steps

1. **Choose database**: [Suggest options - PostgreSQL, MongoDB, Supabase, etc.]

2. **Set up connection**:
   ```javascript
   // Example with Supabase
   import { createClient } from '@supabase/supabase-js'
   const supabase = createClient(SUPABASE_URL, SUPABASE_KEY)
   ```

3. **Replace stub functions**:
   - `getUser(id)` → `supabase.from('users').select().eq('id', id)`
   - `getPosts()` → `supabase.from('posts').select().order('created_at', { ascending: false })`

4. **Create schema**: [Include suggested schema based on mock data structure]

### Files to Modify
- `src/mocks/api.js` → Move to `src/lib/db.js`
- [List other affected files]

---

## 2. [Dependency Category: e.g., Authentication]

### Current Implementation
- **File**: `src/mocks/api.js`
- **Functions**: `login()`, `logout()`, `getCurrentUser()`
- **Behavior**: Always returns first mock user, stores token in localStorage

### Integration Steps

1. **Choose auth provider**: [Suggest options - Auth0, Clerk, Firebase Auth, etc.]

2. **Install SDK**:
   ```bash
   npm install @auth0/auth0-react  # or chosen provider
   ```

3. **Replace stub functions**:
   [Provider-specific code examples]

4. **Update components**: Add auth provider wrapper, protected routes

### Files to Modify
- [List files]

---

## 3. [Continue for each stubbed dependency...]

---

## Environment Variables

Create `.env` file with:

```
# Database
DATABASE_URL=

# Auth
AUTH_CLIENT_ID=
AUTH_SECRET=

# [Other services]
```

## Recommended Migration Order

1. **Database** - Foundation for all data
2. **Authentication** - User identity required for most features
3. **[Other dependencies in logical order]**

## Testing Checklist

After each integration:
- [ ] All existing user flows still work
- [ ] Error handling for network failures
- [ ] Loading states display correctly
- [ ] Edge cases handled (empty data, long content)
