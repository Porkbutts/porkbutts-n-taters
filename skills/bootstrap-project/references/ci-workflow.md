# GitHub CI Workflow

Create `.github/workflows/ci.yml` with the following structure. Adapt the package manager (`npm`, `pnpm`, `yarn`, `bun`) and commands to match the project.

## Template

```yaml
name: CI

on:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  ci:
    name: Lint, Test, Build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: '<package-manager>'

      - name: Install dependencies
        run: <install-command>

      - name: Lint
        run: <lint-command>

      - name: Typecheck
        run: <typecheck-command>

      - name: Test with coverage
        run: <test-coverage-command>

      - name: Upload coverage
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: coverage-report
          path: coverage/

      - name: Build
        run: <build-command>

  coverage-report:
    name: Coverage Report
    runs-on: ubuntu-latest
    needs: ci
    if: github.event_name == 'pull_request'
    permissions:
      pull-requests: write
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: '<package-manager>'

      - name: Install dependencies
        run: <install-command>

      - name: Test with coverage
        run: <test-coverage-command>

      - name: Coverage report
        uses: davelosert/vitest-coverage-report-action@v2  # For Vitest
        # uses: MishaKav/jest-coverage-comment@main        # For Jest
```

## Package Manager Detection

Detect the package manager from lock files:

| Lock file | Manager | Install | Run |
|-----------|---------|---------|-----|
| `pnpm-lock.yaml` | pnpm | `pnpm install --frozen-lockfile` | `pnpm run` |
| `yarn.lock` | yarn | `yarn install --frozen-lockfile` | `yarn` |
| `bun.lockb` or `bun.lock` | bun | `bun install --frozen-lockfile` | `bun run` |
| `package-lock.json` | npm | `npm ci` | `npm run` |

## Common Script Names

Map these to whatever the project's `package.json` scripts are:

| Step | Common scripts |
|------|---------------|
| Lint | `lint`, `eslint` |
| Typecheck | `typecheck`, `type-check`, `tsc` |
| Test + coverage | `test -- --coverage`, `test:coverage`, `vitest run --coverage` |
| Build | `build`, `next build` |

If a script doesn't exist in `package.json`, add it.

## Coverage Thresholds

LLM coding agents write tests alongside implementation, so high coverage is expected and enforceable. Configure the test runner to fail CI when coverage drops below thresholds.

### Vitest (`vitest.config.ts`)

```ts
export default defineConfig({
  test: {
    coverage: {
      thresholds: {
        statements: 80,
        branches: 80,
        functions: 80,
        lines: 80,
      },
    },
  },
});
```

### Jest (`jest.config.ts`)

```ts
export default {
  coverageThreshold: {
    global: {
      statements: 80,
      branches: 80,
      functions: 80,
      lines: 80,
    },
  },
};
```

The test script should run with coverage enabled so thresholds are enforced:

```json
{
  "scripts": {
    "test": "vitest run --coverage"
  }
}
```

## Coverage PR Comments

Post a coverage summary table directly on pull requests so reviewers see coverage at a glance.

### Vitest

Use [`davelosert/vitest-coverage-report-action@v2`](https://github.com/davelosert/vitest-coverage-report-action). Requires:
- Coverage reporter includes `json-summary` (and optionally `json` for file-level details)
- The `coverage-report` job needs `permissions: pull-requests: write`

Configure the coverage reporter in `vitest.config.ts`:

```ts
export default defineConfig({
  test: {
    coverage: {
      reporter: ['text', 'json-summary', 'json'],
      // ...thresholds
    },
  },
});
```

### Jest

Use [`MishaKav/jest-coverage-comment@main`](https://github.com/MishaKav/jest-coverage-comment). Requires:
- Coverage reporter includes `json-summary`
- The `coverage-report` job needs `permissions: pull-requests: write`

Configure in `jest.config.ts`:

```ts
export default {
  coverageReporters: ['text', 'json-summary'],
  // ...thresholds
};
```

### Choosing the Action

| Test runner | Action |
|-------------|--------|
| Vitest | `davelosert/vitest-coverage-report-action@v2` |
| Jest | `MishaKav/jest-coverage-comment@main` |

Use exactly one — pick the action that matches the project's test runner.
