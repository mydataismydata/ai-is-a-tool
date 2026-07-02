# ai-is-a-tool

A git guard that keeps AI attribution out of your commit history.

An AI assistant is a tool — like a hammer. A hammer doesn't co-author the house.
This strips the "co-author" trailers and "generated-with" footers that AI coding
tools try to append, so your history credits **you**.

It's a `commit-msg` hook: mechanical, not a rule some tool has to remember. It
runs as the last gate before a commit is written and edits the message in place.
Install it once per machine and every repo — existing and future — is covered.

## Install — every repo on a machine (recommended)

Clone this repo somewhere permanent, then run the installer once per machine:

```sh
git clone https://github.com/mydataismydata/ai-is-a-tool.git
cd ai-is-a-tool
sh install.sh
```

Windows PowerShell:

```powershell
git clone https://github.com/mydataismydata/ai-is-a-tool.git
cd ai-is-a-tool
./install.ps1
```

That points git's global `core.hooksPath` at this repo's `hooks/` directory, so
the guard applies to every repo on the machine, including any you start later.
Run it once on each machine (your dev box, your Raspberry Pi, ...).

**Update later:** `git pull` in this clone. Every repo picks up the new hook
immediately — nothing to re-copy.

## Install — a single project (self-contained)

If you'd rather vendor it into one repo (e.g. so collaborators get it on clone):

```sh
mkdir -p .githooks
cp /path/to/ai-is-a-tool/hooks/commit-msg .githooks/
chmod +x .githooks/commit-msg
git config core.hooksPath .githooks
git add .githooks/commit-msg && git commit -m "Add commit-msg hook that strips AI attribution"
```

A repo-local `core.hooksPath` overrides the global one, so the two approaches
coexist.

## What it does

**Strips:**
- an assistant `Co-authored-by:` trailer at the start of a line
- a bracketed "generated-with" tool footer

**Keeps:**
- a human `Co-authored-by:` line
- any sentence that merely quotes the trailer text mid-line

The match tokens in `hooks/commit-msg` are written as one-character classes
(e.g. `[x]yz`) so no vendor name appears as a literal, greppable word in this
repo. To cover another assistant, add its token to the alternation the same way.

## Notes

- `core.hooksPath` is set per machine, not per clone of your projects — that's
  why one install covers everything.
- A global hooks path means git uses it instead of a repo's `.git/hooks/`. If a
  project needs its own hooks too, use the per-project install above (local
  overrides global), or add them alongside the hook in the global hooks dir.
- `git commit --no-verify` bypasses all hooks. Don't.
