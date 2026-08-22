# Kalsa Vault Operating Contract

## Purpose

This repository is the canonical authoring vault and spoiler-safe Quartz source for Kalsa, a
high-fantasy setting built for Ghostlight Dungeon. The work is to turn the
teenage seed into a causally dense setting without sanding away its peculiar
bones.

## Authority Map

- **Owner:** subject notes under `Kalsa/Spoilers/` own shared setting claims
  within their stated subject. `Kalsa/Public/` owns situated presentation, and
  `Kalsa/index.md` owns navigation only. `workshop/Direction and Constraints.md`
  owns project doctrine and canon rules.
- **Inputs:** immutable files under `seed/original/`, the seed manifest, current
  canonical notes, explicit operator decisions, Ghostlight play requirements,
  and source-grounded comparison with AetheriaLore.
- **Outputs:** linked canonical Markdown, situated reader notes, index notes,
  bounded critique records, verified spoiler-safe Quartz projections, and
  reviewed project-memory judgments.
- **Derived state:** Quartz output, link graphs, word/link/heading diagnostics,
  benchmark comparisons, queues, pass reports, and `.cc` projections. Derived
  state may report on canon; it may not decide canon.
- **Forbidden writers:** seed witnesses, project memory, workshop notes,
  generated site output, retrieval indexes, and site configuration may not
  silently create or override lore truth.
- **Shared path:** human and agent changes use the same source inventory,
  critique, repair, falsification, verification, and record path described in
  `workshop/deepening/README.md`.
- **Cut line:** do not place author or GM material outside `Kalsa/Spoilers/`,
  bind Quartz directly to the complete author vault, revive timestamp export files as live canonical pages,
  create a second lore database, invent a public repo Persona, or copy
  Aetheria-specific site/lore machinery into Kalsa.

## Repository Boundaries

- `Kalsa/` is the sole canonical Obsidian vault root. Its `index.md` is a reader-first,
  navigation-only consent gate.
- `Kalsa/Public/` is the only publishable Quartz content root. Its notes own
  situated presentation, not the hidden facts they omit or reinterpret. Every
  explanatory model must have an inhabitant owner—a culture, institution,
  lineage, text, witness, or explicit synthesis of named sources. Public is not
  the author ontology with the serial numbers filed off.
- `Kalsa/Spoilers/` is the complete canonical author and GM surface. The folder
  is a consent boundary, not a lore owner; its subject notes retain authority.
- `Kalsa/.obsidian/` owns stable vault configuration. Workspace, graph, and
  cache files are ignored derived state and must not resume inside `Spoilers/`.
- `seed/original/` is immutable evidence. Never edit, normalize, rename, or
  re-encode these files. Verify them with `scripts/lore/verify-seed.ps1`.
- `seed/manifest.md` owns witness filenames, sizes, hashes, and subject labels.
- `workshop/` holds doctrine, critique packets, queues, and pass records. It is
  not lore and must remain outside `Kalsa/`.
- `.epiphany/project-memory.md` is the human-inspectable project-memory source.
  Its `.cc` projection is runtime state, not canon.
- `site/` is a Quartz overlay over `Kalsa/Public/`. `.quartz-build/` and `quartz-site/public/` are
  generated projections and are never edited directly.

## Canon And Provenance

- A seed claim becomes shared canon only when a canonical owner note adopts it.
- Distinguish seed evidence, adopted canon, provisional design, contested
  in-world claims, rumor, and deprecated material. Do not use publication state
  as a substitute for canon state.
- Put proposals and unresolved design in `workshop/`. Put genuinely contested
  setting facts in canonical notes only with clear in-world attribution.
- Prefer one owner note plus links over repeated explanations. If two notes
  appear to own the same claim, stop and resolve the boundary before expanding
  either.
- Preserve the source's strange specificity. Repair causal gaps; do not replace
  them with generic medieval-Europe defaults wearing renamed hats.
- Open source does not mean default omniscience. Public navigation, search,
  sitemap, RSS, and backlinks must not expose author-only or GM material.
- Author labels such as Promethean sequences, signatures, formal capability
  axes, and backstage divine taxonomy remain in `Spoilers/` unless an
  inhabitant owner has reconstructed a bounded analogue. A local synonym does
  not make the author model situated; evidence, institutions, interests, and
  characteristic limits must travel with it.
- Vault openness does not excuse root-level exposure. Author and GM notes remain
  physically inside `Kalsa/Spoilers/` even though determined readers may enter.
- Character knowledge is a projection from bounded evidence. The world compiler
  and resolver may consume hidden mechanics; Persona agents may not receive them
  through unrestricted vault retrieval.

## Deepening Work

Before editing an institution, region, practice, or cross-cutting system:

1. Create a pass from `workshop/deepening/pass-template.md`.
2. Inventory seed statements, adopted facts, contradictions, and unknowns.
3. Name the canonical owner and model its inputs, outputs, dependencies,
   beneficiaries, costs, failure modes, and neighboring interfaces.
4. Assemble an immutable review packet and give every seat in
   `workshop/review-council/README.md` an independent diagnostic turn.
5. Adjudicate every substantive finding; critics diagnose and the coordinator
   decides the bounded repair brief.
6. Repair the smallest coherent set of owner notes.
7. Falsify the result with one hostile or marginal perspective and one
   historical stress case.
8. Give every council seat a post-repair regression turn; Reader Experience
   receives a fresh blind packet.
9. Verify seed integrity, links, publication boundaries, and the Quartz build.
10. Record the pass in the ledger and promote only durable judgment into project
   memory.

Passing prose is not enough. A mature institution must explain authority,
reproduction, material support, doctrine versus practice, distribution of
benefit and harm, dependencies, historical formation, internal contradiction,
and consequences for play. Use `workshop/deepening/benchmark.md` as the parity
standard; do not turn word count into a victory condition.

## Project Memory

- Project memory records durable judgment, operating lessons, adopted
  decisions, open design pressure, and provenance.
- Project memory does not store lore facts as an alternate canon, raw
  transcripts, generated prose, task chatter, or a duplicate roadmap.
- Update `.epiphany/project-memory.md` first. Regenerate the derived CultCache
  state with `.epiphany/sync-project-memory.ps1`.
- Retire stale judgments explicitly instead of leaving contradictory active
  entries. Canonical decisions must also be visible in the owning Markdown
  surface.

## Retrieval And Inspection

- Once Kalsa is indexed, use the global VoidBot source search for semantic
  discovery and then open the returned source notes before editing.
- Use `rg` for exact filenames, exact claims, links, and repository-wide
  patterns. Do not build a repo-local semantic index.
- Read and write Markdown explicitly as UTF-8 in Windows PowerShell.

## Verification

Run from the repository root:

```powershell
.\scripts\lore\verify-seed.ps1
.\scripts\lore\check-vault-layout.ps1
.\scripts\lore\check-wikilinks.ps1
.\scripts\lore\check-publication-boundary.ps1
.\scripts\lore\measure-depth.ps1
.\scripts\lore\test-lore-tools.ps1
.\scripts\quartz\quartz.ps1 build
.\scripts\lore\check-publication-output.ps1
```

For a deepening pass, also verify the complete author vault, verify the
`Kalsa/Public/` boundary, and inspect affected rendered pages. Diagnostics
observe the setting; they do not award canon.
