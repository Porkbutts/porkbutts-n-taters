# Husky Pre-commit Setup

## Installation

```bash
# Install husky and lint-staged
<install-dev-command> husky lint-staged

# Initialize husky
npx husky init
```

This creates `.husky/` directory and adds a `prepare` script to `package.json`.

## Pre-commit Hook

Write `.husky/pre-commit`:

```bash
npx lint-staged
```

## lint-staged Configuration

Add to `package.json`:

```json
{
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": [
      "<lint-command> --fix",
      "<format-command> --write"
    ],
    "*.{json,md,yml,yaml,css,scss}": [
      "<format-command> --write"
    ]
  }
}
```

### Typecheck

lint-staged runs per-file, but `tsc` needs the full project. Add typecheck as a separate step in the pre-commit hook rather than inside lint-staged:

```bash
# .husky/pre-commit
npx lint-staged
<typecheck-command>
```

### Adapting Commands

| Step | Common tools |
|------|-------------|
| Lint | `eslint`, `biome lint` |
| Format | `prettier`, `biome format` |
| Typecheck | `tsc --noEmit`, `vue-tsc --noEmit` |

### Test in Pre-commit (Optional)

Only include tests in pre-commit if they're fast (<30s). For slower test suites, rely on CI only. If included:

```bash
# .husky/pre-commit
npx lint-staged
<typecheck-command>
<test-command> --bail
```

`--bail` stops on first failure to keep pre-commit fast.
