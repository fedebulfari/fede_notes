---
date: 13-10-2026
subject: Database2
description: Physical storage (blocks, pages, heap, hash, B/B+ indexes) and I/O cost model for sequential, point and interval lookups, joins and optimizer decisions.
---

# Physical Database

> [!summary] Overview
> How relations are physically stored and how that storage dictates query cost: **blocks** and **pages**, heap vs sequentially-ordered files, hash buckets with overflow chains, and **B/B+ tree** indexes (dense/sparse, primary/secondary/clustering). The unifying thread is the I/O cost model — a query costs the number of blocks moved — applied to sequential scans, equality and interval lookups, and join strategies. Those formulas are what let the **optimizer** pick access paths from statistics and selectivity, the practical bridge to the trigger-based maintenance in [[Triggers]].

> [!abstract] Goal
> How are tables stored at the physical level? How can they be accessed efficiently? How does storage impact query performance?
> Cost model in I/O-bound applications: **cost of a query = number of blocks moved** between secondary and main memory.

## 1. DBMS Architecture for Query Management

- **Secondary Store Manager / Buffer Manager:** manages main memory, `fix` / `unfix` pages, guarantees reliability.
- **Access Method Manager:** transforms query requests into `read` / `write` requests.
- **Query Manager:** receives `select, insert, delete, update`.
- **Transaction / Reliability / Concurrency Control:** `begin, commit, abort`, lock tables.
![[Physical Data-1792144048944.webp|459]]

## 2. Main vs Secondary Memory

Databases live (mainly) on **secondary memory** for:
- **size** — too large for RAM
- **persistence**

Data can be used only after transfer to main memory.

- **Block:** unit of storage in secondary memory, usually fixed length, order of few KBytes.
- **Page:** unit of storage in main memory. Assumption in this course: `size(page) = size(block)`. In real systems a page may contain several blocks.
![[Physical Data-1792144188500.webp|220]]

> [!info] **I/O operation:** 
> moving a block <-> page.

DBMS bypasses OS File System for data placement: uses FS only for `create/delete files, read/write blocks`, but directly manages file organization, record distribution in blocks, internal block structure, physical allocation on disk (sequential reads, write timing, reliability).

### 2.1. Access Time

Mechanical HDD (Winchester: disks, spindle, arm, heads, tracks, sectors, blocks):
- **seek time:** 8-12 ms — head on correct track
- **latency time:** 2-8 ms — rotation to correct sector
- **transfer time:** ~1 ms — data transfer

SSD: fast read/write, more expensive. For very large datasets cheap storage is the only viable option.

![[Physical Data-1792145181101.webp|297]]

> [!warning] Key figure
> Secondary memory access is **~4 orders of magnitude slower** than main memory. In I/O-bound apps cost depends exclusively on number of secondary accesses.$$\text{Cost of a query}= \text{\#blocks}$$

## 3. Block Organization

We define:
- Blocks: physical components of files
	Fixed size
- Tuples: logical components of tables
	Variable size

Block contains:
- **useful part** with data (tuples)
- **page dictionary / offset table** with pointers (offsets from start) to each elementary item — dictionary and data grow as stacks in opposite directions
- **block header/trailer** (FS control) + **page header/trailer** (access method control)
- **checksum** to detect corruption
![[Physical Data-1792150200446.webp|437]]

### 3.1. Block Factor

- $ST$ = average tuple/record size (variable if `VARCHAR`, nullable)
- $SB$ = block size (fixed, depends on FS/format)
- $B = \lfloor SB / ST \rfloor$ = number of tuples per block

Rest of space:
- unused: **unspanned records**
- used: **spanned records** (hung-up tuples across blocks)

Running example used later:
- Block $= 8192$ bytes (8 KB)
- `STUDENT(ID, Name, LastName, Email, City, Birthdate, Sex)` — $t = 150K$, tuple $= 95$ bytes $(4+25+25+25+12+3+1)$, $B = 8192/95 = 87$, $b = 150000/87 \approx 1.7K$ blocks
- `EXAM(SID, CourseID, Date, Grade)` — $t = 1.8M$, tuple $= 17$ bytes $(4+4+3+4)$, $B = 482$, $b \approx 5.3K$ blocks

### 3.2. Buffer Manager Primitives (In Main Memory, on Pages)

- **Insert / update:** may require page reorganization or new page; `VARCHAR` and other fields update can force reorganization.
- **Delete:** often just mark as invalid + async reorganization later.
- **Access to field:** offset w.r.t. tuple start + field length (from page dictionary).

## 4. Physical Access Structures

**Access method:** software module providing store/retrieve primitives for each physical structures, with their own data structures.

- **Primary structure:** contains all full tuples of a table. Each table has exactly one. Main purpose: store content.
- **Secondary structures:** index primary structures, contain only field values + pointers to primary blocks. Main purpose: speed up search.

Three types:

|  | Primary | Secondary |
|---|---|---|
| **Sequential** | Typical | Not used |
| **Hash-based** | In some DBMS (e.g. Oracle hash clusters, DB2 organize-by-hash) | Frequent |
| **Tree-based (B/B+)** | Obsolete / rare | Typical |

## 5. Sequential Structures (Primary)

Sequential arrangement, next element/block supported. Blocks contiguous or sparse.

- **Entry-sequenced (heap):** order = entry order.
- **Sequentially-ordered:** ordered by key (one or more attributes), e.g. sorted by `ID` or `Lastname`.

### 5.1. Heap

Effective for insertion (no shifting), space occupancy, full sequential `SELECT * FROM T` — especially if blocks contiguous (reduced seek+latency).

Not optimal for:
- point search `WHERE …` — may scan whole table (but usable with secondary indexes)
- updates growing tuple size — shift or delete-old + insert-new

Example: `SELECT * FROM Student WHERE Name='John'` on heap → cost = \#b locks of whole table.

### 5.2. Sequentially-ordered

Tuples sorted by key. Effective for range queries on key, `ORDER BY` / `GROUP BY` on key.

Problem: inserts + growing updates. Solutions:
- differential files + periodic merge (yellow pages)
- free space at load → local reordering
- overflow file: new tuples in linked overflow chain

Example: `SELECT * FROM Student WHERE ID BETWEEN 135 AND 380` → cost = \# read blocks only, can stop early.

|                | Entry-sequenced                                    | Sequentially-ordered                 |
| -------------- | -------------------------------------------------- | ------------------------------------ |
| INSERT         | Efficient                                          | Not efficient                        |
| UPDATE growing | Efficient* (*except find + delete+insert if grows) | Not efficient if data size increases |
| DELETE         | Mark invalid                                       | Mark invalid                         |
| Tuple size     | Fixed or variable                                  | Fixed or variable                    |
| `WHERE key`    | Not efficient                                      | More efficient                       |

> Most common solution is **Entry-sequenced organization** paired with **Secondary access structures**.

## 6. Hash-Based Structures (Primary)

Efficient associative access on key value.

- $N_B$ buckets, $N_B \ll$ \# data_items. Bucket = typically 1 block, often stored adjacent in files.
- Hash function $h(key) \in [0, N_B-1]$ → bucket index.
- Implementation: **folding** (string → uniformly distributed positive int) + **hashing** (int → bucket number).

Efficient for small, almost static tables + point queries `WHERE key = v`. Inefficient for range / full scan / very dynamic content.

Example `h(K)=K mod 10`:
- `WHERE ID='522'`, $h=2$, no overflow → 1 I/O
- `WHERE ID='981'`, $h=1$, with overflow → 1 + avg overflow chain length, e.g. 2 I/O

### 6.1. Overflow Chains

- $B$ = tuples per block (1 bucket = 1 block hypothesis)
- $T$ = \# tuples
- $N_B=$ \# buckets
- Load factor $= T / (B \times N_B)$ = average block occupancy, typical 50-80%

average accesses to overflow list (from statistics):

| Load \ B | 1 | 2 | 3 | 5 | 10 |
|---|---|---|---|---|---|
| 0.5 | 0.5 | 0.177 | 0.087 | 0.031 | 0.005 |
| 0.6 | 0.75 | 0.293 | 0.158 | 0.066 | 0.015 |
| 0.7 | 1.167 | 0.494 | 0.286 | 0.136 | 0.042 |
| 0.8 | 2.0 | 0.903 | 0.554 | 0.289 | 0.110 |
| 0.9 | 4.495 | 2.146 | 1.377 | 0.777 | 0.345 |

_Example: $B=3$, load 70% → cost $= 1 + 0.286$ I/O._

## 7. Indexes — Basic Concepts (Secondary)

Index = like book analytic index: pairs `[search key, pointer to block]`. Smaller than data, can stay in memory. Note pointers point to **blocks** — whole block retrieved to read tuple.

> [!warning] Indexes are not free
> After every `INSERT/UPDATE/DELETE` DBMS must also update indexes. They speed reads but slow writes.

### 7.1. Dense vs Sparse

- **Dense:** entry for each search-key value. Good performance: index search + tuple access. Usable also on heap.
- **Sparse:** entries only for some values. Less space, slower (index search + block scan). Requires sequentially ordered file with $SK = OK$ (ordering key). Good trade-off: one entry per block.

### 7.2. Primary vs Secondary vs Clustering

- **Primary index:** on sequentially ordered file, $SK = OK$, $SK$ unique. Only one per table. Dense or sparse. Usually on primary key, but not necessarily.
- **Secondary index:** $SK \ne OK$. Multiple per table, on different keys. Necessarily **dense**, because contiguous $SK$ values can be scattered across blocks.
- **Clustering index:** generalization of primary with non-unique $OK$. Pointer of $X$ → block with first tuple of $X$. Typically sparse.

| Type | Structure | Search Key | Density | How many |
|---|---|---|---|---|
| Primary | Sequentially ordered, $SK=OK$ | Unique | Dense or sparse | One per table |
| Secondary | Heap or ordered with $SK \ne OK$ | Unique and non-unique | Dense | Many |
| Clustering | Sequentially ordered, $SK=OK$ | Non-unique | Typically sparse | One per table |

> [!warning] Terminology varies by system 
> — check meaning of primary/secondary/clustering/clustered in context.

> [!faq] Search key ≠ Primary key
> - **Primary key:** logical constraint (minimal, unique, not null), no access path implied. Implemented via index.
> - **Search key:** physical attributes used in index to speed location. One value → one or more pointers. May be unique or not.

Pros: small, support point/range/sorted scans. Hash indexes better for point queries (see below).

## 8. Hash-Based Indexes (Secondary)

Used for secondary indexs. Same shape as primary hash, but buckets contain **key + pointer**, not full tuple. Supports equality predicates on search key.

Example: `SELECT * FROM Student WHERE ID='342'`, $h(342)=2$:
- cost = 1 to access hash index (without overflow, +0.3 with) + 1 to reach full tuple via pointer.

## 9. Tree-Based Indexes

Most used in RDBMS for secondary indexes. SQL indexes are B+ trees. Support equality, intervals, `ORDER BY`, `GROUP BY`, `UNION`, `DISTINCT` (sorted).

- **Balanced:** all root-to-leaf paths equal length → predictable performance.
- **B-tree:** key values also in internal nodes, no redundancy, slightly faster lookup but worse intervals.
- **B+ tree (most used):** all key values in leaves; internal nodes = multilevel sparse index on leaves.

### 9.1. B+ Trees

![[Physical Data-1792156284721.webp|437]]
Structure:
- One root, several intermediate nodes, several leaf nodes (majority of blocks). Each node = one block. Large fan-out/degree depends on block/key/pointer sizes.
- Leaf: up to $N-1$ keys, at least $\lceil (N-1)/2 \rceil$, sorted $K_i < K_j$, plus pointers to primary blocks + pointer to next leaf (chain for sequential scan). Leaves form **dense index**.
- Internal: up to $N-1$ keys + $N$ pointers, at least $\lceil N/2 \rceil$ pointers (except root), keys sorted. 
	Search: if $V < K_1$ follow $P_1$, if $V \ge K_{N-1}$ follow $P_N$, else follow $P_{j+1}$ with $K_j \le V < K_{j+1}$.

Leaf chain ordered by key → exact match + interval queries efficient.

### 9.2. B-trees

Eliminates the redundant storage of search-key values, since search-key values appear only once and intermediate nodes only have pointer to sub-tree and too blocks containing the tuple of interest.

For each $K_i$ one pointer to sub-tree $[K_i, K_{i+1})$ + pointer(s) to block(s) with $K_i$ tuples.

 Lookup can be slightly faster, but interval queries are less efficient.
 ![[Physical Data-1792157268978.webp|436]]

## 10. SQL Indexes

```sql
CREATE [UNIQUE] INDEX IndexName ON TableName(AttributeList);
DROP INDEX IndexName;
```

Guidelines for choosing:
1. Do not index small tables.
2. Index PK if not key of primary organization (some DBMS auto-create unique indexes on PK/unique).
3. Add secondary index to heavily used secondary key.
4. Add secondary index to FK if frequently accessed (joins!).
5. Add indexes on `WHERE`, join criteria, `ORDER BY`, `GROUP BY`, sorting ops (`UNION`, `DISTINCT`).
6. Avoid indexing frequently updated column/table.
7. Avoid indexing if query retrieves large proportion of table (full scan cheaper).
8. Avoid long string columns.

> Add secondary structures progressively, checking optimizer actually uses them (`EXPLAIN PLAN`).

## 11. Query Optimization

Same query can be executed many ways. Optimizer:
1. Lexical, syntactic, semantic analysis
2. Translation to internal representation (algebraic tree)
3. Algebraic optimization (equivalent but cheaper tree)
4. Cost-based optimization (statistics + operator implementations) + code generation. May rewrite joins as nested queries.

Example:

```sql
SELECT LastName, FirstName FROM Student, Exam
WHERE Student.ID = Exam.SID AND Exam.CourseID = 'DB2';
-- naive: Cartesian 180K x 18K -> huge
-- better: filter Exam to 200 DB2 rows first, then join
```

With stats: 18K students, ~10 exams each (180K?/1.8M), only 200 take DB2 — pushing selection down reduces intermediate from billions to hundreds.

### 11.1. Profiles and Selectivity

Data dictionary stores per table $T$:
- cardinality (\# tuples) — `SELECT COUNT(*) FROM T` can answer from dictionary
- bytes per attribute $A_j$
- $val(A_j)$ = \# distinct values
- $min/max$ per attribute — `<,>` queries may answer from dictionary
- Periodically refreshed via `UPDATE STATISTICS`.

Selectivity = probability random tuple satisfies predicate.

If $val(A)=N$ and uniform distribution, selectivity of $A=k$ is $1/N$.

_Example: $val(City)=200$ → $1/200 = 0.5\%$; 18K students → ~90 per city. If no distribution info → assume uniform!_

## 12. Optimizations

- Operations: Selection, Projection, Sort, Join, Grouping. 
- Access methods: Sequential, Hash, Tree.

### 12.1. Sequential Scan

Sequential access to all tuples, while doing projection/selection.

Example heap STUDENT ordered by ID:
- `WHERE City='Milan'` → 1.7K I/O (full scan, City not ordering key)
- `WHERE ID<500` → $\le 1.7K$ (can stop when ID=500)

Hash supports **equality** only. Tree supports `WHERE`/`JOIN` + sorting.

### 12.2. Equality Lookup $A_i = v$

- Sequential primary: no lookup (full scan); ordered may reduce.
- Hash/Tree: supported if $A_i$ is search key. Cost depends on primary/secondary + unique/non-unique.

**Primary hash** `WHERE ID='54'` ($h$ on ID):
- no overflow: 1 I/O (full tuple in bucket)
- overflow 0.3: 1.3 I/O

**Secondary hash unique** `WHERE ID='54'`:
- 1 (+overflow) for index + 1 for data block = 2–2.3 I/O

**Secondary hash non-unique** `WHERE LastName='Rossi'`:
- 1 (+0.3) for index + \# tuples accesses. With $val=75K$, 150K tuples → avg 2 pointers/key → $1.3+2 = 3.3$ I/O. Cannot assume Rossis in same primary block.

**Primary B+ unique** `WHERE ID=54` (full tuples in leaves, 4 levels: 3 intermediate + leaf):
- 4 I/O

**Primary B+ not on key** `WHERE City='Milan'` (B+ on ID):
- must scan all leaves: 3 + 2K ≈ 2K I/O

**Primary B+ non-unique** `WHERE City='Milan'` (B+ on City, 4 levels, 2K leaves, 150K tuples, $val(City)=150$):
- 1K tuples/city, 75 tuples/node → 14 leaf nodes chained → $3+14 = 17$ I/O

**Secondary B+ unique** `WHERE ID='54'` (B+ on ID):
- 3 + 1 leaf + 1 data = 5 I/O

**Secondary B+ not on key** `WHERE City='Milan'` (B+ on ID):
- index useless → full scan 1.7K I/O

**Secondary B+ non-unique** `WHERE LastName='Rossi'` ($val=75K$, 150K pointers, 0.5K leaves):
- 2 tuples/name, 300 ptrs/block → 2 tuples in 1 block → $3+1+2 = 6$ I/O (assume no caching, reload block per pointer)

**Secondary B+ on EXAM** `WHERE Date='10/6/2019'` ($val=500$, 1.8M tuples/pointers, 2K leaves, 5.3K data blocks):
- 3.6K tuples/date, 900 ptrs/leaf → 4 leaves → cost $= 3 + 4 + 3.6K \approx 3.6K$ I/O (read 4 leaves, follow 3600 pointers; usually date not leftmost → see non-unique handling)

### 12.3. Non-unique B+ Details

Same key → multiple pointers, possibly multiple leaves. Keys per level satisfy $K_1 \le K_2 \le … \le K_m$ even in intermediate nodes. Search extended: if $K$ is first key in leaf, also visit preceding sibling (double-linked list); continue forward until $>K$.

### 12.4. Interval Lookup $v_1 \le A_i \le v_2$ ($<v$, $>v$ = Edge to first/last)

- Sequential primary: full scan (ordered may reduce).
- Hash (primary/secondary): not supported → full scan.
- Tree (primary/secondary) if $A_i$ search key:
	- **Primary:** 1 per intermediate level to first leaf with $v_1$ + chain until $v_2$.
	- **Secondary:** same + 1 data access per pointer in interval.

Example primary B+ `WHERE ID BETWEEN 6 AND 19`:
- `SELECT *` → 2 intermediate + 3 leaves + 3 data = 8 I/O
- `SELECT ID` (index-only, dense) → 2 + 3 = 5 I/O

### 12.5. Conjunction / Disjunction

```sql
-- conjunction: use most selective supported predicate for access, rest in memory
SELECT * FROM STUDENT WHERE City='Milan' AND Birthdate='12/10/2000';
-- disjunction: if all supported, use all indexes + dedup; if any unsupported -> full scan
SELECT * FROM STUDENT WHERE City='Milan' OR Birthdate='12/10/2000';
```

### 12.6. Multi-attribute Indexes (From Exercise)

`T(Name,Surname,City,Pathology,BloodType)`, 10M tuples, $val$ Name 1000, Surname 2000, City 1000, Pathology 100, BloodType 10. Indexes left-to-right access keys:
- `Idx1(City,Name,Surname)`, `Idx2(Pathology,Name,BloodType)`, `Idx3(Pathology,Surname,City)`

Query `WHERE Name='N' AND Surname='S' AND Pathology='P' AND BloodType='BT'`:
- Idx1 cannot be used efficiently (first attr City missing).
- Idx2 usable partially (Pathology first, then gap? Name second good, BloodType third but Surname missing in middle breaks full prefix — still best).
- Idx3 usable on Pathology only.
Choose most selective usable prefix exploiting stats + uniformity/independence. Detail in class slides.

Hash vs B+ lesson (Publications 1M tuples, 100K blocks, 10/block, primary hash on PubCode cost 1.11, B+ on ISBN fan-out 100, depth $\ge \log_{100}10^6 = 3$):
- `(PubCode='A' OR PubCode='B') AND ISBN='X'` via hash: 2 accesses ×1.11 = 2.22 I/O, filter ISBN in memory — best.
- Via secondary B+: ≥3 to leaf +1 data = ≥4 I/O. Hash unbeatable for random point access; B+ wins for intervals.

## 13. Joins (Cost Formulas)

- **Nested loop:** compare each block of $T_{out}$ with all blocks of $T_{in}$. Cost $= B_{out} + B_{out} \times B_{in}$. If small enough for buffer: $B_{out}+B_{in}$. Optimize case by case (choose smaller as outer).
- **Index scan + lookup:** use indexed $T_{in}$ to fetch only joining tuples without full check. Cost $= B_{out} + T_{out} \times (\text{cost of one index scan on } T_{in})$.
- **Merge scan:** if both sorted on same join key: $B_{out}+B_{in}$. Else sort + merge. Indexed merge scan uses B+ order.
- **Hashed join:** only if both hashed on same join keys (hash tuples to buckets to join).

Example `STUDENT JOIN EXAM ON ID=SID WHERE City='Milan' AND Grade='30'` ($val(City)=150$, $val(Grade)=17$): compare scan STUDENT + lookup EXAM vs scan EXAM + lookup STUDENT using selectivities.

## 14. What Optimizer Really Does

 An optimization problem, whose decisions are: 
 - The data access operations to execute (e.g., scan vs index access) 
 - The order of operations (e.g., the join order) 
 - The option to allocate to each operation (e.g., choosing the join method) 
 - Parallelism and pipelining can improve performances

Construct a decision tree, where each node corresponds to a choice and each leaf node corresponds to a specific execution plan.
![[Physical Data-1792160815765.webp|367]]

 Assign to each plan a cost: $$C_{total} = C_{I/O}*n_{I/O} + C_{CPU}*n_{CPU}$$ then choose the plan with the lowest cost.

Two approach:
 - **Compile and store**: the query is compiled once and executed many times (prepared statement).
	 - The internal code is stored in the DBMS, together with an indication of the dependencies of the code on the particular versions of catalog used at compile time 
	 - On relevant changes of the catalog, the compilation of the query is invalidated and repeated 
 - **Compile and go**: immediate execution, no storage.
	Even if not stored, the code may live for a while in the DBMS and be available for other executions

_Example:_

```sql
CUSTOMER(CustomerID PK, Name); -- 100K
ORDERS(OrderID PK, CustomerID FK, OrderDate, Amount); -- millions
SELECT c.Name, o.OrderID, o.OrderDate, o.Amount
FROM Customer c JOIN Orders o ON o.CustomerID = c.CustomerID
WHERE c.CustomerID = 42;
```

Without index on `Orders(CustomerID)`: scan ORDERS, keep 42, lookup CUSTOMER PK, join.
With `CREATE INDEX idx_orders_customer ON Orders(CustomerID)`: find 42 in index, retrieve matching ORDERS, then CUSTOMER.

Two lessons:
- **Query formulation matters:** `WHERE OrderDate >= DATE '2026-01-01' AND OrderDate < DATE '2027-01-01'` uses `idx_orders_date`; `WHERE EXTRACT(YEAR FROM OrderDate)=2026` does not.
- **Selectivity matters:** if Oracle estimates 80% of ORDERS satisfy range, it will prefer full scan even with index. Good statistics → good cardinality → better plan.

---
Related: [[_Database2 MOC]]
Source: [[02_Physical_Databases.pdf]], [[02a_Physical_Databases_Finalslides.pdf]], [[02b_ Physical_DB_Exercise0 - COMAI.pdf]], [[PhysDB-toComplete.pdf]]
