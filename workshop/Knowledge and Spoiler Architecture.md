---
title: Kalsa Knowledge and Spoiler Architecture
status: governing
document_type: authority-map
source:
  - https://chatgpt.com/share/6a89731d-fe80-83eb-acb4-b2eb9e1fc959
  - workshop/Direction and Constraints.md
updated: 2026-08-22
---

# Kalsa Knowledge and Spoiler Architecture

This map keeps author truth, reader access, character knowledge, and adjudication from collapsing into one omniscient surface. It governs repository and publication structure. It does not decide individual lore claims.

## Owner map

- **Owner:** subject notes under `Kalsa/Spoilers/` retain author-canon and GM-dossier authority within their stated subjects. Notes under `Kalsa/Public/` own only their reader-facing presentation or in-world source text. `Kalsa/index.md` owns navigation only. Ghostlight owns runtime projection and adjudication.
- **Inputs:** author canon, in-world sources, explicit operator decisions, campaign state, character state, observed events, relationships, provenance, and reveal decisions.
- **Outputs:** spoiler-safe Quartz pages, author/GM inspection surfaces, future world-truth packages, retrieval evidence, character-local projections, and typed resolver affordances.
- **Derived state:** the public site, search index, sitemap, RSS, lore digests, graph indexes, prompt text, and compiled packages report or lower owned state. They do not create canon.
- **Forbidden writers:** Quartz visibility cannot decide truth; author taxonomy cannot enter Public prose or a character prompt as neutral world vocabulary; a character belief cannot mutate world truth; a resolver result cannot retroactively make the character understand its cause; a human's spoiler choice cannot widen a character agent's retrieval scope.
- **Shared paths:** canonical edit → source/provenance review → audience/reveal review → reader publication or compiler input → bounded retrieval/projection → adjudication → event receipt → explicit reveal or canonization review.
- **Cut line:** public Quartz consumes only `Kalsa/Public/`, and casual vault navigation exposes only `Public/`, `Spoilers/`, and a navigation-only root index. All author ontology and GM material lives under the explicitly named `Spoilers/` section.

## Knowledge classes

These are reasoning classes, not a demand for a metadata field on every paragraph.

| Class | Meaning | Normal consumers |
| --- | --- | --- |
| Common | Ordinary local knowledge that can be stated without special access. | Reader site, relevant characters |
| Situated | A named culture, office, witness, text, or community's account; useful without being author truth. | Reader site, characters with access |
| Learned | A conclusion obtainable through training, investigation, or accumulated evidence. | Qualified or discovering characters |
| Restricted | Records, rites, locations, intentions, or evidence held by bounded actors. | Authorized or successfully investigating characters |
| Author-only | Underlying mechanics, complete causal history, adjudication limits, and unrevealed relationships. | Compiler, resolver, authors, deliberate spoiler readers |
| Campaign-current | Hidden routes, puzzle answers, private actor intent, clocks, and unresolved outcomes for a live play package. | GM/coordinator and authorized runtime organs |

A claim can move between access classes only through an owned event: teaching, publication, theft, discovery, confession, experiment, revelation, or explicit campaign release. Access class does not change whether the claim is true.

## Repository surfaces

| Surface | Role | Publication |
| --- | --- | --- |
| `Kalsa/index.md` | Navigation-only consent gate. | Vault entry, never Quartz truth |
| `Kalsa/Public/` | Spoiler-safe high-fantasy entrance and canonical situated sources. | Default Quartz input |
| `Kalsa/Spoilers/index.md` | Warned author/GM entrance and navigation. | Deliberate repository access only |
| `Kalsa/Spoilers/Foundations/` | Author-facing ontology, deep history, taxonomy, and constraints. | Repository/author vault only |
| `Kalsa/Spoilers/Institutions/`, `Kalsa/Spoilers/Polities/`, `Kalsa/Spoilers/Places/`, `Kalsa/Spoilers/Events/` | Canon owners; currently mix common, learned, restricted, and author-level statements. | Repository/author vault only until projected |
| `Kalsa/Spoilers/Dungeons/` | Site provenance and GM-ready play dossiers, including campaign-current answers. | Repository/author vault only |
| `Kalsa/Spoilers/Reference/` | Author navigation, provenance policy, and design-state reference. | Repository/author vault only |
| `workshop/` | Design reasoning, critique, queues, and pass evidence. | Never lore publication |

The source stays open. The friction is physical, named, and default-deny at the publication entrypoint; it is not pretend secrecy.

## Public epistemic contract

`Kalsa/Public/` is how players explore Kalsa as its inhabitants understand it.
It is not an abbreviated author encyclopedia. Its explanatory claims must be
owned by a culture, institution, scholarly lineage, named source, witness, or
an explicitly framed comparison among such accounts.

- Author labels such as Promethean sequence numbers, binary signatures, and the
  axes called Clarity, Depth, and Scope remain in `Spoilers/` unless an
  inhabitant source has independently reconstructed a bounded analogue.
- A translated local term must preserve the theory and practice that produced
  it. Renaming Clarity is insufficient if the surrounding prose still grants
  the speaker the author's complete model.
- Schools may be sophisticated and correct within tested domains without
  converging on author truth. Their archives, instruments, patronage, language,
  rivalries, and historical failures explain both what they know and what they
  systematically miss.
- Public synthesis may compare accounts for reader navigation, but it must name
  whose comparison it is or keep its claims to observable consequences shared
  across the cited traditions.
- New discoveries can alter Public knowledge only through an owned act of
  publication, teaching, testimony, translation, or institutional adoption.

## Reveal gradient

1. Show lived high fantasy and spectacle.
2. Present several situated explanations that earn their local usefulness.
3. Let material limits and repeated anomalies create testable questions.
4. Let discoveries revise relationships among clues without awarding author omniscience.
5. Let divine or technical authorities reveal more while preserving their interests, blind spots, and uncertainty.
6. Reserve the complete model for compilation, adjudication, authors, and readers who knowingly enter the spoiler surface.

A reveal succeeds when prior experience becomes more coherent. It fails when it announces that the fantasy world was fake, turns a god into an author mouthpiece, or replaces investigation with a terminal that knows the wiki.

## Ghostlight lowering contract

The future Kalsa world compiler should produce at least three bounded artifacts from one canon:

1. **World truth:** entities, state, capabilities, dependencies, constraints, and hidden causal relations for the resolver.
2. **Retrieval evidence:** source-linked claims and graph relations with access and provenance sufficient to assemble local context.
3. **Epistemic projection:** speaker-local known facts, beliefs, perceptions, memories, feelings, relationships, misreadings, unavailable knowledge, and action affordances.

The character responder never receives world truth wholesale. The resolver never treats character language as the state transition. The reader site is not a substitute for either runtime artifact.

This repository establishes the content boundary only. It does not claim that Ghostlight's compiler integration exists.

## Negative checks

- A fresh reader can navigate and search the Quartz site without seeing the buried-world origin, formal magic taxonomy, divine mechanism, or dungeon answer key.
- A casual Obsidian explorer sees no author domain until deliberately opening `Spoilers/`.
- A fresh or shared Obsidian session cannot reopen a spoiler note or enumerate
  spoiler recents before the root consent gate; local session state is ignored.
- Generated search, sitemap, RSS, and HTML routes match the current `Kalsa/Public/` source exactly; stale pages from an older, broader build are a failed publication.
- A deliberate repository reader sees a warning before entering author/GM surfaces and remains free to continue.
- A god's testimony can be powerful evidence without becoming author truth.
- A character agent cannot retrieve author-only vocabulary merely because it appears nearby in the graph.
- A resolver can reject an impossible miracle without teaching the acting character the hidden reason.
- Revealing a fact to one character does not publish it to every Persona, reader, or institution.
- Public notes never link into author/GM notes; the public build therefore cannot acquire hidden backlinks or crawl targets.
- Public notes contain no unowned author taxonomy. Every explanatory model is
  attributable, translated with limits, or restricted to shared observation.
