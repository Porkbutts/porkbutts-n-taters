# Ship

Create a PR for current changes with version bump and README update.

## Workflow

1. **Check for changes**: Run `git status` and `git diff` to understand what changed
2. **Update README.md**: If any skill content changed, update the corresponding skill description in README
3. **Determine version bump**: Ask user if this is a patch (fixes), minor (features), or major (breaking changes)
4. **Bump versions**: Increment version in BOTH files (keep them in sync):
   - `.claude-plugin/plugin.json`
   - `.claude-plugin/marketplace.json`
5. **Create branch**: `git checkout -b <descriptive-branch-name>`
6. **Commit**: Stage and commit with a clear message summarizing the changes
7. **Push**: `git push -u origin <branch-name>`
8. **Create PR**: Use `gh pr create` with summary and test plan

Note: A GitHub release will be automatically created when the PR is merged.

## Arguments

$ARGUMENTS - Optional description of what changed (used for branch name and commit message)
