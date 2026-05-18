---
description: "Embed plots from an experiment session into the wiki and cross-link with Notion. Use when the user says 'add plots to wiki', 'embed figures', 'file plots', 'add figures to obsidian', or 'plot to notion'."
---

# Plot to Wiki (+ Notion cross-link)

`$ARGUMENTS` — experiment slug (folder name under `projects/experiments/`), OR a Notion experiment page URL/ID.

Notion is for task management. Obsidian is for knowledge storage. This skill bridges them: figures live in the wiki vault, Notion holds the operational record, both pages link to each other.

## Paths

- **Figures source:** `projects/experiments/<slug>/figures/`
- **Figures destination:** `wiki/EngBio/assets/figures/<slug>/`
- **Wiki experiment page:** `wiki/EngBio/sources/experiments/<slug>.md`
- **Wiki experiments dir:** `wiki/EngBio/sources/experiments/` (create if missing)
- **Assets dir:** `wiki/EngBio/assets/figures/` (create if missing)

## Notion references
- **Experiments DB:** `collection://648e5f03-a737-4180-a136-85c374f3482f`

---

## Steps

### 1. Resolve the experiment

**If a slug was given:**
- Check `projects/experiments/<slug>/` exists.
- Read `projects/experiments/<slug>/README.md` to get the Notion URL and experiment name.

**If a Notion URL/ID was given:**
- `notion-fetch` it to get the experiment name.
- Derive the slug: kebab-case of the experiment name (same rule as `/start-experiment`).
- Check if `projects/experiments/<slug>/` exists; if not, warn the user but continue — figures path may still exist.

**In both cases:** `notion-fetch` the Notion page if not already fetched. Note the experiment name, status, and current body content.

### 2. Inventory the figures

```bash
ls -1 projects/experiments/<slug>/figures/
```

Collect all `.png`, `.jpg`, `.jpeg`, `.svg` files. Report the list to the user.

If the directory is empty or missing: stop and say so.

### 3. Copy figures into the wiki vault

```bash
mkdir -p wiki/EngBio/assets/figures/<slug>
cp projects/experiments/<slug>/figures/<file> wiki/EngBio/assets/figures/<slug>/
```

Copy all figures (or only those specified in `$ARGUMENTS`).

### 4. Create or update the wiki experiment page

**Check if `wiki/EngBio/sources/experiments/<slug>.md` already exists.**

**If it does not exist — create it:**

```markdown
---
tags: [experiment]
sources: 0
created: YYYY-MM-DD
updated: YYYY-MM-DD
status: stub
notion: <notion_page_url>
---

# <Experiment Name>

**Notion:** [<Experiment Name>](<notion_page_url>)  
**Date:** YYYY-MM-DD  
**Status:** <status from Notion>

> Operational details (protocol, tasks, assignee) are in Notion. This page stores findings, figures, and scientific interpretation for long-term reference.

## Hypothesis
<copy from README.md or Notion page body>

## Figures

<embed block(s) — see Step 5>

## Findings

*To be filled in when the experiment closes. Run `/close-experiment <slug>` to file results.*

## Links
- [[sources/experiments/]] ← all experiments
- <add 1–2 related topic or entity pages from wiki/EngBio/index.md>
```

**If it already exists — update it:**
- Read the file.
- Find or create the `## Figures` section.
- Append any new figure embeds (do not duplicate ones already present).
- Update `updated` frontmatter date.

### 5. Build Obsidian embed blocks

For each figure file, the Obsidian embed syntax is:

```
![[assets/figures/<slug>/<filename>]]
```

Add a caption line below each embed (plain text, since Obsidian doesn't have native captions):

```
*<filename without extension> — <YYYY-MM-DD>*
```

Example:
```markdown
## Figures

![[assets/figures/temp-adaptation-2/fitness_over_time.png]]
*fitness_over_time — 2026-05-13*

![[assets/figures/temp-adaptation-2/growth_curves.png]]
*growth_curves — 2026-05-13*
```

### 6. Update wiki index and log

**index.md:** If this is a new wiki page, add a row under a `## Experiments` section (create it if missing):
```
| [[sources/experiments/<slug>\|<Experiment Name>]] | <one-line description> | experiment | 0 | stub |
```

**log.md:** Append:
```
## [YYYY-MM-DD] new-page | sources/experiments/<slug>
Created experiment wiki page. Figures embedded: <n>. Notion: <url>
```

### 7. Cross-link: Notion → Obsidian

Use `notion-update-page` with `update_content` to add (or update) a callout block near the top of the Notion experiment page body:

```markdown
> 📓 **Wiki page:** [Obsidian — <Experiment Name>](obsidian://open?vault=EngBio&file=sources%2Fexperiments%2F<slug>)
```

If a `📓 **Wiki page:**` line already exists, replace it (don't duplicate).

Show the user the planned Notion edit before writing. Confirm before proceeding if the page has substantial existing content.

### 8. Report

```
## Figures filed: <Experiment Name>

Figures copied:  wiki/EngBio/assets/figures/<slug>/
  - figure1.png
  - figure2.png

Wiki page:       wiki/EngBio/sources/experiments/<slug>.md  [created / updated]
Notion updated:  ✓  (wiki link added to page body)

To complete the record, run /close-experiment <slug> when analysis is done.
```
