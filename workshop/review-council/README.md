# Kalsa Lore Review Council

This directory owns the reusable critic prompts and council protocol for Kalsa
deepening passes. It does not own lore. A Critic diagnoses one quality surface;
an exhausted Critic becomes a Guardian of later changes; the pass coordinator
adjudicates findings; canonical subject notes retain every setting claim.

The protocol adapts the independent-report and regression shape of
AetheriaLore's Novella Council to a setting vault. Manuscript-only specialties
are omitted. Kalsa instead reviews whether its lore can generate institutions,
cultures, material pressures, history, adventures, and an inviting
inhabitant-facing reading experience without collapsing into authorial jargon
or polished machine prose.

## Council Seats and Modes

Every seat remains part of the council. Its recorded mode determines what it
reviews:

| Seat | Mode | Exhaustion evidence and certified surface | Relevant guardian reviews since sanity |
| --- | --- | --- | ---: |
| [[critics/Institutional Causality|Institutional Causality]] | Critic | — | — |
| [[critics/Culture and Situated Knowledge|Culture and Situated Knowledge]] | Critic | — | — |
| [[critics/Material Life and Ecology|Material Life and Ecology]] | Critic | — | — |
| [[critics/History Conflict and Change|History, Conflict, and Change]] | Critic | — | — |
| [[critics/Ghostlight Play and Consequence|Ghostlight Play and Consequence]] | Critic | — | — |
| [[critics/AI-Isms and Prose|AI-Isms and Prose]] | Guardian | [[../deepening/reviews/KALSA-038/candidate-06-packet|KALSA-038 candidate 06]]; `Kalsa/index.md` and complete `Kalsa/Public/` surface | 0 |
| [[critics/Reader Experience and Navigation|Reader Experience and Navigation]] | Critic | — | — |

A **Critic** receives an independent baseline diagnostic turn and a post-repair
regression turn. A **Guardian** assumes its certified body is clean and reviews
only new changes within its remit: the exact diff, the complete changed notes,
and affected navigation or ownership context. It does not reread untouched
corpus merely to perform a seat.

A seat becomes exhausted only when all of the following are recorded:

- the reviewed surface and its immutable packet identity are explicit;
- a dedicated loop repeatedly repairs and rereads that complete surface;
- the exact final body receives an unqualified pass with no finding at any
  priority;
- every earlier finding is resolved or explicitly disposed;
- one fresh final full-surface reread confirms the shipping body; and
- the coordinator records the Guardian transition, certified baseline, sanity
  cadence, and reactivation triggers here and in the exhausting pass.

An ordinary `No blocking finding`, one clean regression, or several quiet
targeted passes do not exhaust a critic.

Every fifth completed review relevant to a Guardian is a full sanity check
instead of a diff-only review. Reset the counter to zero after that check. Run
the sanity check earlier when any of these occur:

- an operator, reader, or play report identifies recurrence within the remit;
- the Guardian finds a pattern extending beyond the changed notes;
- the critic prompt, guarded publication architecture, or review surface
  changes materially;
- one pass changes at least one third of the certified surface; or
- the certified baseline cannot be reconstructed or its identity is doubtful.

A review is relevant when a pass changes or creates material inside the
Guardian's certified or since-reviewed surface, or when the coordinator records
that the change directly touches the guarded mechanism. For AI-Isms and Prose,
every changed or newly created canonical prose note is relevant. The Guardian
report records those notes for the next sanity surface.

For AI-Isms and Prose, a sanity packet contains the complete current Public
surface plus every canonical prose note reviewed by that Guardian since its
previous sanity check. Other future Guardians must define their sanity surface
when they transition.

A local change defect blocks the candidate and is rerun through the Guardian
after repair. A systemic recurrence, failed sanity check, or obsolete certified
surface returns the seat to **Critic** mode until a new exhaustive loop earns a
new Guardian baseline.

A seat may return `No blocking finding`. Silence is not a report, and a critic
or Guardian must not manufacture a defect to justify its seat. Exhaustion
changes review scope; retirement still requires evidence that the remit itself
is redundant.

## Authority Map

- **Owner:** this file owns council membership, sequence, packet boundaries,
  and completion gates. Individual prompt files own only their diagnostic
  remit.
- **Inputs:** an immutable candidate packet assembled from the pass, exact
  source and owner notes, intended audience, protected strengths, known
  concerns, the candidate diff or baseline, and the recorded mode of every
  seat.
- **Outputs:** raw reports required by each seat's mode, coordinator
  dispositions, a finite repair brief, active-Critic regression reports,
  Guardian change or sanity reports, updated Guardian counters, and a final
  council decision.
- **Derived state:** confidence labels, pattern inventories, counts, agreement,
  report summaries, seat modes, and Guardian counters are evidence. They do not
  decide lore or publication.
- **Forbidden writers:** critics, majorities, detector scores, checklists, and
  report prose may not edit canon, promote a candidate, or invent a missing
  answer. Workshop files may not become a second lore database.
- **Shared path:** baseline packet -> independent active-Critic diagnostics ->
  coordinator adjudication -> bounded owner repair -> active-Critic regression
  plus Guardian change review or sanity check -> coordinator closeout ->
  ordinary repository verification.
- **Cut line:** a generic `Soul review`, one omnibus opinion, or an aggregate
  score cannot stand in for the seven named seats and their mode-required
  reports. Continuity is not a dedicated seat; source fidelity, provenance,
  ownership, and spoiler safety constrain every seat and remain part of final
  verification.

## Packet Contract

Create the packet before critics begin, using [[packet-template]]. Freeze its
identity with a commit, tag, or recorded file hashes. Diagnostic critics do not
see one another's reports.

Record the coordinator in the packet, pass, and synthesis. One person or agent
may hold more than one role when necessary, but the overlap must be explicit;
no critic or repair writer silently inherits adjudication authority.

Active grounded critics receive only the canonical and workshop sources
necessary for their remit. Reader Experience and Navigation receives the
reader-visible entry path, target-audience description, and any navigation
surface under test. It does not receive hidden canon, authorial intention,
known concerns, or other reports. When a pass changes only author material,
give that critic the plausible direct-entry path an author or GM would actually
use and say that the packet is not spoiler-blind.

The packet must distinguish:

- immutable seed evidence;
- adopted canon and its owner;
- provisional design, rumor, contested belief, and unknowns;
- Public inhabitant presentation;
- protected peculiarities and explicit operator decisions;
- the exact scope critics may inspect.

A Guardian receives no baseline diagnostic packet during an ordinary pass. Its
post-repair change packet must name the certified baseline, candidate identity,
diff base, complete changed-note hashes, exact diff, full text of every changed
note within remit, affected navigation or ownership context, and protected
material. Unchanged corpus is outside that packet. Prepend [[guardian-prompt]]
to the seat's specialist prompt and use [[guardian-template]] for its report.

When a sanity trigger fires, freeze the full sanity surface and temporarily run
that seat through the ordinary diagnostic and regression contracts. A clean
sanity check resets its counter and leaves it in Guardian mode. A failed sanity
check returns it to Critic mode.

## Diagnostic Phase

Prepend [[shared-prompt]] to the appropriate critic prompt. Each active Critic
returns [[report-template]] as a separate artifact. Reports may cite the same
defect, but they must arrive independently. Guardians do not take an ordinary
diagnostic turn; their absence here is recorded mode, not silence.

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
packet, including the blind reader packet and Guardian change packets, from that
snapshot. Each active Critic receives the repaired candidate, its raw report,
the relevant dispositions, and the protected-material list, then returns
[[regression-template]]. Each answers only:

1. Which accepted or modified findings were resolved?
2. Which remain unresolved?
3. What new defect appeared within this remit?
4. Which protected strength survived or weakened?
5. What further change is essential rather than preferable?
6. What should now be left alone?

Reader Experience receives a newly assembled blind packet, not its old report
or the coordinator's intentions. Its second turn is fresh evidence rather than
implementation regression.

Each Guardian independently reviews the exact change packet after repair. It
checks whether the diff violates guarded strengths, reintroduces a known defect,
or creates a new defect within remit. A passing report increments its relevant
review counter. A changed candidate invalidates the report and requires a new
Guardian review just as it invalidates an active Critic regression.

Any change after the repaired snapshot invalidates regressions whose inspected
surface may have changed. Freeze a new candidate and rerun those seats; do not
let sequential reviews certify different bodies.

## Completion Gate

A deepening pass cannot close until:

- every active Critic diagnostic report exists, including explicit no-finding
  reports;
- the coordinator has disposed every substantive finding;
- repair changed only named owners and supporting navigation;
- every active Critic regression and every required Guardian change or sanity
  report names the same repaired candidate identity;
- Guardian counters and mode transitions are updated in the seat table;
- no accepted essential defect remains unresolved;
- the coordinator records what must now be left alone;
- seed, wikilink, vault-layout, publication-boundary, Quartz, rendered-page,
  and actual-diff checks appropriate to the pass succeed.

Council completion certifies that the named review process ran. It does not
prove the lore is good forever. New play, readers, sources, or contradictions
can reopen pressure through a new pass.
