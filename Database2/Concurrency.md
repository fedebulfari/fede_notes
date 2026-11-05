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
> - Anomalie: state that no serial execution would produce

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

## 3. Principles of Concurrency Control

We start from the assumption that transactions are observed “a-posteriori” and limited to those that have committed, from that the scheduler decide(while transactions are running) whether the observed schedule is admissible.

![[Concurrency-1793888169789.webp|379]]

### 3.1. Schedules

For $n$ transactions exist $N_{s}$ serial schedules, where:
$$
N_{s}=n!
$$
For $n$ transactions exist $N_{d}$ distinct schedules, where:
$$
N_{d}=\frac{\left( \sum^n_{i=1}k_{i} \right)!}{\prod^n_{i=0}(k_{i}!)}
$$
> [!info] Definitions
> - $r_i(x)$ reads-from $w_j(x)$ in a schedule $S$ when $w_j(x)$ precedes $r_i(x)$ and there is no $w_k(x)$ in $S$ between $w_j(x)$ and $r_i(x)$ 
> - $w_i(x)$, in a schedule $S$, is a final write if it is the last write on $x$ that occurs in $S$

Two schedules are **view-equivalent** ($S_i ≈_{v} S_j$) if they have:
1. Same operations
2. Same reads-from relationship
3. Same final writes

Determining view-equivalence has a polynomial time complexity

A schedule is **view-serializable** if it is **view-equivalent** to a serial schedule of the same transactions

> [!Important] VSR
> The class of **view-serializable** schedules is called VSR

Since determining VSR is an NP-complete problem we can define a stricter VSR group so that we can improve performance loosing some accuracy.
![[Concurrency-1793890649691.webp|461]]

#### 3.1.1. Conflict-serializability

> [!info] Conflict
> Two operations $o_i$ and $o_j$ $(i ≠ j)$ are in conflict if they address the same resource and at least one of them is a write

Two schedules are **conflict-equivalent** $(S_i ≈_C S_j)$ if $S_i$ and $S_j$ contain the same operations and in all the conflicting pairs the transactions occur in the same order.

A schedule is **conflict-serializable** iff it is **conflict-equivalent** to a serial schedule of the same transactions

> [!Important] CSR
> The class of **conflict-serializable** schedules is named **CSR**

Where: 
$$
\text{CRM} \subset \text{VSR}  
$$
![[Concurrency-1793891200929.webp|445]]

##### Conflict-serializability

We can verify conflict-serializability with conflict graphs:
- One node per transaction
- One arc per conflict between two operations of two transactions 

![[Concurrency 2026-11-05 16.11.24.excalidraw|200]]

> [!Important] Theorem
> A schedule is in CSR if and only if its conflict graph is acyclic

> [!Example] Es.
> ![[Concurrency-1793891610307.webp|504x256]]

This would be perfect if the graph was known prior the execution. Since this isn’t the case the scheduler need to work “online”, tho is not feasible to maintain the conflict graph, update it, and check its acyclicity at each operation request.

Concurrency Control can not work only with the commit-projection of the schedule is unrealistic, aborts do occur.

#### 3.1.2. Arrival Sequences

The notation “$r_{1}(x)w_{2}(x)w_{1}(x)w_{3}(x)$” used so far, represent an **a posteriori view**

When dealing with “online” concurrency control, it is important also to consider **arrival sequences**, i.e., sequences of operation requests emitted in order by transactions

For simplicity, with an abuse of annotations we use the same notation as for **a posteriori view**

## 4. Concurrency Control Approaches

In order to implement concurrency control “online” there are two major families of techniques:
- Pessimistic: Based on locks, if a resource is taken, make the requester wait or preempt the holder — i.e., resource access control 
- Optimistic: Based on timestamps and versions, serve as many requests as possible, possibly using out-of-date versions of the data

### 4.1. Locking

A transaction is well-formed w.r.t. locking if:
- read operations are preceded by r_lock (aka SHARED LOCK) and followed by unlock
- write operations are preceded by w_lock (aka EXCLUSIVE LOCK) and followed by unlock
	*unlocking can be delayed w.r.t. to the end of the read/write operation*

Transactions that first read and then write an object may:
- Acquire a w_lock already when reading 
- Acquire a r_lock first and then upgrade it into a w_lock (lock upgrade)

Possible states of an object: 
- Free 
- r-locked (locked by one or more readers) 
- w-locked (locked by a writer) 

---
Related: [[_Database2 MOC]]
Source: [[03_1_Transactions.pdf]], [[03_2_Concurrency.pdf]]