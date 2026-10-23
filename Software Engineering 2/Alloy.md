---
date: 23-10-2026
subject: Software Engineering 2
description: Alloy — language reference (signatures, relations, operators, commands, temporal layer) and worked examples
---

# Alloy

Alloy is a formal notation for specifying models of systems and software.
	It looks like a declarative OO language but with strong mathematical foundations.

It comes with **supporting** tools to **simulate** specifications and perform formal verification of properties(bounded model checking).

In the course we refer to version 6 of this language and tool.

Alloy is used in **Declarative** manner:

> [!quote] Declarative programming is a programming paradigm that expresses the logic of a computation without describing its control flow; describing what the program should accomplish, rather than describing how to go about accomplishing it.

In [[Requirement Engineering]] it can be used to formally describe the domain properties and operations that the machine must provide.

Any real -life system has a set of **properties** and **constraint**; therefore **Automated formal verification** of specifications can help check if the **properties** needed will be satisfied by the system without violating **constraints**

Alloy implement a first order predicate logic + relational calculus; it also implement a subset of relational algebra, tho with almost no arithmetic.
	It compose of Modules and hierarchies and, since version 6, also mutable sets and relations

> [!note] Resources
> - Book is the main reference; work-in-progress book: [practicalalloy.github.io](https://practicalalloy.github.io/index.html)
> - Tool, docs, examples, tutorial: [alloytools.org](https://alloytools.org)
> - Slides partly adapted from G. Dennis and R. Seater (MIT)

> [!info] Why it matters
> Formal verification is used in industry: **Intel** verifies CPU operations with model checking, **NASA** verifies source code of space missions.
>
> *"The first principle is that you must not fool yourself, and you are the easiest person to fool."* — R. P. Feynman

---

## 1. Part I — Language Reference

Definitions, declarations, operators and semantics. Examples are in [[#2. Part II — Examples]].

### 1.1. Semantics: Atoms and Relations

- **Atoms** are Alloy's primitive entities: indivisible, immutable, uninterpreted.
- A **relation** is a set of ordered n-tuples of atoms; n is the **arity** of the relation.
- Relations are **typed**: a relation of type `Person -> String` only contains pairs whose first component is a `Person` and whose second component is a `String`.
- **Everything is a relation**: sets are unary relations, scalars are singleton sets, tuples are elements of n-ary relations.

| Concept                   | Arity         | Shape                                  |
| ------------------------- | ------------- | -------------------------------------- |
| set                       | 1             | `Name = {(N0), (N1), (N2)}`            |
| scalar                    | 1 (singleton) | `myName = {(N1)}`                      |
| binary / ternary relation | 2 / 3         | `addr = {(B0,N0,A0), (B0,N1,A1), …}` |

Consequence: there is no separate notion of "object attribute" or "list"; everything is manipulated with relational operators.

### 1.2. Declarations

#### 1.2.1. Signatures

```alloy
sig A {}              // set of atoms A
abstract sig A {}     // A has no atoms except those of the signatures extending it
one sig A extends B {}// A is a singleton subset of B
sig A extends B {}    // A is a (disjoint) subset of B
sig A in B {}         // A is a subset of B, NOT necessarily disjoint (overlapping allowed)
enum E { V1, V2 }     // abbreviation: abstract sig E + one sig V1, V2 extends E
```

- `extends` ⇒ subset of the parent, partitioned with the other extending signatures when the parent is `abstract`; `in` ⇒ subset that may **overlap** with other subsets.
- `abstract` ⇒ the signature has no atoms of its own; every atom belongs to one of the extending signatures.
- A multiplicity keyword before `sig` sets the number of atoms of the signature itself: `one sig`, `some sig`, `lone sig`.

#### 1.2.2. Fields = Relations

```alloy
sig A { f: m e }
```

- `A` is the **domain**, `e` (an expression) is the **range**, `m` is the **multiplicity**.
- Default multiplicity is `one`.
- A field declared inside a signature is a relation whose first column is `A`; with `f: Name -> lone Addr` inside `Book` the actual relation is ternary: `Book -> Name -> Addr`.

| Keyword | Number of elements |
|---|---|
| `set` | any number (0..n) |
| `one` | exactly one (default) |
| `lone` | zero or one |
| `some` | one or more |

#### 1.2.3. Appended Facts (`this`)

```alloy
sig A { f: lone A } { this not in f }
```

A block after a signature declaration is an implicit **fact** about that signature; `this` denotes the atom of the signature being constrained.

#### 1.2.4. Mutable Declarations (Alloy 6)

```alloy
var sig S {}          // the set S can change over time
var f: e              // the relation f can change over time
```

See [[#1.6. Temporal Layer — Alloy 6]].

### 1.3. Expressions

#### 1.3.1. Relational Operators

| Operator               | Name                                | Notes                                                        |
| ---------------------- | ----------------------------------- | ------------------------------------------------------------ |
| `+`                    | union                               |                                                              |
| `&`                    | intersection                        |                                                              |
| `-`                    | difference                          |                                                              |
| `->`                   | Cartesian product                   | `n->a` builds a pair; used with `+`/`-` to add/remove tuples |
| `.`                    | join / navigation                   | `b.addr`, `n.(b.addr)`, `A.(r)`                              |
| `~r`                   | transpose                           | binary relations only; swaps columns                         |
| `^r`                   | transitive closure                  | binary only: `r + r.r + r.r.r + …`                         |
| `*r`                   | reflexive transitive closure        | binary only: `iden + ^r`                                     |
| `#e`                   | cardinality                         | number of tuples                                             |
| `iden`, `none`, `univ` | identity, empty, universal relation |                                                              |

**Transitive closure intuition** (a list `N0 -> N1 -> N2 -> N3`):

- `^next = {(N0,N1),(N0,N2),(N0,N3),(N1,N2),(N1,N3),(N2,N3)}`
- `*next` adds the reflexive pairs `(Ni,Ni)`
- `first.^next = rest`, `first.*next = Node`

**Transpose intuition**: `~next = {(N1,N0),(N2,N1),(N3,N2)}`. It is the standard way to state inverse relations, e.g. `wife = ~husband`.

#### 1.3.2. Logic and Quantifiers

- Connectives: `and`, `or`, `not`; implication `implies`; equivalence `iff` (or `<=>`).
- Quantifiers (all of them are **formulas**):
	- `all x: S | F` — F holds for every x in S
	- `some x: S | F` — F holds for at least one x in S
	- `no x: S | F` — F holds for no x in S
	- `one x: S | F` — F holds for exactly one x in S
	- `lone x: S | F` — F holds for at most one x in S
- `disj x, y: S` — x and y are distinct (used with `all`/`some`).
- `let x = e | F` — local definition of x inside F.
- Membership and equality: `x in e`, `x not in e`, `e = e'`, `e != e'`.

> [!tip] Same keywords, two roles
> `one`, `lone`, `some`, `set` are **multiplicities** in declarations (`f: lone Addr`) and **quantifiers** in formulas (`some n: Name | …`); `no` is the quantifier counterpart of `set`.

`:>` / `<:` restriction, `++` override and arithmetic are marginal in this course (Alloy has **almost no arithmetic**).

#### 1.3.3. Formulas, Numbers and Cardinality

`all`, `some`, `no`, `one`, `lone` are **formulas**. Cardinality `#e` and comparison operators (`>`, `<`, `>=`, `=`) give numbers, so `#b.addr > 1` is a formula too. Counts such as `#(n1.belongsTo & n2.belongsTo) > 0` are the crude way to say "non-empty intersection" when an `=` between relations is not convenient.

### 1.4. Kinds of Paragraphs

| Element | Role | Must be invoked? |
|---|---|---|
| `sig` / `enum` | define types and relationships | no (always in force) |
| `fact` | global constraint; holds in **every** model | no (always in force) |
| `pred` | reusable **boolean** expression / operation | yes (`run` or call) |
| `fun` | reusable **relational** expression | yes (call it) |
| `assert` | property we want to check | yes (`check`) |
| `run` / `check` | commands: find a model satisfying a pred / find a counterexample to an assert | — |

- Signatures, facts, predicates and functions define **what a correct world (model) looks like**.
- Assertions and commands define **which checks** are performed over those worlds.
- Facts vs predicates: both express constraints; facts hold **globally** for any atom/relation, predicates only when invoked.
- A fact with several constraints considers them implicitly in **and**; facts can be named for readability.

### 1.5. Commands, Scope and Bounded Verification

```alloy
run show                       // find an instance of pred show
run show for 3                 // up to 3 atoms per top-level signature
run show for 3 but 1 Book      // 3 in general, 1 atom for Book
run show for 3 but 1 Book, 3 steps   // scope + number of time instants
check A for 8                  // look for a counterexample to assert A, scope 8
```

- The Analyzer cannot explore the (usually infinite) set of models: **you must bound the search**.
- `check` searches for a **counterexample**, i.e. an instance violating the assertion.
- **Bounded verification**: if no counterexample is found within the scope there is **no guarantee** the assertion holds in general.
	- **testing**: a few cases of *arbitrary size*
	- **bounded verification**: *all cases* within a certain *bound*

### 1.6. Temporal Layer — Alloy 6

#### 1.6.1. Mutable State

| Syntax | Meaning |
|---|---|
| `var f: e`, `var sig S {}` | the relation/set may change from one instant to the next |
| `f'` | value of `f` in the **next** instant |
| `f''` | value two instants later |
| `after F` | F holds in the next instant |
| `p; q` | `p` holds now and `q` in the next instant (sequence) |
| `run … for N steps` | number of time instants to consider |

An operation is a predicate relating the current and next state; it should contain the effect (`x' = …`), the precondition, and the **frame conditions** for everything that does not change (`y' = y`).

#### 1.6.2. Temporal Operators

| FUTURE | PAST | Semantics |
|---|---|---|
| `always F` | `historically F` | F true in i iff F is true in **each** instant k >= i (resp. k <= i) |
| `eventually F` | `once F` | F true in i iff F is true in **some** instant k >= i (resp. k <= i) |
| `after F` | `before F` | F true in the next / previous instant |

- `before F` is **false in the first instant** (no previous instant), whatever F is.
- A constraint about evolution must be wrapped in `always`, otherwise it only constrains the instants it is evaluated in.
- `eventually` is the dual of `always`: `eventually F` iff `not always not F`.

### 1.7. Modelling Recipe

1. **Signatures** from the class diagram: one `sig` per class, fields per association, multiplicity keywords from the UML multiplicities, `enum`/`one sig` for enumerations, appended facts for structural invariants.
2. **Facts** for each constraint in the natural language ("only if", "never", "if … then …"), each with a meaningful name.
3. **Predicates** for operations: precondition, effect via `'`, frame conditions.
4. **Assertions** for goals and for the properties you want to check; then `check` them and inspect counterexamples.
5. **Commands** with a scope large enough to be convincing (`run show`, `check … for 8`, `for N steps`).

---

## 2. Part II — Examples

### 2.1. Address Book

```alloy
sig Name, Addr {}
sig Book {
	addr: Name -> lone Addr
}
```

- `Name` and `Addr` are two types of entities; `Book` is another.
- `addr` is a **ternary** relation `b -> n -> a` (it lives *inside* a book).
- `lone`: each `Name` corresponds to *at most one* `Addr` (in a given book).

Navigation (join) with `.`:

```alloy
myName.(Book.addr)   // all addresses of myName in any book
```

Static analysis — `pred` + `run` searches for instances:

```alloy
pred show {}
run show for 3 but 1 Book
```

Constraining the instance:

```alloy
pred show [b: Book] {
	#b.addr > 1              // more than one name->addr pair
	#Name.(b.addr) > 1       // more than one distinct name has an address
}

pred show2 [b: Book] {
	#b.addr > 1
	some n: Name | #n.(b.addr) > 1   // can it be satisfied? no (lone!)
}
```

#### 2.1.1. Dynamic Analysis, Old Style (pre-Alloy 6)

Before mutable relations, evolution was modelled with two versions of the book (`b` and `bpost`):

```alloy
pred add [b, bpost: Book, n: Name, a: Addr] {
	bpost.addr = b.addr + n->a
}

pred del [b, bpost: Book, n: Name] {
	bpost.addr = b.addr - n->Addr
}

pred showAdd [b, bpost: Book, n: Name, a: Addr] {
	add[b, bpost, n, a]
	#Name.(bpost.addr) > 1
}
run showAdd
```

#### 2.1.2. Assertions and Counterexamples

```alloy
assert delUndoesAdd {
	all b, bpost, bppost: Book, n: Name, a: Addr |
		add[b, bpost, n, a] and del[bpost, bppost, n]
		implies b.addr = bppost.addr
}
check delUndoesAdd for 3
```

- Here a counterexample exists: `add` on a name that already exists overwrites the old address, then `del` removes the name entirely.
- Fix: only add names that are not already present.

```alloy
assert delUndoesAdd {
	all b, bpost, bppost: Book, n: Name, a: Addr |
		no n.(b.addr) and add[b, bpost, n, a] and del[bpost, bppost, n]
		implies b.addr = bppost.addr
}
```

#### 2.1.3. Functions Used in Assertions

```alloy
fun lookup [b: Book, n: Name] : set Addr {
	n.(b.addr)
}

assert addLocal {
	all b, bpost: Book, n1, n2: Name, a: Addr |
		add[b, bpost, n1, a] and n1 != n2
		implies lookup[b, n2] = lookup[bpost, n2]
}
check addLocal for 3 but 2 Book
```

### 2.2. Family Tree

```alloy
abstract sig Person {
	father: lone Man,
	mother: lone Woman
}
sig Man extends Person {
	wife: lone Woman
}
sig Woman extends Person {
	husband: lone Man
}
```

#### 2.2.1. Predicates and Functions over the Tree

```alloy
fun grandpas [p: Person] : set Person {
	p.(mother+father).father
}

pred ownGrandpa [p: Person] {
	p in p.grandpas        // same as: p in grandpas[p]
}

run ownGrandpa for 4 Person
```

The run finds a model where someone is his own grandpa (and also his own father) — the spec is too weak.

#### 2.2.2. Facts: Closure and Inverse Relations

```alloy
fact {
	no p: Person | p in p.^(mother+father)   // no one is his own ancestor
	wife = ~husband                          // transpose
}
```

#### 2.2.3. Social Conventions and Relative Strength

```alloy
// no one is married to an ancestor: intersection of relations
fact SocialConvention {
	no ((wife+husband) & ^(mother+father))
}

fun ancestors [p: Person]: set Person {
	p.^(mother+father)
}

// stronger version: spouses have no common ancestors
fact noCommonAncestors {
	all p1: Man, p2: Woman |
		p1->p2 in wife implies ancestors[p1] & ancestors[p2] = none
}

// weaker, brother/sister-style constraint
fact SocialConvention3 {
	no ((wife+husband) & (mother+father).~(mother+father))
}
```

"Proof" of relative strength by comparing assertions:

```alloy
assert Stronger {
	noCommonAncestors implies SocialConvention3
}
check Stronger for 8

assert NotStronger {
	SocialConvention3 implies noCommonAncestors
}
check NotStronger for 8
```

`Stronger` has no counterexample, `NotStronger` does ⇒ `noCommonAncestors` is stronger.

#### 2.2.4. Adding Assertions

```alloy
assert NoSelfFather {
	no m: Man | m = m.father
}
check NoSelfFather
```

### 2.3. Device: Temporal Operators at Work

```alloy
sig Device { var status: DevStatus }
enum DevStatus { Working, Broken }

// once broken, never repaired
fact NoRepair {
	all d: Device |
		always (d.status = Broken implies after always d.status = Broken)
}

// a working device will eventually break
fact NotAlwaysFunctioning {
	all d: Device |
		always (d.status = Working implies eventually d.status = Broken)
}

// working now implies always been working
fact NowWorkingPreviouslyWorking {
	all d: Device |
		always (d.status = Working implies historically d.status = Working)
}

// equivalent, using before
fact NowWorkingPreviouslyWorking2 {
	all d: Device |
		after always (d.status = Working implies before d.status = Working)
}

pred break [d: Device] {
	d.status = Working
	d.status' = Broken
}

// if broken, it must have broken in the past
fact IfBrokenDidBreak {
	all d: Device |
		always (d.status = Broken implies once break[d])
}
```

### 2.4. Mailbox: Mutable Signatures and Operations

```alloy
var sig Message {}

// Trashed ⊆ Message, overlapping subsets allowed (unlike extends)
var sig Trashed in Message {}

pred delete [m: Message] {
	m not in Trashed
	Trashed' = Trashed + m
	Message' = Message
}

pred restoreEnabled [m: Message] { m in Trashed }

pred restore [m: Message] {
	restoreEnabled[m]
	Trashed' = Trashed - m
	Message' = Message
}

pred deleteTrashed {
	#Trashed > 0
	after #Trashed = 0
	Message' = Message - Trashed
}

pred doNothing {
	Message' = Message
	Trashed' = Trashed
}

pred receiveMessages {
	#Message' > #Message
	Message in Message'
	Trashed' = Trashed
}
```

Behaviour: initially the trash is empty, then at every step one of the operations happens.

```alloy
fact systemBehavior {
	no Trashed
	always (
		(some m: Message | delete[m] or restore[m])
		or deleteTrashed
		or receiveMessages
		or doNothing
	)
}
```

Assertions to check:

```alloy
// restoring implies a previous delete
assert restoreAfterDelete {
	all m: Message | always restore[m] implies once delete[m]
}

// if all messages are trashed and the trash is emptied, no messages remain
assert deleteAll {
	always ((Message in Trashed and deleteTrashed) implies after always no Message)
}

// the set of messages never changes  (false: receiveMessages)
assert messagesNeverChange {
	always (Message' in Message and Message in Message')
}

// if nothing is ever deleted, the trash is never emptied
assert ifMessagesNotDeletedTrashNotEmptied {
	(always all m: Message | not delete[m]) implies always not deleteTrashed
}
```

> [!warning] Common trap
> `var sig Message {}` with `Message' = Message` in `delete`/`restore`, but `receiveMessages` grows it: `messagesNeverChange` therefore fails.

### 2.5. Exam-Style Exercise Patterns

All examples follow the recipe of [[#1.7. Modelling Recipe]]: **signatures (+ facts on structure) → facts for constraints → predicates for operations → assertions for goals**.

#### 2.5.1. Communication Networks — overlay/underlay

```alloy
sig Network {
	uses: lone Network
} { this not in uses }

sig Node {
	belongsTo: Network,
	isLinkedTo: some Node,
	isAttachedTo: lone Node
} {
	this not in isAttachedTo and
	this not in isLinkedTo
}
```

- `uses` = "uses hierarchy" / vertical composition: overlay uses underlay.
- `isLinkedTo` = links inside a network; `isAttachedTo` = node attached to a node of the underlay (the session endpoint).
- Not modelled: the link/session correspondence itself (a link in the overlay implemented by a session in the underlay), machines, OS, directories.

```alloy
fact linkedNodesInTheSameNetwork {
	all disj n1, n2: Node |
		n1 in n2.isLinkedTo implies #(n1.belongsTo & n2.belongsTo) > 0
	// alternative: ... implies n1.belongsTo = n2.belongsTo
}

fact isAttachedToInConnectedNetworks {
	all disj n1, n2: Node |
		n1 in n2.isAttachedTo implies #(n1.belongsTo & n2.belongsTo.uses) > 0
	// alternative: ... implies n1.belongsTo in n2.belongsTo.uses
}

fact overlayNodeShouldBeAttached {
	all ntw: Network |
		(some ntw2: Network | ntw2 in ntw.uses)
		implies all n: Node | n.belongsTo = ntw implies n.isAttachedTo != none
}

fact notEmptyNetwork {
	all ntw: Network | some n: Node | n.belongsTo = ntw
}

pred isReachable [n1: Node, n2: Node] {
	n1 in n2.^isLinkedTo    // path from n2 to n1
}
```

> [!tip] Reading direction
> `n1 in n2.isLinkedTo` means the pair `(n2, n1)` is in the relation (n2 is linked to n1). Reachability from n2 back to n1 = `n2.^isLinkedTo`.

#### 2.5.2. Traffic Lights

```alloy
abstract sig Color {}
one sig GREEN, RED extends Color {}
abstract sig Traffic {}
one sig FLOWING, STOPPED extends Traffic {}

sig Semaphore { color: one Color }
sig Road { traffic: one Traffic }
sig Intersection {
	connection: Semaphore -> Road
} { #connection = 2 }

fun getIRoads [i: Intersection]: set Road { Semaphore.(i.connection) }
fun getSRoads [s: Semaphore]: set Road { s.(Intersection.connection) }
fun getSemaphores [i: Intersection]: set Semaphore { (i.connection).Road }
```

```alloy
fact intersectionStructure {
	(all i: Intersection |
		(let s = getSemaphores[i] | #s = 2) and
		(let r = getIRoads[i] | #r = 2))
	and
	all sem: Semaphore | (let rd = getSRoads[sem] | #rd = 1)
}

fact greenIsExclusive {
	all i: Intersection |
		let s = getSemaphores[i] |
			all s1, s2: Semaphore |
				(s1 in s and s2 in s and s1 != s2) implies s1.color != s2.color
}

fact goWithGreen {
	(all s: Semaphore | let r = getSRoads[s] |
		s.color = RED iff r.traffic = STOPPED)
	and
	(all r: Road | r.traffic = STOPPED implies #((Intersection.connection).r) > 0)
}

pred show { #Intersection = 1 }
run show for 8
```

#### 2.5.3. Social Network

```alloy
sig User {
	follows: set User,
	has: Timeline
} { this not in follows }

sig Timeline { stores: set Message }
sig Message { issuedBy: one User }

fact { all t: Timeline | one u: User | u.has = t }

// timelines contain only messages by followed users
fact { all t: Timeline, m: Message |
	m in t.stores implies m.issuedBy in (has.t).follows }
```

Alloy 6 version (publishing new messages over time):

```alloy
var sig Message { var issuedBy: User }
sig Timeline { var stores: set Message }

fact {
	always (all t: Timeline, m: Message |
		m in t.stores implies m.issuedBy in (has.t).follows)
}

// every message by a followed user is in the follower's timeline
fact { always (all m: Message, u: User |
	m.issuedBy in u.follows implies m in u.has.stores) }
```

#### 2.5.4. City Center Area Monitor

```alloy
enum Boolean { True, False }

sig User { owns: some Vehicle }
sig Vehicle { has: one LicensePlate, one cca: CCA }
sig LicensePlate { one v: Vehicle | v.has = this }
sig Gate { var collLicPlatesToday: set LicensePlate }
sig CCA {
	has_installed: some Gate,
	var is_active: Boolean
}
// Vehicle: one u: User | this in u.owns ; one cca: CCA | this in cca.has_installed
```

```alloy
fact activeCCAdef {
	all cca: CCA |
		cca.is_active = True
		and eventually cca.is_active = False
		and always (cca.is_active = False implies always cca.is_active = False)
}
```

#### 2.5.5. Airbus Braking Logic

```alloy
abstract sig Bool {}
one sig True, False extends Bool {}
enum AirCraftState { Flying, TakingOff, Landing, MovingOnRunaway }

sig Wheels {
	var retracted: Bool,
	var turning: Bool
} { always turning = True implies retracted = False }

sig Aircraft {
	var status: one AirCraftState,
	wheels: one Wheels,
	var wheelsPulsesOn: one Bool,
	var reverseThrustEnabled: one Bool
} { always status = Flying implies wheels.retracted = True }

fact domainAssumptions {
	all a: Aircraft |
		always (a.wheelsPulsesOn = True iff a.wheels.turning = True)
	all a: Aircraft |
		always (a.wheels.turning = True iff a.status = MovingOnRunaway)
}

fact requirement {
	all a: Aircraft |
		always (a.reverseThrustEnabled = True iff a.wheelsPulsesOn = True)
}

assert goal {
	all a: Aircraft |
		always (a.reverseThrustEnabled = True iff a.status = MovingOnRunaway)
}
check goal

// Landing comes after Flying and before MovingOnRunaway
fact {
	all a: Aircraft |
		always (a.status = Landing
			implies (once a.status = Flying and eventually a.status = MovingOnRunaway))
}
```

> [!note] Lessons
> - No counterexample ≠ correct model: the spec can be internally coherent but wrong w.r.t. the world.
> - The model abstracts away delays between correlated events; make them explicit if critical.
> - Facts that talk about evolution must be wrapped in `always`.

#### 2.5.6. Towers and Cubes

```alloy
abstract sig Size {}
one sig Large, Medium, Small extends Size {}

sig Cube {
	size: Size,
	cubeUp: lone Cube
} { cubeUp != this }

fact noCircularPiling { no c: Cube | c in c.^cubeUp }

fact pilingUpRules {
	all c1, c2: Cube |
		c1.cubeUp = c2 implies
		(c1.size = Large
		or c1.size = Medium and (c2.size = Medium or c2.size = Small)
		or c1.size = Small and c2.size = Small)
}
```

Note: `cubeUp: lone Cube` still allows one cube to be on top of two different cubes — the spec does not rule it out (would need `~cubeUp` to be `lone`/`one` per cube).

```alloy
pred canPileUp [cUp: Cube, cDown: Cube] {
	cDown != cUp and
	(cDown.size = Large
	or cDown.size = Medium and (cUp.size = Medium or cUp.size = Small)
	or cDown.size = Small and cUp.size = Small)
}
```

With a non-stackable **Top** component:

```alloy
abstract sig Block {}
sig Top extends Block {}
sig Cube extends Block {
	size: Size,
	cubeUp: lone Block
} { cubeUp != this }

pred canPileUp [bUp: Block, bDown: Block] {
	bDown != bUp and bDown in Cube and
	(bUp in Top
	or bDown.size = Large
	or bDown.size = Medium and (bUp.size = Medium or bUp.size = Small)
	or bDown.size = Small and bUp.size = Small)
}
```

#### 2.5.7. Luggage Keeper

```alloy
abstract sig Status {}
one sig Safe, Unsafe extends Status {}

sig Luggage { luggageStatus: one Status }
sig User {
	owns: set Luggage,
	carries: set Luggage,
	hasKeys: set EKey
}
sig Locker {
	hasKey: lone EKey,
	storesLuggage: lone Luggage
}
sig Shop { lockers: some Locker }
sig EKey {}

// D1: safe iff carried by its owner, or stored in a locker whose key the owner holds
fact DAsafeLuggages {
	all lg: Luggage |
		lg.luggageStatus in Safe iff
		all u: User | lg in u.owns implies
			(lg in u.carries
			or some lk: Locker |
				lg in lk.storesLuggage and lk.hasKey != none and lk.hasKey in u.hasKeys)
}

// R1: a key opens only one locker
fact requirement {
	all ek: EKey | no disj lk1, lk2: Locker |
		ek in lk1.hasKey and ek in lk2.hasKey
}

// G1: all luggage of each user is safe
pred goal {
	all u: User, lg: Luggage | lg in u.owns implies lg.luggageStatus in Safe
}
```

`GenKey` requires mutable fields (`var hasKey`, `var storesLuggage`):

```alloy
pred GenKey [lk: Locker] {
	lk.hasKey = none                                  // precondition: locker is free
	lk.storesLuggage' = lk.storesLuggage              // frame condition
	some ek: EKey | lk.hasKey' = ek                   // postcondition: new key
}
```

#### 2.5.8. Recipe Management

```alloy
sig Ingredient {}
abstract sig Cuisine {}
one sig Italian, Indian, French, Japanese extends Cuisine {}

sig Recipe {
	ingredients: some Ingredient,
	cuisine: Cuisine
}

sig User {
	favoriteCuisine: set Cuisine,
	favoriteRecipes: set Recipe,
	availableIngredients: set Ingredient,
	suggestedRecipes: set Recipe
} {
	suggestedRecipes & favoriteRecipes = none
	all sr: suggestedRecipes | sr.ingredients & availableIngredients != none
}

pred missingIngredients [u: User, r: Recipe, res: set Ingredient] {
	r in u.suggestedRecipes                    // precondition
	res = r.ingredients - u.availableIngredients // postcondition
}

pred suggestRecipe [u: User, possibleRecipes: some Recipe, res: set Recipe] {
	// postcondition
	(all r: res |
		r in possibleRecipes and
		not r in u.favoriteRecipes and
		r.ingredients & u.availableIngredients != none)
	and
	(u.availableIngredients & possibleRecipes.ingredients != none
		implies (some r: possibleRecipes |
			r.ingredients & u.availableIngredients != none and
			not r in u.favoriteRecipes and r in res))
	and
	(u.availableIngredients & possibleRecipes.ingredients = none implies res = none)
}
```

---

## 3. Checklist / Pitfalls

> [!abstract] Before submitting an Alloy model
> - [ ] Every constraint from the text is a **fact** (global) unless it is an operation (**pred**) or a goal (**assert**).
> - [ ] Structural constraints from UML multiplicities are written in signature **appended facts** `{ … }`.
> - [ ] In Alloy 6, relations that evolve are declared `var`, effects use `'`, invariants over time use `always`.
> - [ ] Preconditions before postconditions in operation predicates; add **frame conditions** (`x' = x`) for untouched state.
> - [ ] `lone` vs `set` vs `some` checked against the natural language ("at most one", "any number", "at least one").
> - [ ] `^` for reachability, `~` for inverse relations, `&` for intersection, `disj` when distinctness is needed.
> - [ ] Run/check with a scope large enough, and remember the result is only **bounded** verification.

---

Related: [[_Software Engineering 2 MOC]], [[Requirement Engineering]], [[UMLs]]
Source: [[03a.AlloyPart1-2.pdf]], [[03b.AlloyExercises.pdf]]
