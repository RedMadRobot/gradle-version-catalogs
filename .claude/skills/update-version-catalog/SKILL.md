---
name: update-version-catalog
description: >-
  Use EVERY time the user asks to update / bump the version catalogs, "сделать
  обновление", "обновить каталог(и)", "обнови версии", "оформи изменения",
  "update the catalog", or to record dependency version changes in the
  changelog. Renovate commits the version bumps into versions-*/libs.versions.toml;
  this skill collects those changes, records them in CHANGELOG.md following the
  format rules below, and validates with `./gradlew validateCatalog`. ALSO use
  it when the user asks to add a new dependency ("добавь зависимость",
  "add dependency") giving Maven coordinates like "group:artifact" — the skill
  finds the latest stable version, adds it to the right catalog, and records it
  in the changelog.
---

# Update Version Catalog

Renovate is the source of version updates: it keeps each dependency bump on its
own remote branch `origin/renovate/<dep>` (e.g. `origin/renovate/dagger`,
`origin/renovate/compose-bom`), with a commit topic like `stack: dagger 2.60`.
This skill does NOT invent versions — it collects Renovate's bumps onto a fresh
working branch, documents them in `CHANGELOG.md`, and validates the catalogs.

This document is self-contained: all `CHANGELOG.md` formatting rules are inlined
below. Everything that can be checked mechanically IS checked mechanically —
`lint-changelog.sh`, `check-doc-links.sh` and `finish-check.sh` are the source of
truth, not your own reading of the diff.

---

## HARD RULE — respond in Russian

All output shown to the user — progress updates, questions, summaries, and the
final report — MUST be written strictly in Russian, regardless of the language
of the user's request. This applies only to the assistant's messages; code,
commit messages, `CHANGELOG.md` entries, and file contents follow their own
existing conventions and are unaffected.

---

## HARD RULE — work only on the created branch

All work happens on the single `dev-update-YYYY-MM-DD` branch created in step 1.

- **NEVER** commit, amend, reset, rebase, cherry-pick, push, or otherwise mutate
  any other branch — **especially `main`**. `main` may only be read (fetched /
  pulled fast-forward in step 1) and used as the cherry-pick/reset base.
- Confirm you are on the working branch before every commit/amend/reset
  (`git branch --show-current` → must be `dev-update-*`). If it is not, STOP and
  fix the branch before running the command.
- Do NOT touch `release/*` or `origin/renovate/*` branches (renovate branches are
  read-only sources for cherry-pick).
- Do NOT `git push` anything unless I explicitly ask.

If any step would require changing a branch other than the working one, STOP and
ask me instead of proceeding.

---

## Command types — recognise what was asked before starting

Every command is one of three kinds:

| The user asks | Flow to follow | Commits produced |
| ------------- | -------------- | ---------------- |
| **Update** existing dependencies («обнови зависимости/каталоги», «сделай обновление», "update") | Workflow steps 1–10 | **1** update commit: all cherry-picked bumps + their `CHANGELOG.md` entries |
| **Add** new dependencies («добавь зависимость …», "add <group:artifact>") | "Adding a new dependency" section (its step 1 = workflow step 1) | **1** addition commit: catalog edits + their `CHANGELOG.md` entries |
| **Both at once** («обнови зависимости и добавь …») | TWO operations, both mandatory: workflow steps 1–9 **in full first**, then (step 10) the ENTIRE addition flow on top of the finished update commit | **2** commits: first the update commit, then the addition commit — never mixed |

All additions requested by one command share a single addition commit, no
matter how many dependencies are added. A correction to an earlier result
(«исправь ссылку», «поправь changelog») is none of these — it is a
continuation of the previous command (see workflow step 1) and creates no new
commit.

**Before doing ANYTHING else, classify the command against this table and tell
the user (in Russian) which kind it is.** For a **Both at once** command,
explicitly announce the plan as two numbered operations — e.g. «Команда
двойная: 1) обновление каталогов, 2) добавление <deps>. Начинаю с
обновления.» — and track both as separate items in your task list so neither
can be dropped.

### HARD RULE — "Both at once" is TWO sequential operations, never one

A command that both updates and adds (any phrasing that combines them:
«обнови зависимости и добавь X», «сделай обновление и добавь X», "update the
catalogs and add X", or an addition mentioned anywhere in an update request)
is NOT one task. It is TWO complete, sequential operations:

1. **Operation 1 — Update:** workflow steps 1–9, all the way through
   validation, producing the update commit.
2. **Operation 2 — Addition:** the ENTIRE "Adding a new dependency" flow
   (its steps 2–7; step 1 is skipped — the branch already exists), producing a
   SECOND, separate commit on top of the update commit.

Finishing operation 1 does NOT complete the command. Do NOT report results,
do NOT stop, do NOT wait for further input after the update — continue
straight into operation 2. The command is complete ONLY when
`finish-check.sh --expect-commits 2` passes, i.e. `git log origin/main..HEAD`
shows BOTH commits (update + addition) and both passed validation. If you are
about to write the final summary and the user's request mentioned adding a
dependency but there is no addition commit — you are not done; go back and
perform operation 2.

---

## Commit rules — one command, which commits

- **Update and addition are separate commits.** When a single command asks both
  to update dependencies AND to add new ones ("обнови зависимости и добавь
  <deps>") — the "Both at once" row of the command-types table — produce
  **two commits**: first the update commit (all cherry-picked
  bumps + their `CHANGELOG.md` entries), then the addition commit (catalog
  edits + their `CHANGELOG.md` entries). Each commit follows the same rules —
  changelog folded into its own commit, lint, link checks, validation. Never mix
  bumps and additions in one commit.
- **Never amend or rewrite commits that existed before the current command.**
  Amending is allowed only for a commit created while executing the current
  command (e.g. folding `CHANGELOG.md` or lint fixes into it). If the
  `dev-update-*` branch already exists and carries commits from an earlier
  command or session, record the current command's result as **new commit(s) on
  top** — do not amend, reset, or squash into the old ones.
- These rules are **enforced by the scripts**, not by your memory:
  `start-update.sh` records the **command base** and never moves it silently;
  `squash-commit.sh` and `commit-release.sh` refuse to rewrite commits at or
  below it; `commit-release.sh` also refuses to create a *second* message-commit
  in the same command (a rephrased message would otherwise duplicate the
  addition commit). If a script refuses, read its message — do not work around
  it with hand-written git commands.

---

## Catalog distribution rule

Which catalog a dependency belongs to is decided **by its Maven group alone** —
never by product name, ecosystem, or vendor. Apply the first matching rule:

| Maven group | Catalog |
| ----------- | ------- |
| `androidx.*` | `versions-androidx` |
| `com.redmadrobot.*` | `versions-redmadrobot` |
| everything else | `versions-stack` |

Explicit consequences (do NOT ask about these — the rule already decides):

- `org.jetbrains.compose.*` (Compose Multiplatform), `org.jetbrains.androidx.*`
  (multiplatform ports of AndroidX libraries), `org.jetbrains.kotlin*`,
  `org.jetbrains.kotlinx.*`, `org.jetbrains.dokka.*` → **`versions-stack`**.
  "Compose" or "androidx" in the *name* does not move a JetBrains group into
  `versions-androidx`.
- `com.google.android.material` (Material Components), `com.google.*`,
  `com.squareup.*`, Firebase, Dagger, testing frameworks, Gradle plugins →
  **`versions-stack`**.
- Android testing libraries in the `androidx.test.*` group →
  **`versions-androidx`** (group starts with `androidx.`).
- Gradle plugins follow the same rule by their **plugin id / marker group**:
  `org.jetbrains.*`, `dev.*`, `com.*` etc. → `versions-stack` unless the id
  starts with `androidx.` or `com.redmadrobot.`.

If a dependency genuinely does not fit (e.g. a new red_mad_robot group that is
not `com.redmadrobot.*`), STOP and ask — do not guess a catalog.

---

## Workflow

All git operations use the ready-made scripts in
`.claude/skills/update-version-catalog/scripts/` — do NOT hand-write git
commands, run these instead (via the Bash tool / Git Bash). Every mutating
script guards that HEAD is a `dev-update-*` branch, uses `origin/main` only as a
read-only base, and never opens an editor (so nothing can hang the session).

| Script | Purpose |
| ------ | ------- |
| `list-renovate-updates.sh` | Fetch + list all renovate branches ahead of main, with bumps & diffs (read-only) |
| `start-update.sh [YYYY-MM-DD] [--new-command] [--force]` | Start a command: fetch ALL remote branches, create/switch to (or stay on) the `dev-update-*` working branch, record the command base — run once at the start of every command |
| `cherry-pick-renovate.sh [names…]` | Cherry-pick all (or named) renovate branches onto the working branch; safe to re-run |
| `squash-commit.sh ["msg"]` | Squash the current command's picked commits into one |
| `show-version-diffs.sh` | Catalog version diffs of the release commit **+ automatic version-format guard** (read-only) |
| `bom-diff.sh <group:artifact> <old> <new>` | Component version diff of two BOM releases, read from the BOMs' POMs (read-only) |
| `find-latest-version.sh <group:artifact>…` | Latest stable version from Google Maven / Maven Central / Plugin Portal (read-only) |
| `resolve-doc-url.sh <group:artifact> <version>` | Resolve a dependency's version-specific doc URL (known list → POM HomePage → GitHub tag) (read-only) |
| `known-doc-urls.tsv` | Data file: dependencies whose docs have no per-version page (or are JS-rendered) + which link checks to skip for them |
| `commit-release.sh ["msg"] [--new-commit]` | Create or amend the current command's commit (update or addition) with catalog + `CHANGELOG.md` changes |
| `lint-changelog.sh [--skip-renovate]` | Cross-check `[Unreleased]` entries against the release diff, format rules, and renovate branches (read-only) |
| `check-doc-links.sh [--all]` | Verify every added link: host policy, version-specific URL, reachability, version present on the page, `#anchor` exists (read-only) |
| `finish-check.sh [--skip-renovate] [--expect-commits N] [--with-gradle]` | **Final gate** — git state, commit count, lint, links, `:warning:` candidates |
| `lib.sh` | Shared helpers (sourced, never run): maps, version ordering, TOML parsing |

The scripts run on **macOS and Windows/Git Bash alike**: they stay within bash 3.2
(the version macOS ships) and POSIX/BSD tool behaviour. When editing them, keep to
the rules documented at the top of `lib.sh` — no associative arrays, no `${var,,}`,
no `sort -V` (use `vsort`/`vge`), no `\t`/`\n` in a `sed` replacement, no `\s` in a
regex, and no expansion of a possibly-empty `"${array[@]}"`. `*.sh` is pinned to LF
in `.gitattributes`: a CRLF copy would fail on macOS with `$'\r': command not found`.

### 1. Fetch and create the working branch — run at the start of EVERY command

First check where you are: `git branch --show-current`.

- **On `main` or already on a `dev-update-*` branch** → run:

  ```bash
  bash .claude/skills/update-version-catalog/scripts/start-update.sh
  ```

  The script ALWAYS starts by fetching **all** remote branches with an explicit
  refspec, so the fresh `origin/main` and every current `origin/renovate/*`
  branch are available BEFORE the working branch is created. On `main` it then
  creates `dev-update-YYYY-MM-DD` (today's date) off the freshly fetched
  `origin/main`; local `main` is never modified. Pass an explicit `YYYY-MM-DD`
  to override the date. Already on a `dev-update-*` branch it stays there — the
  current command's results become new commit(s) on this branch.

  It also **refuses to start** from any other branch and with a dirty working
  tree (uncommitted changes would be swept into the release commit by
  `commit-release.sh`). If it refuses, report the message and ask me — do not
  pass `--force` on your own.
- **On any other branch** (`release/*`, feature branch, …) → STOP and ask me
  which branch to work on; do not guess.

**Command base.** The script records the current HEAD as the command base;
`squash-commit.sh` / `commit-release.sh` never rewrite anything at or below it.
Run it exactly **once per command, at the start**. If it is run again while a
command is in progress it now **keeps** the recorded base and prints a NOTE —
that is the safe behaviour, not an error. Only a genuinely NEW command on a
branch that already carries commits should move the base, with
`start-update.sh --new-command`.

**What counts as a command.** A command is a user request that starts a NEW
update or addition task («обнови каталоги», «добавь зависимость …»). A
follow-up request that corrects the result already produced in this session
(«исправь ссылку», «поправь changelog», fixing a lint/link problem you
reported) is a **continuation of the previous command, NOT a new command**: do
NOT re-run `start-update.sh` for it. Just edit the files and re-amend with
`commit-release.sh`.

### 2. Cherry-pick the Renovate bumps

First review what is available, then cherry-pick:

```bash
bash .claude/skills/update-version-catalog/scripts/list-renovate-updates.sh
bash .claude/skills/update-version-catalog/scripts/cherry-pick-renovate.sh          # all
# or a subset: ... cherry-pick-renovate.sh dagger kotest hilt
```

Cherry-pick **every** renovate branch that has a new commit — not only the ones
touching `versions-*/libs.versions.toml`. Infrastructure updates such as the
Gradle wrapper (`gradle/wrapper/*`) and GitHub Actions (`.github/workflows/*`)
belong in the release commit too; they just do NOT get a `CHANGELOG.md` entry
(see "What NOT to record"). Skip a branch only if I explicitly say so — mention
what you skipped.

On a conflict the script stops and prints exactly what to do: resolve it in
`versions-*/libs.versions.toml` by keeping the newer version, `git add` the
file, run `GIT_EDITOR=true git cherry-pick --continue`, then simply **re-run the
script** — commits already on the branch are skipped by patch-id *and* by
subject, and a pick that turns out empty is skipped automatically.

### 3. Squash the cherry-picked commits into one

All bumps collected by the **current command** must live in a **single commit** —
the `CHANGELOG.md` changes are added to that same commit later (step 8).

```bash
bash .claude/skills/update-version-catalog/scripts/squash-commit.sh
```

The script builds the commit message itself (the subjects of the squashed
commits, oldest first, one per line — the same style as existing release
commits on `main`). Do NOT pass a message argument unless I explicitly asked
for a specific one.

After this, on a fresh branch `git log origin/main..HEAD` shows exactly one
commit. If the branch already carried commits from an earlier command, only the
current command's commits are squashed (the script says where it stopped).

### 4. Extract old → new versions per catalog

```bash
bash .claude/skills/update-version-catalog/scripts/show-version-diffs.sh
```

From the output, collect per changed `libs.versions.toml`: library/plugin name,
old version (`-` lines), new version (`+` lines). Classify each as added /
updated / removed / renamed (see symbols below).

**Version-format change.** The script's `=== version format guard ===` section
decides this for you: every `FORMAT_CHANGE <alias> <old> → <new> (<reason>)`
line is a bump whose version *shape* changed (pre-release suffix appeared or
disappeared, semver → calendar, plain → dash-compound, segment count changed
without shared leading segments). For each such line **STOP and ask me to
confirm**, showing the library with its **old → new** version; continue only
after I confirm. When the section prints `OK — no version-format changes`, do
not ask about version formats at all. (Gaining or losing a plain trailing patch
segment, `2.60` → `2.60.1`, is not a format change and is never flagged.)

### 5. Categorize by section

The catalog (and its changelog subsection) is determined by the **catalog
distribution rule** above — the subsection always matches the
`libs.versions.toml` the change lives in: `versions-androidx/` → **AndroidX**,
`versions-stack/` → **Stack**, `versions-redmadrobot/` → **red_mad_robot**.

### 6. Add release-notes links

Every entry's library name is a link to release notes **for that exact version**.
Where the URL comes from, in this order:

1. **A previous release section of `CHANGELOG.md`** already links this library →
   reuse that URL with the new version substituted. This is the default for
   `:arrow_up:` entries and almost always works.
2. **Templates** for the big families:
   - AndroidX: `https://developer.android.com/jetpack/androidx/releases/{library}#{version}`
     (some libraries anchor as `#{library}-{version}` — the anchor check in
     step 9 catches a wrong one);
   - GitHub projects: `https://github.com/{org}/{repo}/releases/tag/{tag}` —
     the tag format varies per project (`v1.2.3`, `dagger-2.60.1`, `r6.1.1`,
     plain `6.14.0`), so do not assume the `v` prefix.
3. **Resolve it with the script** — mandatory for `:sparkle:` entries and for
   anything you are unsure about. Never construct a URL from a naming pattern:

   ```bash
   bash .claude/skills/update-version-catalog/scripts/resolve-doc-url.sh <group:artifact> <version>
   ```

   It checks `known-doc-urls.tsv` first, then reads the artifact's **HomePage**
   from its POM (Google Maven / Maven Central / Plugin Portal) and, when that is
   GitHub, finds the **tag matching the version** via `git ls-remote` (no API
   rate limit). Verdicts:

   - `KNOWN <url>` — from `known-doc-urls.tsv`; use as-is.
   - `RELEASE <url>` / `TAG <url>` — the release/tag page for the version; use
     it directly.
   - `HOMEPAGE <url>` — only a project/repo home was found. This does NOT point
     at the version, so it is **not a valid CHANGELOG link**: show me this URL
     as the closest match and ask me for the correct version-specific URL.
     Proceed only after I supply one (or confirm the shown one).
   - `NO_HOMEPAGE` — the POM has no usable `<url>`/`<scm>` (common for Gradle
     plugin markers). Use the Plugin Portal route in "Adding a new dependency"
     step 5, or search GitHub for `group:artifact`.
   - `NOT_FOUND` — the artifact POM is in no repository; STOP and ask me for the URL.
   - `GH_RATE_LIMITED <repo-url>` — only from the API fallback; set
     `GITHUB_TOKEN`/`GH_TOKEN` (or wait) and re-run. It is NOT "no release
     exists" — do not downgrade to `HOMEPAGE`.

**A documentation link MUST point at the specific version** (path, tag or
`#anchor`). A repository home, a docs landing page or a release-notes index
without a version anchor is invalid. A Maven artifact/repository page is
FORBIDDEN as an entry URL: never `mvnrepository.com`, `search.maven.org`,
`central.sonatype.com`, `maven.google.com`, `repo1.maven.org` or similar
listings. `check-doc-links.sh` enforces both rules in step 9.

**Vendors without per-version pages.** A few vendors (AppsFlyer, Firebase,
Google Play services, …) publish one release-notes page for everything, or
render the recent entries with JavaScript. They are listed in
`known-doc-urls.tsv` together with the checks to skip — `resolve-doc-url.sh`
returns their URL as `KNOWN` and `check-doc-links.sh` relaxes the version/anchor
checks for them. If step 9 fails for a NEW such vendor and you have verified in
a browser that the page really is the right release-notes page, propose adding a
row to `known-doc-urls.tsv` (and say so in the report) instead of silently
recording a version-less link.

### 7. Write entries into `[Unreleased]`

1. Open `CHANGELOG.md`, locate the `## [Unreleased]` section.
2. Add each entry to the correct subsection (red_mad_robot / AndroidX / Stack).
3. Format each entry per the reference at the end of this document.
4. Sort within each subsection: regular libraries alphabetically first, then
   `plugin:` entries alphabetically.
5. Replace `*No changes*` when adding the first entry to a subsection; keep all
   three subsections present even if some stay `*No changes*`.
6. One entry per catalog alias that changed — an entry with the same versions as
   another library does not document it (`lint-changelog.sh` matches by alias
   name, not by version pair).

### 8. Fold `CHANGELOG.md` into the single commit

The `CHANGELOG.md` edit must go into the **same commit** as the version bumps —
do NOT create a separate commit for the changelog alone:

```bash
bash .claude/skills/update-version-catalog/scripts/commit-release.sh
```

The script stages `CHANGELOG.md` plus any catalog edits and amends the squashed
commit from step 3 (or creates the release commit when none exists yet — see
"Adding a new dependency"). It prints `git show HEAD --stat`, which should list
both the `versions-*/libs.versions.toml` changes and `CHANGELOG.md` in one
commit, and **warns about any modified file that was left out** — read that
warning, it means something is not in the commit.

Run this BEFORE the checks in step 9: they read the commit, not the working
tree (`lint-changelog.sh` stops with an explicit message if you forget).

### 9. Validate

**a. Lint the changelog against the release diff:**

```bash
bash .claude/skills/update-version-catalog/scripts/lint-changelog.sh
```

Cross-checks the `[Unreleased]` entries against the actual catalog diff and
the format rules: every catalog change (including added/removed/renamed modules
and plugin ids) is documented under its own alias, no phantom entries, exact
`old` → `new` versions — for nested BOM components too — correct subsection,
valid symbols/links/arrow, sorting, no duplicates, and that every renovate
branch's bump made it into the diff (a branch already superseded by a newer bump
is reported as `INFO: … superseded`, not as a problem).

**The `--skip-renovate` flag is decided by the current command, not by the
commit being linted:**

- the command cherry-picked renovate branches → ALWAYS run without the flag —
  including when linting the addition commit of a combined update-and-add
  command;
- the command cherry-picked nothing (standalone add) → run with
  `--skip-renovate`, otherwise pending renovate branches would be falsely
  reported as "not picked".

Fix every reported problem in `CHANGELOG.md`, re-amend with `commit-release.sh`,
and re-run until it prints `OK`.

**b. Verify every documentation link:**

```bash
bash .claude/skills/update-version-catalog/scripts/check-doc-links.sh
```

For each link added to `CHANGELOG.md` in HEAD it checks: forbidden Maven hosts,
that the URL itself carries the new version, reachability after redirects, that
the fetched page really mentions the version (dot/dash/underscore variants), and
that a `#anchor` exists in the HTML — a wrong anchor is invisible otherwise,
since fragments are client-side and the page still answers 200.

Do NOT check links by hand with WebFetch instead of this script. If it reports a
problem, fix the link (correct anchor/tag, or another release-notes source),
re-amend with `commit-release.sh` and re-run. Use WebFetch only to *investigate*
a reported problem, and `known-doc-urls.tsv` for a vendor that genuinely has no
per-version page (see step 6).

**c. Validate the catalogs:**

```bash
./gradlew validateCatalog
```

Confirm the build passes. Report every result plainly — if a link is broken, a
version is missing from its page, or validation fails, surface it rather than
claiming success.

### 10. Final gate — run it before reporting anything

```bash
# update-only command
bash .claude/skills/update-version-catalog/scripts/finish-check.sh
# standalone addition
bash .claude/skills/update-version-catalog/scripts/finish-check.sh --skip-renovate
# combined update-and-add command
bash .claude/skills/update-version-catalog/scripts/finish-check.sh --expect-commits 2
```

It re-checks the whole result in one place: working branch, no cherry-pick left
in progress, clean working tree, the expected number of commits ahead of
`origin/main`, every commit carrying its CHANGELOG entries, lint, links, and an
advisory list of `:warning:` candidates (major/minor bumps documented without
the mark — mention them to me, never add the mark yourself).

**Combined command?** Re-read the user's request: did it ALSO ask to add new
dependencies («…и добавь …», "…and add …")? If yes, the update you just finished
was only **operation 1 of 2**. Continue immediately with the "Adding a new
dependency" flow (steps 2–7 — do NOT re-run `start-update.sh`) and only report
the command as done when `finish-check.sh --expect-commits 2` passes.

Report the result in Russian: the commits produced, what was documented, and any
`ALL CHECKS PASSED` / failures verbatim in substance. `./gradlew validateCatalog`
is not part of the gate by default — either run it separately (step 9c) or pass
`--with-gradle`.

---

## Adding a new dependency

When I give Maven coordinates (`group:artifact`, e.g.
`org.jetbrains.compose.foundation:foundation`) and ask to add them, the flow
is: find the latest stable version → add to the right catalog → document →
one addition commit. This can happen inside a regular update session or
standalone.

When the same command also asked for an update, finish the update commit first
(steps 1–9 of the workflow), then do the addition as a **separate commit** on
top of it — never fold additions into the update commit (see "Commit rules").
All additions requested by one command share a single addition commit.

1. **Working branch** — same rule as workflow step 1: on `main` or a
   `dev-update-*` branch run `start-update.sh`; any other branch → STOP and ask.
   In a combined update-and-add command the update already ran it — do NOT run
   it again for the addition.

2. **Find the version in Maven:**

   ```bash
   bash .claude/skills/update-version-catalog/scripts/find-latest-version.sh org.jetbrains.compose.foundation:foundation
   ```

   `find-latest-version.sh` only accepts `group:artifact`. Which coordinate to
   pass depends on whether you are adding a **library** or a **Gradle plugin** —
   tell them apart by how I gave it to you:

   - **Library** (goes in `[libraries]`, given as Maven coordinates
     `group:artifact`, contains a colon, e.g.
     `org.jetbrains.compose.foundation:foundation`) → pass those coordinates
     **verbatim**. Do not transform them.
   - **Gradle plugin** (goes in `[plugins]`, given as a plugin **id** — a
     dotted string with **no colon**, e.g. `dev.drewhamilton.poko`,
     `org.jetbrains.compose`) → you MUST query the plugin's **marker artifact**,
     whose coordinate is derived mechanically from the id:

     ```
     <plugin.id>:<plugin.id>.gradle.plugin
     ```

     i.e. the plugin id is used as BOTH the group and (with the
     `.gradle.plugin` suffix) the artifact. Worked examples:

     | Plugin id (given) | Coordinate to pass to the script |
     | ----------------- | -------------------------------- |
     | `dev.drewhamilton.poko` | `dev.drewhamilton.poko:dev.drewhamilton.poko.gradle.plugin` |
     | `org.jetbrains.compose` | `org.jetbrains.compose:org.jetbrains.compose.gradle.plugin` |
     | `com.google.devtools.ksp` | `com.google.devtools.ksp:com.google.devtools.ksp.gradle.plugin` |

     NEVER guess a `group:artifact` by splitting the id on the last dot (e.g.
     `dev.drewhamilton:poko` is **wrong** and will return `NOT_FOUND`). Always
     build the marker coordinate with the rule above. The marker artifact lives
     in the Gradle Plugin Portal, which the script already queries.

   Resolve the version to add by these rules, in order. Stable means a plain
   release with no pre-release qualifier (no `-alpha`, `-beta`, `-rc`, `-M`,
   `-dev`, `-SNAPSHOT`, etc.).

   - **The latest available version is stable** (`LATEST_STABLE <v>`) → take it
     and use it without asking.
   - **A stable version exists, but a newer pre-release is also available**
     (`STABLE <v> NEWER_PRERELEASE <v>`) → **STOP and ask me** which of the two
     to use, showing both. Do NOT silently pick either.
   - **Only non-stable versions exist** (`UNSTABLE candidates: …`) → **STOP and
     ask me** which of the shown versions to use. Do NOT silently pick a
     pre-release.
   - **No version anywhere** (`NOT_FOUND`) → **STOP and ask me** both which
     version to specify **and** which documentation URL to use. Do not guess.

   If repositories disagree on the latest version, show me both and ask.

3. **Pick the catalog** strictly by the Maven group per the
   "Catalog distribution rule" section above: `androidx.*` →
   `versions-androidx`; `com.redmadrobot.*` → `versions-redmadrobot`;
   everything else (including `org.jetbrains.compose.*` and
   `org.jetbrains.androidx.*`) → `versions-stack`. Do not ask which catalog —
   the rule decides.

4. **Edit that catalog's `libs.versions.toml`:**
   - `[versions]`: add `alias = "version"`. If the artifact shares a version
     with already-present artifacts from the same project, reuse their existing
     version alias instead of adding a new one.
   - `[libraries]`: add `alias = { module = "group:artifact", version.ref = "alias" }`
     (for a Gradle plugin use `[plugins]` with `id`).
   - Follow the naming conventions: alias follows the Maven coordinates, drop
     module names that duplicate the group, version alias matches the library
     alias. Keep the file's existing grouping, comments, and alphabetical
     order within a group.
   - **Gradle reserved words** (the complete list) — never use `extensions`,
     `class`, or `convention` as an alias segment, nor `bundles`, `versions`,
     or `plugins` as the first segment. `./gradlew validateCatalog` (step 9c)
     is the final safety net for a bad alias.
   - Worked example — adding the libraries `com.example.avocado:avocado` and
     `com.example.avocado:avocado-core` `1.2.0` plus the Gradle plugin
     `dev.drewhamilton.poko` `0.19.3`:

     ```toml
     [versions]
     avocado = "1.2.0"   # one shared version alias for the whole project
     poko = "0.19.3"

     [libraries]
     # artifact repeats the group's last word → alias keeps only "avocado"
     avocado = { module = "com.example.avocado:avocado", version.ref = "avocado" }
     avocado-core = { module = "com.example.avocado:avocado-core", version.ref = "avocado" }

     [plugins]
     poko = { id = "dev.drewhamilton.poko", version.ref = "poko" }
     ```

5. **CHANGELOG entry** — a `:sparkle:` line in the matching subsection of
   `[Unreleased]`, with the version in backticks (see the format reference).
   Entry name = the library alias; a plugin entry additionally carries the
   `plugin:` prefix.

   **Resolve the link — never invent it**, with `resolve-doc-url.sh` and the
   verdicts listed in workflow step 6. For a **library** pass its Maven
   coordinates verbatim. For a **Gradle plugin** the marker artifact's POM
   usually has no HomePage (`NO_HOMEPAGE`) — then find the real repository via
   the Plugin Portal page:

   ```
   https://plugins.gradle.org/plugin/<plugin.id>
   ```

   e.g. `https://plugins.gradle.org/plugin/dev.drewhamilton.poko` →
   `github.com/drewhamilton/Poko` → release/tag URL for the version. (Web search
   for "<plugin.id> github" is a fine fallback.) A plugin id is NOT a GitHub
   path — never turn `dev.drewhamilton.poko` into
   `github.com/dev.drewhamilton/poko`.

   The Maven artifact page and the Plugin Portal page are lookup aids only —
   never put them in the entry. If none of these steps yield a version-specific
   documentation URL, STOP and ask me for it before writing the entry.

6. **Commit:**

   ```bash
   bash .claude/skills/update-version-catalog/scripts/commit-release.sh "stack: add <alias> <version>"
   ```

   Standalone add: the script creates the addition commit, and later re-runs
   (lint/link fixes) amend it — **re-run it with the exact same message**, a
   different message is refused so a rephrasing cannot produce a second commit.
   Combined update-and-add command: the update commit already exists, so this
   creates the addition commit on top of it.

7. **Validate as in workflow step 9, then run the final gate (step 10).** The
   `--skip-renovate` rule applies: standalone add command (nothing
   cherry-picked) → `lint-changelog.sh --skip-renovate` and
   `finish-check.sh --skip-renovate`; combined update-and-add command → WITHOUT
   the flag and with `--expect-commits 2`.

---

## CHANGELOG.md format reference

### Symbol legend

| Symbol       | Meaning                                                              |
| ------------ | -------------------------------------------------------------------- |
| `:sparkle:`  | Added dependency                                                     |
| `:arrow_up:` | Updated dependency                                                   |
| `:x:`        | Removed dependency                                                   |
| `:memo:`     | Dependency or version name changed                                   |
| `:warning:`  | Be careful on update. May contain breaking or behaviour changes.     |

`:warning:` is NOT set by this skill — deciding whether an update is breaking
requires reading the dependency's release notes, which is out of scope here.
`finish-check.sh` lists major/minor bumps as *candidates*; report them to the
maintainer, who adds the mark. Preserve any existing `:warning:` marks when
editing entries.

### File structure

- **Header** — symbol legend.
- **`## [Unreleased]`** — changes not yet released, with the three subsections
  `### red_mad_robot`, `### AndroidX`, `### Stack`.
- **Version sections** — `## [YYYY.MM.DD]`, each with the same three subsections.
- **Footer links** — previous-year changelogs and GitHub compare links per version.

### Entry format

```markdown
# New dependency — link the library's release/tag page for the version;
# never a Maven artifact page (ask the user if none can be found)
- :sparkle: [library-name](release-or-tag-url) `version`

# Updated dependency
- :arrow_up: [library-name](release-notes-url) `old-version` → `new-version`

# Removed dependency
- :x: [library-name](release-notes-url)

# Renamed / changed
- :memo: [library-name](release-notes-url) description

# Plugin — prefix with `plugin:`
- :arrow_up: plugin: [Plugin Name](url) `old-version` → `new-version`
```

Use the real arrow `→` (never `->`). Wrap version numbers in backticks. Entry
name = the catalog alias. Sorting inside a subsection: libraries alphabetically,
then `plugin:` entries alphabetically; `- *No changes*` when there is nothing.

### Common patterns

**BOM updates** — list individual component bumps nested under the BOM entry:

```markdown
- :arrow_up: [compose-bom](url) `2026.06.00` → `2026.06.01`
  - :arrow_up: [compose-animation](url) `1.11.3` → `1.11.4`
  - :arrow_up: [compose-foundation](url) `1.11.3` → `1.11.4`
```

Where the nested versions come from:

- **Components that have their own alias in the catalog** (all `compose-*` ones
  do — Renovate bumps them alongside the BOM) → take the versions **from the
  catalog diff** (`show-version-diffs.sh`). This is the source of truth, and
  `lint-changelog.sh` cross-checks nested entries against it.
- **Components without an alias of their own** (e.g. individual Firebase
  artifacts under `firebase-bom`) → get the list mechanically from the BOMs'
  POMs:

  ```bash
  bash .claude/skills/update-version-catalog/scripts/bom-diff.sh androidx.compose:compose-bom 2026.06.00 2026.06.01
  bash .claude/skills/update-version-catalog/scripts/bom-diff.sh com.google.firebase:firebase-bom 34.16.0 34.17.0
  ```

  Do not read version numbers off the BOM-mapping web page; the POM diff is
  exact. Each nested component links to its own release notes.

**Monorepo updates** — each library from the same repo gets its own entry:

```markdown
- :arrow_up: [okhttp](url) `5.2.1` → `5.3.2`
- :arrow_up: [okhttp-logging-interceptor](url) `5.2.1` → `5.3.2`
```

**Catalog name changes** — use the memo symbol (a module/plugin-id change with
an unchanged version needs an entry too; `lint-changelog.sh` requires it):

```markdown
- :memo: [library-name](url) Renamed from old-name to new-name
```

### Quality checks

`lint-changelog.sh` (step 9a) enforces symbols, link syntax, backticked
versions, the `→` arrow, `plugin:` prefixes, sorting, duplicates, the three
subsections, exact `old` → `new` versions and full coverage of the diff;
`check-doc-links.sh` (step 9b) enforces the link rules. Do not re-verify these
by hand — run the scripts and fix what they report. Two things they cannot
check, which stay on you:

- existing `:warning:` marks are preserved (never add one yourself);
- an entry's link really is the release notes *of that library* (a reachable
  page with a matching version can still be the wrong project).

### What NOT to record

Do **not** add to the changelog:
- Gradle wrapper updates.
- GitHub Actions / CI-CD workflow changes.
- Documentation-only changes.
- Internal build-script modifications.
- Config-file changes that don't affect dependencies.

---

## Out of scope

This skill records changes into `[Unreleased]`. Cutting an actual release
(moving `[Unreleased]` into a dated `## [YYYY.MM.DD]` section, bumping
`gradle.properties`, updating footer compare links, tagging) is done by
`./release.sh` — do not do it here unless the user explicitly asks to release.
