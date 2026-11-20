---
description: "Health-check the wiki: find orphan pages, contradictions, stale claims, missing cross-links, and coverage gaps. Use when the user says 'lint the wiki', 'check wiki health', 'audit the wiki', or after a large ingestion batch."
---

# Wiki Lint

`$ARGUMENTS` — optional: "quick" for a fast index-only check, "deep" for full page reads. Default: medium (reads all pages, checks links, skips web searches).

## Checks

### 1. Orphan pages
Find pages with no inbound links (not referenced from index.md or any other page).
```bash
# Find all [[wiki links]] across the vault
grep -r "\[\[" wiki/EngBio --include="*.md" | grep -oP '\[\[([^\]|]+)' | sort | uniq
```
Compare to files found with `find wiki/EngBio -name "*.md"`. Report any files with zero inbound references.

### 2. Broken internal links
Find `[[links]]` that reference pages that don't exist. Report as "dead links" with the file they appear in.

### 3. Stale or unverified claims
Grep for `(unverified)`, `(speculative)`, `(contested)` across all pages. List each with its page and context. For each, suggest: "Could be resolved by X paper" if a relevant source exists in `library/`.

### 4. index.md completeness
Check every `.md` file in the wiki (excluding SCHEMA.md, index.md, log.md, raw/) exists in `index.md`. Report missing entries.

### 5. Coverage gaps
Read each concept/entity page and identify:
- Sections marked "(to expand)" or "(Empty — add entries as knowledge is acquired)"
- Pages with `status: stub` that have existed for >30 days (check `created` frontmatter vs. today's date)
- Pages with `sources: 0` that could be sourced from existing library papers

### 6. Missing concept pages
Scan all pages for `[[concept/page-name]]` or `[[entity/page-name]]` links where the target page doesn't yet exist. List as "wanted pages".

### 7. Source count drift
Find pages where the `sources` frontmatter count doesn't match the number of `[[sources/...]]` citations in the body. Report discrepancies.

### 8. Cross-link suggestions
For any two pages that both mention the same entity or concept but don't link to each other, suggest adding a cross-link.

---

## Output format

Produce a structured lint report:

```
## Wiki Lint Report — YYYY-MM-DD

### Orphan pages (N)
- wiki/EngBio/...

### Dead links (N)
- [[link]] in file/path.md

### Stale claims (N)
- "(speculative)" in topics/fitness-landscapes.md: "..."

### Missing from index (N)
- wiki/EngBio/...

### Stub pages >30 days old (N)
- topics/... (created: YYYY-MM-DD)

### Wanted pages (N)
- [[topics/page-name]] — referenced from X, Y, Z

### Source count drift (N)
- topics/ltee.md — frontmatter says 5, body has 3 citations

### Suggested cross-links
- topics/ltee.md ↔ entities/ltem.md (both mention "continuous culture")

### Recommended next actions
1. ...
2. ...
```

After the report, append to `wiki/EngBio/log.md`: `## [YYYY-MM-DD] wiki-lint | N issues found`
