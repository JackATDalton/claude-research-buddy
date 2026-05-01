---
description: "Ingest research paper PDFs into the library. Use when the user says 'ingest this paper', 'add this paper', 'process this PDF', or 'ingest inbox' for batch processing."
---

# Ingest Paper

`$ARGUMENTS` — a PDF path, OR "inbox" to batch-process all PDFs in `library/inbox/`.

**Batch mode:** Run `scripts/ingest-batch.sh` — it launches parallel `claude -p` processes (4 at a time by default). Or run `scripts/ingest-batch.sh library/inbox/ 8` for more parallelism.

## Steps

1. **Check for duplicates.** Grep `library/library.bib` for the paper's DOI or title. If found, skip and report.

2. **Read the PDF** using the Read tool (page chunks for >10 pages). Read the entire paper. **Only extract what is in the PDF** — never reconstruct from training data.

3. **Create `library/papers/<author-YYYY-keyword>/`** (e.g., `brunton-2016-sindy`) with:
   - `paper.pdf` — copy of the original
   - `extracted.md` — complete structured extraction. Paraphrase prose (don't copy verbatim). Preserve equations, tables, figure captions.
   - `summary.md` — following `library/TEMPLATE.md` format. In "Notes & open questions", grep the library for related papers and note connections. If the paper highlights or makes tractable any important open problems (read `research/research-context.md` for what matters to us), append them to `research/problem-repository.md`.

4. **Append bib entry** to `library/library.bib` (key = folder name). Include a `keywords` field — pick from `library/keywords.txt`. Only add a new keyword if nothing existing fits, and append it to `keywords.txt` alphabetically.

5. **Append to `library/ingestion-log.md`**: `- YYYY-MM-DD: <bib-key> — <paper title>`

6. **Create wiki source page** at `wiki/EngBio/sources/papers/<bib-key>.md`. Read `wiki/EngBio/SCHEMA.md` for format conventions. The wiki page must:
   - Have YAML frontmatter: `tags`, `sources: 1`, `created`, `updated`, `status: developing`
   - Include a one-paragraph abstract/summary
   - List key findings as bullets
   - Link to relevant wiki topic/entity pages using `[[topics/page-name]]` and `[[entities/page-name]]` — read `wiki/EngBio/index.md` to find which pages exist. Use subfolder paths where applicable: `[[topics/python/gui-primer]]`.
   - Include a PDF reference line: `**PDF:** [Open](file:///Users/jackdalton/Desktop/claude-research-buddy/library/papers/<bib-key>/paper.pdf)`
   - Include a library reference line: `**Library:** \`library/papers/<bib-key>/\``

7. **Update existing wiki pages.** For each concept/entity page the paper informs: append a brief finding with a citation link `[[sources/papers/<bib-key>|Author et al. YYYY]]`. Increment the `sources` frontmatter field on each updated page.

8. **Update `wiki/EngBio/index.md`** — add a row for the new paper under "Sources — Papers".

9. **Append to `wiki/EngBio/log.md`**: `## [YYYY-MM-DD] ingest-paper | <bib-key> — <title>`

10. **Clean up:** `mv "<pdf>" library/inbox/.processed/`

11. **Commit and push:** `cd library && git add papers/<bib-key>/ library.bib keywords.txt ingestion-log.md && git commit -m "Ingest: <bib-key>" && git push`
