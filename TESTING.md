# Testing Guide

Quick reference for testing h-hooks commitlint validation.

## Quick Start

```bash
# 1. Install dependencies
npm install
pip install pre-commit

# 2. Install git hooks
pre-commit install --hook-type commit-msg

# 3. Run automated test suite
./test-commit-messages.sh
```

## Manual Testing

### Test Valid Commits

```bash
# Should all pass
git commit --allow-empty -m "HYPERFLEET-001 - feat: add feature"
git commit --allow-empty -m "HYPERFLEET-002 - fix: resolve bug"
git commit --allow-empty -m "feat: add capability"
git commit --allow-empty -m "docs: update readme"
```

### Test Invalid Commits

```bash
# Should all fail
git commit --allow-empty -m "feat: Add Feature"  # Uppercase
git commit --allow-empty -m "add feature"        # No type
git commit --allow-empty -m "feat add"           # No colon
git commit --allow-empty -m "feat: test."        # Period at end
```

## Test Using npm Scripts

```bash
# Test valid message
npm run test:valid

# Test invalid message
npm run test:invalid

# Test last commit
npm run test:last-commit

# Run all npm tests
npm run test:all
```

## Test Without Committing

```bash
# Test a message directly
echo "HYPERFLEET-123 - feat: test" | npx commitlint

# Test and see verbose output
echo "invalid message" | npx commitlint --verbose
```

## Automated Test Suite

Run the comprehensive test script:

```bash
./test-commit-messages.sh
```

This tests:
- ✅ 14 valid commit message formats
- ❌ 13 invalid commit message formats
- Provides pass/fail summary

## Expected Output

### When Valid ✅

```
Testing: JIRA ticket with feat type ... ✓ PASS
```

### When Invalid ❌

```
Testing: Subject starts with uppercase ... ✓ PASS (correctly rejected)
```

## Troubleshooting

### Tests fail with "npx: command not found"

```bash
# Install Node.js
brew install node  # macOS
sudo apt install nodejs npm  # Ubuntu
```

### Pre-commit hook not working

```bash
# Reinstall
pre-commit uninstall --hook-type commit-msg
pre-commit install --hook-type commit-msg

# Verify
ls -la .git/hooks/commit-msg
```

### Want to see detailed error messages

```bash
# Add --verbose flag
echo "invalid" | npx commitlint --verbose
```

## Comparison: Local vs Remote

| Validation | Local (pre-commit) | Remote (Prow) |
|------------|-------------------|---------------|
| **Trigger** | Before commit | On PR |
| **Speed** | Instant | ~30 seconds |
| **Config Source** | h-hooks repo | h-hooks repo (downloaded) |
| **Can bypass** | Yes (--no-verify) | No |
| **Purpose** | Fast feedback | Enforcement gate |

Both use the **same configuration** from h-hooks, ensuring consistency.

## Success Criteria

All tests in `test-commit-messages.sh` should pass:
- ✅ Valid messages accepted
- ❌ Invalid messages rejected
- Clear error messages shown
- Same behavior as Prow CI

## Next Steps

After testing here, apply the same configuration to your actual HyperFleet repository:

1. Copy `.pre-commit-config.yaml`
2. Copy `commitlint.config.js`
3. Copy `package.json` devDependencies
4. Follow setup instructions
