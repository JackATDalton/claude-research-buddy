---
description: "Draft or extend a LaTeX thesis section using wiki knowledge and library papers as context. Use when the user says 'write section', 'draft this section', 'write up X', or selects a section heading and asks for a draft. Primary bridge between Obsidian wiki and VSCode LaTeX writing."
---

# Write Section

`$ARGUMENTS` — a section heading (quoted string), OR a path to a `.tex` file + optional section heading within it, OR a path to a `plan.md` with a writing outline.

## Steps

### 1. Identify the section

If a `.tex` file was given: read the file to understand the document structure and find the target section. Note what content already exists (don't overwrite non-empty sections without asking).

If a heading string was given: search for the corresponding `.tex` file:
```bash
grep -r "<heading keywords>" projects/ --include="*.tex" -l | head -5
```
Ask the user to confirm the target file if ambiguous.

Read `research/writing-style.md` before drafting anything.

### 2. Load wiki context

Run `scripts/wiki-search.sh "<section topic keywords>"` across the wiki. Also check `wiki/EngBio/index.md` for directly relevant pages. Read all relevant pages in full — these are the primary source for what to write.

**Topic → wiki page mapping (common cases):**
- "LTEE" / "evolutionary dynamics" → `topics/ltee.md`, `topics/evolutionary-dynamics.md`
- "fitness landscape" / "drift" → `topics/fitness-landscapes.md`
- "continuous culture" / "chemostat" / "LTEM" → `topics/continuous-culture-evolution.md`, `entities/ltem.md`
- "active learning" / "Bayesian" → `topics/active-learning-biology.md`
- "modelling" / "simulation" → search wiki for modelling pages

### 3. Load library papers

```bash
grep -i "<topic keywords>" library/library.bib | grep -E "^@|key ="
```

For each relevant bib key, read `library/papers/<bib-key>/summary.md`. For sections requiring technical depth, also read `extracted.md` for equations, figures, or specific results.

Collect the bib keys you'll cite — you'll use these for `\cite{}` commands.

### 4. Check for completed experiments

`notion-search` for experiments related to this section topic with Status = "Completed". Fetch any that are directly relevant. These may provide your own data to cite or mention.

### 5. Draft the LaTeX

Write the section following `research/writing-style.md`. Conventions:
- Use `\cite{bib-key}` with keys from `library/library.bib`
- Use `\ref{}` for figures and tables that already exist in the document
- Mark gaps where a figure or table should go: `% TODO: figure — <description>`
- Mark claims needing a citation you don't have: `% TODO: cite — <claim>`
- Do not invent results or citations — if the wiki or library doesn't cover something, flag it as a gap

**Section length guidance:**
- `\subsection` → 200–500 words typically
- `\section` → 500–1500 words, structured with subsections
- Aim for clear topic sentences; avoid padding

### 6. Write to file

Present the draft to the user first. On approval:
- Write the drafted content into the correct location in the `.tex` file using the Edit tool
- Preserve all existing `\label{}`, `\begin{figure}`, and other environments
- Don't reformat existing content in other sections

### 7. Report gaps

After writing, list:
- **Missing citations** (`% TODO: cite`) — suggest running `/lit-review` for these topics
- **Missing figures** (`% TODO: figure`) — suggest what data/analysis would produce them
- **Wiki gaps** — concepts mentioned in this section that don't yet have a wiki page (candidate for `/wiki-ingest` or `/lit-review`)

Append to `wiki/EngBio/log.md`: `## [YYYY-MM-DD] write-section | "<section heading>" — N citations used, N gaps flagged`
