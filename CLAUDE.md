# research-buddy

Human-in-the-loop AI research assistant built as composable Claude Code skills. Implements the LLM Wiki pattern: a persistent, synthesised knowledge base that compounds with every paper ingested, experiment run, and question asked.

## Setup

First-time users: run `scripts/setup.sh` to create your research context, library, and environment.

## Three-layer knowledge architecture

| Layer | Path | Purpose | Claude's role |
|---|---|---|---|
| **Wiki** | `wiki/EngBio/` | Synthesised, interlinked knowledge — concepts, entities, topics, analyses | Writes and maintains |
| **Library** | `library/` | Academic papers: raw PDFs + full extractions | Reads and extracts |
| **Projects** | `projects/<name>/` | Active project work: plan, theory, code, decisions | Reads and writes |

**Notion** handles operational work: experiment tracking, task management, meeting notes. Do not duplicate this in the wiki.

## Structure

- `.claude/skills/` — research skills: lit-review, reassess, plan, theory, experiment, write, critique, brainstorm, pipeline, ingest-paper, wiki-ingest, wiki-query, wiki-lint, field-knowledge, daily, start-experiment, close-experiment, write-section, experiment-design, explain
- `wiki/EngBio/` — Obsidian vault (symlink to OneDrive). The persistent knowledge wiki. Read `wiki/EngBio/SCHEMA.md` for conventions.
  - `wiki/EngBio/index.md` — catalog of all wiki pages; read this first when searching the wiki
  - `wiki/EngBio/log.md` — append-only record of all wiki operations
  - `wiki/EngBio/concepts/` — scientific/theoretical concept pages
  - `wiki/EngBio/entities/` — machines, organisms, systems, people
  - `wiki/EngBio/topics/` — broad synthesis across concepts
  - `wiki/EngBio/synthesis/` — comparisons, analyses, open questions
  - `wiki/EngBio/sources/papers/` — one page per ingested academic paper (summary + PDF link)
  - `wiki/EngBio/sources/articles/` — clipped web articles, blog posts, podcast notes
  - `wiki/EngBio/raw/` — drop zone for unprocessed article sources
- `library/` — paper library. Each paper has `summary.md` (overview) and `extracted.md` (full structured extraction) — read `extracted.md` when you need specific details, equations, or results beyond the summary. Bib entries (with keywords) in `library/library.bib`. Canonical keyword list in `library/keywords.txt`.
- `projects/<name>/` — one folder per research problem. Each is an **independent git repo**.
- `projects/experiments/<slug>/` — per-experiment analysis directories created by `/start-experiment`. Each contains `README.md` (Notion context + hypothesis), `analysis/` (scripts), `figures/`, `data/`.
- `research/research-context.md` — researcher expertise, lab capabilities, problem selection criteria
- `research/problem-repository.md` — running list of important open problems
- `scripts/find-papers.py` — Semantic Scholar search tool
- `scripts/wiki-search.sh` — grep-based search across wiki pages (used by /wiki-query)
- `scripts/run-pipeline.sh` — unattended pipeline launcher
- `scripts/init.sh` — create a new project

## Usage

**Session start:** `/daily` — fetches Notion tasks, in-progress experiments, recent wiki updates, uncommitted work. Run once to orient.

**Experiment lifecycle:**
- `/experiment-design <question>` — propose and create a new experiment in Notion (Design Phase)
- `/start-experiment <name or Notion URL>` — load experiment context, scaffold analysis directory
- `/close-experiment <slug>` — file results to Notion, distil findings to wiki

**Writing (LaTeX):**
- `/write-section <heading>` — draft a thesis section from wiki + library context

**Knowledge:**
- `/ingest-paper <pdf>` — process academic PDF into library/ and create wiki source page
- `/wiki-ingest <file or URL>` — add article/note to wiki
- `/wiki-query <question>` — synthesise answer from wiki; optionally file as new page
- `/wiki-lint` — health-check wiki (run after ingestion batches)

**Research:**
- `/lit-review`, `/plan`, `/experiment`, `/write`, `/brainstorm`, `/theory`, `/critique`, `/reassess`

**Unattended:** `./scripts/run-pipeline.sh projects/<name>` for overnight runs.

**New project:** `./scripts/init.sh <name> path/to/plan.md`

## Wiki-first conventions

- **Before any research session:** read `wiki/EngBio/index.md` to know what's already compiled.
- **After any session that surfaces field-level insight:** update relevant wiki pages. Don't let knowledge stay only in chat history.
- **After every `/ingest-paper` run:** a wiki source page is automatically created and concept pages updated.
- **After every `/lit-review` run:** file a topic or synthesis page in the wiki.
- **Periodically:** run `/wiki-lint` to catch orphan pages, dead links, and coverage gaps.

## Project conventions

- `plan.md` — the single living document per project: problem, approach, hypotheses, experiments, paper outline
- `theory/` — one `.tex` file per theoretical result. Compile with `latexmk -pdf`. The working space for proofs and derivations.
- `decisions.md` — append-only decision log: every change, pivot, question, with date and reason
- `research/writing-style.md` — writing guide. Skills that produce written output should read it.
- `research/problem-selection.md` — what makes a great problem. Skills that evaluate or choose problems should read it.
- Paper library lives in `library/`. Each paper has `summary.md` and `extracted.md`. Bib entries in `library/library.bib`. Canonical keyword list in `library/keywords.txt`.
