---
date: 21-10-2026
subject: Software Engineering 2
description:
---

# Software Production

Software is everywhere: our society is totally dependent on software-intensive systems (healthcare, transportation, energy, manufacturing), so failures cannot be tolerated — yet they still happen. E.g. the **worldwide IT outage of 19 July 2024**: a CrowdStrike update crashed ~8.5 million Windows devices, hitting airlines and airports, healthcare, media, banks and stock exchanges, F1 teams and the Paris 2024 committee — caused by an *array out of bounds read*.

**Software engineering**: the field of computer science dealing with software systems that are

- large and complex
- built by teams
- existing in many versions
- lasting many years
- undergoing changes

⇒ in short, **multi-person construction of multi-version software**.

**Programming skills are not enough**:

| Programmer | Software engineer |
|---|---|
| Develops a complete program | Identifies requirements and develops specifications |
| Works on known specifications | Designs a component to be combined with other components, developed, maintained, used by others — possibly part of several systems |
| Works individually | Collaborates in a team to ensure the component shows adequate qualities |

Required skills: technical, project management, cognitive, enterprise organization, interaction with different cultures, domain knowledge. The quality of human resources is of primary importance.

The software **product** is different from traditional products since it is **intangible**, **malleable** and **human intensive** (it does not have a trivial manufacturing process), and it is difficult to describe and evaluate. Process quality, product quality and people quality all affect cost, time and schedule.

## 1. Software Qualities

![[Software Production-1792573752883.webp|565]]

ISO/IEC 25010:2023 product quality model — nine top-level characteristics, each refined into sub-characteristics: functional suitability, performance efficiency, compatibility, interaction capability, reliability, security, safety, maintainability, flexibility (e.g. reliability = faultlessness, availability, fault tolerance, recoverability; maintainability = modularity, reusability, analyzability, modifiability, testability).

- **Productivity**: ability to produce a good amount of product.  
	Measured in Delivered Items by unit of effort — lines of code (and variations), function points, person-months.

- **Timeliness**: ability to respond to change requests in a timely fashion
	![[Software Production-1792573944598.webp|394x290]]

## 2. Software Lifecycles

1. Initially no reference model: just **code & fix**
2. After some time, the **waterfall** model, to fix the many problems:
	- identify phases and activities 
	- force linear progression from a phase to the next 
	- no returns (they are harmful) 
	- better planning and control 
	- standardize outputs (artifacts) from each phase 
	- Software like manufacturing
3. Flexible processes: iterative models, agile methods, DevOps
![[Software Production-1792665006106.webp|451]]

> [!info] Waterfall organization
> **High phases**: feasibility study, requirements analysis & specification, design.
> **Low phases**: coding & unit test, integration & system test, deployment, maintenance.
> ![[Software Production-1792663351942.webp|510x238]]
>
> Effort distribution (van Vliet 2008): requirements engineering 10%, specification 10%, design 15%, coding 20%, **V&V 45%**.

### 2.1. Maintenance

- Corrective: repair faults or defects found (≈20%)
- Evolution:
	- Adaptive: adapt the software to changes in the environment — hardware, OS, business rules, policies (≈20%)
	- Perfective: accommodate new or changed user requirements (≈50%)
	- Preventive: increase the system's maintainability (≈10%)

> [!note] Correction vs evolution
> The distinction can be unclear, because specifications are often incomplete and ambiguous — and specs are often part of a **contract** between developer and customer. Freezing specs early is problematic: they are more likely to be wrong.

### 2.2. Software Evolution

Since it is (almost) never anticipated and planned, it can cause disasters: software is very easy to change, so under emergency changes are applied directly to the code, leading to an inconsistent state of project documents.

Therefore it is good practice to:
- first modify the design, then change the implementation
- apply changes consistently in all documents

Changes must be anticipated and software must be designed to accommodate changes in a cost-effective way — this is one of the **main goals of software engineering**.

#### 2.2.1. Validation and Verification

Waterfall is a **black box**: informal requirements specification in, product out. The organization must be as transparent as possible, to allow early checks and changes via feedback.
- **Verification**: *"are we doing the **product right**?"*
- **Validation**: *"are we making the **right product**?"*

#### 2.2.2. Flexible Process

The main goal of having a flexible process is to adapt to changes (especially in requirements and specifications), therefore the stages are not necessarily sequential and processes become iterative and incremental.

> [!example] Es.
> Phases become **interdependent** and **partially overlapping**: requirements analysis & specification ↔ implementation & testing, design ↔ production, feasibility study ↔ deployment & disposal.
> ![[Software Production-1792664749342.webp|478]]

There are many forms of flexible process — effective in dynamic contexts (many changes per week, web-based and mobile applications):
- eXtreme Programming (XP) 
- SCRUM 
- DevOps
- etc.

---
Related: [[_Software Engineering 2 MOC]]
Source: [[01.IntroSE.pdf]]
