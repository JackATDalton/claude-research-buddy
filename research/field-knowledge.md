# Field Knowledge

A living scientific reference document. Skills and conversations append here whenever something substantive is learned about the field. Organised by topic; entries include date, source, and relevance notes.

---

## How to use this file

- Read this file at the start of any research conversation where domain context matters.
- Append new entries under the relevant section (or add a new section) whenever a conversation surfaces concrete scientific knowledge — experimental findings, theoretical results, key papers, field consensus, open debates.
- Never paraphrase memory here: record the actual science. Cross-reference `library/` for paper-level detail.
- Keep entries factual and citable. Mark speculative or contested claims explicitly.

---

## Laboratory Evolution & Experimental Evolution

### The Lenski Long-Term Evolution Experiment (LTEE)

**Added:** 2026-04-28 | **Source:** training knowledge | **Relevance:** foundational reference for long-term lab evolution; directly informs LTEM experimental design and interpretation

**Overview**  
Started in 1988 by Richard Lenski (Michigan State University). Twelve replicate populations of *E. coli* B (strain REL606) evolved in minimal glucose medium (Davis minimal broth + glucose), with daily 1:100 serial dilution into fresh medium (~6.64 generations/day). Now exceeding **80,000 generations** — the longest-running experimental evolution study in history. Frozen samples every 500 generations give a "fossil record" allowing retrospective genomic and fitness analysis.

**Major Findings**

1. **Fitness trajectory — diminishing returns**  
   Fitness (relative to the ancestor) increased rapidly early then decelerated, following a roughly hyperbolic curve. Populations still show measurable adaptation at 80,000 generations, with no evidence of a hard plateau. This implies a deep supply of beneficial mutations even after tens of thousands of generations.

2. **Parallel molecular evolution**  
   Many populations independently mutated the same genes, especially early: *topA* (DNA topology), *spoT* (ppGpp metabolism / stringent response), *nadR* (NAD biosynthesis), *pykF* (pyruvate kinase), *pbpA-rodA* (cell shape), *rpsA*. Convergence at the gene level (and sometimes the exact mutation) demonstrates strong, repeatable selection — the fitness landscape has prominent peaks accessible from the ancestor.

3. **The citrate innovation (Ara-3, ~generation 31,500)**  
   Under the standard glucose + citrate medium, *E. coli* cannot use citrate aerobically (a defining character). Population Ara-3 evolved aerobic citrate utilization (Cit+) — a rare, complex evolutionary innovation. This required:
   - **Potentiation** — one or more earlier mutations that made the innovation accessible (epistatic enabling)
   - **Actualization** — a duplication event that brought the *citT* transporter under aerobic promoter control
   - **Refinement** — subsequent mutations improving Cit+ performance
   
   This case is the clearest experimental demonstration of **historical contingency** in evolution: replaying the tape from the ancestral state rarely produced Cit+; replaying from the potentiated state frequently did. Closely related to Gould's "replaying the tape" thought experiment.

4. **Hypermutators**  
   Six of twelve populations evolved elevated mutation rates (hypermutator phenotypes) via loss-of-function mutations in mismatch repair (*mutL*, *mutS*) or other mutator loci. Hypermutators initially sweep to fixation due to hitchhiking with beneficial mutations, but may accumulate deleterious load later. This represents an indirect selection pathway for increased evolvability under strong selection pressure.

5. **Clonal interference and diversity dynamics**  
   Even within a single "clonal" population, multiple beneficial lineages compete (clonal interference). Periodic selection sweeps are visible in the genomic data. Some populations (notably Ara-1) maintained long-term polymorphism through negative frequency-dependent selection between two ecotypes (one specialised on glucose, one on cross-fed acetate). This challenges the assumption that lab populations are genetically uniform.

6. **Loss-of-function mutations dominate early**  
   A large fraction of early beneficial mutations are deletions or knockouts (e.g., loss of *rbs* operon, loss of *spoT* regulation). This reflects that in a simple, constant glucose environment many ancestral functions are costly and their loss is adaptive. Relevant caution: environments with more complex selective pressures may favour gain-of-function mutations more.

7. **Epistasis shapes trajectories**  
   Beneficial effects of mutations are not additive. Diminishing-returns epistasis (later beneficial mutations are smaller in effect) is pervasive. Sign epistasis (a mutation beneficial in one genetic background is deleterious in another) also occurs, constraining accessible evolutionary paths. This directly affects the shape of the fitness landscape navigated during LTEM runs.

8. **Morphology and physiology**  
   Populations evolved larger cell size, altered cell-cycle regulation, and changes in resource allocation. Evolved lines are more fit in glucose but often less fit in alternative environments — local adaptation with trade-offs.

9. **Ongoing adaptation without saturation**  
   Even at 80,000 generations, fitness is still increasing (albeit slowly). Whole-genome sequencing shows ongoing accumulation of mutations. This suggests the fitness landscape is not a simple single peak — there is a near-continual supply of accessible beneficial mutations, possibly because the genetic background itself keeps shifting.

**Key papers**  
- Lenski & Travisano (1994) PNAS — first major fitness trajectory paper  
- Blount, Borland & Lenski (2008) PNAS — Cit+ evolution and historical contingency  
- Wiser, Ribeck & Lenski (2013) Science — fitness trajectory to 50,000 generations, power-law model  
- Good et al. (2017) Nature — whole-population sequencing across 60,000 generations, clonal interference, mutation dynamics  
- Lenski (2017) Nature Reviews Microbiology — 30-year perspective review  

**Relevance to LTEM work**  
The LTEE provides the baseline expectation for evolution in glucose minimal medium. LTEM differs in: (i) continuous culture vs. serial dilution, (ii) controllable selection pressure (temperature, antibiotics, feedstock), (iii) online fitness monitoring via OD/growth rate. Key open questions informed by LTEE: Does the fitness trajectory in chemostat-like continuous culture follow the same hyperbolic shape? Does hypermutator evolution occur at similar rates? Does parallel evolution at the gene level still dominate early adaptation?

---

## Fitness Landscapes

*(Empty — add entries as knowledge is acquired)*

---

## Continuous Culture Evolution (Chemostat / Turbidostat)

*(Empty — add entries as knowledge is acquired)*

---

## Evolutionary Engineering & Industrial Applications

*(Empty — add entries as knowledge is acquired)*

---

## Active Learning & Bayesian Optimisation in Biology

*(Empty — add entries as knowledge is acquired)*

---

## AI Agents for Automated Science

*(Empty — add entries as knowledge is acquired)*

---

## Nitrogen Fixation

*(Empty — add entries as knowledge is acquired)*

---

## Synthetic Biology & Metabolic Engineering

*(Empty — add entries as knowledge is acquired)*

---

## Extremophile Biology / Mars Terraforming

*(Empty — add entries as knowledge is acquired)*
