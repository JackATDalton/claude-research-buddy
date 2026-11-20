---
description: "File experiment results: update Notion status and fields, distil scientific findings to the wiki if significant, log the close-out. Use when the user says 'close experiment', 'file results', 'experiment done', 'wrap up experiment', or 'write up results'."
---

# Close Experiment

`$ARGUMENTS` — experiment slug (folder name under `projects/experiments/`), OR a Notion experiment URL/ID, OR an experiment name.

## Notion references
- **Experiments DB:** `collection://648e5f03-a737-4180-a136-85c374f3482f`
- **Status options:** "Future Experiment" | "Design Phase" | "In progress" | "In Review" | "Pending Close-Out" | "Completed" | "Archived"
- **Updateable fields:** Status, Analysis Scripts (URL), Results Files (URL), Next Experiment (relation)

## Steps

### 1. Locate the experiment

If a slug was given: read `projects/experiments/<slug>/README.md` to get the Notion URL. Then `notion-fetch` the Notion page.

If a Notion URL/ID was given: fetch it directly.

Read the full Notion page body and all properties.

### 2. Gather analysis outputs

Check `projects/experiments/<slug>/`:
```bash
ls projects/experiments/<slug>/analysis/
ls projects/experiments/<slug>/figures/
ls projects/experiments/<slug>/data/
```

Ask the user (or infer from directory contents):
- What is the headline result?
- Did the experiment succeed, fail, or produce a partial result?
- What is the path to the analysis script? (for `Analysis Scripts` field)
- What is the path/URL to the results data? (for `Results Files` field)

### 3. Write a results summary

Draft a concise results summary (3–6 bullet points) to add to the Notion experiment page body:

```markdown
## Results — YYYY-MM-DD

- **Headline:** <one sentence>
- Key finding 1
- Key finding 2
- Interpretation: <what does this mean for the project>
- **Next step:** <what experiment or action follows>
```

Show the user for approval before writing to Notion.

### 4. Update Notion

Use `notion-update-page` to:
- Add the results summary to the page body
- Set `Status` → "Completed" (or "In Review" if further sign-off needed — ask)
- Set `Analysis Scripts` → absolute file path or GitHub URL of analysis script
- Set `Results Files` → path or URL to data/figures directory
- Set `Next Experiment` relation if a follow-on experiment is planned

### 5. Distil to wiki (if scientifically significant)

Ask: "Are these results field-level findings — something that would inform how we interpret future experiments, not just this one?" 

If yes: run `scripts/wiki-search.sh "<topic keywords>"` to find relevant wiki pages. For each relevant page:
- Append a `## Finding — YYYY-MM-DD` subsection with the key result and a note: `*Source: Notion experiment — <name>*`
- Increment the `sources` frontmatter field
- Update `updated` date

If the finding introduces a new concept not yet in the wiki, create a stub page in the appropriate directory and add it to `index.md`.

Update `wiki/EngBio/log.md`: `## [YYYY-MM-DD] close-experiment | <experiment name> → wiki pages updated: X, Y`

### 6. Log to decisions.md

If a `projects/<project-name>/decisions.md` exists for the linked project, append:
```
## YYYY-MM-DD — Experiment closed: <Name>
<Headline result>. <Next step or implication for project direction.>
```

### 7. Final report

```
## Experiment closed: <Name>

Notion updated: Status → Completed ✓
Analysis Scripts: <path> ✓
Results Files: <path> ✓

Wiki updates: <list of pages updated, or "none — results were experiment-specific">

Next experiment: <name if set, or "none planned yet">
```
