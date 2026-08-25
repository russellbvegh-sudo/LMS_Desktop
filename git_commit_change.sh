#!/bin/bash
# Rewrite commit author/committer identity across all branches and tags.
#
# Run from Git Bash:
#   bash git_commit_change.sh
#
# Or from PowerShell / CMD:
#   git_commit_change.cmd

set -euo pipefail

export FILTER_BRANCH_SQUELCH_WARNING=1

CORRECT_NAME="Russell Vegh"
CORRECT_EMAIL="russellbvegh@gmail.com"

# Space-separated list works in /bin/sh (used by git filter-branch's env-filter).
OLD_EMAILS="joselrosario81@gmail.com"

git filter-branch -f --env-filter "
CORRECT_NAME=\"$CORRECT_NAME\"
CORRECT_EMAIL=\"$CORRECT_EMAIL\"
for OLD_EMAIL in $OLD_EMAILS; do
    if [ \"\$GIT_COMMITTER_EMAIL\" = \"\$OLD_EMAIL\" ]; then
        export GIT_COMMITTER_NAME=\"\$CORRECT_NAME\"
        export GIT_COMMITTER_EMAIL=\"\$CORRECT_EMAIL\"
    fi
    if [ \"\$GIT_AUTHOR_EMAIL\" = \"\$OLD_EMAIL\" ]; then
        export GIT_AUTHOR_NAME=\"\$CORRECT_NAME\"
        export GIT_AUTHOR_EMAIL=\"\$CORRECT_EMAIL\"
    fi
done
" --tag-name-filter cat -- --branches --tags

echo
echo "Rewrite complete. Verify with:"
echo "  git shortlog -sne --all"
echo
echo "If the output looks correct, force-push the rewritten history:"
echo "  git push --force --all"
echo "  git push --force --tags"
echo
echo "Optional cleanup of filter-branch backup refs:"
echo "  git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin"
