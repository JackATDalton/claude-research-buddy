---
description: "Ingest non-paper sources into the wiki: web articles, podcast notes, book chapters, blog posts. Use when the user says 'add this to the wiki', 'ingest this article', 'file this note', or 'add to wiki'. For academic PDFs use /ingest-paper instead."
---

# Wiki Ingest

`$ARGUMENTS` — path to a source file in `wiki/EngBio/raw/`, OR a URL (will fetch and save first), OR "all" to process all files in `wiki/EngBio/raw/`.

Use `/ingest-paper` for academic PDFs. This skill handles everything else: web articles (clipped via Obsidian Web Clipper), podcast transcripts, book chapter notes, blog posts, reports.

## Steps

1. **Read the source.** If a URL was provided, use WebFetch to retrieve the content, then save it as a markdown file to `wiki/EngBio/raw/<slug>.md` before proceeding.

2. **Brief discussion (optional).** For a new source, ask: "What's the key insight here and what does it change or confirm?" Skip this step if in batch mode.

3. **Read `wiki/EngBio/SCHEMA.md`** to understand conventions.

4. **Read `wiki/EngBio/index.md`** to identify which existing pages this source is relevant to.

5. **Create a source page** at `wiki/EngBio/sources/articles/<slug>.md`:

   ```markdown
   ---
   tags: [article, <topic-tags>]
   sources: 1
   created: YYYY-MM-DD
   updated: YYYY-MM-DD
   status: developing
   url: <original url if applicable>
   author: <author if known>
   ---
   
   # Title

   **Source:** [Title](url) — Author, Date

   ## Summary
   One paragraph distilling the core argument or finding.

   ## Key points
   - Point 1
   - Point 2
   ...

   ## Relevance to our work
   One paragraph connecting to Jack's research.

   ## Related wiki pages
   - [[concepts/relevant-concept]]
   - [[entities/relevant-entity]]
   ```

6. **Update existing wiki pages.** For each concept/entity page the source informs: append a finding with a `[[sources/articles/<slug>|Source title]]` citation. Increment the `sources` frontmatter field on each updated page.

7. **Create new concept/entity pages** if the source introduces something not yet in the wiki. Follow the format in `SCHEMA.md`. Then add them to `index.md`.

8. **Update `wiki/EngBio/index.md`** — add a row under "Sources — Articles".

9. **Append to `wiki/EngBio/log.md`**: `## [YYYY-MM-DD] ingest-article | <slug> — <title>`

10. **Move processed file:** `mv wiki/EngBio/raw/<slug>.md wiki/EngBio/raw/.processed/` (create `.processed/` dir if needed).
