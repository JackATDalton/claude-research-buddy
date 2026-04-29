---
description: "Ask questions against the wiki and get synthesised answers. Optionally file the answer back as a new wiki page. Use when the user asks 'what do we know about X', 'summarise our knowledge of Y', 'compare A and B', or 'query the wiki'."
---

# Wiki Query

`$ARGUMENTS` — a question or topic to query. May also include a directive like "file this" to save the answer as a wiki page.

## Steps

### 1. Find relevant pages

Run `scripts/wiki-search.sh "<query terms>"` to find candidate pages. Also read `wiki/EngBio/index.md` and scan section headings for relevant entries. Collect the 3–8 most relevant page paths.

### 2. Read the relevant pages

Read each identified page in full. Note: read `wiki/EngBio/SCHEMA.md` if conventions are unclear.

### 3. Synthesise an answer

Write a direct, structured answer drawing from the wiki pages. Use `[[wiki links]]` as inline citations — e.g., "The fitness trajectory follows a power-law ([[concepts/ltee|LTEE]])." 

Mark gaps explicitly: "No wiki page exists yet for X — consider `/wiki-ingest` or `/ingest-paper`."

Format the answer appropriately:
- Factual question → 1–3 paragraphs with citations
- Comparison → markdown table
- Open question → structured discussion with "what we know" vs. "open questions"
- Request for analysis → structured synthesis, possibly with a hypothesis

### 4. Offer to file the answer

After answering, ask: "Should I file this as a wiki page?"

File it if:
- The answer is a substantive comparison or analysis (→ `synthesis/`)
- The answer surfaces a new conceptual synthesis (→ `topics/` or `concepts/`)
- The answer identifies an important open question worth tracking

If filing:
- Create the page in the appropriate directory following SCHEMA.md format
- Add cross-links from related pages to the new page
- Update `wiki/EngBio/index.md`
- Append to `wiki/EngBio/log.md`: `## [YYYY-MM-DD] wiki-query | <page title>`

### 5. Identify gaps

At the end, note:
- Claims that are `(unverified)` or `(speculative)` and could be resolved by a paper
- Topics mentioned across multiple pages that don't have their own page yet
- Sources that would substantially improve coverage
