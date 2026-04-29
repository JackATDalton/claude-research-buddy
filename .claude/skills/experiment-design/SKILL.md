---
description: "Design a new experiment: read wiki context and existing Notion experiments, propose a design, and create a Notion page. Use when the user says 'design an experiment', 'plan an experiment', 'what experiment should we run next', or 'create experiment for X'."
---

# Experiment Design

`$ARGUMENTS` — a research question or goal (e.g., "test whether LTEM fitness trajectories follow LTEE power-law"), OR a Notion project URL to design within, OR a completed experiment slug to design the follow-up to.

## Notion references
- **Experiments DB:** `collection://648e5f03-a737-4180-a136-85c374f3482f`
- **Projects DB:** `collection://d2a17b9a-65e6-4d0c-a2b5-7b624fbd92b8`
- **Experiment template:** `800d8628-8062-420b-94fd-8a751863d4cc`
- **Status to set:** "Design Phase"
- **Type options:** "Computational" | "Experimental"

## Steps

### 1. Understand the goal

Parse the argument:
- If a research question: proceed with it directly
- If a project URL: `notion-fetch` it to understand the project goal, then derive the most valuable next experiment
- If a completed experiment slug: read its README.md and fetch the Notion page to understand results, then design the natural follow-up

Read `research/research-context.md` and `research/problem-selection.md` for context on what makes a good experiment for this lab.

### 2. Load wiki context

Run `scripts/wiki-search.sh "<topic keywords>"` to find relevant concept and entity pages. Read them. The wiki represents current knowledge — the experiment should extend or test something from it.

Key questions to answer from the wiki:
- What do we already know about this topic?
- What are the open questions flagged in relevant pages?
- What would a result here change or confirm?

### 3. Audit existing experiments

`notion-search` for experiments related to this topic (across all statuses). `notion-fetch` the most relevant 2–3. Confirm the proposed experiment is:
- Not a duplicate of something already done or planned
- Building on (not ignoring) prior results
- Appropriately scoped given what's already known

### 4. Propose the design

Draft a structured experiment proposal for the user to review:

```
## Proposed experiment: <Short name>

**Type:** Computational | Experimental
**Research question:** <one sentence — what does this distinguish?>

**Hypothesis:** <falsifiable — what do we expect and why>
**Null hypothesis:** <what would no effect look like>

**Method sketch:**
1. <Step 1>
2. <Step 2>
...

**Controls:** <what must be controlled or compared against>
**Expected outcome:** <what would a positive result look like>
**Expected duration:** <rough estimate>

**What it changes:**
- If hypothesis confirmed: <implication for project / wiki>
- If null confirmed: <implication>

**Depends on:** <prior experiments, data, or resources needed>
**Priority suggestion:** High | Medium | Low
**Reason:** <why this experiment, why now>

**Wiki pages this would inform:** concepts/..., entities/ltem, ...
```

Present this to the user. Iterate until approved.

### 5. Create the Notion page

On approval, use `notion-create-pages` to create a new experiment entry in the Experiments DB with:
- **Name:** the short experiment name
- **Status:** "Design Phase"
- **Type:** Computational or Experimental
- **Priority:** as suggested
- **Projects:** link to the relevant project(s)
- **Previous experiment:** link to predecessor if applicable

Page body should include the full proposal text formatted as Notion content, plus:
- A "Resources" section with links to relevant wiki pages (plain URLs since Notion doesn't support Obsidian wiki links)
- A blank "Results" section ready to fill

### 6. Update wiki

Add an "(unverified)" note to the relevant wiki concept pages indicating this experiment is planned:

```markdown
*Experiment planned to test this — see Notion: [Short name](<notion url>) (Design Phase, YYYY-MM-DD)*
```

Append to `wiki/EngBio/log.md`: `## [YYYY-MM-DD] experiment-design | <experiment name> created in Notion`

### 7. Report

```
## Experiment created: <Name>

Notion: <url>
Status: Design Phase | Type: <type> | Priority: <priority>

Hypothesis: <one line>
Next step: run /start-experiment <notion url> when ready to begin

Wiki pages flagged: <list>
```
