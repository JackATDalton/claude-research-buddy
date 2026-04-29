---
description: "Record, retrieve, or extend scientific field knowledge. Use when the user says 'add this to field knowledge', 'what do we know about X', 'record what we learned', or 'update field knowledge'. Also invoke proactively at the end of any conversation that surfaced concrete scientific findings, key experimental results, or important theoretical context."
---

# Field Knowledge

Reads and extends `research/field-knowledge.md` — the living scientific reference for Jack's research field.

`$ARGUMENTS` — one of:
- `add <topic>` — append a new entry (from this conversation) under the relevant section
- `show [topic]` — summarise current knowledge on a topic
- `list` — list all sections and entry counts
- *(no argument)* — read the full file and confirm it's loaded into context

## When to invoke proactively

At the end of any skill run (`/lit-review`, `/ingest-paper`, `/experiment`, `/theory`, `/brainstorm`) where new **field-level** scientific knowledge was established — not just project-specific results. Ask: "Is this knowledge that would help interpret future experiments or literature?" If yes, append it.

## Steps

### `add` — appending new knowledge

1. **Read `research/field-knowledge.md`** to understand current content and avoid duplication.

2. **Identify the right section.** Match the topic to an existing section header. If no section fits, create one at the bottom with a `##` header.

3. **Write the entry** under the section using this format:

```markdown
### <Descriptive title>

**Added:** <YYYY-MM-DD> | **Source:** <paper bib-key / conversation / training knowledge / experiment> | **Relevance:** <one line linking to Jack's work>

<Scientific content. Factual, citable. Mark contested claims with "(contested)" or "(speculative)". Include equations if relevant. Keep it dense — this is a reference, not an explanation.>

**Key papers** (if applicable)
- Author et al. (YYYY) Journal — one-line summary

**Open questions / connections**
- <links to LTEM, LTEE, active learning work, or other sections>
```

4. **Append the entry** using the Edit tool. Do not rewrite existing entries.

5. Confirm: "Added entry '<title>' under '<section>'."

---

### `show` — retrieve knowledge

1. Read `research/field-knowledge.md`.
2. Extract and present all entries under the matching section.
3. Note any gaps ("No entries yet for X — consider /lit-review or /ingest-paper to fill this.").

---

### `list` — index

1. Read `research/field-knowledge.md`.
2. Print each `##` section header and count how many `###` entries it contains.

---

### *(no argument)* — load context

Read `research/field-knowledge.md` silently and confirm: "Field knowledge loaded — N entries across M sections."

---

## Guidelines

- **Only record field-level knowledge** — findings that generalise beyond the current project. Project-specific results go in `projects/<name>/decisions.md` or `plan.md`.
- **Cite sources.** If from a paper in the library, use the bib-key. If from training knowledge, say so and note the knowledge cutoff (August 2025).
- **Mark speculation.** Any claim that is contested in the literature or inferred rather than directly shown should be flagged.
- **Cross-link sections** where concepts interact (e.g., fitness landscapes ↔ LTEE ↔ LTEM experimental design).
- **Never delete existing entries.** If an entry is superseded, append an update note below it with a date.
