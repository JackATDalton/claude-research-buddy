---
description: "Set up context for analysing an experiment. Fetches experiment details from Notion, loads relevant wiki pages, and scaffolds the analysis environment in VSCode. Use when the user says 'start experiment', 'analyse experiment', 'work on experiment', or provides a Notion experiment URL."
---

# Start Experiment

`$ARGUMENTS` — a Notion experiment page URL or ID, OR an experiment name to search for.

## Notion references
- **Experiments DB:** `collection://648e5f03-a737-4180-a136-85c374f3482f`
- **Experiment fields:** Name, Status, Type, Date, Priority, Protocol (relation), Materials (relation), Samples (relation), Projects (relation), Analysis Scripts (URL), Results Files (URL), Previous experiment (relation), Next Experiment (relation)

## Steps

### 1. Find the experiment in Notion

If a URL/ID was given: `notion-fetch` it directly.

If a name was given: `notion-search` for the name, pick the best match, confirm with the user if ambiguous.

Read the full experiment page including body content (hypothesis, protocol notes, any previous results).

### 2. Fetch linked context from Notion

In parallel:
- Fetch the linked **Protocol** page(s) if present
- Fetch the linked **Project** page(s) to understand the broader research goal
- Note the `Previous experiment` chain — fetch the immediately prior experiment's results if it exists

### 3. Load wiki context

Run `scripts/wiki-search.sh "<experiment topic keywords>"` to find relevant wiki pages. Also check:
- `wiki/EngBio/entities/ltem.md` — always relevant for LTEM experiments
- Any concept pages related to the experimental variable (temperature → `concepts/continuous-culture-evolution.md`, fitness → `concepts/fitness-landscapes.md`)

Read the relevant pages.

### 4. Scaffold the analysis directory

Create `projects/experiments/<slug>/` where slug is a short kebab-case version of the experiment name (e.g., `temp-adaptation-2`).

```
projects/experiments/<slug>/
  README.md        ← generated context document (see format below)
  analysis/        ← analysis scripts go here
  figures/         ← output figures
  data/            ← symlink or note pointing to data location
```

If `Analysis Scripts` URL is already set in Notion, note the existing script path. If empty, scaffold a starter analysis script appropriate to the experiment type (Python for computational, Jupyter notebook for exploratory).

**README.md format:**
```markdown
# <Experiment Name>

**Notion:** <url>
**Date:** YYYY-MM-DD
**Status:** <status>
**Project:** <linked project name>

## Hypothesis
<from Notion page body>

## Protocol
<from linked Protocol page, summarised>

## Previous experiment
<summary of previous results if applicable>

## Data location
<Results Files URL or path from Notion>

## Relevant wiki context
- [[concepts/...]] — one line summary
- [[entities/ltem]] — ...

## Analysis plan
<brief sketch of what analysis makes sense given the hypothesis>
```

### 5. Update Notion status

If the experiment is currently "Design Phase" or "Future Experiment", ask the user: "Should I set status to In Progress?" If yes, use `notion-update-page` to update the Status field to "In progress" and set the Date to today.

### 6. Report

Print a summary:
```
## Experiment loaded: <Name>

Status: <status> | Date: <date> | Project: <project>

Protocol: <one-line summary>
Data: <Results Files URL or "not set — add path to Notion">
Analysis Scripts: <URL or "not set — will scaffold">

Wiki context loaded:
- concepts/ltee — ...
- entities/ltem — ...

Analysis directory: projects/experiments/<slug>/
Starter script: projects/experiments/<slug>/analysis/analysis.py (or .ipynb)

Next: open the data, run /close-experiment <slug> when done.
```
