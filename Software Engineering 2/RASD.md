---
date: 23-10-2026
subject: Software Engineering 2
description:
aliases:
---

# RASD

The purpose of RASD (_Requirements Analysis and Specification Document_) is to:

- **Communicate** an understanding of the requirements — it explains both the application domain and the system to be developed.
- Act as a **contract** with the customers — it may be **legally binding**.
- Define a **baseline** for other activities:
	- _Project planning and estimation_ — size, cost, schedule.
	- _Software V&V_ — it must contain enough information to verify whether the delivered system meets the requirements (supports system testing).
	- _Change control_ — requirements change, software evolves.

Audience:

| Audience                       | What they look for                                                                            |
| ------------------------------ | --------------------------------------------------------------------------------------------- |
| Customers & Users              | Validation of goals and of the high-level description of functions, not detailed requirements |
| System / Requirements Analysts | Specifications of other, inter-related systems                                                |
| Developers & Programmers       | The requirements they will implement                                                          |
| Quality Assurance              | Evidence that the requirements have been met                                                  |
| Project Managers               | Measures to control the analysis and development processes                                    |

## 1. Target Qualities

- **Completeness**
	- _w.r.t. goals_: $Req \land Dom \models Goals$ — requirements suffice to satisfy the goals under the domain assumptions; all goals (including quality goals) are identified and $Dom$ holds (incidental and malicious behaviours anticipated).
	- _w.r.t. inputs_: the required behaviour is specified for every possible type of input.
	- _w.r.t. structure_: no TBDs left in the document.
- **Precision**: level of detail sufficient for design, development and verification of the release.
- **Pertinence**: each requirement/assumption is needed for some goal, each goal is needed by stakeholders, and no design or implementation decisions sneak in.
- **Consistency**: no contradiction among goals, requirements and assumptions.
- **Unambiguity**
	- _vocabulary_: every term is defined and used consistently.
	- _assertions_: goals, requirements and assumptions admit a single interpretation.
	- _responsibilities_: the split between software-to-be and environment is explicit.
	- _verifiability_: a process exists to test satisfaction of each requirement.
- **Feasibility**: technically realizable within budget and schedule.
- **Comprehensibility**: understandable by the whole target audience.
- **Good Structuring**: highlights links between goals, requirements and assumptions; every item is defined before it is used.
- **Modifiability**: adapt/extend/contract through local modifications, with easily assessable impact.
- **Traceability**: sources of goals, requirements and assumptions are indicated, requirements/assumptions are linked to goals, and items can be referenced by later documents (design, test cases).

## 2. RASD Structure Summary

> [!Example] Possible structure
> ![[Requirement Engineering-1792747000099.webp|630x296]]
> ![[Requirement Engineering-1792747110337.webp|439x175]]
>
> Reference standard: ISO/IEC/IEEE 29148 (Nov 2018).

1. INTRODUCTION 
	1. Purpose: the goals of the project (why the product exists)
	2. Scope: analysis of the world, of the shared phenomena, plus the system's relationship to other products and its external interfaces
	3. Definitions, Acronyms, Abbreviations 
	4. Revision history
	5. Reference Documents 
	6. Document Structure
2. OVERALL DESCRIPTION 
	1. Product perspective: scenarios, further details on the shared phenomena, and a domain model (possibly class and state diagrams)
	2. Product functions: the most important requirements / use cases
	3. User characteristics: anything relevant to clarify their needs (including factors that may influence usability)
	4. Assumptions, dependencies and constraints: domain assumptions and anything limiting the developer's options (regulations, reliability, criticality, hardware limitations, interfaces)
3. SPECIFIC REQUIREMENTS: more details on all aspects of Section 2, if useful for the development team.
	1. External Interface Requirements 
		- User Interfaces
		- Hardware Interfaces 
		- Software Interfaces 
		- Communication Interfaces 
	2. Functional Requirements: use case diagrams, use cases with sequence and activity diagrams, and mapping on requirements
		- Cover validity checks, sequence of operations, responses to abnormal situations (overflow, failures, error handling), effect of configuration parameters, input/output relationships.
		- Organize hierarchically by mode, user class or feature: satisfaction of lower-level requirements must guarantee satisfaction of the parent one (**closure property**).
	3. Performance Requirements
	4. Design Constraints 
		- Standards compliance (domain-specific standards, regulatory documents)
		- Hardware limitations
		- Any other constraint / project limitation 
	5. Software System Attributes (all high-priority NFRs, grouped by type)
		- Reliability 
		- Availability
		- Security 
		- Maintainability
		- Portability
	6. Supporting information: sample input/output formats, background material, description of the problems to be solved
4. FORMAL ANALYSIS USING ALLOY: 
	- Brief presentation of the main objectives driving the formal modeling activity 
	- The model itself 
	- What can be verified with it, why what is verified is important given the problem at hand 
	- To show the soundness and correctness of the model, this section can show some worlds obtained by running it, and/or the results of the checks performed on meaningful assertions
5. EFFORT SPENT: the number of hours each group member has worked on this document 
6. REFERENCES

### 2.1. Writing Requirements

Templates:

$$\text{[Subject][Action][Constraint of Action]} \quad \text{or} \quad \text{[Condition][Subject][Action][Object][Constraint of Action]}$$

> [!example]
> "The system **shall display** resources in ascending order of identifier." → _[Subject][Action][Constraint of Action]_
>
> "**When the system receives a new position from an ambulance**, the system **shall update** the recorded ambulance position **within 2 seconds**." → _[Condition][Subject][Action][Object][Constraint of Action]_

### 2.2. Traceability

Use cases relate to requirements through stable identifiers (e.g. RE.3 ↔ UC.3.1 and UC.3.2; UC.3.1 may also refer to RE.2). Make this explicit, typically with a matrix that grows during development:

| Raw ID | Goal ID | Req ID | Use Case ID | Test case ID | Comments |
|---|---|---|---|---|---|
| r1 | G.1 | RE.3 | UC.3.1 | TC.3.1.1 | |
| r2 | G.1 | RE.2 | UC.3.1 | | |

## 3. Reviewing a RASD

Focus on **content rather than structure**, and judge the document against the target qualities of Section 1.

1. **Ambiguities and hidden assumptions** — for each, say what makes it unclear and propose a revised, precise sentence.
2. **Impact of weaknesses** — imagine leaving each one uncorrected:
	- How does it affect developers' understanding?
	- What risks for the final outcome and user satisfaction?
	- How does it impact cost or timelines?
3. **Inconsistencies and contradictions** — in requirements, terminology or descriptions; report and suggest how to align the sections.
4. **Overall improvements** — 2–3 general suggestions on structure and readability of the whole document.

---
Related: [[_Software Engineering 2 MOC]]
Sources: [[02g.CreatingRASD.pdf]], [[02h.RASD_lab_DiNItto.pdf]]
