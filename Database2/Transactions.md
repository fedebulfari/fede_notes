---
date: 03-11-2026
subject: Database2
description:
---

# Transactions

> [!tip] DBMS Architecture
![[Concurrency Control-1793717237862.webp|488]]

Transaction are elementary, atomic unit of work performed by an application

Each transaction is conceptually encapsulated within two commands:
- Begin transaction
- Commit-work/Rollback-work

> [!info] Transactional System (OLTP)
> A Transactional System is a system that manage the execution of transactions on behalf of the concurrent application

![[Concurrency Control-1793717543038.webp|367]]

## 1. ACID Properties

A Transaction must be:
- **A**tomic
- **C**onsistent
- **I**isolated
- **D**urable



---
Related: [[_Database2 MOC]]
Source: