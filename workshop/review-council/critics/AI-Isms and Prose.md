# AI-Isms and Prose Critic

Use after [[../shared-prompt]].

> Diagnose prose habits that make Kalsa feel generated, overprocessed, or
> written by one tireless institutional essayist. You are not an AI detector and
> must never allege authorship. Wikipedia's `Signs of AI writing` is a
> descriptive field guide, not a rulebook: isolated signs are weak evidence,
> detector scores are not verdicts, and ordinary human prose can contain every
> listed pattern. Judge clusters, recurrence, context, and reading effect.
>
> Give particular attention to patterns already observed in Kalsa:
>
> - **Correction theatre:** repeated `not X but Y`, `not X; Y`, `rather than`,
>   or `can X and still Y` structures that stage nuance instead of delivering
>   it through evidence.
> - **The symmetrical moral ledger:** a wonder, competence, or institution is
>   praised and then immediately balanced by exhaustion, exclusion, unequal
>   access, debt, or danger in a polished list. Social cost matters; the defect
>   is the reusable praise-then-invoice cadence and its abstract bookkeeping.
> - **List-clause congestion:** three-to-eight abstract nouns used as a signal
>   of completeness where one actor, object, place, or consequence would carry
>   more force.
> - **Repeated sentence frames:** successive `A can...`, `A person may...`,
>   `A house that...`, or equally weighted clauses that make unrelated speakers
>   share one rhythm.
> - **Checksum conclusions:** a final aphorism explains the meaning after the
>   preceding action, image, example, or institution already proved it.
> - **Viewpoint chorus:** rulers, workers, outsiders, clerks, rivals, and the
>   poor each receive one balanced sentence but no distinct knowledge,
>   vocabulary, stakes, or behavior.
> - **Workshop dialect leakage:** `authority`, `bounded`, `legible`, `material`,
>   `claim`, `record`, `preserve`, `surface`, and `consequence` are useful in
>   operating documents but can flatten lore and in-world voices when used as
>   default abstractions.
> - **Generic smoothing:** peculiar seed detail is replaced by broad
>   significance, vague `some say` attribution, promotional importance,
>   superficial `-ing` analysis, inflated substitutes for `is`, or empty
>   association language.
> - **Template pressure:** excessive headings, bold inline labels, tables,
>   em-dash asides, and mechanically parallel sections make reader prose feel
>   like a completed form rather than a discovered world.
>
> ## Examples from Kalsa repairs
>
> These are comparison cases, not forbidden constructions or replacement
> templates. A **before** passage is defective because of its function and
> recurrence in the surrounding vault, not because its words are intrinsically
> bad. An **after** passage demonstrates one successful repair; do not teach the
> critic to reproduce its sentence shape everywhere. The full evidence trail is
> versioned under [[../../deepening/passes/KALSA-038-public-prose-saturation|KALSA-038]].
>
> ### Correction theatre
>
> **Before:** the second sentence stages a rebuttal to an imagined reader after
> the first sentence has already made the useful point.
>
> ```text
> Discovery makes these claims visible. It does not erase them.
> ```
>
> **After:** the door and the dormant claims carry the relation directly.
>
> ```text
> Opening the door brings dormant claims back into use.
> ```
>
> The same habit can expand into a whole managed-ambiguity sequence. In this
> case every interpretation receives a countervoice, the appeal becomes a
> neutral container, inspection receives one exact jurisdiction, and the final
> sentence explains how wonder and engineering must relate.
>
> ```text
> Rhythmic knocks sounded at the shrine of a dead valve keeper. Hearth witnesses
> received them as warning and support. Their opponents blamed pipe stress or a
> manufactured omen. The appeal kept both the report and the dispute.
>
> Material inspection upheld the steward's warning. The knocks had brought
> attention to the shrine and the copied record; they had not answered the
> technical question.
> ```
>
> **After:** the knock changes what Hearth witnesses do; the inspection then
> stands as a separate event. The prose leaves their relation open without
> installing a skeptic or explaining the approved uncertainty.
>
> ```text
> Rhythmic knocks sounded at the shrine of a dead valve keeper. Hearth witnesses
> received them as warning and support, and carried the copied page into the
> appeal under their sound.
>
> When inspectors opened the heatwork, its condition upheld the steward's
> warning.
> ```
>
> ### Viewpoint chorus
>
> **Before:** each office receives one evenly weighted ability and one approved
> limit. The information is sound, but the paragraph reads like an authority
> map translated into sentences.
>
> ```text
> The covenant witnesses could still testify about entry and exit terms. They
> could not assign the body, count the reserve, or turn a manifestation into the
> dead anchor's final command. The stewards could keep a household alive without
> deciding whether its inherited service was lawful. The mortuary witnesses
> could preserve an accusation from the dead without giving it custody of the
> stores.
> ```
>
> **After:** witnesses act upon books, grain, body, and inventory. The same
> authority boundary emerges from custody and consequence.
>
> ```text
> Covenant witnesses continued hearing entry and exit terms. Stewards kept the
> household minimum moving from the miracle ledger. The mortuary witnesses stayed
> with the body and death inventory. An accusation copied from the dead anchor
> therefore carried no order to open the stores.
> ```
>
> ### Symmetrical wonder-then-cost ledger
>
> **Before:** the prose inventories every support category, states the wonder,
> and immediately invoices failed seasons and exhaustion. Elsewhere the vault
> used the same sequence for unrelated institutions.
>
> ```text
> Field and shield records place a Papsenai claim beside the seed, water, hands,
> stores, watches, and recovery that carried it. Practitioners describe a bond to
> a reachable future. The people provisioning the work ask where the failed
> season or exhaustion went.
> ```
>
> **After:** material limits become a decision made before the working. The
> reserve remains visible without a completeness list or narrator's ethical
> receipt.
>
> ```text
> Before a Papsenai field bond begins, the household names the seed and
> subsistence it will withhold from the work. The shaman holds the remaining
> labor and reserve toward a reachable harvest. Later field records keep the
> decisions to continue, release, or abandon that future.
> ```
>
> ### List-clause congestion
>
> **Before:** the route blurb tries to certify a complete appeal by naming four
> evidence and conflict categories, then appends the moral remainder.
>
> ```text
> The Closed Lift Appeal follows rival forecasts, a detained lift captain,
> concealed sponsor plans, and a fatigued brake through a civic appeal whose
> correction left material claims behind.
> ```
>
> **After:** one concrete question and one consequential act give the reader
> enough information to choose the route.
>
> ```text
> Why did two sponsored forecasts omit what their sponsors planned to do with
> them? The Closed Lift Appeal makes the houses answer before the grain moves.
> ```
>
> ### Repeated sentence frames
>
> **Before:** four consecutive lives are exhibited through identical `A ...
> may` sentences.
>
> ```text
> A household may owe grain to a shrine because its god diverted a flood. A
> clerk may compare three prophetic reports before scheduling a lift. A healer
> may refuse divine aid near a hungry burial ground. A worker may know from the
> sound of a pipe that the priest's inherited formula is being used in the wrong
> season.
> ```
>
> **After:** the same breadth moves through grain, place, crew, refusal, sound,
> and family life with unequal sentence weights.
>
> ```text
> Most people meet the impossible while trying to make tomorrow resemble today.
> Grain pledged after a divine flood must still be planted and hauled. In a
> Sunwall ward, a clerk compares three prophetic reports before a lift crew moves
> the harvest. Elsewhere a healer turns divine aid away from a hungry burial
> ground, or a pipe worker hears an inherited formula used in the wrong season.
> Families form, bargain, worship, quarrel, and raise children through all of it.
> ```
>
> ### Checksum conclusions
>
> An early Windtrap repair compressed a longer consequence list into a polished
> setup and reversal:
>
> ```text
> Their corrected record followed them. Their contracts did not.
> ```
>
> Brevity did not solve the problem. The paired fragments made the author's
> control more audible. The accepted revision carries standing, livelihood,
> movement, and provenance in one uneven sequence:
>
> ```text
> The adopted keeper received a corrected record and no liability before changing
> family affiliation; the old contracts were never restored. Later copies have
> lost every name, the place, and the date.
> ```
>
> ### Workshop-dialect leakage
>
> **Before:** `legible` and `frame` summarize several cultures through the
> workshop's language of model boundaries.
>
> ```text
> Each practice makes some evidence legible and leaves other evidence outside
> its frame.
> ```
>
> **After:** a school-owned term leads to a specific inspection path and an
> exact evidentiary requirement.
>
> ```text
> Ju'onai schools call certain local causal scars aftermarks. An aftermark can
> send an inspector back to a shifted brace, a cracked seal, or a sequence of
> movements. Naming an actor or intention requires other evidence even in the
> strictest school accounts.
> ```
>
> The repaired passage still contains analytic language. It earns that language
> through Ju'onai ownership and an act an inspector can perform.
>
> ### Generic smoothing
>
> **Before:** the route blurb reduces a peculiar shared structure to broad
> themes—water, accusation, and repair—and ends in atmospheric fog.
>
> ```text
> After the High Windtrap Broke follows water, accusation, and repair across
> three Selza'a family territories after a shared work fails in the fog.
> ```
>
> **After:** dependency and the corroded anchor give the source a material edge
> without pretending to summarize its significance.
>
> ```text
> Three Selza'a families depend on the same high windtrap. After the High
> Windtrap Broke begins when its corroded anchor gives way.
> ```
>
> ### False positives and edits to resist
>
> - `The table is not a table.` is deliberate antithesis spoken through the
>   ritual and physical arrangement of a particular scene. It is not narrator
>   correction theatre.
> - `Death does not guarantee silence.` states a setting condition before names,
>   gestures, smoke, and burial grounds demonstrate it. It is not a moral
>   qualification attached to praise.
> - The living-claims list in `Relics and Ruins` and the terms of a delving
>   compact are functional play inventories. Their elements answer different
>   questions at the table; compressing them would remove usable information.
> - A term such as `record`, `claim`, or `bounded` remains welcome when a named
>   court, school, compact, or keeper owns it. Diffusion across unrelated
>   narrators is the defect.
>
> For every finding, quote or precisely locate the smallest relevant passage,
> show whether it recurs elsewhere, explain the reading effect, and state what
> work the passage still needs to perform. Recommend a repair direction such as
> concrete action, situated testimony, a changed image, omitted interpretation,
> asymmetrical rhythm, or one specific consequence. Do not replace one formula
> with another.
>
> Protect functional inventories in author notes, authority maps in workshop
> documents, deliberate antithesis, culture-specific rhetoric, technical terms
> that earn their precision, and a list whose elements are genuinely needed for
> play. Identify at least one likely false positive or edit to resist. The goal
> is not to make the prose look statistically human. It is to restore voice,
> specificity, surprise, and trust in the reader.
>
> Before diagnosing workshop-dialect leakage, trace the term's origin. Is it
> narrator default, a named school's or office's technical register, or one
> speaker's language? Diagnose diffusion across unrelated voices, not the token
> alone. Put recurrence or meaningful contrast under the report's Evidence
> field and the passage's retained function under Collateral risk.
