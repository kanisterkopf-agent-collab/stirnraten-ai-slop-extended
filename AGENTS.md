# AGENTS.md — Operating Contract

Read this file in full before your first action in this repo. It is not advisory.

## 1. What this repo is

A single-file PWA game ("Stirnraten" / Heads-Up). `index.html` is the entire
application — markup, styles, and script, ~890 lines, no build step. `sw.js` is
the service worker, `manifest.json` the PWA manifest, icons at the root.

Consequences of that shape:

- There is no compiler to catch you. A stray brace in `index.html` ships broken.
- There is no bundler, so no imports — everything lives in one scope.
- The service worker caches aggressively. **A change to `index.html` that does
  not bump `CACHE_NAME` in `sw.js` will not reach a returning user.** This is the
  single most common bug in this class of app; treat the two files as coupled.

## 2. Identity

Commit as your own identity, never the human's:

```
git config user.name  "hermes"
git config user.email "hermes@agents.local"
```

Your card is `agents/hermes.md`. If a task falls outside your card's scope, stop
and escalate rather than expanding your own scope.

## 3. The bus

There is no side channel. All coordination happens in issues and pull requests so
the human can audit it afterwards. **No issue, no branch.**

| Label | Meaning |
|---|---|
| `agent:hermes` | owned by that agent |
| `state:ready` | unblocked, may be claimed |
| `state:doing` | claimed and actively worked |
| `state:blocked` | waiting on a decision, dependency, or the human |
| `state:review` | PR open, awaiting review |
| `state:done` | merged and verified |
| `prio:high` / `prio:low` | urgency |

Claim by moving `state:ready` → `state:doing` and commenting:

```
Claiming. ETA: <estimate>. Plan: <one or two lines>.
```

**Re-read the issue immediately before you comment.** Claims are not locks; two
agents waking together both see `state:ready`. If someone claimed it first, walk
away.

## 4. Branches and PRs

- `main` is the shipped branch. `develop` carries work that is ahead of it.
- Never push to `main` or `develop` directly. Ever.
- Branch: `agent/<your-name>/<issue>-<slug>`, e.g. `agent/hermes/4-tilt-deadzone`.
- One logical change per PR. Put `Closes #4` in the body.
- Do not self-merge. Move the issue to `state:review` and stop.

## 5. Testing, given there is no test framework

The game's core mechanic is a device-tilt gesture, which a headless runner cannot
exercise honestly. So:

- For logic changes (shuffling, scoring, timer), extract or reason about the pure
  function and **paste the actual output** you ran in Node/Python.
- For gesture and layout changes, state plainly that verification needs a real
  device, and name what to check. Do not claim it works.
- Always confirm `index.html` parses — open it, or run it through a parser.
- If you bump `CACHE_NAME`, say so explicitly in the PR.

Never write "tested" without the command output beside it.

## 6. Handoffs

When you stop mid-task, comment on the issue:

```
## Handoff
**State:** what works now, what does not.
**Next step:** the single next action, concretely.
**Gotchas:** anything that will bite the next agent.
**Files:** paths that matter.
```

A handoff without a concrete next step is a failure to hand off.

## 7. Blocked and escalation

Move to `state:blocked` and @-mention the human when:

- the task needs a credential, a device, or an account you do not have
- two valid designs exist and the choice is a product decision (word lists,
  scoring rules, visual direction)
- the change would touch branch protection, CI secrets, or deployment
- you have failed the same thing three times

Format: `Blocked on: <what>. Unblocks when: <precise condition>.`

## 8. Never do

- Never commit secrets, tokens, or personal data.
- Never force-push a branch another agent may have based work on.
- Never rewrite history on `main` or `develop`.
- Never close an issue you did not create without human approval.
- Never claim something is verified without the output to prove it.

## 9. Definition of done

Merged, the game still loads and plays, and the issue is closed with a one-line
summary of what shipped. Not when the code is written.
