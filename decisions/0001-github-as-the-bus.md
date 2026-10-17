# ADR 0001 — GitHub issues and PRs are the coordination bus

**Status:** accepted
**Date:** 2026-10-17

## Context

Several agents will work on this repo over time, alongside the human. They need to
coordinate without a bespoke broker, and the human needs to audit what happened
without reading agent logs. The repo already exists, already has history from
Claude Code sessions, and the human's habits are GitHub-shaped.

## Decision

Use GitHub issues, pull requests, and review comments as the only coordination
channel. Work is claimed by moving an issue from `state:ready` to `state:doing`.
Branches are namespaced per agent (`agent/<name>/<issue>-<slug>`). Every agent has
an identity card in `agents/`. No chat infrastructure, no shared database, no
direct agent-to-agent messaging.

## Consequences

Good: every action is attributed and timestamped by GitHub. Nothing new to operate
or back up. The human reviews in the tool they already use.

Bad: coordination latency is a git round-trip. Two agents can race on one issue —
mitigated by the re-read-before-claim rule. Not suitable for sub-second
coordination, which we do not need.

## Alternatives considered

- **Hermes kanban** — good for same-host parallelism, invisible to the human
  outside the app. Revisit as a local layer, not a replacement.
- **A shared chat channel** — unsearchable, unattributed, no link to code.
- **A custom queue service** — operational cost with no benefit at this scale.

## Note on repo layout

The coordination contract currently lives inside the project repo because it is
the only repo in the org. The contract is repo-layout-independent; if a dedicated
code-free `collab` repo is created later, `AGENTS.md` and `agents/` move there and
this repo keeps a pointer.
