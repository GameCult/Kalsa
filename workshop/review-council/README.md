# Kalsa Lore Review Council

This directory owns the reusable critic prompts and council protocol for Kalsa
deepening passes. It does not own lore. A critic diagnoses one quality surface;
the pass coordinator adjudicates findings; canonical subject notes retain every
setting claim.

The protocol adapts the independent-report and regression shape of
AetheriaLore's Novella Council to a setting vault. Manuscript-only specialties
are omitted. Kalsa instead reviews whether its lore can generate institutions,
cultures, material pressures, history, adventures, and an inviting
inhabitant-facing reading experience without collapsing into authorial jargon
or polished machine prose.

## Council Seats

Every deepening pass gives each seat one diagnostic turn and one post-repair
regression turn:

1. [[critics/Institutional Causality|Institutional Causality]]
2. [[critics/Culture and Situated Knowledge|Culture and Situated Knowledge]]
3. [[critics/Material Life and Ecology|Material Life and Ecology]]
4. [[critics/History Conflict and Change|History, Conflict, and Change]]
5. [[critics/Ghostlight Play and Consequence|Ghostlight Play and Consequence]]
6. [[critics/AI-Isms and Prose|AI-Isms and Prose]]
7. [[critics/Reader Experience and Navigation|Reader Experience and Navigation]]

A seat may return `No blocking finding`. Silence is not a report, and a critic
must not manufacture a defect to justify its seat. Replace or retire a seat if
several passes show that its remit is redundant; do not keep a pageant of agent
names.

## Authority Map

- **Owner:** this file owns council membership, sequence, packet boundaries,
  and completion gates. Individual prompt files own only their diagnostic
  remit.
- **Inputs:** an immutable candidate packet assembled from the pass, exact
  source and owner notes, intended audience, protected strengths, known
  concerns, and the candidate diff or baseline.
- **Outputs:** seven raw diagnostic reports, coordinator dispositions, a finite
  repair brief, seven regression reports, and a final council decision.
- **Derived state:** confidence labels, pattern inventories, counts, agreement,
  and report summaries are evidence. They do not decide lore or publication.
- **Forbidden writers:** critics, majorities, detector scores, checklists, and
  report prose may not edit canon, promote a candidate, or invent a missing
  answer. Workshop files may not become a second lore database.
- **Shared path:** baseline packet -> independent diagnostic turns ->
  coordinator adjudication -> bounded owner repair -> independent regression
  turns -> coordinator closeout -> ordinary repository verification.
- **Cut line:** a generic `Soul review`, one omnibus opinion, or an aggregate
  score cannot stand in for the seven named reports. Continuity is not a
  dedicated seat; source fidelity, provenance, ownership, and spoiler safety
  constrain every seat and remain part of final verification.

## Packet Contract

Create the packet before critics begin, using [[packet-template]]. Freeze its
identity with a commit, tag, or recorded file hashes. Diagnostic critics do not
see one another's reports.

Record the coordinator in the packet, pass, and synthesis. One person or agent
may hold more than one role when necessary, but the overlap must be explicit;
no critic or repair writer silently inherits adjudication authority.

Six grounded critics receive only the canonical and workshop sources necessary
for their remit. Reader Experience and Navigation receives the reader-visible
entry path, target-audience description, and any navigation surface under test.
It does not receive hidden canon, authorial intention, known concerns, or other
reports. When a pass changes only author material, give that critic the
plausible direct-entry path an author or GM would actually use and say that the
packet is not spoiler-blind.

The packet must distinguish:

- immutable seed evidence;
- adopted canon and its owner;
- provisional design, rumor, contested belief, and unknowns;
- Public inhabitant presentation;
- protected peculiarities and explicit operator decisions;
- the exact scope critics may inspect.

## Diagnostic Phase

Prepend [[shared-prompt]] to the appropriate critic prompt. Each critic returns
[[report-template]] as a separate artifact. Reports may cite the same defect,
but they must arrive independently.

The coordinator then records a disposition for every substantive finding:

- `Accept` — the evidence identifies a defect in scope;
- `Modify` — the defect is real but the proposed direction crosses an owner or
  threatens protected material;
- `Reject` — the finding is unsupported, outside remit, or would make Kalsa
  more generic;
- `Defer` — the pressure is real but belongs to a named later pass or needs
  operator input.

Agreement increases attention, not authority. A lone well-supported finding
can block a pass. Seven correlated preferences cannot vote a seed fact out of
existence.

Every diagnostic finding receives a stable critic-local ID. Preserve that ID
through disposition, repair instruction, regression, and queue deferral. The ID
is a routing key, not a score or a claim of canon authority.

## Repair Phase

The coordinator converts accepted and modified findings into one bounded repair
brief. Repair begins by deleting or demoting obsolete authority. A writer or
Hands agent may then produce a candidate, but only the coordinator integrates
it into canonical owner notes.

Do not feed raw disagreement to a writer and ask it to average the reports.
Do not revise passages outside the accepted brief merely because a critic
noticed them. Record new pressure in the queue.

## Regression Phase

After repair, freeze one repaired candidate identity. Derive every specialist
packet, including the blind reader packet, from that snapshot. Each original
seat receives the repaired candidate, its raw report, the relevant dispositions,
and the protected-material list, then returns [[regression-template]]. Each
answers only:

1. Which accepted or modified findings were resolved?
2. Which remain unresolved?
3. What new defect appeared within this remit?
4. Which protected strength survived or weakened?
5. What further change is essential rather than preferable?
6. What should now be left alone?

Reader Experience receives a newly assembled blind packet, not its old report
or the coordinator's intentions. Its second turn is fresh evidence rather than
implementation regression.

Any change after the repaired snapshot invalidates regressions whose inspected
surface may have changed. Freeze a new candidate and rerun those seats; do not
let sequential reviews certify different bodies.

## Completion Gate

A deepening pass cannot close until:

- all seven diagnostic reports exist, including explicit no-finding reports;
- the coordinator has disposed every substantive finding;
- repair changed only named owners and supporting navigation;
- all seven regression reports exist and name the same repaired candidate
  identity;
- no accepted essential defect remains unresolved;
- the coordinator records what must now be left alone;
- seed, wikilink, vault-layout, publication-boundary, Quartz, rendered-page,
  and actual-diff checks appropriate to the pass succeed.

Council completion certifies that the named review process ran. It does not
prove the lore is good forever. New play, readers, sources, or contradictions
can reopen pressure through a new pass.
