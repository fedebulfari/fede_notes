---
date: 22-10-2026
subject: Software Engineering 2
description:
---

# Requirement Engineering

**Definition** (Nuseibeh & Easterbrook, 2000): the primary measure of success of a software system is the degree to which it meets the purpose for which it was intended. RE is the process of *discovering that purpose*, by identifying stakeholders and their needs and documenting them in a form amenable to analysis, communication and implementation.

RE is not a one-shot phase: it starts in the feasibility study and requirements analysis & specification, but new requirements keep emerging during design, deployment and maintenance.

Requirements classify by kind — for example:

- Functional: "The system shall allow users to reserve taxis."
- NFR: "The system has to provide feedback in 5 seconds."
- Constraint: "The system must be implemented in Java."

Requirements fall into three types:

- **Functional**: describe the interactions between the system and its environment (independent of implementation).
- **Non-functional (NFR)**: characterize user-visible aspects that are not directly related to functions.
- **Constraint**: imposed by the customer or the environment.

## 1. NFR

Constraints on *how* the functionality must be provided.

- Must be **measurable through metrics**, otherwise they cannot be verified.
- Product qualities involved: performance efficiency, security, safety, reliability, maintainability, compatibility, interaction capability…
- The **application domain** determines their relevance and prioritization (Netflix vs. Ariane 5).
- They have a strong impact on the system structure: 24/7 availability ⇒ likely a replicated system with redundant components.

> [!example] Es.1
> "The system shall validate and accept credit cards and cashier's check with high priority"
>
> Issues:
> - **Multiple concerns**: two requirements in one.
> - **Ambiguous**: if credit card processing works but cashier's check validation does not, is the requirement satisfied?
> - **Ambiguous**: does "high priority" apply only to cashier's checks? To both? Are credit cards low priority?

> [!example] Es.2
> "The system shall process all mouse clicks very fast to ensure users do not have to wait"
>
> Issue:
> - **Cannot be verified (tested)**: what does "fast" mean? Is there a metric? Can it be quantified?

> [!example] Es.3
> "The user must have Adobe Acrobat installed"
>
> Issue:
> - **Cannot be achieved by the software system itself**: it is not something the system must do. It could be stated as a constraint or assumption, but it is not a functional requirement.

> [!example] Es.4
> "The search for the available taxi should be implemented in class Controller"
>
> Issue:
> - **Design, not a requirement**: it dictates the implementation instead of the observable behavior.

## 2. Issues

- Poor requirements are ubiquitous and need continuous review and revision (Bell & Thayer, 1976).
- The cost of correcting an error grows with the number of later decisions based on it (Boehm, 1981): relative cost goes from ~1 during requirements to ~50 after delivery. Requirements errors have the greatest potential cost, because many design decisions depend on them.
- Extracting and refining requirements iteratively is the hardest and most important function of software engineering (Brooks, 1987).
- ⇒ Be coherent and limit ambiguity or anything left to interpretation.

## 3. Complexity

- **Broad scope**
	- Composite systems: human organizations + physical devices + software components
	- More than one system: alternative proposals for the system-to-be, system evolution, product families
	- Multiple abstraction levels: high-level goals, operational details
- **Multiple concerns**
	- Functional, quality, development ⇒ conflicts
	- Hard and soft concerns
- **Multiple stakeholders** with different backgrounds: customers, users, domain experts, developers… ⇒ conflicts

## 4. World and Machine

- **Machine**: the portion of the system to be developed (software-to-be + hardware).
- **World** (environment): the portion of the real world affected by the machine.

The purpose of the machine is always in the world. RE deals with the phenomena occurring in the World and models them into the Machine — **requirement models are models of the world** (a new `Accident` object is a machine-only phenomenon, not a RE concern).

![[Requirement Engineering-1792684065345.webp|437]]

- **Goals**: prescriptive assertions formulated in terms of World phenomena (not necessarily shared).
- **Domain assumptions/properties**: descriptive assertions assumed to hold in the World.
- **Requirements**: prescriptive assertions formulated in terms of **shared** phenomena.

Since the purpose lives in the world, "the reserved taxi picks the user up" is not something the machine alone can guarantee.

## 5. Completeness

Given a set of Requirements $R$, Goals $G$ and Domain assumptions $D$, $R$ is complete iff:

$$R \land D \models G$$

- $R$ ensures satisfaction of $G$ in the context of domain assumptions $D$.
- $G$ captures all stakeholders' needs.
- $D$ represents valid properties/assumptions about the World.

Analogy with program correctness: program $P$ running on computer $C$ is correct if $P \land C \models R$.

> [!example] Case study: Airbus A320 (Warsaw, 1993)
> - Landing in bad weather, the software-controlled braking deployed **9 seconds after touchdown**; the runway was too short, the aircraft hit an embankment: 2 dead, 54 injured.
> - Goal $G$: reverse thrust enabled iff the aircraft is moving on the runway.
> - Domain assumptions $D$: wheel pulses on iff wheels turning; wheels turning iff moving on runway.
> - Requirement $R$: reverse thrust enabled iff wheel pulses on.
> - $R \land D \models G$ holds — yet the system failed, because **$D$ did not hold**: when aquaplaning the wheels stop turning while the aircraft is still moving, so reverse thrust stayed disabled.
> - Lesson: an invalid/incomplete domain assumption silently breaks the correctness argument; the weaker or wrong $D$, the more dangerous the "proof".

## 6. Steps

1. **Carry out domain analysis**
	- Identify phenomena, in particular the shared ones.
	- Identify goals.
	- Identify domain assumptions.
2. **Define requirements**
	- With an eye to the goals to be achieved.
	- Express them using only shared phenomena.
3. **Prove that $R \land D \models G$**

The point of the whole activity is to explore alternatives — different World/Machine interfaces and different $(R, D)$ pairs satisfying the same $G$ — and to evaluate their strengths and risks.

### 6.1. Elicitation: Scenarios and Use Cases

Why it is hard (e.g. loan-approval rules): **implicit knowledge** (rules never written down, or docs ambiguous/outdated), **conflicting information** (people disagree), **bias** (fear of being replaced), **probe effect** (observed behavior differs from normal). Coping: combine listening, observing, studying; stay close to stakeholders; let them describe their own viewpoints.

A **scenario** is a concrete, focused, informal narrative of a *single instance* of using the system (e.g. "warehouse on fire": Bob spots the fire, Alice reports address/level and requests units, John acknowledges and allocates, Alice gets the ETA). It names concrete actors and does not cover all possible situations.

**Finding the scenario** — ask yourself or the client:

- Which user groups are supported by the system in performing their work?
- What are the primary tasks the system must perform?
- What data will the actor create, store, change, remove or add?
- What external changes does the system need to know about?
- What changes or events must the actor of the system be informed about?

Don't rely on questionnaires alone:

- Insist on task observation if the system already exists (interface engineering or reengineering).
- Ask to speak to the end user, not just the software contractor.
- Expect resistance and try to overcome it.

**After the scenario is formulated** — generalize it (e.g. from "Warehouse on fire" derive a "Report Emergency" use case) and structure the description in terms of:

- Participating actors (generalize "Bob" to FieldOfficer)
- Entry condition ("when the use case starts, …")
- Flow of events (informal natural language, active voice)
- Exit condition ("the use case terminates when …")
- Exceptions
- Special requirements (constraints, NFRs)

> [!warning] Poor use case
> Name "Accident" (not a verb), the Dispatcher actor is missing although it appears in the flow, and steps have no clear subject ("an ambulance is dispatched" — by whom?).

> [!tip]
> - Name use cases with verbs indicating what the user is trying to accomplish.
> - Name actors with nouns.
> - Write use case steps in active voice.
> - Make the causal relationship between steps clear.
> - One use case per user transaction.
> - Describe exceptions separately.
> - Keep use cases small (no more than two/three pages).
> - Clearly distinguish steps done by actors from steps done by the system — it helps identify the system boundary.

![[Requirement Engineering-1792689051477.webp|608]]

**Use cases and requirements**: each use case may lead to one or more requirements (e.g. "FRIEND must have a response time lower than 30 seconds"), and from requirements new, more detailed use cases can be derived.

## 7. Modelling Tools

A model is "a representation in a certain medium of something in the same or another medium; it captures the important aspects of the thing being modeled and simplifies or omits the rest" (Booch). A model is *good* when an interpretation $I$ maps reality to the model while preserving the relationships that hold in reality.

- **What to model in RE**: the objects and people of interest for the problem, the relevant phenomena, the goals, requirements and domain assumptions.
- **Modelling issues**: different views must stay **coherent**; some **ambiguity** is unavoidable, so state where alternative interpretations are acceptable.

Tools:

- **Natural language**
	- Pros: simple.
	- Cons: ambiguous and vague; easy to forget relevant information.
- **Formal language** ([[Alloy]], Z, first-order logic, etc.)
	- Pros: supports tool-based analysis and validation; forces specifying all relevant details.
	- Cons: requires an expert.
- **Semi-formal language** ([[UMLs]])
	- Pros: simpler than formal; imposes some structure on models.
	- Cons: not amenable to automated analysis; some ambiguity remains.
- **Mixed approach**
	- Semi-formal language for the basics.
	- Annotate and complement the semi-formal model with explanatory informal text.
	- Formal language for the most critical parts.

We can also help ourselves using [[RASD]].

---
Related: [[_Software Engineering 2 MOC]]
Sources: [[02a.RE.pdf]], [[02b.video1_ElicitationOfRequirements.pdf]], [[02c.ExampleScenarioUCReqs.pdf]], [[02d.video2_ModelingReqs.pdf]]
