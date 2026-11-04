---
date: 03-11-2026
subject: Database2
description:
---

# Concurrency

> [!tip] DBMS Architecture
![[Concurrency Control-1793717237862.webp|447x279]]

In DBs concurrency is fundamental, since the system should manage tens of thousands transactions per second.

Differently to a serial execution, where multiple transitions are executed one by one, in concurrent execution the parallel execution of the transactions can cause miss-behaviour of the system. 

The Concurrency Control System manage the simultaneous execution of multiple transitions while avoiding anomalies and ensuring performance.

> [!info] Definitions
> - **Model**: abstraction of a system/object/process disregarding some details to simplify the research of relevant properties
>
> - **Operation**: read or write of a specific datum by a specific transaction
>
> - **Schedule**: sequence of operations performed by concurrent transactions that respects the order of operations of each transaction
> 	- **Scheduler**: a component that accepts or rejects the operations requested by the transactions
> 	- **Serial schedule**: a schedule in which the actions of each transaction occur in a contiguous sequence
> 		- **Serializable schedule**: non-serial schedule that leaves the db in the same state of a serial schedule

The **goal** of Concurrency Control Systems is to reject all schedules that cause anomalies.

## 1. Transactions

Transaction are elementary, atomic unit of work performed by an application

Each transaction is conceptually encapsulated within two commands:
- Begin transaction
- Commit-work/Rollback-work

> [!info] Transactional System (OLTP)
> A Transactional System is a system that manage the execution of transactions on behalf of the concurrent application

![[Concurrency Control-1793717543038.webp|367]]

### 1.1. ACID Properties

A Transaction must be:
- Atomic
	- A **Commit** marks the end of the transaction, an error should invoke a rollback
	- A **Rollback** is used in case it is called or it the is a violation of the integrity constraints
- Consistent: 
	- A transaction must preserve db integrity 
	- Integrity is checked at the end of each SQL statement but can be postponed(if declared Deferrable) until commit
- Isolated: The execution of a transaction must be independent of the concurrent execution of other transactions, therefore must produce the same result as the execution of the same transactions in a sequence
- Durable: The effect of a transaction that has successfully committed will last "forever"
![[Transactions-1793811026347.webp|450]]

## 2. Anomalies

- **Lost update** — `r1 - r2 - w2 - w1`
	- An update is applied from a state that ignores a preceding update, which is lost
- **Dirty read** — `r1 - w1 - r2 - abort1 - w2`
	- An uncommitted value is used to update the data
- **Nonrepeatable read** — `r1 - r2 - w2 - r1`
	- Someone else updates a previously read value
- **Phantom update** — `r1 - r2 - w2 - r1`
	- Someone else updates data that contributes to a previously valid constraint
- **Phantom insert** — `r1 - w2(new data) - r1`
	- Someone else inserts data that contributes to a previously read datum

## 3. Concurrency Theory vs System Implementation

---
Related: [[_Database2 MOC]]
Source: