---
date: 22-10-2026
subject: Software Engineering 2
description:
---

# Definition

Requirement engineering is the process of discovering the pourpose of a system un order to implement it the closest to the needs of the user.

Example of requirement are: Accessibility, Responsiveness, Avability, Implementation, etc.

We can subdivide requirements in 3 types:
- Functioonal: describe the interactions between the system and its environment.
- Non-functional(NFR): characterization of user-visibble aspect not directly related to functions
- Constraint: imoosed by the customer or the environment

## NFR

 Constraint on how the functionality must be provided.

 > [!example] Es.1
 > “The system shall validate and accept credit cards and cashier’s check with high priority” 
 >
 > Issue(s)? 
 > - **Multiple concerns**: two requirements instead of one 
 > - **Ambiguous**: if the credit card processing works, but the cashier’s check validation does not, is this requirement satisfied? 
 > - **Ambiguous**: does “high priority” refer to cashier’s checks only, so are credit cards low priority? Other way around? Are they both high priority?

> [!example] Es.2
> “The system shall process all mouse clicks very fast to ensure users do not have to wait” 
>
> Issue(s)?
> - **Cannot be verified (tested)**: what does “fast” mean? Do we have a metric? Can you quantify it?

> [!example] Es.3
> “the user must have Adobe Acrobat installed” 
>
> Issue(s)? 
> - **Cannot be achieved by the software system itself**: it is not something the system must do 
> It could be expressed as a constraint or assumption, but it is not a functional requirement

# Issues

Requirements engineering can be misleading if too ubiquitous.
If error are made, to fix them can be one of the bigger cost in a software development, since design decision depend on them.
Is important to be Coherent and limit the Ambiguity or things left to interpretation

# Complexity

- Broad scope:
	- Composite systems 
		human organizations + physical devices + software components 
	- More than one system 
		alternative proposals for system-to-be, system evolutions, product family 
	- Multiple abstraction levels 
		high-level goals, operational details 
- Multiple concerns: 
	- functional, quality, development 
	- hard and soft concerns 
- Multiple stakeholders with different background 
	 customers, users, domain experts, developers,…

# Word and Machine

We can define as Machine the system to be developed and world the environment that affect it.
Requirement Engineering need to concerns with the  phenomena occurring in the World and model them in to the Machine

![[Requirement Engineering-1792684065345.webp|437]]

- Goals: Prescriptive assertions formmuylated in terms of the phenomena
- Assumption: Descriptive assertion assumed to hold in the world
- Requirements: Prescriptive assertion dormulaed in term if shared phenomena
 

# Completeness

Given a set of Requirements $R$, Goals $G$ and Domain $D$
$R$ is complete iff:
- $R$ ensure datisfaction of g in he context of domain assumption D
$$R \text{ and } D ⊨ G$$
- G capture all stakeholders needs
- D represent valid properties/assumption about the world

# Steps

1. Carry out domain analysis
	- Identify phenomena, in particular the shared ones -
	- Identify goals
	- Identify domain assumptions
2. Define Requirements
	Make sure that requirements are expressed using only shared phenomena
3. Prove that $R \text{ and } D ⊨ G$

In Particular: 
1. Finding the scenario:
	- Ask yourself or the client the following questions:
		- Which user groups are supported by the system to perform their work? 
		- What are the primary tasks that the system needs to perform? 
		- What data will the actor create, store, change, remove or add in the system? 
		- What external changes does the system need to know about? 
		- What changes or events will the actor of the system need to be informed about? 
	- However, don’t rely on questionnaires alone:
		- Insist on task observation if the system already exists (interface engineering or reengineering) 
		- Ask to speak to the end user, not just to the software contractor 
		- Expect resistance and try to overcome it
2. After the scenrio  is formmuylated
	- Generalize scenarios: 
		- Example: from “Warehouse on fire” we can generalize a “Report Emergency” use case 
	- Structure the description in terms of:
		- Participating actors
		- Describe the Entry Condition 
		- Describe the Flow of Events 
		- Describe the Exit Condition 
		- Describe Exceptions 
		- Describe Special Requirements (Constraints, Nonfunctional Requirements)

> [!tip] 
> - Use cases named with verbs that indicate what the user is trying to accomplish 
> - Actors named with nouns 
> - Use cases steps in active voice 
> - The causal relationship between steps should be clear 
> - A use case per user transaction
> - Separate description of exceptions 
> - Keep use cases small (no more than two/three pages) 
> - The steps accomplished by actors and those accomplished by the system should be clearly distinguished

![[Requirement Engineering-1792689051477.webp|608]]

# Modelling Tools

As a mean to model our system we can use:
- Natural Language:
	- Pros: 
		- simple
	- Cons: 
		- ambiguous and vague
- Formal language:
	- Pros: 
		- possibility to use tools to support analysis and validation
		- Needs to be specific an detailed
	- Cons: needs to be an expert
- Semi-formal Language(UML, etc.):
	- Pros:
		- Simpler than formal language
		- Impose some kind of structure in the models
	- Cons: 
		- Not as useful for automated analysis
		- Some level of ambiguity
- Mixed approach:
	- Semi-formal language for basics
	- Comment the semi-formal model with explanatory informal text
	- Use formal language for most critical parts

## UMLs

UMLs as already said are a type of semi-formal languages.
![[Requirement Engineering-1792687027582.webp|488]]
Use case:
- Flow of events in the system including interaction with actors
- It is initiated by an actor
- Each use case has a name
- Each use case has a termination condition.

Use Case **association**(relationship between use cases):
- Include: a use case ses another use case
- Extend: a use case extend another use case
- Generalization: abstract use case that has several different speculations

![[Requirement Engineering-1792687278152.webp|516]]

### Requirements-level Class Diagrams

Conceptual models for the application domain

They include entities that will not be represented in the software-to-be

Usually, no operations of the entities are modelled

### Domain-level Class Diagrams

![[Requirement Engineering-1792687690968.webp|467x250]]

### Dynamic Models

Dynamic models have the purpose to model the interactions, behavior of users and workflow

Considering a use-cases, we model:
- Interaction between objects— **sequence diagrams** 
- Dynamic behavior of single objects— **state machine diagrams**
- Workflow— **activity diagram**

#### Sequence Diagrams

Graphical description of objects participating in a use case or scenario using a DAG(directed acyclic graph) notation

Steps:
- Analyze the flow of **events** in a use case (or scenario) 
- Each event must have a **sender** and a **receiver** 
- The representation of the event is referred to as **message** in the sequence diagram notation 
- Sender and receiver are **objects** participating in the use-case

![[Requirement Engineering-1792688346409.webp|490]]

#### State Machine Diagrams

Capture the behavior of objects, instances of a class

![[Requirement Engineering-1792688315965.webp|564]]

| State diagram                                                  | Sequence diagram                                   |
| -------------------------------------------------------------- | -------------------------------------------------- |
| Focus on changes in an individual object over time             | Focus on the interaction between objects over time |
| Class-level documentation                                      | Instance-level documentation                       |
| We can infer many possible event and order-dependent behaviors | Shows one specific case or a subset of cases       |

#### Activity Diagrams

Describe an activity without assigning responsibilities
![[Requirement Engineering-1792688567096.webp|287]]![[Requirement Engineering-1792688584346.webp|222x276]]

| Sequence diagram                              | Activity diagram                           |
| --------------------------------------------- | ------------------------------------------ |
| Focus on object interaction                   | Focus on activities and flow of activities |
| Suited for describing an interaction protocol | Suited for describing a process            |

### Requirements Elicitation and Modeling with UMLs

![[Requirement Engineering-1792689091674.webp|589]]

---
Related: [[_Software Engineering 2 MOC]]
Source: [[02a.RE.pdf]]
