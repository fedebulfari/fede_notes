---
subject: Database2
description: Index of the Database2 notes on active database triggers and physical database design — storage structures, indexes, I/O cost models and query optimization
---

# Database2

> [!summary] Overview
> Database2 looks at what a relational DBMS does underneath SQL: how data is physically organized and what it costs to access, and which mechanisms react automatically when data changes. [[Physical Database]] explains why an execution plan is cheap or expensive, [[Triggers]] explains what the system does on its own once data changes. Read storage first — the cost reasoning it establishes is what makes trigger side effects (and their maintenance of materialized views) expensive.

## Reading path

1. [[Physical Database]] — DBMS architecture, main versus secondary memory, blocks and pages, heap/hash/sequential structures, primary and secondary indexes (hash, B+ tree), SQL indexes, query optimization, join cost formulas.
2. [[Triggers]] — constraints versus triggers, the Event-Condition-Action model, execution model, SQL:1999 syntax, transition variables, BEFORE/AFTER, ROW/STATEMENT, conditional replication, multiple triggers, cascading and termination, materialized views, vendor syntax.

## Themes

- **Cost model** — in an I/O-bound setting, the cost of a query is the number of blocks moved; every structure is judged against that number.
- **Access paths** — heap, hash and tree structures trade scan cost against point/interval lookup cost, and indexes add write and space overhead.
- **Active behaviour** — triggers move logic from the application into the DBMS, at the price of hidden control flow.

## Core ideas

- Sequential scan, hash lookup and B+ tree range scan have different asymptotics and different constants — the optimizer's job is to pick between them.
- A **primary** structure determines physical order; a **secondary** index only points into it.
- Join cost depends on the access path available on the inner relation, not only on table sizes.
- Triggers follow **ECA**: an event fires them, a condition gates them, an action runs; `OLD`/`NEW` expose the changed row.
- Cascading triggers can loop or terminate — the triggering graph is the object to reason about.

## Gaps and next steps

- Only two topics are in the vault so far: no transactions, concurrency control, recovery, or normalization/design notes.
- [[Triggers]] ends with vendor syntax; a comparison table of PostgreSQL/MySQL/Oracle behaviour would be a useful addition.
- [[Physical Database]] has the cost formulas — worth a one-page cheat sheet before the exam.
