---
title: Canon and Provenance
status: canonical-policy
source_witness:
  - page-2026-08-20-10-39-03.md
  - page-2026-08-20-10-39-12.md
  - page-2026-08-20-10-39-25.md
  - page-2026-08-20-10-39-32.md
  - page-2026-08-20-10-39-38.md
  - page-2026-08-20-10-39-45.md
  - page-2026-08-20-10-39-51.md
  - page-2026-08-20-10-39-58.md
  - page-2026-08-20-10-40-04.md
tags:
  - reference
  - canon
  - provenance
---

# Canon and Provenance

Canon is what the current setting has adopted as true. Provenance records where a claim came from and when it was adopted or repaired. This page explains how to tell an established fact from an old proposal, an inhabitant's belief, or a question nobody has settled.

The exported seed preserves Kalsa's early material. It supplies evidence, including claims that may contradict one another; it does not make every old sentence binding. Current notes adopt the ideas that give Kalsa its identity, identify contradictions, and keep undecided questions open. An **owner note** is the note responsible for an adopted subject. Reference notes may explain or link to it without taking over that responsibility.

## Reading a note's status

| Status | Meaning |
|---|---|
| `source-fact` | The exported seed states this claim. Another seed witness may contradict it. |
| `canonical-policy` | This note sets rules for handling canon, source history, and unresolved claims. |
| `canonical-foundation` | This note owns adopted setting truth about its subject. |
| `canonical-reference` | This note provides navigation or brings information together. The owner notes it points to remain authoritative. |
| `canonical-polity` | This note owns an adopted polity, culture, or territorial arrangement. |
| `canonical-institution` | This note owns an adopted office, procedure, jurisdiction, or lasting social arrangement. |
| `canonical-place` | This note owns an adopted settlement or other inhabited place. |
| `canonical-dungeon` | This note owns an adopted playable site and the pressures currently affecting it. |
| `adopted-history` | A recorded repair pass deliberately added this event to current history. The event is not claimed to appear in the seed. |
| `adopted-candidate` | This is a design model kept for critique, not a setting fact. Other canonical notes may cite the problem or open question it raises, but must not assume its institution, actors, or procedures exist. |
| `in-world-belief` | People or institutions in Kalsa hold this claim. Authors do not guarantee that it is true. |
| `story-seed` | This is a proposed protagonist, threat, or campaign premise. It is not automatically part of the standing setting. |
| `unresolved` | This question remains open. Notes that depend on it must not quietly supply an answer. |
| `preservation-stub` | This owner note preserves limited source-backed material and awaits fuller institutional development. It must not invent certainty to look complete. |
| `unresolved-stub` | This placeholder reserves a subject that remains canonically undecided. |
| `retired` | This terminology or claim has been deliberately removed from current use. Its source history remains preserved. |

## Tracing a claim to its source

Each canonical note names its seed exports in the frontmatter field `source_witness`. These unedited files live outside the vault directory. They establish the early material behind the subject; their presence does not mean that every office, procedure, place, or event in the current note appeared in the seed.

Later additions have their own records. Material established through deepening carries an `adopted_in` pass identifier. Later structural repairs may also carry `repaired_in` identifiers. The corresponding design records can be inspected under `workshop/deepening/passes/`, outside the published vault.

| Witness | Primary contents |
|---|---|
| `page-2026-08-20-10-39-03.md` | Kaos ontology, Projections, God Beasts, thaumavores, binary taxonomy, early national sketches |
| `page-2026-08-20-10-39-12.md` | Logos, Ark, Mathys/Prometheus, Fall, post-Fall history, magic notes, story seed |
| `page-2026-08-20-10-39-25.md` | Control population, surface labor, null-descended religions |
| `page-2026-08-20-10-39-32.md` | Luck and selza'a |
| `page-2026-08-20-10-39-38.md` | Sorcery, terjamna, Jamnai, Soiru'i, geothermal arcology |
| `page-2026-08-20-10-39-45.md` | Shamanism, papsenai, Alliance, Ti'asantatca |
| `page-2026-08-20-10-39-51.md` | Analysis and Ju'onai Hegemony |
| `page-2026-08-20-10-39-58.md` | Prophecy, noble houses, divided city, Sunwall |
| `page-2026-08-20-10-40-04.md` | Channeling, Sarxe, Saxfoldi, Ji'esti |

## Decisions adopted by the initial foundation

The following repairs govern how the seed is used in current canon.

### Cities, populations, and history

- There are eight Rings and eight Crown Cities: seven Gifted Cities and one Control Crown.
- Null describes a magical condition. Controls and Spokers are two distinct historical populations.
- Magical inheritance works through inherited strain-complexes whose expression must reach a threshold. It does not divide peoples into a hierarchy of pure and diluted descent.
- The two Channeler histories describe successive events. Ju'onai displacement comes first; the Terjamna Ji'esti massacre comes later. The mercenary history concerns a diaspora outside Sarxe society, not Sarxe society as a whole.
- The returning Prometheus and Cabal plot remains a story seed.

### Magic, observation, and possible futures

- Promethean Sequence numerals and binary Kaos signatures are separate labeling systems.
- Clarity concerns how well causal structure can be resolved. Depth concerns access to counterfactual outcomes—what could happen under different conditions. Scope concerns how far that reach extends through space and time.
- What an observer can detect depends on the layer of magic being observed. Luck can be inferred, but cannot be detected directly.
- Kaos creates neither matter nor energy.
- Every Gift has its own form of oracular relation. No oracle stands outside the causal field it observes: observation, responses, rival Gifts, and material intervention can all change which futures remain reachable.
- A divine hierarchy can bring local events under its control by controlling information, potential, the means of intervention, and the ability of rivals to act. This is **local timeline capture**. It depends on circumstances and has limits; it does not establish that the whole world follows one predetermined future.
- At divine scale, Kaos can gather, transform, move, and assemble existing matter at apparently impossible speed, provided causal routes have been prepared. Every such act still needs source matter, energy, means of intervention, time, potential, and a possible branch in which it can occur.

### Projections, thaumavores, and godhood

- When a God absorbs a Projection, the Projection continues. Absorption binds it and routes it within the divine structure; it does not erase its identity.
- Repeated feeding can sustain an acquired potential body through which a thaumavore manifests and acts. Interception can destroy that body and its current foothold. This does not establish that the thaumavore has been released, or settle which memories and aspects of personhood survive in the Individual Projection.
- Captured flow can give a thaumavore lasting independent agency and open a route of ascent. Becoming a God also requires stabilization and the binding of other Beasts or Projections. Whether this has happened historically, how common it might be, and what Gods remember of it remain unresolved.

## Questions that must remain open

A note's `## Unresolved` section places a real limit on what other notes may claim. A linked note can propose an answer, but cannot treat that proposal as an established fact.

The largest current unknowns are the present date and map, the Control Crown, Intuition, the mechanics of inheritance and divine binding, and the exact limits of magic. Some institutions now have owner notes that establish a limited scope; their regional forms remain unresolved.

## Setting truth and knowledge within Kalsa

A fact can be canonical without anyone in Kalsa knowing it. Notes must distinguish what happened, what people believe happened, and what authors use to explain or adjudicate it.

1. **Observed phenomenon.** Someone has witnessed an effect, or a lasting material trace exists. People may publicly agree that it occurred while disputing its cause.
2. **Common or attributed account.** A community, witness, cult, office, or popular tradition gives an account of what happened and what it means. The attribution matters.
3. **Learned model.** A school, lineage, profession, court, or priesthood has an organized explanation. Record the evidence behind it, the conditions in which it has been tested, its vocabulary, and its known failures.
4. **Restricted evidence or model.** Access to particular records, rites, instruments, sites, or conclusions is limited by who controls them, the dangers involved, or requirements for initiation.
5. **Backstage constraint.** Authors and adjudicators use this causal limit to decide what can happen. It applies whether or not anyone in Kalsa understands it.
6. **Backstage explanatory model.** Authors currently connect those constraints through terms such as the Promethean Sequence, signatures, formal axes, Projections, and Beast taxonomy. This is a coherent working explanation. It is neither a textbook shared across Kalsa nor a guarantee that every named category is a final account of what exists.
7. **Unresolved ontology.** The nature of something remains undecided. No owner note may settle it merely by adopting a local doctrine, writing a convenient glossary definition, or narrating with confidence.

A local theory may be sophisticated, predict useful results, and get some things right without matching the authors' explanation. Equally, a real causal limit does not give a character the evidence or vocabulary to describe it.

Institutions decide which accounts count in law, worship, scholarship, or practical work. Recording an official decision does not give them control over what is true. Nor does explaining the machinery beneath an experience cancel its divine, legal, or emotional reality for the people living through it.

See [[Spoilers/Reference/Story Seeds|Story Seeds]], [[Spoilers/Reference/Timeline|Timeline]], and [[../index|Kalsa]].
