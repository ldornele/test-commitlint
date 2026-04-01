# Test Project for h-hooks Commitlint Validation

This is a minimal test project to validate the commitlint configuration from [h-hooks](https://github.com/ldornele/h-hooks).

## Purpose

Test and verify that the centralized commit message validation works correctly with:
- Local pre-commit hooks
- Manual commitlint validation
- Different commit message formats (valid and invalid)

## Setup

### 1. Install Dependencies

```bash
# Install pre-commit framework
pip install pre-commit

# Install Node.js dependencies for commitlint
npm install
```

### 2. Install Git Hooks

```bash
# Install commit-msg hook
pre-commit install --hook-type commit-msg
```

### 3. Initialize Git Repository (if not already)

```bash
git init
git add .
git commit -m "HYPERFLEET-000 - chore: initialize test project"
```

## Testing Commit Messages

### Valid Commit Messages (Should Pass)

Test these commit messages - they should all be accepted:

```bash
# With JIRA ticket
git commit --allow-empty -m "HYPERFLEET-813 - feat: add new feature"
git commit --allow-empty -m "HYPERFLEET-425 - fix: resolve bug in validation"
git commit --allow-empty -m "HYPERFLEET-100 - docs: update documentation"
git commit --allow-empty -m "HYPERFLEET-200 - refactor: improve code structure"

# Without JIRA ticket
git commit --allow-empty -m "feat: add new capability"
git commit --allow-empty -m "fix: resolve memory leak"
git commit --allow-empty -m "docs: update readme"
git commit --allow-empty -m "test: add unit tests"

# With scope
git commit --allow-empty -m "HYPERFLEET-300 - feat(api): add new endpoint"
git commit --allow-empty -m "fix(auth): resolve token expiration"
```

### Invalid Commit Messages (Should Fail)

Test these commit messages - they should all be rejected:

```bash
# Subject starts with uppercase (should be lowercase)
git commit --allow-empty -m "feat: Add new feature"
git commit --allow-empty -m "HYPERFLEET-123 - fix: Fix bug"

# Missing type
git commit --allow-empty -m "HYPERFLEET-123 - add new feature"
git commit --allow-empty -m "add new feature"

# Missing colon
git commit --allow-empty -m "HYPERFLEET-123 - feat add feature"
git commit --allow-empty -m "feat add feature"

# Invalid type
git commit --allow-empty -m "HYPERFLEET-123 - feature: add something"
git commit --allow-empty -m "added: new feature"

# Subject ends with period (not allowed)
git commit --allow-empty -m "feat: add new feature."
git commit --allow-empty -m "HYPERFLEET-123 - fix: resolve bug."

# Subject too long (>72 characters after type)
git commit --allow-empty -m "feat: this is a very long commit message subject that exceeds the maximum allowed length of seventy-two characters"

# Empty subject
git commit --allow-empty -m "feat: "
git commit --allow-empty -m "HYPERFLEET-123 - fix: "
```

## Manual Validation

You can also test commit messages without actually committing:

```bash
# Test a single commit message
echo "HYPERFLEET-813 - feat: add validation" | npx commitlint

# Test the last commit
npx commitlint --from=HEAD~1 --to=HEAD

# Test a range of commits
npx commitlint --from=main --to=HEAD
```

## Bypassing Validation (Not Recommended)

For testing purposes only, you can bypass the pre-commit hook:

```bash
git commit --no-verify -m "any message"
```

**Warning:** This defeats the purpose of validation. Use only for testing hook behavior.

## Test Scenarios

### Scenario 1: Test Local Hook

```bash
# Should pass
git commit --allow-empty -m "HYPERFLEET-999 - test: verify local hook"

# Should fail
git commit --allow-empty -m "Test: invalid message"
```

### Scenario 2: Test Manual Validation

```bash
# Create a test commit with invalid message (bypass hook)
git commit --allow-empty --no-verify -m "Invalid message"

# Now validate it manually
npx commitlint --from=HEAD~1 --to=HEAD
# Should show error
```

### Scenario 3: Test Multiple Commits

```bash
# Create multiple commits
git commit --allow-empty -m "HYPERFLEET-001 - feat: first feature"
git commit --allow-empty -m "HYPERFLEET-002 - feat: second feature"
git commit --allow-empty -m "HYPERFLEET-003 - fix: bug fix"

# Validate all of them
npx commitlint --from=HEAD~3 --to=HEAD
```

## Expected Behavior

✅ **When validation passes:**
- Pre-commit hook completes silently
- Commit is created successfully
- No error messages

❌ **When validation fails:**
- Pre-commit hook blocks the commit
- Error message shows what's wrong
- Helpful examples of valid format
- Link to HyperFleet commit standard

## Troubleshooting

### Hook not running

```bash
# Reinstall hook
pre-commit uninstall --hook-type commit-msg
pre-commit install --hook-type commit-msg

# Verify installation
ls -la .git/hooks/commit-msg
```

### npx not found

```bash
# Install Node.js
# macOS:
brew install node

# Ubuntu/Debian:
sudo apt install nodejs npm

# Verify
node --version
npm --version
```

### Pre-commit not found

```bash
# Install pre-commit
pip install pre-commit

# Verify
pre-commit --version
```

## Clean Up

To reset the test repository:

```bash
# Remove all commits but keep files
git reset --soft HEAD~10  # Adjust number as needed

# Or completely reset
rm -rf .git
git init
```

## References

- [h-hooks Repository](https://github.com/ldornele/h-hooks)
- [HyperFleet Commit Standard](https://github.com/openshift-hyperfleet/architecture/blob/main/hyperfleet/standards/commit-standard.md)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Commitlint Documentation](https://commitlint.js.org/)

## Quick Test Script

Copy and run this to test all scenarios:

```bash
#!/bin/bash
echo "Testing valid commits..."
git commit --allow-empty -m "HYPERFLEET-001 - feat: test feature" && echo "✓ Pass" || echo "✗ Fail"
git commit --allow-empty -m "fix: test fix" && echo "✓ Pass" || echo "✗ Fail"

echo ""
echo "Testing invalid commits (should fail)..."
git commit --allow-empty -m "feat: Test" && echo "✗ Should have failed" || echo "✓ Correctly rejected"
git commit --allow-empty -m "added feature" && echo "✗ Should have failed" || echo "✓ Correctly rejected"

echo ""
echo "All tests complete!"
```
