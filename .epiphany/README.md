# Kalsa Project Memory

This directory is Kalsa's bounded persistent-memory surface. It is deliberately
smaller than a Persona or a full autonomous swarm workspace.

## Ownership

- `project-memory.md` is the human-inspectable source for durable project
  judgment and unresolved design pressure.
- `state/project-memory.cc` is a typed CultCache state-ledger projection of that
  source for runtime inspection. It is generated, not hand-edited.
- `sync-project-memory.ps1` rebuilds the projection from the Markdown source.

Neither surface owns lore truth. Canon remains in owner notes under `Kalsa/`,
and project doctrine remains in `workshop/Direction and Constraints.md`.

## What Belongs Here

- decisions that should steer later work;
- architectural or editorial lessons that prevent repeated mistakes;
- unresolved questions that materially change future choices;
- provenance anchors for those judgments;
- explicit retirement of stale guidance.

Raw lore claims, generated prose, transcripts, task logs, pass-by-pass trivia,
and site build state do not belong here. Pass details live under
`workshop/deepening/`; only their durable lesson may be promoted.

## Updating Memory

1. Edit `project-memory.md`.
2. Keep each active or open entry on one parseable list line using the existing
   identifier format.
3. Update the `snapshot_at` timestamp.
4. Rebuild and inspect the typed projection:

```powershell
.\.epiphany\sync-project-memory.ps1
& "F:\Projects\Epiphany\target\debug\epiphany-state-ledger-store.exe" status --store .\.epiphany\state\project-memory.cc
```

The synchronizer uses Epiphany's typed `epiphany.state_ledger` CultCache entry.
It does not invent a public Persona or a competing project-memory schema. If a
dedicated shared project-memory contract later exists, migrate the projection
through a reviewed tool and keep this source's identifiers and provenance.
