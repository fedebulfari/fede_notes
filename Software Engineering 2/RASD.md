---
date: 23-10-2026
subject: Software Engineering 2
description:
aliases:
---

# RASD

The purpose of RASD (_Requirements Analysis and Specification Document_) is to **Communicate** an understanding of the requirements, making a **Contractual** binding with the customers, defining a **Baseline** for other activities as project planning, software verification and validation, change control

Audience:
- Customers and Users
- System Analysts and Requirement Analysts
- Developers and Programmers
- Quality Assurance teams
- Project Managers

> [!Example] Possible structure
> ![[Requirement Engineering-1792747000099.webp|630x296]]
 ![[Requirement Engineering-1792747110337.webp|439x175]]
 >
> Templates could be:
> $$\text{[Subject][Action][Constraint of Action]}\\ or \\ \text{[Condition][Subject][Action][Object][Constraint of Action]}$$

## 1. Target Qualities

- Completeness
- Precision
- Pertinence
- Consistency
- Unambiguity
- Feasibility
- Comprehensibility
- Good Structuring
- Modifiability
- Traceability

## 2. RASD Structure Summary

1. INTRODUCTION 
	1. Purpose: here we include the goals of the project 
	2. Scope: here we include the analysis of the world and of the shared phenomena 
	3. Definitions, Acronyms, Abbreviations 
	4. Revision history
	5. .Reference Documents 
	6. Document Structure
2. OVERALL DESCRIPTION 
	1. Product perspective: here we include scenarios and further details on the shared phenomena and a domain model, possibly expressed through class diagrams and state diagrams
	2. Product functions: here we include the most important requirements / use cases 
	3. User characteristics: here we include anything that is relevant to clarify their needs
	4. Assumptions, dependencies and constraints: here we include domain assumptions
3. SPECIFIC REQUIREMENTS: Here we include more details on all aspects in Section 2 if they can be useful for the development team.
	1. External Interface Requirements 
		- User Interfaces
		- Hardware Interfaces 
		- Software Interfaces 
		- Communication Interfaces 
	2. Functional Requirements: use case diagrams, use cases and related sequence and activity diagrams, and mapping on requirements 
	3. Performance Requirements
	4. Design Constraints 
		- Standards compliance 
		- Hardware limitations
		- Any other constraint 
	5. Software System Attributes 
		- Reliability 
		- Availability
		- Security 
		- Maintainability 
		- Portability
 4. FORMAL ANALYSIS USING ALLOY: 
	- Brief presentation of the main objectives driving the formal modeling activity 
	- The model itself 
	- What can be verified with it, why what is verified is important given the problem at hand 
	- To show the soundness and correctness of the model, this section can show some worlds obtained by running it, and/or the results of the checks performed on meaningful assertions
5. EFFORT SPENT: In this section you will include information about the number of hours each group member has worked for this document 
6. REFERENCES

---
Related: [[_Software Engineering 2 MOC]]
Source: [[02g.CreatingRASD.pdf]]