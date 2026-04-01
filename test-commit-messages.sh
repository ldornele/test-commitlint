#!/usr/bin/env bash
#
# Test script for commitlint validation
# Tests various commit message formats (valid and invalid)

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "========================================="
echo "Testing h-hooks Commitlint Validation"
echo "========================================="
echo ""

# Counter for tests
PASS=0
FAIL=0

# Test function
test_commit() {
    local message="$1"
    local should_pass="$2"
    local description="$3"

    echo -n "Testing: $description ... "

    if echo "$message" | npx commitlint --quiet 2>/dev/null; then
        if [ "$should_pass" = "true" ]; then
            echo -e "${GREEN}✓ PASS${NC}"
            ((PASS++))
        else
            echo -e "${RED}✗ FAIL (should have been rejected)${NC}"
            ((FAIL++))
        fi
    else
        if [ "$should_pass" = "false" ]; then
            echo -e "${GREEN}✓ PASS (correctly rejected)${NC}"
            ((PASS++))
        else
            echo -e "${RED}✗ FAIL (should have been accepted)${NC}"
            ((FAIL++))
        fi
    fi
}

echo "=== Valid Commit Messages ==="
echo ""

test_commit "HYPERFLEET-813 - feat: add new feature" "true" "JIRA ticket with feat type"
test_commit "HYPERFLEET-425 - fix: resolve bug" "true" "JIRA ticket with fix type"
test_commit "HYPERFLEET-100 - docs: update documentation" "true" "JIRA ticket with docs type"
test_commit "feat: add new capability" "true" "No JIRA ticket, feat type"
test_commit "fix: resolve memory leak" "true" "No JIRA ticket, fix type"
test_commit "docs: update readme" "true" "No JIRA ticket, docs type"
test_commit "HYPERFLEET-300 - feat(api): add new endpoint" "true" "With scope"
test_commit "refactor: improve code structure" "true" "Refactor type"
test_commit "test: add unit tests" "true" "Test type"
test_commit "chore: update dependencies" "true" "Chore type"
test_commit "ci: update workflow" "true" "CI type"
test_commit "build: update makefile" "true" "Build type"
test_commit "perf: optimize query" "true" "Perf type"
test_commit "style: format code" "true" "Style type"

echo ""
echo "=== Invalid Commit Messages ==="
echo ""

test_commit "feat: Add new feature" "false" "Subject starts with uppercase"
test_commit "HYPERFLEET-123 - fix: Fix bug" "false" "Subject starts with uppercase (with ticket)"
test_commit "HYPERFLEET-123 - add new feature" "false" "Missing type"
test_commit "add new feature" "false" "Missing type (no ticket)"
test_commit "HYPERFLEET-123 - feat add feature" "false" "Missing colon"
test_commit "feat add feature" "false" "Missing colon (no ticket)"
test_commit "HYPERFLEET-123 - feature: add something" "false" "Invalid type 'feature'"
test_commit "added: new feature" "false" "Invalid type 'added'"
test_commit "feat: add new feature." "false" "Subject ends with period"
test_commit "HYPERFLEET-123 - fix: resolve bug." "false" "Subject ends with period (with ticket)"
test_commit "feat: " "false" "Empty subject"
test_commit "HYPERFLEET-123 - fix: " "false" "Empty subject (with ticket)"
test_commit "feat: this is a very long commit message subject that exceeds the maximum allowed length of seventy-two characters for the subject line" "false" "Subject too long"

echo ""
echo "========================================="
echo "Test Results"
echo "========================================="
echo -e "${GREEN}Passed: $PASS${NC}"
echo -e "${RED}Failed: $FAIL${NC}"
echo ""

if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed${NC}"
    exit 1
fi
