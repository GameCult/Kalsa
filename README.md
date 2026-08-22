# Kalsa

Kalsa is a high-fantasy setting for Ghostlight Dungeon: gods, prophets, shamans, old miracles, sacred machinery, fallen cities, and peoples trying to live among explanations that do not agree.

This repository is the complete open author vault. It contains setting-level and dungeon spoilers in plain text. They are not secret, but they are not the intended first encounter either. The public reader surface is deliberately smaller so that people can choose when to inspect the machine.

Open `Kalsa/`—not the repository root—as the Obsidian vault. Its file explorer
shows the reader section and one explicitly named spoiler section.

## Start here

- Readers and players: begin with [`Kalsa/Public/index.md`](Kalsa/Public/index.md). The [Quartz site](https://gamecult.github.io/Kalsa/) publishes only this spoiler-safe surface.
- Vault explorers: [`Kalsa/index.md`](Kalsa/index.md) is a navigation-only gate between the reader path and the warned spoiler section.
- Deliberate spoiler readers and writers: continue through [`Kalsa/Spoilers/index.md`](Kalsa/Spoilers/index.md).
- Writers: read [`workshop/Direction and Constraints.md`](workshop/Direction%20and%20Constraints.md), then [`Kalsa/Spoilers/Reference/Canon and Provenance.md`](Kalsa/Spoilers/Reference/Canon%20and%20Provenance.md).
- Maintainers: the iterative repair system lives under `workshop/deepening/`; site-specific Quartz configuration lives under `site/`.

## Authority map

- `Kalsa/Public/`: spoiler-safe common knowledge and situated sources; the only Quartz content root
- `Kalsa/Spoilers/`: complete open author canon and GM material; deliberately entered repository/Obsidian section
- `Kalsa/index.md`: navigation only; owns no setting claims
- `Kalsa/.obsidian/`: stable configuration for the canonical vault; session and cache state remain local and ignored
- `seed/original/`: immutable source witnesses
- `seed/manifest.md`: source hashes and witness map
- `workshop/`: critique, proposals, contradictions, and repair evidence; never automatic canon
- `.epiphany/`: durable agent judgment and continuity; never setting truth
- `site/`: Kalsa-specific Quartz projection
- `scripts/`: build and verification tools
- `quartz-site/public/`: generated output, ignored by Git

Obsidian is the authoring interface. Quartz is the reader projection. Neither owns lore. Public prose does not overrule its canonical subject owner, and author truth does not enter a character's knowledge merely because both exist in one open repository.

## Local site

The shared engine is the sibling [`GameCult-Quartz`](https://github.com/GameCult/GameCult-Quartz) repository. Install that engine's dependencies once, then run:

```powershell
.\scripts\quartz\quartz.ps1 build
```

For local development:

```powershell
.\scripts\quartz\quartz.ps1 dev
```

Set `GAMECULT_QUARTZ_ROOT` when the shared engine is not checked out beside this repository. The launcher stages the engine under `.quartz-build/engine` and writes the static site to `quartz-site/public`.

The intended custom domain is `kalsa.gamecult.org`. DNS and the GitHub Pages domain binding are an external deployment step; repository configuration does not pretend that step has already happened.

## Deepening standard

The target is causal density comparable to AetheriaLore, not a matching heap of nouns. A mature institution exposes its origin, authority, material base, recruitment and succession, ordinary procedure, beneficiaries and costs, dependencies, internal contradiction, organized resistance, failure modes, and consequences for play. Each repair wave is modeled, challenged by an unfamiliar reader, grounded against named sources, changed in a bounded diff, and verified before its ledger entry closes.
