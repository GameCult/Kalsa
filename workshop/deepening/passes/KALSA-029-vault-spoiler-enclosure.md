---
pass_id: KALSA-029
status: complete
target: casual Obsidian exploration and physical spoiler enclosure
canonical_owner: workshop/Knowledge and Spoiler Architecture.md
started: 2026-08-22
completed: 2026-08-22
---

# KALSA-029 — Vault Spoiler Enclosure

## Objective

Make spoiler consent visible in the Obsidian file tree rather than relying on
Quartz exclusion and a warning inside an already-spoiling root layout.

## Authority map before repair

- **Owner:** author notes owned their subjects, but seven author/GM directories
  sat beside `Public/` at the vault root.
- **Inputs:** 58 author/GM notes, eight reader notes, the KALSA-026 reveal
  doctrine, and the operator's report from casual vault exploration.
- **Outputs:** a public site that was safe while the Obsidian explorer was not.
- **Derived state:** Quartz correctly hid author pages; that success concealed
  the unresolved vault-navigation leak.
- **Forbidden writers:** directory position did not change canon, but it did
  decide what a casual explorer encountered before consent.
- **Shared path:** opening `Kalsa/` exposed domain names such as Foundations and
  Dungeons before the reader chose the author surface.
- **Cut line:** remove every author/GM directory and the author index from the
  vault root; do not preserve old-path copies, junctions, or symlinks.

## Repair

- `Kalsa/index.md` becomes a navigation-only reader-first gate.
- `Kalsa/Public/` remains the unchanged Quartz and reader source.
- `Kalsa/Spoilers/` encloses the author index plus Dungeons, Events,
  Foundations, Institutions, Places, Polities, and Reference.
- Subject notes retain their prior authority after the move; the Spoilers
  folder itself owns no lore.
- Author and workshop wikilinks receive explicit `Spoilers/` paths.
- Institutional depth measurement reads only `Kalsa/Spoilers/`, not situated
  Public prose or the navigation gate.
- `check-vault-layout.ps1` makes the root enclosure structural and rejects a
  future author directory placed beside `Public/` and `Spoilers/`.
- `Kalsa/` becomes the sole canonical Obsidian vault root. Stable configuration
  lives under `Kalsa/.obsidian/`; ignored session state is neutralized and may
  not reopen or enumerate `Spoilers/` before consent.

## Falsification

### Casual explorer

At the vault root, the explorer sees only `Public/`, `Spoilers/`, and a neutral
index. No deep-history, ontology, polity, event, or dungeon title appears before
choosing the spoiler folder.

### Deliberate author

The complete open author graph remains reachable under one warned index. Links,
canon ownership, provenance, and workshop evidence survive the move without a
compatibility copy.

## Verification

- [x] Top-level Kalsa paths are limited to `Public/`, `Spoilers/`, `index.md`,
  and derived `.obsidian/` state.
- [x] The current Obsidian workspace opens `index.md`, contains no spoiler
  recents or pane bindings, and session/cache files are ignored at any depth.
- [x] No old author directory remains at the vault root.
- [x] Complete-vault and Public-only wikilinks resolve without escape.
- [x] No tracked Markdown retains an obsolete author-root path.
- [x] Seed hashes, lore-tool tests, publication boundary, production Quartz
  build, and exact generated routes pass.
- [x] Project memory and the Body map record the new physical boundary.

## Decision record

- **Adopted:** one explicit spoiler enclosure with no secrecy claim.
- **Explicitly not adopted:** duplicate public canon, symlink compatibility,
  prompt-only spoiler warnings, or hiding author material from the repository.
- **Project-memory judgment promoted or retired:** strengthened
  `memory-open-spoiler-friction` so it governs the vault root, physical spoiler
  enclosure, and current/session startup state as well as Quartz.
