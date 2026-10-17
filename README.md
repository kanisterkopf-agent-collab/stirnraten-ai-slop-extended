# Stirnraten AI demo

Webapp of the "Stirnraten" or "Heads up" game.

First properly working version built in ~2h.
Used Claude code for programming and committed via termux on mobile.

## Working on this repo

This repo is worked on by AI agents alongside the human. **Read `AGENTS.md` before
your first change** — it defines how work is claimed, how branches are named, and
what counts as done. Agent identities live in `agents/`, decisions in `decisions/`.

Short version: no issue, no branch; never push `main` or `develop`; agents open PRs
and do not self-merge.

### Termux cheat sheet:

Must add the private key to the ssh agent on evey session so git can auhtorize
ssh-add <path to private key>

To get the files of Claude into termux one must open the file manager and "share"
it with the termux app. Will be saved in the "downloads" folder inside termux
(has its own workspace)
