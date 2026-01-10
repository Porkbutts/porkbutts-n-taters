---
name: functional-prototype
description: Build functional prototypes from PRDs or specifications. Creates working UI screens with stubbed dependencies (database, APIs) and precanned mock data. Generates docs/next-steps.md explaining how to replace stubs with real integrations. Use when user provides a PRD, spec, or feature description and wants a clickable prototype to demonstrate user stories. Trigger when user mentions: build a prototype, make a demo, implement this PRD, create a mockup, prototype this spec, make it clickable, or build from this spec. This skill creates working UI with mock data and stubbed integrations—ideal for validating flows before full implementation.
---

# Functional Prototype Builder

Build working prototypes from PRDs that demonstrate user stories with realistic mock data and stubbed dependencies.

## Workflow

### 1. Analyze PRD

Extract from the specification:
- **User stories**: List each user-facing flow
- **Screens**: Identify all unique screens/views needed
- **Data entities**: Users, posts, products, etc.
- **External dependencies**: Database, auth, payment, APIs
- **Tech stack**: If not specified, ask user

### 2. Set Up Project

Create project structure based on tech stack from PRD:

```
project-name/
├── src/
│   ├── components/     # Reusable UI components
│   ├── pages/          # Screen/route components
│   ├── mocks/
│   │   ├── data.js     # Precanned mock data
│   │   └── api.js      # Stubbed API functions
│   └── utils/
├── docs/
│   └── next-steps.md   # Integration guide (generated last)
└── package.json
```

### 3. Generate Mock Data

Create realistic precanned data in `src/mocks/data.js`:

```javascript
// Example for a social app
export const mockUsers = [
  { id: '1', name: 'Sarah Chen', avatar: '/avatars/1.png', bio: 'Product designer' },
  { id: '2', name: 'Marcus Johnson', avatar: '/avatars/2.png', bio: 'Software engineer' },
];

export const mockPosts = [
  { id: '1', authorId: '1', content: 'Just shipped a new feature!', likes: 42, createdAt: '2024-01-15' },
];
```

**Guidelines:**
- Use realistic names, content, dates
- Include edge cases (long text, empty states)
- Add 5-10 items per entity minimum
- Cross-reference IDs correctly

### 4. Stub Dependencies

Create stubbed functions in `src/mocks/api.js`:

```javascript
import { mockUsers, mockPosts } from './data';

// Simulate network delay
const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));

// STUB: Database queries
export async function getUser(id) {
  await delay(100);
  return mockUsers.find(u => u.id === id) || null;
}

export async function getPosts() {
  await delay(150);
  return [...mockPosts].sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));
}

// STUB: Auth
export async function login(email, password) {
  await delay(200);
  // Always succeeds with first mock user
  return { user: mockUsers[0], token: 'mock-jwt-token' };
}

// STUB: External API (e.g., payment)
export async function processPayment(amount) {
  await delay(300);
  return { success: true, transactionId: 'txn_' + Date.now() };
}
```

**Stub patterns by dependency type:**

| Dependency | Stub Pattern |
|------------|--------------|
| Database | Return filtered/sorted mock data |
| Auth | Return mock user, always succeed |
| File upload | Store in memory/localStorage |
| Payment | Return success with fake transaction ID |
| External API | Return realistic mock response |
| Email/SMS | Console.log the message |
| Search | Filter mock data client-side |

### 5. Build Screens

For each screen identified in step 1:
- Import stubbed API functions (not real ones)
- Use mock data for initial state
- Implement full UI with interactions
- Handle loading states (stubs have delays)
- Handle error states (add mock error scenarios)

**Focus on:**
- Complete user flows end-to-end
- Realistic UI with actual content
- State changes (optimistic updates OK)
- Navigation between screens

### 6. Generate next-steps.md

After prototype is complete, create `docs/next-steps.md` following the template in [references/next-steps-template.md](references/next-steps-template.md).

Document every stub with:
- What it currently does
- What real integration is needed
- Specific files to modify
- Suggested libraries/services

## Output Checklist

Before declaring complete, verify:
- [ ] All user stories from PRD are demonstrable
- [ ] Every screen is implemented and navigable
- [ ] Mock data looks realistic
- [ ] Stubs simulate async behavior (delays)
- [ ] Loading and empty states handled
- [ ] `docs/next-steps.md` documents all stubs
