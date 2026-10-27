---
subject: Software Engineering 2
description: Map of content for Software Engineering 2 — the software production process, requirements engineering, UML modelling, the RASD artefact and Alloy formal verification
---

# Software Engineering 2

> [!summary] Overview
> The course follows one thread: why software must be **engineered** rather than merely programmed, how its **requirements** are discovered and made precise, and which **models and documents** carry that precision from the customer to the implementation. It starts from the production process — qualities, lifecycles, maintenance, V&V — then requirements engineering, then the modelling tools: UML for semi-formal structure and behaviour, the RASD as the specification deliverable, and Alloy for the formal analysis UML cannot provide.

## 1. Reading Path

1. [[Software Production]] — software qualities and ISO/IEC 25010, the intangible product, lifecycles from code-and-fix to waterfall and agile, maintenance, evolution, V&V.
2. [[Requirement Engineering]] — functional/non-functional/constraint requirements, elicitation, world versus machine, goals and domain assumptions, completeness as $R \land D \models G$.
3. [[UMLs]] — use case diagrams, requirements- and domain-level class diagrams, sequence/state machine/activity diagrams, and the limits of UML for assertions.
4. [[RASD]] — purpose as communication, contract and baseline; target qualities; ISO/IEC/IEEE 29148 structure; templates and review criteria.
5. [[Alloy]] — atoms and relations, signatures, facts, predicates, assertions, bounded verification, the temporal layer, and worked models.

## 2. Core Ideas

- **Multi-person, multi-version, multi-year**: engineering exists because programs outlive their authors and their assumptions.
- Qualities are not free — lifecycles are trade-offs between rigidity (waterfall) and the ability to absorb change (iterative, agile).
- **V&V**: verification asks whether we built the system right, validation whether we built the right system.
- Requirements are about the **world**, not only the machine: goals, domain assumptions and the completeness formula make that explicit.
- UML is **semi-formal** — good for communication, unable to *assert* properties; Alloy fills that gap with first-order logic over relations, checked within a bounded scope.

## 3. Gaps and next Steps

- No dedicated note on software **testing** or on project management, though both are referenced from [[Software Production]].
- [[RASD]] is a template and checklist; a worked RASD would show how the sections interact.
- [[Alloy]] is the longest note in the vault — use its checklist and exam-style examples before the written test.
