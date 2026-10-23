---
date: 23-10-2026
subject: Software Engineering 2
description:
---

# UMLs

UMLs, as already said, are a type of semi-formal language: they impose structure but are not amenable to automated analysis, and some ambiguity remains. Their models and views are split into **static** (class, object, component, deployment) and **dynamic** (use case, state, sequence/scenario, collaboration, activity) diagrams.
![[Requirement Engineering-1792687027582.webp|488]]

Use case:
- Flow of events in the system including interaction with actors
- It is initiated by an actor (a human, an external system, …)
- Each use case has a name
- Each use case has a termination condition

The **UML Use Case Model** (or diagram) is the set of **all** use cases, specifying the complete functionality of the system.

Use Case **association** (relationship between use cases):
- **Include**: a use case *uses* another use case (functional decomposition — the included one is always executed)
- **Extend**: a use case *extends* another use case (additional behaviour inserted at an extension point, under a condition)
- **Generalization**: an abstract use case has several different specializations (the specialized one inherits and refines the base one)

![[Requirement Engineering-1792687278152.webp|516]]

## 1. Requirements-level Class Diagrams

- Conceptual models for the application domain — **different from OO software design models**.
- They may include entities that will **not** be represented in the software-to-be.
- Implementation follows requirement modelling ⇒ implementation details are still unknown.
- Usually, no operations (methods) of entities are modelled; sometimes high-level functions of the system are useful. Detailed operations are postponed to software design.

### 1.1. Deriving the Model: noun–verb Analysis

- **Nouns** may represent: domain entities (classes), specializations (subclasses), attributes (data).
- **Verbs** may represent: associations between classes, operations.

> [!example] AuctionManager
> "Each auction involves a batch of items, which are bid upon one by one…" ⇒ `Auction 1 — 1..* Item`, `Item 1 — * Bid`, `Bid concerns Item`.
>
> Note: `Bid` is not just an association, because the description gives it its own characteristics (an amount of money, who placed it…), so it becomes an entity.

## 2. Domain-level Class Diagrams

Same conceptual model, applied to a fuller case (Trip Tracker: routes, stops, problems, subscriptions, notifications).

![[Requirement Engineering-1792687690968.webp|467x250]]

- **Domain-level** diagram: only the entities of the world.
- **Domain-level diagram with system**: the system-to-be is added as an entity, to show which domain entities it interacts with and how — a first, coarse view of the S2B/environment boundary.

## 3. Dynamic Models

Purpose: model the interactions, the behaviour of participants and the workflow. Starting from a use case or a scenario:
- Interaction between objects — **sequence diagrams** 
- Dynamic behavior of single objects — **state machine diagrams**
- Workflow — **activity diagram**

### 3.1. Sequence Diagrams

Graphical description of objects participating in a use case or scenario, using a DAG (directed acyclic graph) notation.

Steps:
- Analyze the flow of **events** in a use case (or scenario) 
- Each event must have a **sender** and a **receiver** 
- The representation of the event is referred to as **message** in the sequence diagram notation 
- Sender and receiver are **objects** participating in the use case

Notes:
- Objects/classes have already been identified during object modelling; other objects may emerge from dynamic modelling.
- Different views must stay **consistent**.

![[Requirement Engineering-1792688346409.webp|490]]

> [!warning] Common mistake
> Drawing reply/return messages as ordinary (solid) messages: replies are dashed arrows, and a sequence diagram must respect the ordering and dependencies of the events it models.

### 3.2. State Machine Diagrams

Capture the behavior of the objects that are instances of a certain class (e.g. the `Problem` entity of Trip Tracker).

![[Requirement Engineering-1792688315965.webp|564]]

| State diagram                                                  | Sequence diagram                                   |
| -------------------------------------------------------------- | -------------------------------------------------- |
| Focus on changes in an individual object over time             | Focus on the interaction between objects over time |
| Class-level documentation                                      | Instance-level documentation                       |
| We can infer many possible event and order-dependent behaviors | Shows one specific case or a subset of cases       |

### 3.3. Activity Diagrams

Describe an activity without assigning responsibilities; used to highlight important processes (e.g. "register on the web", showing the steps of the student and of the system).

Notation: starting point, decision, merge, fork, join, ending point.

![[Requirement Engineering-1792688567096.webp|287]]![[Requirement Engineering-1792688584346.webp|222x276]]

| Sequence diagram                              | Activity diagram                           |
| --------------------------------------------- | ------------------------------------------ |
| Focus on object interaction                   | Focus on activities and flow of activities |
| Suited for describing an interaction protocol | Suited for describing a process            |

## 4. Requirements Elicitation and Modeling with UMLs

Goals, use cases, scenarios and phenomena feed the **domain assumptions**, and together they produce the requirements models.

![[Requirement Engineering-1792689091674.webp|589]]

Which diagram answers which question:

| Question | Diagram |
|---|---|
| What are the input/output transformations? | Use case diagram and use cases (from scenarios) |
| What is the structure of the world? | Class diagram (static view) — entities, associations, multiplicities, attributes, high-level operations |
| Is there any state change in an object to be defined explicitly? | State machine diagram (class behaviour) |
| How is the expected interaction S2B–environment? | Sequence diagram (from use cases) — senders, receivers, sequence, dependencies, concurrency |
| Which processes must be highlighted? | Activity diagram (workflow) |

> [!warning] UML is not enough (Airbus braking logic)
> With UML we described all phenomena (aircraft, wheels, sensor, reverse thrust system) and a use case `EnablingReverseThrust`. But we cannot express the **goal** (`Reverse_enabled ⇔ Moving_on_runway`), the **domain properties** (`Wheel_pulses_on ⇔ Wheels_turning`, `Wheels_turning ⇔ Moving_on_runway`) or the **requirement** (`Reverse_enabled ⇔ Wheel_pulses_on`).
>
> Pure UML does not help in expressing **assertions**: models must be complemented with a formal or informal description of them (see [[Requirement Engineering]] §5 and [[Alloy]]).

---
Related: [[_Software Engineering 2 MOC]]
Source: [[02e.UML4RE.pdf]]
