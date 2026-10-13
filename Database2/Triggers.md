---
date: 13-10-2026
subject: Database2
description:
---

> [!abstract] Overview
> Triggers implement **active behaviour** in DBMS: automatic actions executed on `INSERT`, `UPDATE`, `DELETE`. They follow the **Event-Condition-Action (ECA)** paradigm and complement declarative integrity constraints.

From passive to active:
- **1975:** idea of integrity constraints → data quality
- **1980-1990:** research on constraints & triggers
- **SQL-92:** declarative constraints (key, referential integrity, `CHECK`, domain)
- **SQL:1999:** triggers / active rules (procedural specification)
- Support varies widely across vendors, with different execution semantics.

# 1. Constraints vs Triggers

Declarative constraints example:

```sql
CREATE TABLE author (
  idAut INT PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  salary DECIMAL(10,2),
  CHECK (salary >= 10000)
);

CREATE TABLE book (
  idBook SERIAL PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  authorref INT NOT NULL 
	REFERENCES author(idAut) ON DELETE CASCADE
);
```

- `INSERT INTO book VALUES ('Data bases', 99)` fails if author 99 does not exist.
- `INSERT INTO author VALUES (1, 'John Smith', 9000)` fails if salary < 10000 or key duplicates.
- `DELETE FROM author WHERE idAut = 5` cascades to books.

Triggers are needed when checks are **too complex for constraints**. They are compiled and stored in the DBMS like stored procedures, but executed automatically on events, not invoked by client.

# 2. Event-Condition-Action (ECA)

- **Event (E):** normally a DB state modification: `INSERT`, `DELETE`, `UPDATE [OF column]`
- **Condition (C):** predicate identifying when action is required (`WHEN` clause)
- **Action (A):** generic update statement or stored procedure, usually `INSERT` / `DELETE` / `UPDATE`, can include error notification

Example: log grade history

```sql
-- Student(StudID, Name, Email, ...)
-- Exam(StudID, CourseID, Date, Grade, ...)
-- Log(TS, StudID, CourseID, PreviousGrade, NewGrade)
-- E: UPDATE of Grade in Exam
-- C: new Grade <> old Grade
-- A: INSERT INTO Log
```

Question: manage at DB level or in external application? At DB level → centralized, transparent to all apps.

# 3. Execution Model

```
SQL_statement (INSERT/DELETE/UPDATE)
  → Database BEFORE
  → effect of statement
  → Database AFTER
```

Transition variables/tables (`OLD` / `NEW`) expose before/after state of affected rows to triggers.

Target table example:

```sql
UPDATE Exam SET Grade = '30'
WHERE StudID = '12345' OR (StudID = '54321' AND CourseID = '35');
```

Affected rows are visible as `OLD` (before: Grade = null) and `NEW` (after: Grade = 30).

![[Triggers-1791900160390.webp|527]]

# 4. SQL:1999 Syntax

```sql
	CREATE TRIGGER <TriggerName>
	{ BEFORE | AFTER }
E	{ INSERT | DELETE | UPDATE [OF <Column>] } ON <Table>
	REFERENCING { [ OLD TABLE [AS] <OldTableAlias> ]
	              [ NEW TABLE [AS] <NewTableAlias> ] |
	              [ OLD [ROW] [AS] <OldTupleName> ]
	              [ NEW [ROW] [AS] <NewTupleName> ] }
	[ FOR EACH { ROW | STATEMENT } ]
C	[ WHEN <Condition> ]
A	<SQLProceduralStatement>;
```

- `E` = timing + event + table
- `C` = `WHEN`
- `A` = procedural statement

# 5. Transition Variables

| Granularity     | Before state         | After state          |
| --------------- | -------------------- | -------------------- |
| Row-level       | `OLD` tuple variable | `NEW` tuple variable |
| Statement-level | `OLD TABLE`          | `NEW TABLE`          |

- `OLD` / `OLD TABLE` undefined for `INSERT` 
- `NEW` / `NEW TABLE` undefined for `DELETE`

Cases:
- **UPDATE:** both `OLD` and `NEW` defined.
- **INSERT:** only `NEW`, e.g. `INSERT INTO Exam VALUES (12345,32,'15/09/20',25), (12346,32,'15/09/20',28)` → new table has 2 rows.
- **DELETE:** only `OLD`, e.g. `DELETE FROM Exam WHERE ...` → old table has deleted rows.

> [!tip] Naming
> Standard uses `OLD` / `NEW`, `OLD TABLE` / `NEW TABLE`. Postgres uses `OLD` / `NEW` for rows and `REFERENCING OLD TABLE AS ...`. Oracle uses `:OLD`, `:NEW`. Always check vendor syntax.

# 6. Execution Modes: BEFORE vs AFTER

## BEFORE
- Action executed **before** DB change, if condition holds.
- Used to **validate a modification before it takes place** and possibly condition its effect.
- Safeness constraint: BEFORE triggers cannot update DB directly, but **can modify transition variables** in row-level granularity:

```sql
SET new.VALUE = 0;
```

## AFTER
- Action executed **after** DB modification, if condition holds.
- Most common mode, suitable for most applications.

Example: prevent negative values

```sql
-- BEFORE version: modifies the modification, 1 UPDATE only
CREATE TRIGGER No_Negative_Values
BEFORE UPDATE OF VALUE ON T1
FOR EACH ROW
WHEN (new.VALUE < 0)
SET new.VALUE = 0;
```

```sql
-- AFTER version: needs 2nd UPDATE, less efficient
-- NOT allowed in some DBMS (e.g. MySQL cannot update triggering table)
CREATE TRIGGER No_Negative_Values
AFTER UPDATE OF VALUE ON T1
FOR EACH ROW
WHEN (new.VALUE < 0)
UPDATE T1 SET VALUE = 0 WHERE ID = new.ID;
```

> [!warning] Prefer BEFORE to "fix" incoming data. AFTER that updates the same triggering table is forbidden in MySQL and inefficient elsewhere.

Flight miles exercise - same pattern:

```sql
-- BEFORE ROW: INSERT
CREATE TRIGGER Miles300_Ins
BEFORE INSERT ON Flight
FOR EACH ROW
WHEN (new.flightMiles < 300)
SET new.flightMiles = 300;

-- BEFORE ROW: UPDATE
CREATE TRIGGER Miles300_Upd
BEFORE UPDATE OF flightMiles ON Flight
FOR EACH ROW
WHEN (new.flightMiles < 300)
SET new.flightMiles = 300;
```

```sql
-- AFTER ROW (not possible in some DBMS)
CREATE TRIGGER Miles300_After
AFTER UPDATE OF flightMiles ON Flight
FOR EACH ROW
WHEN (new.flightMiles < 300)
UPDATE Flight SET flightMiles = 300
WHERE passengerName = new.passengerName
  AND flightNumber = new.flightNumber
  AND date = new.date;
```

```sql
-- AFTER STATEMENT
CREATE TRIGGER Miles300_Stmt
AFTER UPDATE OF flightMiles ON Flight
REFERENCING NEW TABLE AS NEW_T
FOR EACH STATEMENT
UPDATE Flight SET flightMiles = 300
WHERE (passengerName, flightNumber, date) IN (
  SELECT passengerName, flightNumber, date
  FROM NEW_T WHERE flightMiles < 300
);
```

# 7. Granularity: ROW vs STATEMENT

## Row-level: `For each Row`
- Considered and possibly executed **once per affected tuple**.
- Simpler to write, but can be less efficient.

## Statement-level: `For Each Statement`
- Considered and possibly executed **only once per activating statement**, independently of number of affected tuples (even if zero).
- Set-oriented, closer to traditional SQL philosophy.

## Transition Variables

Special variables denoting the before and after state of the modification with a syntax that depends on the granularity:

# 8. Conditional replication

Tables `T1(ID, VALUE)` and replica `T2(ID, VALUE)`.

```sql
CREATE TRIGGER Replic_Ins
AFTER INSERT ON T1
FOR EACH ROW
INSERT INTO T2 VALUES (new.ID, new.VALUE);

CREATE TRIGGER Replic_Del
AFTER DELETE ON T1
FOR EACH ROW
DELETE FROM T2 WHERE T2.ID = old.ID;

-- assumes ID unchanged, VALUE only
CREATE TRIGGER Replic_Upd
AFTER UPDATE OF VALUE ON T1
FOR EACH ROW
WHEN (new.ID = old.ID)
UPDATE T2 SET VALUE = new.VALUE WHERE ID = new.ID;
```

Conditional replication: only VALUE >= 10

```sql
CREATE TRIGGER Cond_Repl_Ins
AFTER INSERT ON T1 FOR EACH ROW
WHEN (new.VALUE >= 10)
INSERT INTO T2 VALUES (new.ID, new.VALUE);

CREATE TRIGGER Cond_Repl_Del
AFTER DELETE ON T1 FOR EACH ROW
WHEN (old.VALUE >= 10)
DELETE FROM T2 WHERE T2.ID = old.ID;
```

Update needs 3 triggers (ID fixed for simplicity):

```sql
-- case 1: becomes relevant -> replicate
CREATE TRIGGER Cond_Repl_Upd_1
AFTER UPDATE OF VALUE ON T1 FOR EACH ROW
WHEN (old.VALUE < 10 AND new.VALUE >= 10 AND new.ID = old.ID)
INSERT INTO T2 VALUES (new.ID, new.VALUE);

-- case 2: stays relevant -> propagate
CREATE TRIGGER Cond_Repl_Upd_2
AFTER UPDATE OF VALUE ON T1 FOR EACH ROW
WHEN (old.VALUE >= 10 AND new.VALUE >= 10
  AND old.VALUE != new.VALUE AND new.ID = old.ID)
UPDATE T2 SET VALUE = new.VALUE WHERE ID = new.ID;

-- case 3: becomes irrelevant -> delete
CREATE TRIGGER Cond_Repl_Upd_3
AFTER UPDATE OF VALUE ON T1 FOR EACH ROW
WHEN (old.VALUE >= 10 AND new.VALUE < 10 AND new.ID = old.ID)
DELETE FROM T2 WHERE ID = new.ID;
```

## Statement-level version

```sql
-- DELETE
CREATE TRIGGER St_Repl_Del
AFTER DELETE ON T1
REFERENCING OLD TABLE AS OLD_T
FOR EACH STATEMENT
DELETE FROM T2 WHERE T2.ID IN (SELECT ID FROM OLD_T);

-- INSERT
CREATE TRIGGER St_Repl_Ins
AFTER INSERT ON T1
REFERENCING NEW TABLE AS NEW_T
FOR EACH STATEMENT
INSERT INTO T2
SELECT ID, VALUE FROM NEW_T WHERE VALUE >= 10;

-- UPDATE: delete all updated, re-insert relevant
CREATE TRIGGER St_Repl_Upd
AFTER UPDATE ON T1
REFERENCING OLD TABLE AS OLD_T NEW TABLE AS NEW_T
FOR EACH STATEMENT
BEGIN
  DELETE FROM T2 WHERE T2.ID IN (SELECT ID FROM OLD_T);
  INSERT INTO T2 SELECT ID, VALUE FROM NEW_T WHERE VALUE >= 10;
END;
```

Statement-level is compact for bulk `UPDATE T1 SET value = 2*value`.

# 9. Multiple Triggers on Same Event

SQL:1999 prescribed order:

1. BEFORE statement-level
2. BEFORE row-level
3. Modification applied + integrity constraints checked
4. AFTER row-level
5. AFTER statement-level

If several triggers in same category: order depends on implementation (creation time, alphabetical name, `PRECEDES` / `FOLLOWS` in MySQL).

# 10. Cascading and Termination

- **Cascading / nesting:** action of T1 fires T2.
- **Recursive cascading / looping:** statement S on T starts cascade generating same event S on T.

## Termination analysis via triggering graph
- Node i for each trigger Ti.
- Arc i → j if execution of Ti's action **may activate** Tj (syntactic analysis).
- If **acyclic → guaranteed termination** (sufficient, not necessary).
- If cyclic → may or may not terminate.

Example:

```sql
-- Employee(RegNum, Name, Salary, Contribution, DeptN, ...)
-- T1: after salary update, adjust contribution
CREATE TRIGGER AdjustContributions
AFTER UPDATE OF Salary ON Employee
REFERENCING NEW TABLE AS NewEmp
FOR EACH STATEMENT
UPDATE Employee SET Contribution = Salary * 0.8
WHERE RegNum IN (SELECT RegNum FROM NewEmp);

-- T2: after any Employee update, cut salaries if over budget
CREATE TRIGGER CheckOverallBudgetThreshold
AFTER UPDATE ON Employee
FOR EACH STATEMENT
WHEN (50000 < (SELECT SUM(Salary + Contribution) FROM Employee))
UPDATE Employee SET Salary = 0.9 * Salary;
```

Graph T1 ↔ T2 has two cycles but system terminates because salaries only decrease. If condition inverted to `50000 > ...`, it would diverge.

Real systems limits:
- **MySQL:** stored function/trigger cannot modify table already used by invoking statement.
- **Postgres:** no direct cascade limit; recursive invocation possible; programmer must avoid infinite recursion.
- **SQL Server:** nested up to 32 levels; AFTER does not self-recurse unless `RECURSIVE_TRIGGERS` on.
- **Oracle:** up to 32 cascades at once; limited by `OPEN_CURSORS`.
- **Informix:** complex rules, see docs.

>[!example] Es 1: Book Sales
>
Schema:
>
>```
BOOK(Isbn, Title, SoldCopies)
WRITING(Isbn, Name)
AUTHOR(Name, SoldCopies) -- maintained only by triggers
>```
>
No cascading: events on base tables, actions on materialized table.
>
>- T1: `UPDATE SoldCopies ON BOOK` → update AUTHOR
>- T2: `INSERT ON WRITING` → update AUTHOR
>- T3 on `INSERT BOOK` not needed: referential integrity forces BOOK and AUTHOR to exist before WRITING.
>>```sql
CREATE TRIGGER UpdateSalesAfterNewSale
AFTER UPDATE OF SoldCopies ON Book
FOR EACH ROW
UPDATE Author
SET SoldCopies = SoldCopies + new.SoldCopies - old.SoldCopies
WHERE Name IN (SELECT Name FROM Writing WHERE Isbn = new.Isbn);
-- assumes Isbn never updated
>```
>
>```sql
CREATE TRIGGER UpdateSalesAfterNewAuthorship
AFTER INSERT ON Writing
FOR EACH ROW
UPDATE Author
SET SoldCopies = SoldCopies +
  (SELECT SoldCopies FROM Book WHERE Isbn = new.Isbn)
WHERE Name = new.Name;
>```

>[!example] Es 2: Hierarchy Management
>
>```
Product(ID, Name, SuperProduct, OwnWeight, TotalWeight)
-- TotalWeight = OwnWeight + sum(sub-products TotalWeight)
-- Root: SuperProduct = NULL
-- TotalWeight updated only by triggers
>```
>
Assumption: users can only 1) insert, 2) delete, 3) update SuperProduct. Alternative is recursive view (`WITH RECURSIVE`). Triggers good design **only if reads of TotalWeight >> updates**.
>
>- T1: INSERT product → set `TotalWeight = OwnWeight` (+ propagate via T3)
>- T2: DELETE product → decrease super's TotalWeight (+ propagate via T3)
>- T3: UPDATE TotalWeight → propagate to super (recursive cascading)
>- T4: UPDATE SuperProduct → move weight from old super to new super
>- Deletion of sub-products managed by `ON DELETE CASCADE`.
>
>```sql
-- T1
CREATE TRIGGER Product_After_Insert
AFTER INSERT ON Product FOR EACH ROW
UPDATE Product SET TotalWeight = OwnWeight WHERE ID = new.ID;
>
-- T2
CREATE TRIGGER Product_After_Delete
AFTER DELETE ON Product FOR EACH ROW
WHEN (old.SuperProduct IS NOT NULL)
UPDATE Product
SET TotalWeight = TotalWeight - old.TotalWeight
WHERE ID = old.SuperProduct;
>
-- T3: propagation
CREATE TRIGGER Product_After_Update_TotalWeight
AFTER UPDATE OF TotalWeight ON Product FOR EACH ROW
WHEN (new.SuperProduct IS NOT NULL
  AND new.TotalWeight != old.TotalWeight)
UPDATE Product
SET TotalWeight = TotalWeight + (new.TotalWeight - old.TotalWeight)
WHERE ID = new.SuperProduct;
>
-- T4: move
CREATE TRIGGER Product_After_Update_Super
AFTER UPDATE OF SuperProduct ON Product FOR EACH ROW
WHEN (new.SuperProduct IS NULL OR new.SuperProduct != old.SuperProduct)
BEGIN
  UPDATE Product
  SET TotalWeight = TotalWeight - old.TotalWeight
  WHERE ID = old.SuperProduct;
  UPDATE Product
  SET TotalWeight = TotalWeight + new.TotalWeight
  WHERE ID = new.SuperProduct;
END;
>```
>
>> [!warning] Cascading order
> When multiple triggers fire on same event, vendors decide precedence differently. Delayed triggers execute later; full behaviour is far from trivial. See Postgres example below.

> [!warning] Postgres cascading trap
>
>```sql
CREATE TRIGGER T1 AFTER UPDATE OF x ON ttest
FOR EACH ROW WHEN (NEW.x >= 10)
UPDATE ttest SET x = NEW.x / 2.0;
>
CREATE TRIGGER T2 AFTER UPDATE OF x ON ttest
FOR EACH ROW WHEN (NEW.x >= 6)
UPDATE ttest SET x = NEW.x * 1.4;
-- update x to 12, initial 0: T1 wins alphabetically, T2 delayed
-- chain creates delayed T2 instances seeing stale NEW values
-- e.g. T2 sees NEW=11.76 but current x=5.88 -> sets 16.46
-- process never stops -> error
>```
>
>Key lesson: delayed instances see **activation-time NEW**, not current value. Document and avoid such mutual recursion.

# 11. Materialized Views

A view is a virtual table defined with a query stored in the database catalog and then used in queries as if it were a normal table

```sql
CREATE VIEW DeptCost AS
SELECT d.DeptNum AS dept, COALESCE(SUM(e.salary),0) AS totCost
FROM dept d LEFT JOIN emp e ON e.dept = d.DeptNum
GROUP BY d.DeptNum;
```

- **Normal view**: rewritten each query to use base tables.
- **Materialization:** store result in table. Useful when **queries >> updates**.
- Some DBMS have `CREATE MATERIALIZED VIEW`; alternative: triggers.

**Incremental maintenance**: most modifications affect small part:

- Update `idemp`: no effect
- Insert/delete employee, update salary: 1 tuple in deptcost
- Update `dept`: 2 tuples in deptcost
- Insert/delete department: 1 tuple in deptcost

If incremental cost < recompute from scratch → prefer incremental.

Solution sketch (no cascading, events on base, actions on view table):
- T1 INSERT EMP → increase totCost
- T2 DELETE EMP → decrease totCost
- T3 UPDATE salary (dept unchanged) → apply delta
- T4 UPDATE dept → + new dept, - old dept
- T5 INSERT DEPT → insert `(new.DeptNum, 0)`
- T6 DELETE DEPT → delete (or via FK)
> [!example] Es. 3
>
>```sql
CREATE TRIGGER Incremental_InsEmp
AFTER INSERT ON emp FOR EACH ROW
UPDATE DeptCost SET totCost = totCost + new.salary
WHERE dept = new.dept;
>
CREATE TRIGGER Incremental_DelEmp
AFTER DELETE ON emp FOR EACH ROW
UPDATE DeptCost SET totCost = totCost - old.salary
WHERE dept = old.dept;
>
CREATE TRIGGER Incremental_SalaryUpdate
AFTER UPDATE OF salary ON emp FOR EACH ROW
WHEN (old.dept = new.dept)
UPDATE DeptCost
SET totCost = totCost - old.salary + new.salary
WHERE dept = new.dept;
>
CREATE TRIGGER Incremental_DeptChange
AFTER UPDATE OF dept ON emp FOR EACH ROW
BEGIN
  UPDATE DeptCost SET totCost = totCost + new.salary
  WHERE dept = new.dept;
  UPDATE DeptCost SET totCost = totCost - old.salary
  WHERE dept = old.dept;
END;
>
CREATE TRIGGER Incremental_DeptInsert
AFTER INSERT ON dept FOR EACH ROW
INSERT INTO DeptCost VALUES (new.DeptNum, 0);
>
CREATE TRIGGER Incremental_DeptDelete
AFTER DELETE ON dept FOR EACH ROW
DELETE FROM DeptCost WHERE dept = old.DeptNum;
>```
>
Integrity interaction:
>
>```sql
CREATE TABLE emp (
  idemp INT NOT NULL AUTO_INCREMENT,
  salary INT DEFAULT NULL,
  dept INT NOT NULL,
  PRIMARY KEY (idemp),
  CONSTRAINT empdept FOREIGN KEY (dept)
>	REFERENCES dept(DeptNum) ON DELETE CASCADE
>);
>```

>[!warning] Triggers assume referential integrity: deleting dept cascades to employees; assigning to non-existing dept → violation.

# 12. Design Principles

- Use triggers to guarantee that when specific operation is performed, related actions are performed.
- Do not duplicate built-in DBMS features. Prefer declarative constraints for bad-data rejection.
- Limit size: if > ~60 lines, move logic to stored procedure and call it.
- Use only for centralized, global operations that must fire regardless of user/app.
- Avoid recursive triggers unless absolutely necessary (memory exhaustion risk).
- Use judiciously: executed for every user on every event.

Source: https://docs.oracle.com/cd/B12037_01/appdev.101/b10795/adfns_tri.htm

# 13. Evolution and Vendor Syntax

Active DB evolution:
- Execution mode (immediate, deferred, detached)
- New events (system-defined, temporal, user-defined)
- Complex events and event calculus
- `INSTEAD OF` clause
- Rule administration: priorities, grouping, dynamic activation/deactivation
- Vendor variations (e.g. Oracle)

**Oracle:** multiple events allowed, no table variables, `WHEN` only with row-level, different conflict semantics, no limit on BEFORE action power.

```sql
CREATE TRIGGER TriggerName
{ BEFORE | AFTER } <event> [, <event> ...]
-- [REFERENCING [OLD [ROW] [AS] OldTupleName]
--               [NEW [ROW] [AS] NewTupleName]]
-- FOR EACH ROW [WHEN SQLPredicate]
-- PL/SQLStatements
```

**PostgreSQL:**

```sql
CREATE [OR REPLACE] [CONSTRAINT] TRIGGER name
{ BEFORE | AFTER | INSTEAD OF } { event [ OR ... ] } ON table_name
[ REFERENCING { { OLD | NEW } TABLE [AS] transition_relation_name } [...] ]
[ FOR EACH { ROW | STATEMENT } ]
[ WHEN ( condition ) ]
EXECUTE { FUNCTION | PROCEDURE } function_name ( arguments );
-- event: INSERT | UPDATE [OF column ...] | DELETE | TRUNCATE
```

**MySQL:**

```sql
CREATE TRIGGER trigger_name
{ BEFORE | AFTER } { INSERT | UPDATE | DELETE }
ON tbl_name FOR EACH ROW
[{ FOLLOWS | PRECEDES } other_trigger_name]
trigger_body;
```

# 14. Conclusions

- All major RDBMS support triggers, mostly subset of SQL:1999, with subtle execution differences and proprietary languages → **portability is hard**.
- Centralize semantics in DB under DBMS control, not replicated in apps.
- Guarantee properties not expressible via constraints.
- Always document them, because behaviour is hidden.

---
Related: [[_Database2 MOC]]
Source:  [[01_Triggers.pdf]]
