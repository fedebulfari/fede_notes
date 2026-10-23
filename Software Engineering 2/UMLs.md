---
date: 23-10-2026
subject: Software Engineering 2
description:
---

# UMLs

UMLs as already said are a type of semi-formal languages.
![[Requirement Engineering-1792687027582.webp|488]]
Use case:
- Flow of events in the system including interaction with actors
- It is initiated by an actor
- Each use case has a name
- Each use case has a termination condition.

Use Case **association**(relationship between use cases):
- Include: a use cases as another use case
- Extend: a use case extend another use case
- Generalization: abstract use case that has several different speculations

![[Requirement Engineering-1792687278152.webp|516]]

## 1. Requirements-level Class Diagrams

Conceptual models for the application domain

They include entities that will not be represented in the software-to-be

Usually, no operations of the entities are modelled

## 2. Domain-level Class Diagrams

![[Requirement Engineering-1792687690968.webp|467x250]]

## 3. Dynamic Models

Dynamic models have the purpose to model the interactions, behavior of users and workflow

Considering a use-cases, we model:
- Interaction between objects— **sequence diagrams** 
- Dynamic behavior of single objects— **state machine diagrams**
- Workflow— **activity diagram**

### 3.1. Sequence Diagrams

Graphical description of objects participating in a use case or scenario using a DAG(directed acyclic graph) notation

Steps:
- Analyze the flow of **events** in a use case (or scenario) 
- Each event must have a **sender** and a **receiver** 
- The representation of the event is referred to as **message** in the sequence diagram notation 
- Sender and receiver are **objects** participating in the use-case

![[Requirement Engineering-1792688346409.webp|490]]

### 3.2. State Machine Diagrams

Capture the behavior of objects, instances of a class

![[Requirement Engineering-1792688315965.webp|564]]

| State diagram                                                  | Sequence diagram                                   |
| -------------------------------------------------------------- | -------------------------------------------------- |
| Focus on changes in an individual object over time             | Focus on the interaction between objects over time |
| Class-level documentation                                      | Instance-level documentation                       |
| We can infer many possible event and order-dependent behaviors | Shows one specific case or a subset of cases       |

### 3.3. Activity Diagrams

Describe an activity without assigning responsibilities
![[Requirement Engineering-1792688567096.webp|287]]![[Requirement Engineering-1792688584346.webp|222x276]]

| Sequence diagram                              | Activity diagram                           |
| --------------------------------------------- | ------------------------------------------ |
| Focus on object interaction                   | Focus on activities and flow of activities |
| Suited for describing an interaction protocol | Suited for describing a process            |

## 4. Requirements Elicitation and Modeling with UMLs

![[Requirement Engineering-1792689091674.webp|589]]



---
Related: [[_Software Engineering 2 MOC]]
Source: [[02e.UML4RE.pdf]]