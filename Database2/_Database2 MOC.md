---
subject: Database2
description: Index of the Database2 notes on physical database design, active database triggers and concurrency control — storage structures, indexes, I/O cost models, query optimization, ECA triggers and serializability
---

# Database2

> [!summary] Overview
> Database2 looks at what a relational DBMS does underneath SQL: how data is physically organized and what it costs to access, which mechanisms react automatically when data changes, and how many transactions can run at once without corrupting the data. [[Physical Database]] explains why an execution plan is cheap or expensive, [[Triggers]] explains what the system does on its own once data changes, and [[Concurrency]] explains how the DBMS decides which interleaved executions are legal. Read storage first — the cost reasoning it establishes is what makes trigger side effects (and their maintenance of materialized views) expensive — and read [[Concurrency]] before anything about transactions, recovery or isolation levels.

## 1. Reading Path

1. [[Physical Database]] — DBMS architecture, main versus secondary memory, blocks and pages, heap/hash/sequential structures, primary and secondary indexes (hash, B+ tree), SQL indexes, query optimization, join cost formulas.
2. [[Triggers]] — constraints versus triggers, the Event-Condition-Action model, execution model, SQL:1999 syntax, transition variables, BEFORE/AFTER, ROW/STATEMENT, conditional replication, multiple triggers, cascading and termination, materialized views, vendor syntax.
3. [[Concurrency]] — transactions and ACID, OLTP transactional systems, the anomaly catalogue (lost update, dirty read, non-repeatable read, phantoms), schedules, view- and conflict-serializability (VSR, CSR), and conflict graphs.

## 2. Themes

- **Cost model** — in an I/O-bound setting, the cost of a query is the number of blocks moved; every structure is judged against that number.
- **Access paths** — heap, hash and tree structures trade scan cost against point/interval lookup cost, and indexes add write and space overhead.
- **Active behaviour** — triggers move logic from the application into the DBMS, at the price of hidden control flow.
- **Correctness under interleaving** — a schedule is acceptable not because it looks safe but because it is equivalent to some serial execution; the DBMS trades strictness (CSR) against permissiveness (VSR) because the exact test is intractable.

## 3. Core Ideas

- Sequential scan, hash lookup and B+ tree range scan have different asymptotics and different constants — the optimizer's job is to pick between them.
- A **primary** structure determines physical order; a **secondary** index only points into it.
- Join cost depends on the access path available on the inner relation, not only on table sizes.
- Triggers follow **ECA**: an event fires them, a condition gates them, an action runs; `OLD`/`NEW` expose the changed row.
- Cascading triggers can loop or terminate — the triggering graph is the object to reason about.
- **ACID** is the contract: atomicity and durability are about failure, consistency about constraints, isolation about concurrency — and isolation is the only one a concurrent scheduler can weaken.
- **Serializability is equivalence, not order**: view-serializability compares reads-from and final writes, conflict-serializability compares the order of conflicting pairs.
- $\text{CSR} \subset \text{VSR}$ — conflict-serializability is stricter but checkable in polynomial time via acyclicity of the conflict graph; testing VSR is NP-complete.
- The conflict graph (one node per transaction, one arc per conflicting pair) is the practical tool: acyclic schedule in, cycle schedule out.

## 4. Gaps and next Steps

- Only three topics are in the vault so far: no recovery, no locking/timestamp concurrency-control protocols, and no normalization/design notes — [[Concurrency]] stops at the theory of admissible schedules and never reaches how a scheduler enforces them (2PL, timestamps, isolation levels).
- [[Triggers]] ends with vendor syntax; a comparison table of PostgreSQL/MySQL/Oracle behaviour would be a useful addition.
- [[Physical Database]] has the cost formulas — worth a one-page cheat sheet before the exam.
- [[Concurrency]] has the schedule-counting formulas ($n!$ serial, $\frac{(\sum k_i)!}{\prod k_i!}$ distinct) and the anomaly templates — a decision table mapping each anomaly to its CSR failure pattern would make exam questions mechanical.
