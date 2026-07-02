#!/bin/sh
# Enable these hooks for EVERY git repo on this machine — existing and any you
# start later — by pointing git's global core.hooksPath at this repo's hooks/.
#
# Run once per machine (dev box, Raspberry Pi, ...). To update the hook later,
# just `git pull` in this clone; every repo picks it up immediately.
set -eu

hooks_dir=$(CDPATH= cd -- "$(dirname -- "$0")/hooks" && pwd)
chmod +x "$hooks_dir"/* 2>/dev/null || true
git config --global core.hooksPath "$hooks_dir"

echo "Global git hooks enabled."
echo "  core.hooksPath = $hooks_dir"
echo "Active in every repo on this machine."
echo "(git commit --no-verify bypasses hooks — don't.)"
