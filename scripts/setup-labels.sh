#!/usr/bin/env bash
# Create/refresh the label contract described in AGENTS.md.
# Idempotent: --force updates colour/description if the label already exists.
# Requires Issues enabled on the repo and Issues:write on the token.
set -euo pipefail

REPO="${1:-kanisterkopf-agent-collab/stirnraten-ai-slop-extended}"

label() { gh label create "$1" --repo "$REPO" --color "$2" --description "$3" --force >/dev/null && echo "  ok  $1"; }

# state:*
label "state:ready"    "0E8A16" "Unblocked, may be claimed"
label "state:doing"    "1D76DB" "Claimed and in progress"
label "state:blocked"  "B60205" "Waiting on a decision or dependency"
label "state:review"   "5319E7" "PR open, awaiting review"
label "state:done"     "C2E0C6" "Merged and verified"

# prio:*
label "prio:high"      "D93F0B" "Do this before other work"
label "prio:low"       "FBCA04" "Nice to have"

# agent:*  (add one per identity card in agents/)
label "agent:hermes"   "006B75" "Owned by the hermes agent"

echo "labels applied to $REPO"
