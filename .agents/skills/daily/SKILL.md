---
description: "Morning orientation across all three tools. Shows today's tasks from Notion, in-progress experiments, recent wiki updates, and uncommitted project work. Use when the user says 'daily', 'what's on today', 'orient me', 'what am I working on', or at the start of a session."
---

# Daily Orientation

`$ARGUMENTS` — none. Run once at the start of a working session.

## Notion references
- **To Do DB:** `collection://b9a0c589-fe64-47de-ae3f-94d11184618d` — fields: Item, Progress (Not started / In progress / Complete / Archive), Priority (Low / Medium / High / Urgent), Deadline
- **Experiments DB:** `collection://648e5f03-a737-4180-a136-85c374f3482f` — fields: Name, Status, Date, Priority, Projects (relation), Analysis Scripts (URL), Results Files (URL)
- **Projects DB:** `collection://d2a17b9a-65e6-4d0c-a2b5-7b624fbd92b8`
- **Work hub:** `https://www.notion.so/9a5c3df12e3d4149963a527438d450b3`

## Steps

Run all of the following in parallel, then compile the brief.

### 1. Fetch tasks
Use `notion-search` against the To Do DB (`collection://b9a0c589-fe64-47de-ae3f-94d11184618d`). Extract items where Progress is "Not started" or "In progress". Sort by Priority (Urgent → High → Medium → Low). Take top 5.

### 2. Fetch in-progress experiments
Use `notion-search` with query "In progress" against the Experiments DB (`collection://648e5f03-a737-4180-a136-85c374f3482f`). Also fetch "Pending Close-Out" and "In Review" status experiments. For each, note: Name, Status, Date, linked Projects.

### 3. Check wiki log
Read `wiki/EngBio/log.md`. Extract entries from the last 7 days. List page names updated.

### 4. Check projects for stale work
Run:
```bash
find projects/ -name "plan.md" -newer projects/ 2>/dev/null | head -10
git status --short
```
Note any projects with modified but uncommitted files.

### 5. Check library inbox
```bash
ls library/inbox/ 2>/dev/null | grep -v "^\.processed$" | grep -v "^\.staging$" | wc -l
```
Report count of unprocessed PDFs waiting for `/ingest-paper`.

---

## Output format

Print a single compact brief — no headers beyond the date, no extra padding:

```
## Today — YYYY-MM-DD

**Tasks**
- [High] Task name
- [Medium] Task name
- [Low] Task name (+ N more)

**Active experiments**
- Experiment name — Status (since DATE)
- Experiment name — Pending Close-Out

**Wiki (last 7 days)**
- N pages updated: concept/ltee, entities/ltem, ...
(or "No recent wiki activity")

**Uncommitted work**
- projects/Transfer-of-Status-2026/ — 2 files modified
(or "Working tree clean")

**Library inbox**
- N PDFs waiting to be ingested (run /ingest-paper inbox)
(or "Inbox empty")

---
Suggested: [one concrete action — e.g., "/close-experiment temp-adaptation-2" or "/write-section 'LTEE and evolutionary dynamics'"]
```

The suggested action should be the single most obvious next step given the brief — don't suggest more than one.
