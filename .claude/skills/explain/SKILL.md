---
description: "Explain a concept (scientific, technical, or codebase-related) and file the explanation as a wiki page. Use when the user says 'explain X', 'how does X work', 'what is X', or 'help me understand X'. Always writes to the wiki — not just chat."
---

# Explain

`$ARGUMENTS` — the concept or topic to explain. May be a scientific concept, a software architecture idea, a codebase module, or an experimental method.

## Steps

### 1. Check the wiki first

Read `wiki/EngBio/index.md`. If a page already exists for this concept, read it fully — use it as the starting point rather than starting from scratch.

Run `scripts/wiki-search.sh "<concept>"` to find any related pages that should inform or be cross-linked.

### 2. Gather source material

Depending on the concept type:

- **Codebase concept** — read the relevant source files directly. Identify the key classes, functions, and data flow. Trace through the code to understand the actual behaviour, not just the intended one.
- **Scientific concept** — search `library/` for relevant papers (`summary.md` for overview, `extracted.md` for details). Also draw from wiki pages already compiled.
- **Mixed** — do both.

Take notes on the core idea, the key details, known subtleties, and any open questions or known bugs.

### 3. Explain to the user

Give a clear, structured explanation in the conversation. Tailor to Jack's level (PhD researcher in experimental evolution; strong biology and growing quantitative/software skills):

- Lead with the **core idea** in 1–2 sentences
- Then **how it works** — the mechanism, the maths if relevant, the code structure if applicable
- Then **key subtleties** — gotchas, edge cases, known bugs, design decisions
- End with **open questions** or things worth tracking

Use code blocks for key snippets. Use equations where they clarify rather than obscure.

### 4. File to the wiki

Always file the explanation as a wiki page. Determine the right location:

| Concept type | Directory |
|---|---|
| Scientific/theoretical concept | `wiki/EngBio/concepts/` |
| Machine, system, organism, codebase module | `wiki/EngBio/entities/` |
| Cross-cutting synthesis across concepts | `wiki/EngBio/synthesis/` |
| Broad topic spanning multiple concepts | `wiki/EngBio/topics/` |

If a page already exists, **update it** rather than creating a new one.

Use SCHEMA.md frontmatter format:
```yaml
---
tags: [<category>, <topic-tags>]
sources: <integer>
created: YYYY-MM-DD
updated: YYYY-MM-DD
status: stub | developing | mature
---
```

The page should be a lasting reference — write it as if a future reader has no context from this conversation. Include:
- Core idea / purpose
- How it works (mechanism, maths, code structure)
- Key parameters or configuration
- Known subtleties, bugs, or gotchas
- Related pages (link at least 2)

### 5. Cross-link

Add a link to the new/updated page from at least one related existing page. Edit that page to include the link in its Related section.

### 6. Update index and log

Update `wiki/EngBio/index.md`:
- If new page: add a row to the appropriate section table
- If updated page: update the summary and `updated` date if changed
- Update `**Quick stats:**` line (page count and date)

Append to `wiki/EngBio/log.md`:
```
## [YYYY-MM-DD] new-page | <Title>
Explained <concept> — <one sentence on what was covered>.
```
or `update` if editing an existing page.
