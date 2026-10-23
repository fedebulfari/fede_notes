---
date: 22-10-2026
subject: Software Engineering 2
description:
---

# Requirement Engineering

Requirement engineering is the process of discovering the pourpose of a system un order to implement it the closest to the needs of the user.

Example of requirement are: Accessibility, Responsiveness, Avability, Implementation, etc.

We can subdivide requirements in 3 types:
- Functioonal: describe the interactions between the system and its environment.
- Non-functional(NFR): characterization of user-visibble aspect not directly related to functions
- Constraint: imoosed by the customer or the environment

## 1. NFR

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

# 1. Issues

Requirements engineering can be misleading if too ubiquitous.
If error are made, to fix them can be one of the bigger cost in a software development, since design decision depend on them.
Is important to be Coherent and limit the Ambiguity or things left to interpretation

# 2. Complexity

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

# 3. Word and Machine

We can define as Machine the system to be developed and world the environment that affect it.
Requirement Engineering need to concerns with the phenomena occurring in the World and model them in to the Machine

![[Requirement Engineering-1792684065345.webp|437]]

- Goals: Prescriptive assertions formmuylated in terms of the phenomena
- Assumption: Descriptive assertion assumed to hold in the world
- Requirements: Prescriptive assertion dormulaed in term if shared phenomena
 

# 4. Completeness

Given a set of Requirements $R$, Goals $G$ and Domain $D$
$R$ is complete iff:
- $R$ ensure datisfaction of g in he context of domain assumption D
$$R \text{ and } D ⊨ G$$
- G capture all stakeholders needs
- D represent valid properties/assumption about the world

# 5. Steps

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
2. After the scenario is formmulated
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

# 6. Modelling Tools

As a mean to model our system we can use:
- Natural Language:
	- Pros: 
		- simple
	- Cons: 
		- ambiguous and vague
- Formal language([[Alloy]], Z, first order logic, etc.):
	- Pros: 
		- possibility to use tools to support analysis and validation
		- Needs to be specific an detailed
	- Cons: needs to be an expert
- Semi-formal Language([[UMLs]]):
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

We can also help ourselves using [[RASD]]

---
Related: [[_Software Engineering 2 MOC]]
Sources: [[02a.RE.pdf]], [[02b.video1_ElicitationOfRequirements.pdf]], [[02c.ExampleScenarioUCReqs.pdf]], [[02d.video2_ModelingReqs.pdf]]