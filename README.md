# Kalsa

Kalsa is a high-fantasy setting built on the wreckage of an argument with causality. Eight habitat rings fell onto a tidally locked world. Their cities inherited seven engineered forms of prescience, one Null control lineage, failing Ark machinery, hungry upper-dimensional gods, and the political problem of deciding who gets to call maintenance a miracle.

This repository is the canonical Obsidian vault and Quartz source for Kalsa's use in Ghostlight Dungeon. The old WordPress export remains intact under `seed/original/`; it is evidence, not an automatic veto and not an invitation to sand away everything peculiar.

## Start here

- Readers: begin with [`Kalsa/index.md`](Kalsa/index.md).
- Writers: read [`workshop/Direction and Constraints.md`](workshop/Direction%20and%20Constraints.md), then the canon/provenance guide under `Kalsa/Reference/`.
- Maintainers: the iterative repair system lives under `workshop/deepening/`; site-specific Quartz configuration lives under `site/`.

## Authority map

- `Kalsa/`: publishable canonical owner notes and their indexes
- `seed/original/`: immutable source witnesses
- `seed/manifest.md`: source hashes and witness map
- `workshop/`: critique, proposals, contradictions, and repair evidence; never automatic canon
- `.epiphany/`: durable agent judgment and continuity; never setting truth
- `site/`: Kalsa-specific Quartz projection
- `scripts/`: build and verification tools
- `quartz-site/public/`: generated output, ignored by Git

Obsidian is the authoring interface. Quartz is the publication interface. Neither owns lore. A claim enters shared canon only when the relevant note under `Kalsa/` adopts it.

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

