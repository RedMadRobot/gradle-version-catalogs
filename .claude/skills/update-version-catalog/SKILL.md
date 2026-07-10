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
below.

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
`git log origin/main..HEAD` shows BOTH commits (update + addition) and both
passed validation. If you are about to write the final summary and the user's
request mentioned adding a dependency but there is no addition commit — you
are not done; go back and perform operation 2.

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
  top** — do not amend, reset, or squash into the old ones. This is enforced by
  the **command base** recorded by `start-update.sh` (workflow step 1):
  `squash-commit.sh` and `commit-release.sh` refuse to rewrite commits at or
  below it — which is why `start-update.sh` must run at the start of every
  command, and only then. A correction to this session's result is a
  continuation of the previous command, not a new command — see workflow
  step 1.

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
script guards that HEAD is a `dev-update-*` branch and uses `origin/main` only as
a read-only base, enforcing the HARD RULE above; the command base recorded by
`start-update.sh` additionally protects earlier commands' commits from
amend/squash (see "Commit rules").

| Script | Purpose |
| ------ | ------- |
| `list-renovate-updates.sh` | Fetch + list all renovate branches ahead of main, with bumps & diffs (read-only) |
| `start-update.sh [YYYY-MM-DD]` | Start a command: fetch ALL remote branches (incl. every `origin/renovate/*`), create/switch to (or stay on) the `dev-update-*` working branch and record the command base — run once at the start of every command |
| `cherry-pick-renovate.sh [names…]` | Cherry-pick all (or named) renovate branches onto the working branch |
| `squash-commit.sh ["msg"]` | Squash all picked commits into one |
| `show-version-diffs.sh` | Show catalog version diffs in the release commit (read-only) |
| `find-latest-version.sh <group:artifact>…` | Latest stable version of an artifact from Google Maven / Maven Central / Plugin Portal (read-only) |
| `resolve-doc-url.sh <group:artifact> <version>` | Resolve a dependency's doc URL (new or updated) from its POM HomePage, then find the matching GitHub release/tag for the version (read-only) |
| `commit-release.sh ["msg"]` | Create or amend the current command's commit (update or addition) with catalog + `CHANGELOG.md` changes |
| `lint-changelog.sh [--skip-renovate]` | Cross-check `[Unreleased]` entries against the release diff, format rules, and renovate branches (read-only) |
| `check-changelog-urls.sh` | Reachability + redirect check of URLs added to `CHANGELOG.md` (read-only) |

### 1. Fetch and create the working branch — run at the start of EVERY command

First check where you are: `git branch --show-current`.

- **On `main` or already on a `dev-update-*` branch** → run:

  ```bash
  bash .claude/skills/update-version-catalog/scripts/start-update.sh
  ```

  The script ALWAYS starts by fetching **all** remote branches with an explicit
  refspec (`+refs/heads/*:refs/remotes/origin/*` + `--prune`), so the fresh
  `origin/main` and every current `origin/renovate/*` branch are available
  BEFORE the working branch is created. On `main` it then creates
  `dev-update-YYYY-MM-DD` (today's date) off the freshly fetched `origin/main`;
  local `main` is never modified. Pass an explicit `YYYY-MM-DD` to override the
  date. Already on a `dev-update-*` branch it stays there — the current
  command's results become new commit(s) on this branch (see "Commit rules").

  In both cases the script records the **command base** (current HEAD):
  `squash-commit.sh` and `commit-release.sh` refuse to rewrite anything at or
  below it, protecting earlier commands' commits. Run it exactly **once per
  command, at the start** — never mid-command (that would move the base
  past the commit you are still building and block `commit-release.sh`).

  **What counts as a command.** A command is a user request that starts a NEW
  update or addition task («обнови каталоги», «добавь зависимость …»). A
  follow-up request that corrects the result already produced in this session
  («исправь ссылку», «поправь changelog», fixing a lint/link problem you
  reported) is a **continuation of the previous command, NOT a new command**:
  do NOT re-run `start-update.sh` for it — that would move the command base
  onto the very commit you need to fix and `commit-release.sh` would refuse to
  amend it. Just edit the files and re-amend with `commit-release.sh` as
  usual.
- **On any other branch** (`release/*`, feature branch, …) → STOP and ask me
  which branch to work on; do not guess.

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

On a conflict the script stops mid-cherry-pick. Resolve it in
`versions-*/libs.versions.toml` by keeping the newer version, `git add` the
file, then `GIT_EDITOR=true git cherry-pick --continue` (the `GIT_EDITOR=true`
is required — plain `--continue` opens an interactive editor for the commit
message and would hang the session). Then simply re-run the script — commits
already applied to HEAD are skipped automatically.

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
commit. If the branch already carried commits from an earlier command, squash
ONLY the commits cherry-picked by the current command (see "Commit rules") —
the log then shows the old commits plus one new update commit.

### 4. Extract old → new versions per catalog

```bash
bash .claude/skills/update-version-catalog/scripts/show-version-diffs.sh
```

From the output, collect per changed `libs.versions.toml`: library/plugin name,
old version (`-` lines), new version (`+` lines). Classify each as added /
updated / removed / renamed (see symbols below).

**Version-format change — require confirmation.** Compare the *shape* of the new
version against the previous one (number of dot-separated parts, presence of a
pre-release/suffix, dash-separated compound, calendar/BOM style). If the new
version's format **differs** from the old version's format, do NOT proceed
automatically — stop and ask me to confirm, showing the library name with its
**old → new** version. Continue only after I confirm.

**Exception — do NOT trigger the guard** when the only difference is that a
trailing numeric segment was added (or dropped) while the shared leading numeric
segments are unchanged. Gaining/losing a plain patch component is a normal
version, not a format change:
- `2.60` → `2.60.1` (patch segment appended — OK, no confirmation)
- `1.2.3` → `1.2` (trailing segment dropped — OK)

Examples that trigger the guard (format genuinely changed):
- `1.1.0` → `1.1.1-beta03` (plain → pre-release suffix)
- `1.9.5` → `2026.06.00` (semver → calendar/BOM)
- `0.7.1` → `0.8.0-0.6.x-compat` (plain → dash-separated compound/suffix)

Examples that do NOT trigger it (same format):
- `1.1.0` → `1.2.0`
- `2.2.20-2.0.3` → `2.2.20-2.0.4`
- `1.1.1-beta02` → `1.1.1-beta03`

For added dependencies (no old version) this check does not apply.

### 5. Categorize by section

The catalog (and its changelog subsection) is determined by the **catalog
distribution rule** below — the subsection always matches the
`libs.versions.toml` the change lives in: `versions-androidx/` → **AndroidX**,
`versions-stack/` → **Stack**, `versions-redmadrobot/` → **red_mad_robot**.

### 6. Add release-notes links

Link each library name to its official release notes, using the exact-version
anchor/tag where possible:

- **AndroidX:** `https://developer.android.com/jetpack/androidx/releases/{library}#{version}`
- **Firebase:** `https://firebase.google.com/support/release-notes/android#bom_v{version}`
- **GitHub projects:** `https://github.com/{org}/{repo}/releases/tag/v{version}`

**Updated dependencies (`:arrow_up:`) — where the URL comes from.** In this
order:

1. Find the same library's entry in a previous release section of
   `CHANGELOG.md` and reuse its URL with the new version substituted — this
   is the default and almost always works.
2. No previous entry → build the URL from the templates above. Note: the
   GitHub tag format varies per project — the `v` prefix is not universal
   (e.g. `dagger-2.60.1`, `r6.1.1`, plain `6.14.0`).
3. Unsure of the tag format → run
   `resolve-doc-url.sh <group:artifact> <new-version>` — it works for updates
   just as well as for new dependencies.

Whichever source you used, the version-presence check in step 9 catches
mistakes.

**New dependencies (`:sparkle:`) — resolve the link, never invent it.** Do NOT
guess or construct a URL from a naming pattern — every link must be one you
actually resolved. Use the script:

```bash
bash .claude/skills/update-version-catalog/scripts/resolve-doc-url.sh <group:artifact> <version>
```

It reads the artifact's **HomePage** from its POM (`<url>`/`<scm>`) in Google
Maven / Maven Central / the Plugin Portal, and if that is a GitHub repository
queries the GitHub API for the **release or tag matching the version** on that
page. It prints one verdict:

- `RELEASE <url>` / `TAG <url>` — the GitHub release/tag page for the version;
  use it directly.
- `HOMEPAGE <url>` — the POM HomePage (GitHub repo home or a non-GitHub site),
  found when no per-version release/tag exists. This URL does NOT point at the
  specific version, so it is **not a valid CHANGELOG link** (see the
  version-specific link rule below). Do NOT use it as the entry URL — instead
  show me this URL as the closest match that could be found and ask me to
  provide the correct version-specific documentation URL myself. Proceed only
  after I supply a URL (or explicitly confirm the shown one is acceptable).
- `NO_HOMEPAGE` — the POM has no usable `<url>`/`<scm>` (common for Gradle
  plugin markers). Fall through to the Plugin Portal route described under
  "Adding a new dependency" step 5, or search GitHub for the artifact
  coordinates (`group:artifact`) to locate the source repository.
- `NOT_FOUND` — the artifact POM is in no repository; STOP and ask me for the URL.
- `GH_RATE_LIMITED <repo-url>` — the GitHub API rate limit blocked the
  release/tag lookup. This is NOT "no release exists" — do not fall back to
  `HOMEPAGE` or ask me for a URL. Set `GITHUB_TOKEN`/`GH_TOKEN` (or wait for
  the limit to reset) and re-run the script.

**AndroidX libraries** keep the `developer.android.com` release-notes URL
instead of the script output.

**A documentation link MUST point at the specific version.** A URL that only
addresses the project/library in general — a repository home, a docs landing
page, a release-notes index with no version anchor, anything without the exact
version in its path/anchor/tag — is considered **invalid** as a CHANGELOG link.
When only such a version-less URL can be found (e.g. the script's `HOMEPAGE`
verdict), do NOT record it silently: show me the URL that was found and ask me
to provide the correct version-specific URL myself, proceeding only after I
supply one (or confirm the shown URL is acceptable).

A link to a Maven artifact page as the CHANGELOG entry itself is FORBIDDEN:
never use `mvnrepository.com`, `search.maven.org`, `central.sonatype.com`,
`maven.google.com`, `repo1.maven.org`, or any other repository/artifact listing.
If the script yields no documentation URL and GitHub search also fails, STOP and
ask me explicitly to provide the URL for that dependency — do not guess.

### 7. Write entries into `[Unreleased]`

1. Open `CHANGELOG.md`, locate the `## [Unreleased]` section.
2. Add each entry to the correct subsection (red_mad_robot / AndroidX / Stack).
3. Format each entry per the rules below.
4. Sort within each subsection: regular libraries alphabetically first, then
   `plugin:` entries alphabetically.
5. Replace `*No changes*` when adding the first entry to a subsection; keep all
   three subsections present even if some stay `*No changes*`.
6. No duplicate entries; verify links point to the correct version.

### 8. Fold `CHANGELOG.md` into the single commit

The `CHANGELOG.md` edit must go into the **same commit** as the version bumps —
do NOT create a separate commit for the changelog alone:

```bash
bash .claude/skills/update-version-catalog/scripts/commit-release.sh
```

The script stages `CHANGELOG.md` plus any catalog edits and amends the squashed
commit from step 3 (or creates the release commit when none exists yet — see
"Adding a new dependency"). Amend only the commit created by the current
command — never a commit that pre-dates it (see "Commit rules"). It prints
`git show HEAD --stat`, which should now list both the
`versions-*/libs.versions.toml` changes and `CHANGELOG.md` in one commit.

### 9. Validate

**a. Lint the changelog against the release diff:**

```bash
bash .claude/skills/update-version-catalog/scripts/lint-changelog.sh
```

Cross-checks the `[Unreleased]` entries against the actual catalog diff and
the format rules: every catalog change is documented, no phantom entries, exact
`old` → `new` versions, correct subsection, valid symbols/links/arrow, sorting,
no duplicates, and that every renovate topic version made it into the diff (a
`renovate: … not picked` failure is expected only for branches I explicitly
told you to skip — mention them).

**The `--skip-renovate` flag is decided by the current command, not by the
commit being linted:**

- the command cherry-picked renovate branches → ALWAYS run without the flag —
  including when linting the addition commit of a combined update-and-add
  command;
- the command cherry-picked nothing (standalone add) → run with
  `--skip-renovate`, otherwise pending renovate branches would be falsely
  reported as "not picked".

Fix every reported problem in `CHANGELOG.md`, re-run until it prints `OK`,
then re-amend with `commit-release.sh`.

**b. Check each release-notes link you added.** For every new `CHANGELOG.md`
entry, run two checks against its URL:

1. **Reachability** — each URL resolves (HTTP `2xx`, or `3xx` redirect):

   ```bash
   bash .claude/skills/update-version-catalog/scripts/check-changelog-urls.sh
   ```

   Lines marked `(redirected to: …)` need attention: some sites redirect
   missing pages to a generic page and still answer `200` — open the final URL
   and confirm it is really the release-notes page for that library.

2. **Version presence** — the page actually mentions the entry's **new
   version**. Fetch the page content (WebFetch, or `curl -sL "$url"`) and search
   for the new version string from that entry (the one in backticks). Account
   for format variants (e.g. `2.60` vs `dagger-2.60`, `34.15.0` vs `bom_v34-15-0`,
   dots vs dashes).

   For `:sparkle:` entries with the default GitHub release/tag link the same
   check applies. If I explicitly provided a different URL for a new
   dependency, skip the version-presence check — verify only that the page
   is reachable and really belongs to that library.

**If a link is unreachable, redirects to an unrelated page, OR the page does
not contain the new version**, do NOT silently keep it. Show me the problem
entries — one line each with the library, the new version, and the current
URL — and offer to find a replacement link (correct anchor/tag, or a different
release-notes source). Fix the links, re-amend with `commit-release.sh`, and
re-check before proceeding.

**c. Validate the catalogs:**

```bash
./gradlew validateCatalog
```

Confirm the build passes. Report every result plainly — if a link is broken, a
version is missing from its page, or validation fails, surface it rather than
claiming success.

### 10. Combined command? — the work is NOT finished yet

STOP before summarising. Re-read the user's request: did it ALSO ask to add
new dependencies («…и добавь …», "…and add …")? If yes, the update you just
finished was only **operation 1 of 2** (see the HARD RULE in "Command types").
Continue immediately with the "Adding a new dependency" flow (steps 2–7 — do
NOT re-run `start-update.sh`) to produce the separate addition commit. Only
after that second commit exists and is validated may you report the command as
done. If the request was update-only, this step is a no-op.

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
   `dev-update-*` branch run `start-update.sh` (creates/switches to the branch
   and records the command base); any other branch → STOP and ask. In a
   combined update-and-add command the update already ran it — do NOT run it
   again for the addition.

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

   - **The latest available version is stable** → take that **latest stable**
     version and use it without asking.
   - **A stable version exists, but a newer non-stable version is also
     available** (e.g. latest stable `1.2.0`, but `1.3.0-beta01` exists) →
     **STOP and ask me** which of the two to use. Show both — the latest stable
     and the newer pre-release — so I can pick. Do NOT silently pick either.
   - **Only non-stable versions exist** (the artifact is published, but every
     available version is a `beta`/`alpha`/`rc`/other pre-release — the script
     prints `UNSTABLE`) → **STOP and ask me** which of the available versions
     to use. Show the candidate versions you found so I can pick one. Do NOT
     silently pick a pre-release.
   - **No version is available in Maven at all** (the artifact is not found in
     any repository) → **STOP and ask me** both which version to specify **and**
     which documentation URL to use for the CHANGELOG link. Do not guess a
     version or a link.

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
   `plugin:` prefix (see the format reference).

   **Resolve the link — never invent it.** Use the script (do NOT construct a
   URL from a naming pattern):

   ```bash
   bash .claude/skills/update-version-catalog/scripts/resolve-doc-url.sh <group:artifact> <version>
   ```

   It reads the artifact's **HomePage** from its POM and, when that is GitHub,
   finds the **release or tag matching the version** — see workflow step 6 for
   the full list of verdicts
   (`RELEASE`/`TAG`/`HOMEPAGE`/`NO_HOMEPAGE`/`NOT_FOUND`/`GH_RATE_LIMITED`). For
   a **library** pass its Maven coordinates verbatim. For a **Gradle plugin**
   the marker artifact's POM usually has no HomePage (`NO_HOMEPAGE`) — resolve
   its repo the plugin way described next.

   **Finding a Gradle plugin's GitHub repo.** A plugin id is NOT its GitHub
   path — do not turn `dev.drewhamilton.poko` into `github.com/dev.drewhamilton/poko`.
   Instead open the plugin's Gradle Plugin Portal page, which links to the real
   source repository:

   ```
   https://plugins.gradle.org/plugin/<plugin.id>
   ```

   e.g. `https://plugins.gradle.org/plugin/dev.drewhamilton.poko` →
   `github.com/drewhamilton/Poko` → release/tag URL for the version. (Web search
   for "<plugin.id> github" is a fine fallback.)

   The Maven artifact page and the Plugin Portal page are lookup aids only —
   NEVER put a Maven artifact page (`mvnrepository.com`, `search.maven.org`,
   `central.sonatype.com`, `maven.google.com`, repo listings) as the entry URL.
   The link must point at the **specific version** — a version-less URL (repo
   home, docs landing page, `HOMEPAGE` verdict) is invalid: show me the URL that
   was found and ask me to provide the correct version-specific one before
   writing the entry. If none of these steps yield a documentation URL, STOP and
   ask me to provide the URL for that dependency before writing the entry — do
   not guess.

6. **Commit:**

   ```bash
   bash .claude/skills/update-version-catalog/scripts/commit-release.sh "stack: add <alias> <version>"
   ```

   Standalone add (no update in this command): the script creates the addition
   commit, and later re-runs (lint/link fixes) amend it. Combined
   update-and-add command: the update commit already exists — the addition
   MUST become a **new commit** on top of it; amend only that addition commit
   afterwards, never the update commit or anything older (see "Commit rules").

7. **Validate as in workflow step 9.** The `--skip-renovate` rule from there
   applies: standalone add command (nothing cherry-picked) →
   `lint-changelog.sh --skip-renovate`; combined update-and-add command →
   WITHOUT the flag, also when linting the addition commit.

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
The maintainer adds it manually where needed; preserve any existing `:warning:`
marks when editing entries.

### File structure

- **Header** — symbol legend.
- **`## [Unreleased]`** — changes not yet released, with the three subsections
  `### red_mad_robot`, `### AndroidX`, `### Stack`.
- **Version sections** — `## [YYYY.MM.DD]`, each with the same three subsections.
- **Footer links** — previous-year changelogs and GitHub compare links per version.

### Entry format

```markdown
# New dependency — link the library's GitHub release/tag page for the version;
# never a Maven artifact page (ask the user if no GitHub page can be found)
- :sparkle: [library-name](github-release-or-tag-url) `version`

# Updated dependency
- :arrow_up: [library-name](release-notes-url) `old-version` → `new-version`

# Removed dependency
- :x: [library-name](release-notes-url)

# Renamed / changed
- :memo: [library-name](release-notes-url) description

# Plugin — prefix with `plugin:`
- :arrow_up: plugin: [Plugin Name](url) `old-version` → `new-version`
```

Use the real arrow `→` (never `->`). Wrap version numbers in backticks.

### Sorting within a subsection

1. Regular libraries — alphabetically by name.
2. Plugins (`plugin:` prefix) — alphabetically by name.
3. If no changes: `- *No changes*`.

### Common patterns

**BOM updates** — list individual component bumps nested under the BOM entry:

```markdown
- :arrow_up: [compose-bom](url) `2025.10.00` → `2025.11.01`
  - :arrow_up: [compose-animation](url) `1.9.3` → `1.9.5`
  - :arrow_up: [compose-foundation](url) `1.9.3` → `1.9.5`
```

The catalog diff contains only the BOM's own version — the component versions
are NOT in it. Take them from the BOM's version-mapping / release-notes page
(for `compose-bom`:
<https://developer.android.com/develop/ui/compose/bom/bom-mapping> — compare
the old and the new BOM mapping and list the libraries whose versions
changed). Each nested component links to its own release notes (for AndroidX —
the usual `developer.android.com/jetpack/androidx/releases/…` URL with the
component's version anchor).

**Monorepo updates** — each library from the same repo gets its own entry:

```markdown
- :arrow_up: [okhttp](url) `5.2.1` → `5.3.2`
- :arrow_up: [okhttp-logging-interceptor](url) `5.2.1` → `5.3.2`
```

**Catalog name changes** — use the memo symbol:

```markdown
- :memo: [library-name](url) Renamed from old-name to new-name
```

### Quality checklist

- [ ] Every entry has the correct emoji symbol.
- [ ] Library names are links to release notes; `:sparkle:` entries link to
      the library's GitHub release/tag page (or a URL explicitly provided by
      the user) — never to a Maven artifact page.
- [ ] Version numbers wrapped in backticks.
- [ ] Arrow `→` used (not `->`).
- [ ] Existing `:warning:` marks preserved (never added by this skill).
- [ ] Entries sorted alphabetically (libraries first, then plugins).
- [ ] Plugins have `plugin:` prefix.
- [ ] No duplicate entries.
- [ ] All three subsections present (even if `*No changes*`).
- [ ] Links valid and point to the correct version.

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
