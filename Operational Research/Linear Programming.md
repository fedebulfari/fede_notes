---
date: 04-11-2026
subject: Operational Research
description: Linear programming theory — polyhedra and vertices, primal/dual pairs, weak and strong duality, Farkas' lemma, feasible growth directions, primal-dual simplex, complementary slackness, shadow prices, sensitivity and reduced costs
tags: []
---

# Linear Programming

> [!summary] Overview
> [[Problem Optimization]] gave the language of LP; [[Flows]] solved one special LP combinatorially. This note develops the general theory. The feasible set is a **polyhedron**; if the optimum is finite it is attained at a **vertex**, and a vertex is a point where $n$ independent constraints are tight. Every LP has a **dual** built from the same data, whose variables price the constraints. **Weak duality** ($cx\le yb$) turns any pair of feasible solutions with equal value into a proof of optimality. **Strong duality** says the two optima coincide whenever both problems are feasible, and **Farkas' lemma** says that at any feasible point either a **feasible growth direction** exists or the active constraints already generate the cost vector — that dichotomy is the **primal-dual simplex** algorithm. **Complementary slackness** links tight constraints to positive dual variables, which are the **shadow prices** of the resources; read through a **basis**, the same conditions give the reduced-cost test behind the primal simplex.

> [!note] Scope
> The slide programme covers §1.2, §2, §3.1–3.2, §3.4, §4 (including 4.3–4.4) and §5 without 5.2. The full cone algorithm behind the primal-dual method (§3.3) and the primal simplex variant (§5.2) are included here for context; the examinable core is duality, growth directions, complementary slackness, shadow prices and the basis optimality test.

## 1. Form and Transformations

A **linear programming problem** optimizes a linear function over a set described by finitely many linear inequalities or equations:

$$ \max\ cx \quad \text{s.t.} \quad Ax\le b,\qquad x\in\mathbb R^n $$

with $A$ an $m\times n$ real matrix, $b\in\mathbb R^m$, $c\in\mathbb R^n$. The feasible set is the intersection of $m$ half-spaces, or of hyperplanes when some constraints are equalities.

Two reference forms are used throughout:

| Form | Name | Used for |
| :--- | :--- | :--- |
| $\max\{cx : Ax\le b\}$ | **canonical** / general | the geometry and the primal-dual algorithm of this chapter |
| $\min\{cx : Ax=b,\ x\ge0\}$ | **standard** | computations and bases |

Every LP can be rewritten in either form:

| Transformation | Replacement |
| :--- | :--- |
| $\max cx$ | $-\min(-c)x$ (same optimizers) |
| $A_i x\ge b_i$ | $-A_i x\le -b_i$ |
| $A_i x= b_i$ | $A_i x\le b_i$ and $-A_i x\le -b_i$ |
| $x_j$ free | $x_j=x_j^+-x_j^-$, $x_j^+,x_j^-\ge0$ |
| $A_i x\le b_i$ | $A_i x+s_i=b_i$, $s_i\ge0$ (slack) |
| $A_i x\ge b_i$ | $A_i x-s_i=b_i$, $s_i\ge0$ (surplus) |

> [!warning] Sign constraints are constraints
> In canonical form the variables are **free** unless constrained. Writing $x_D,x_W\ge0$ means adding the rows $-x_D\le0$ and $-x_W\le0$ to $A$; they are not implicit. This matters when writing the dual: each of those rows receives its own dual variable ($y_4,y_5$ in the doors example), and forgetting them changes the dual problem.

> [!note] Notation
> $cx$ is the scalar product of $c$ and $x$; depending on context a vector is read as a row or a column. In the dual, $yA$ is the product of the row vector $y$ by $A$, and $A_i$ is the $i$-th row of $A$ (the gradient of the $i$-th constraint), $A^j$ its $j$-th column.

## 2. Geometry of the Feasible Set

- **Convex set** $S$: for all $x,y\in S$ and $\lambda\in[0,1]$, $\lambda x+(1-\lambda)y\in S$.
- **Cone** $C$: $x\in C\Rightarrow \lambda x\in C$ for all $\lambda\ge0$.
- **Convex cone**: $\lambda x+\mu y\in C$ for all $x,y\in C$ and $\lambda,\mu\ge0$.
- **Polyhedral cone**: $C=\{x : A_i x\le0,\ i=1,\dots,m\}$.
- **Finitely generated cone**: $C=\{\lambda_1 x^1+\dots+\lambda_r x^r : \lambda_i\ge0\}$.
- **Polyhedron**: $P=\{x : A_i x\le b_i,\ i=1,\dots,m\}$; a **polytope** is a bounded polyhedron.

Three definitions describe the same special point of a polyhedron:

> [!important] Extreme point, vertex, basic solution
> Let $P=\{x : A_i x\le b_i,\ i=1,\dots,m\}$ and $x\in P$.
> - $x$ is an **extreme point** if it is not a proper convex combination of two other points of $P$.
> - $x$ is a **vertex** if there is $c\in\mathbb R^n$ with $cx>cy$ for every $y\in P$, $y\ne x$ — some linear objective is uniquely maximized at $x$.
> - $x$ is a **basic feasible solution** if among the active constraints $I(x)=\{i : A_i x=b_i\}$ there are $n$ vectors $A_i$ that are linearly independent.
>
> The three definitions are equivalent. *Vertex ⇒ extreme:* a strict linear inequality survives any convex combination. *Extreme ⇒ basic:* if fewer than $n$ independent active rows exist, choose $d\ne0$ with $A_i d=0$ for all $i\in I(x)$; then $x\pm\varepsilon d$ stays feasible for small $\varepsilon$, so $x$ is a convex combination. *Basic ⇒ vertex:* take $c=\sum_{i\in B}A_i$ for a basis $B\subseteq I(x)$; then $cy\le\sum_{i\in B}b_i=cx$, with equality only when every constraint in $B$ is tight, which pins $y=x$.

> [!note] Why vertices matter
> A polyhedron has finitely many extreme points. In general it decomposes as
> $$ P=Q+C, $$
> with $Q=\operatorname{conv}\{v^1,\dots,v^s\}$ a polytope and $C$ a polyhedral cone (**Motzkin decomposition**). If $\max\{cx : x\in P\}$ has a finite optimum, then one of the extreme points $v^k$ of $Q$ is optimal: if $cd>0$ for some $d\in C$ the problem is unbounded, otherwise the cone part can be dropped.

The separation theorem is the geometric engine behind duality:

> [!important] Separating hyperplane
> If $S\subset\mathbb R^n$ is closed and convex and $c\notin S$, there are $x\in\mathbb R^n$ and $\varepsilon>0$ such that
> $$ cx\ge zx+\varepsilon \qquad \forall z\in S. $$
> *Proof idea:* take $z_0$, the point of $S$ nearest to $c$, and set $x=c-z_0$; moving from $z_0$ towards any $z\in S$ increases the distance to $c$, which gives $(c-z_0)(z-z_0)\le0$ and hence the inequality.

This is exactly the **linear classifier**: observations of class 1 must satisfy $a_i x\le y$, those of class 2 $a_i x\ge y+\varepsilon$; the weights $x$ are the normal of a hyperplane separating the two clouds, and $y$ is its threshold. When the two classes cannot be separated, the LP is infeasible.

## 3. Worked Geometry: Doors and Windows

A small firm produces aluminium doors ($D$) and wooden windows ($W$):

| Resource (hours per item) | $D$ | $W$ | Availability |
| :--- | :---: | :---: | :---: |
| Smith $A_1$ | 1 | 0 | 4 |
| Carpenter $A_2$ | 0 | 2 | 12 |
| Assembler $A_3$ | 3 | 2 | 18 |
| Profit (€ per item) | 30 | 50 | |

$$ \max\ 30x_D+50x_W \quad\text{s.t.}\quad x_D\le4,\quad 2x_W\le12,\quad 3x_D+2x_W\le18,\quad x_D,x_W\ge0 $$

The feasible region is the pentagon with vertices

| Vertex | $(0,0)$ | $(4,0)$ | $(4,3)$ | $(2,6)$ | $(0,6)$ |
| :--- | :---: | :---: | :---: | :---: | :---: |
| Profit | 0 | 120 | 270 | **360** | 300 |

The level lines $30x_D+50x_W=z$ are parallel to each other and move in the direction of the gradient $c=(30,50)$. The last contact with the polygon is the vertex $(2,6)$, where $A_2$ and $A_3$ are active: $x=(2,6)$, $z=360$.

![[Linear Programming-1793790112132.webp|357]]
At this point $c$ lies inside the cone generated by the active constraint gradients $A_2=(0,2)$ and $A_3=(3,2)$ — the geometric form of optimality. The dual solution is $y=(0,15,10,0,0)$ ($y_4,y_5$ are the multipliers of $x_D,x_W\ge0$, both zero): the smith's hours are not fully used, so their price is zero; one more carpenter hour is worth €15 and one more assembler hour €10. Indeed $12\cdot15+18\cdot10=360$.

## 4. The Dual Problem

Every LP has a **dual**, another LP built from the same matrix with the roles of $b$ and $c$ exchanged. Two examples motivate the construction.

### 4.1. Symmetric Pair: Diet Problem

A chicken breeder must mix two cereals $A,B$ so that the daily ration contains at least 11 units of carbohydrates, 20 of proteins and 9 of vitamins:

| Nutrient | $A$ | $B$ | Minimum |
| :--- | :---: | :---: | :---: |
| Carbohydrates | 2 | 2 | 11 |
| Proteins | 4 | 2 | 20 |
| Vitamins | 1 | 3 | 9 |
| Cost | 12 | 16 | |

$$ \text{P:}\quad \min\ 12x_1+16x_2 \quad\text{s.t.}\quad
\begin{aligned}
2x_1+2x_2&\ge11\\
4x_1+2x_2&\ge20\\
x_1+3x_2&\ge9\\
x_1,x_2&\ge0
\end{aligned} $$

The **chicken pill seller** fixes prices $y_1,y_2,y_3$ for one unit of carbohydrate, protein and vitamin. To be competitive, the pill equivalent of a unit of cereal $A$ must not cost more than $A$ itself, and similarly for $B$:

$$ \text{D:}\quad \max\ 11y_1+20y_2+9y_3 \quad\text{s.t.}\quad
\begin{aligned}
2y_1+4y_2+y_3&\le12\\
2y_1+2y_2+3y_3&\le16\\
y_1,y_2,y_3&\ge0
\end{aligned} $$

This is a **symmetric pair**: both problems have inequality constraints and sign-restricted variables.

### 4.2. Asymmetric Pair: Transportation

Factories $i=1,\dots,n$ produce $a_i$, warehouses $j=1,\dots,m$ require $d_j$, with $\sum_i a_i=\sum_j d_j$, and $c_{ij}$ is the unit transport cost:

$$ \text{P:}\quad \min\ \sum_{i,j}c_{ij}x_{ij} \quad\text{s.t.}\quad
\sum_j x_{ij}=a_i,\qquad \sum_i x_{ij}=d_j,\qquad x_{ij}\ge0 $$

A transport company buys at factory $i$ at price $\lambda_i$ and resells at warehouse $j$ at price $\mu_j$; its margin cannot exceed the transport cost it replaces:

$$ \text{D:}\quad \max\ \sum_i a_i\lambda_i+\sum_j d_j\mu_j \quad\text{s.t.}\quad \lambda_i+\mu_j\le c_{ij} $$

Here the primal has equality constraints and non-negative variables; the dual has free variables and inequality constraints. This is an **asymmetric pair**. The constraint matrix is the node-arc incidence matrix of the complete bipartite graph between factories and warehouses — the transportation LP is a min-cost flow on that graph, as in [[Flows]].

> [!note] The two pairs are equivalent
> A symmetric pair becomes asymmetric by doubling free variables ($x=x^+-x^-$), and an asymmetric pair becomes symmetric by writing equalities as two inequalities. The duality theorems below are stated for one form but hold for all.

### 4.3. Writing the Dual Mechanically

Read the table from the **primal min** side (use the mirror image for a primal max): each primal constraint gives a dual variable, each primal variable gives a dual constraint.

| Primal (min) | Dual (max) |
| :--- | :--- |
| $A_i x\ge b_i$ | $y_i\ge0$ |
| $A_i x\le b_i$ | $y_i\le0$ |
| $A_i x=b_i$ | $y_i$ free |
| $x_j\ge0$ | $yA^j\le c_j$ |
| $x_j\le0$ | $yA^j\ge c_j$ |
| $x_j$ free | $yA^j=c_j$ |

For a primal **max**: reverse every inequality, i.e. $A_i x\le b_i\Rightarrow y_i\ge0$, $A_i x\ge b_i\Rightarrow y_i\le0$, $x_j\ge0\Rightarrow yA^j\ge c_j$, $x_j\le0\Rightarrow yA^j\le c_j$.

> [!example]- Writing a dual directly
> $$ \max\ 12x_1+7x_2 \quad\text{s.t.}\quad 5x_1+7x_2=8,\quad 4x_1+2x_2\ge15,\quad 2x_1+x_2\le3,\quad x_1\ge0,\ x_2\text{ free} $$
> The first constraint is an equality, so $y_1$ is free; the second is $\ge$ in a max problem, so $y_2\le0$; the third is $\le$, so $y_3\ge0$. The variable $x_1\ge0$ gives a $\ge$ constraint, $x_2$ free gives an equality:
> $$ \min\ 8y_1+15y_2+3y_3 \quad\text{s.t.}\quad
> \begin{aligned}
> 5y_1+4y_2+2y_3&\ge12\\
> 7y_1+2y_2+y_3&=7\\
> y_2\le0,\quad y_3&\ge0
> \end{aligned} $$

### 4.4. Geometry of the Dual

For the asymmetric pair, the dual constraints read

$$ y_1A_1+y_2A_2+\dots+y_mA_m=c,\qquad y\ge0. $$

So the dual asks: **express the cost vector $c$ as a non-negative combination of the constraint gradients**, minimizing the weighted cost $\sum_i b_i y_i$. The dual feasible region lives in the space of multipliers, not in the space of the decision variables.

At an optimal vertex $x$, only the active constraints can have $y_i>0$, and $c$ belongs to the cone generated by their gradients. In the doors example, at $(2,6)$ the active rows are $A_2,A_3$ and indeed $c=15A_2+10A_3$. At the non-optimal vertex $(4,3)$, the active rows are $A_1,A_3$, and $c$ is **not** in their cone: $c=(30,50)$ would need $y_3=25$ and then $y_1=30-3\cdot25=-45<0$. A negative multiplier is precisely the certificate that the vertex can be improved.

## 5. Duality Theorems

### 5.1. Weak Duality

> [!important] Weak duality
> If $x$ is feasible for P: $\max\{cx : Ax\le b\}$ and $y$ is feasible for D: $\min\{yb : yA=c,\ y\ge0\}$, then
> $$ cx\le yb. $$

*Proof:* $cx=yAx$ because $yA=c$; and $yAx\le yb$ because $Ax\le b$ and $y\ge0$. $\blacksquare$

Two immediate consequences:

- **Certificate of optimality.** If $cx=yb$ for feasible $x,y$, then both are optimal: no primal solution can beat $yb$ and no dual solution can beat $cx$.
- If P is unbounded, D is infeasible; a single dual feasible point would bound P.

This is exactly the logic of the max-flow/min-cut theorem: a flow and a cut of equal value prove each other optimal.

### 5.2. Strong Duality

> [!important] Strong duality
> If P and D both admit feasible solutions, then both have optimal solutions and
> $$ \max\{cx : Ax\le b\}=\min\{yb : yA=c,\ y\ge0\}. $$

*Proof sketch.* Let $x$ be optimal and $I=I(x)$ the active constraints. Since $x$ is optimal, the system $A_I\xi\le0$, $c\xi>0$ has no solution. By Farkas' lemma (below), there is $\eta\ge0$ with $\eta A_I=c$. Set $y_i=\eta_i$ for $i\in I$ and $y_i=0$ otherwise. Then $y$ is dual feasible and
$$ yb=\eta b_I=\eta A_I x=cx, $$
so weak duality makes $x$ and $y$ optimal. $\blacksquare$

An optimal $x$ is therefore characterized by **$c$ belonging to the cone of the active constraint gradients** — the geometric statement used in §4.4.

### 5.3. Farkas' Lemma

> [!important] Farkas' lemma (fundamental theorem of linear inequalities)
> Let $A$ be $m\times n$ of maximum rank and $c\in\mathbb R^n$. Exactly one of the following systems has a solution:
> $$ \text{(i)}\quad \eta A=c,\ \eta\ge0; \qquad\qquad \text{(ii)}\quad A\xi\le0,\ c\xi>0. $$

*Proof.* If (i) holds and (ii) held too, then $0<c\xi=\eta A\xi\le0$, a contradiction. Conversely, if (i) has no solution, $c$ is not in the closed convex cone $S=\{z=\eta A : \eta\ge0\}$. The separating hyperplane theorem gives $\xi$ with $c\xi>z\xi$ for all $z\in S$. Taking $z=0$ gives $c\xi>0$; taking $z=\alpha\eta A$ and letting $\alpha\to\infty$ forces $A\xi\le0$. $\blacksquare$

Geometrically: either $c$ is in the cone generated by the rows of $A$, or there is a direction $\xi$ inside the polar cone along which $c$ still increases. There is no third possibility — this is what makes the optimality test and the improvement step exhaustive.

### 5.4. The Four Possible Cases

| P / D | finite optimum | unbounded | infeasible |
| :--- | :---: | :---: | :---: |
| **finite optimum** | ✓ | – | – |
| **unbounded** | – | – | ✓ |
| **infeasible** | ✓ | ✓ | ✓ |

- If P has a finite optimum, so does D (strong duality).
- If P is unbounded, D is infeasible.
- If P is infeasible, D can be anything: both problems may even be infeasible at once.

## 6. Solving an LP: Feasible Growth Directions

### 6.1. Direction and Step

Start from a feasible $x$ and look for a better point on a ray:

$$ x'=x+\lambda\xi,\qquad \lambda>0. $$

$\xi$ is a **feasible growth direction** if

$$ c\xi>0 \quad\text{(it improves the objective)} \qquad\text{and}\qquad A_I\xi\le0 \quad\text{(it does not leave the polyhedron immediately)}, $$

where $I=I(x)$ is the set of active constraints. Only active constraints restrict an infinitesimal move; inactive ones are at positive distance.

If such a $\xi$ exists, the largest feasible step is set by the inactive constraints that are being approached:

$$ \lambda_{\max}=\min\left\{\frac{b_i-A_i x}{A_i\xi} : i\notin I,\ A_i\xi>0\right\}, $$

with $\lambda_{\max}=+\infty$ when the set is empty — then P is unbounded.

> [!warning] Active vs. all constraints
> The feasibility condition is $A_I\xi\le0$, **not** $A\xi\le0$. Requiring every constraint would forbid moving away from an inactive constraint and would wrongly declare optimal points non-improvable.

### 6.2. Restricted Primal and Dual

The search for $\xi$ is itself an LP, the **restricted primal**:

$$ \text{RP:}\quad \max\ c\xi \quad\text{s.t.}\quad A_I\xi\le0. $$

Its dual, the **restricted dual**, has one variable $\eta_i$ per active constraint:

$$ \text{RD:}\quad \min\ 0\eta \quad\text{s.t.}\quad \eta A_I=c,\ \eta\ge0. $$

RD is a pure feasibility problem. By Farkas' lemma:

- **RD feasible** ⇒ no growth direction ⇒ $x$ is optimal. The proof builds $y=(\eta,0)$, feasible for D with $yb=\eta b_I=\eta A_I x=cx$.
- **RD infeasible** ⇒ RP is unbounded (it always contains $\xi=0$) ⇒ a growth direction exists.

> [!note] LP on cones
> RP has the special form $\max\{c\xi : A\xi\le0\}$: either $0$ is optimal or the problem is unbounded. Either $c$ lies in the cone generated by the rows of $A$, or there is a direction in the polar cone with positive cost. The cone algorithm below decides which, and is the subroutine of the simplex.

### 6.3. Primal-Dual Simplex

```
x feasible; I := {i : A_i x = b_i}
while true:
    if η A_I = c has no solution:
        find ξ with A_I ξ = 0, cξ = 1        # move inside the current face
    else if some η_h < 0:
        find ξ with A_I ξ = -u_h             # cξ = -η_h > 0
    else:
        y := (η, 0); stop                    # optimal
    λ := min{(b_i - A_i x)/(A_i ξ) : i ∉ I, A_i ξ > 0}
    if λ = ∞: stop                           # P unbounded, D empty
    x := x + λξ;  I := {i : A_i x = b_i}
```

- In the first case the dual system is inconsistent: the direction keeps all active constraints tight and makes at least one new constraint active, so $|I|$ grows.
- In the second case $\eta$ exists but has a negative component: the direction relaxes constraint $h$ and improves the objective, so $h$ leaves the active set.
- In the third case $\eta\ge0$ is a dual certificate and the algorithm stops.
- If $x$ is in the interior ($I=\varnothing$), the first move is along $c$ itself.
- When $A_I$ is square and invertible, the direction is explicit: $\xi=-A_I^{-1}u_h$, and $c\xi=-\eta_h>0$.
- Degenerate steps (a constraint already active with $\lambda=0$) are handled by **Bland's rule** — always choose the smallest eligible index — which prevents cycling.

### 6.4. Worked Trace on Doors and Windows

> [!example]- From $(3,1)$ to the optimum
> **Start** at $x=(3,1)$, with no active constraint. Move along $c=(30,50)$:
> $$ \lambda=\min\left\{\frac{4-3}{30},\frac{12-2}{100},\frac{18-11}{190}\right\}=\frac1{30}, $$
> so $x=(4,8/3)$ and $I=\{1\}$ (the smith's constraint becomes tight).
>
> **Step 2.** At $x=(4,8/3)$, $I=\{1\}$. The system $\eta_1A_1=c$ is inconsistent ($\eta_1=30$ but $0=50$). Solve $A_1\xi=0$, $c\xi=1$: $\xi=(0,1/50)$. The blocking constraints are $A_2$ and $A_3$; the minimum ratio is $\lambda=50/3$, giving $x=(4,3)$ and $I=\{1,3\}$.
>
> **Step 3.** At $x=(4,3)$, $I=\{1,3\}$. Solve $\eta_1A_1+\eta_3A_3=c$:
> $$ \eta_1+3\eta_3=30,\qquad 2\eta_3=50 \;\Rightarrow\; \eta_3=25,\ \eta_1=-45<0. $$
> The negative component selects constraint 1. Solve $A_1\xi=-1$, $A_3\xi=0$: $\xi=(-1,3/2)$, and $c\xi=45>0$. The step is $\lambda=2$ (constraint $A_2$ blocks), so $x=(2,6)$ and $I=\{2,3\}$.
>
> **Step 4.** At $x=(2,6)$, $I=\{2,3\}$. Solve $\eta_2A_2+\eta_3A_3=c$:
> $$ 2\eta_2+2\eta_3=50,\qquad 3\eta_3=30 \;\Rightarrow\; \eta_3=10,\ \eta_2=15\ge0. $$
> Dual feasible: $y=(0,15,10,0,0)$, value $360=cx$. Stop — optimal.

## 7. Finding a Feasible Starting Point

If $b\ge0$, then $x=0$ is feasible. Otherwise split the constraints into $I_+=\{i : b_i\ge0\}$ and $I_-=\{i : b_i<0\}$ and solve the **auxiliary problem**

$$ \max\ -\sum_{i\in I_-}u_i \quad\text{s.t.}\quad
A_{I_+}x\le b_{I_+},\qquad A_{I_-}x-u_{I_-}\le b_{I_-},\qquad u_{I_-}\ge0. $$

The point $x=0$, $u_{I_-}=-b_{I_-}>0$ is feasible, so the algorithm can start. Its optimal value is $\le0$ because $u\ge0$.

- If the optimum is $0$, then $u=0$ and the corresponding $x$ is feasible for P.
- If the optimum is $<0$, no $u$ can be driven to zero and **P is infeasible**.

This is the **two-phase** method: phase 1 finds a feasible point (or proves none exists), phase 2 optimizes the real objective. In practice the same simplex routine is run twice, with different costs.

## 8. Complementary Slackness

> [!important] Complementary slackness — asymmetric pair
> For P: $\max\{cx : Ax\le b\}$ and D: $\min\{yb : yA=c,\ y\ge0\}$, let $x$ and $y$ be feasible. The following are equivalent:
> 1. $x$ and $y$ are optimal;
> 2. $cx=yb$;
> 3. $y(b-Ax)=0$.
>
> Component by component:
> $$ y_i(b_i-A_i x)=0,\qquad i=1,\dots,m, $$
> i.e. $y_i>0\Rightarrow A_i x=b_i$ and $A_i x<b_i\Rightarrow y_i=0$.

*Proof.* $cx=yAx\le yb$, with equality iff $y(b-Ax)=0$ because every factor is non-negative. $\blacksquare$

For the **symmetric pair** (P: $\max\{cx : Ax\le b,\ x\ge0\}$, D: $\min\{yb : yA\ge c,\ y\ge0\}$) there are two families of conditions:

$$ y(b-Ax)=0 \qquad\text{and}\qquad (c-yA)x=0, $$

i.e. a positive dual variable forces the primal constraint tight, and a positive primal variable forces the dual constraint tight.

> [!tip] Using complementary slackness to certify a point
> Given a candidate $x$:
> 1. Check primal feasibility.
> 2. Set $y_i=0$ for every **inactive** constraint.
> 3. Solve $y_IA_I=c$ for the remaining $y_I$ (often a small triangular system).
> 4. If $y_I\ge0$, then $x$ is optimal and $y$ is an optimal dual solution. A negative component means $x$ is **not** optimal.
>
> This is usually much faster than solving the dual from scratch, and it is the standard way to prove optimality of a vertex found by inspection.

> [!example]- Certifying $x=(2,3)$
> $$ \max\ x_1+2x_2 \quad\text{s.t.}\quad x_1+x_2\le5,\quad x_1\le4,\quad x_2\le3,\quad x\ge0 $$
> At $x=(2,3)$ constraints 1 and 3 are active, constraint 2 is not. Set $y_2=0$; the symmetric dual constraints are $y_1+y_2\ge1$, $y_1+y_3\ge2$. Since $x_1,x_2>0$, both dual constraints are tight: $y_1=1$, $y_1+y_3=2\Rightarrow y_3=1$. So $y=(1,0,1)\ge0$, and $cx=8=yb$. Both are optimal.

> [!warning] Degeneracy and uniqueness
> If more than $n$ constraints are active at $x$, the system $y_IA_I=c$ is underdetermined and the dual solution is not unique. Complementary slackness still holds for every optimal pair, but some bases contained in $I(x)$ give negative multipliers even though $x$ is optimal — a basis test must then be read as *sufficient*, not necessary.

## 9. Economic Interpretation: Shadow Prices

Interpret P as allocating resources $b$ among activities (columns of $A$) to maximize profit. Perturb the availability:

$$ P(\varepsilon):\quad \max\ cx \quad\text{s.t.}\quad Ax\le b+\varepsilon. $$

If $\varepsilon$ is small enough that the optimal solution $x(\varepsilon)$ keeps the **same active constraints** as $x$, then the old dual solution $y$ is still feasible for $D(\varepsilon)$ — its constraints do not involve $b$ — and it is still complementary to $x(\varepsilon)$. Hence it is still optimal, and

$$ cx(\varepsilon)=y(b+\varepsilon)=cx+\sum_i y_i\varepsilon_i. $$

So

$$ y_i=\frac{\partial z^*}{\partial b_i} $$

is the **marginal value** of resource $i$: the most you should pay for one additional unit. These are the **shadow prices**.

- $y_i>0$ ⇒ resource $i$ is fully used (its constraint is tight); increasing it increases the optimum at rate $y_i$.
- $y_i=0$ ⇒ the resource has slack; an extra unit is worthless at the current plan.
- The interpretation is local: it holds only while the active set — the basis — does not change.

> [!example] One more carpenter hour
> At $x=(2,6)$, $y=(0,15,10,0,0)$. Raise the carpenter's availability from 12 to 13. The new optimum is the intersection of $A_2$ ($2x_W=13$) and $A_3$ ($3x_D+2x_W=18$):
> $$ x=\left(\frac53,\frac{13}{2}\right),\qquad z=30\cdot\frac53+50\cdot\frac{13}{2}=375. $$
> The increase is $375-360=15=y_2$, exactly the shadow price. The same active set stays optimal as long as $x_D=(18-b_2)/3$ remains between 0 and 4, i.e. for $b_2\in[6,18]$; outside that range the basis changes and the formula must be recomputed.

## 10. Sensitivity Analysis

The same idea answers "for which data does my optimal solution remain optimal?". Two cases are examined in the course.

### 10.1. Changing the Cost Vector

Let $c$ be replaced by $c'$. For a non-degenerate vertex $x$, it stays optimal iff the dual solution associated with its active set stays non-negative:

$$ y_I' A_I=c',\qquad y_I'\ge0. $$

> [!example] Door price range
> Take $c=(\alpha,50)$ in the doors problem, with $x=(2,6)$ and active constraints $A_2,A_3$. Solving
> $$ 3y_3=\alpha,\qquad 2y_2+2y_3=50 $$
> gives $y_3=\alpha/3$ and $y_2=25-\alpha/3$. Non-negativity requires
> $$ 0\le\alpha\le75. $$
> Geometrically, $c$ must remain inside the cone generated by $A_2$ and $A_3$. At $\alpha=0$ the objective is flat along the face $x_W=6$; at $\alpha=75$ it is parallel to $A_3$, so the whole edge between $(2,6)$ and $(4,3)$ becomes optimal.

### 10.2. Changing the Right-Hand Side

Increasing $b_i$ moves the corresponding hyperplane outward. The optimum follows the same basis until a new constraint becomes active or an old one loses contact; the value changes linearly with slope $y_i$ inside that range. This is the parametric version of §9.

> [!tip] How to answer a sensitivity question
> 1. Identify the active constraints at the optimum.
> 2. Write the dual system restricted to that active set.
> 3. Impose non-negativity of the dual variables — this gives the range for the parameter.
> 4. Check that the primal vertex stays feasible in the same range.
> 5. At the ends of the range, a different basis takes over; re-solve there.

## 11. Bases, Reduced Costs and the Primal Simplex

### 11.1. Complementary Basic Solutions

Let $B\subseteq\{1,\dots,m\}$ with $|B|=n$ and $\det A_B\ne0$; $N=\{1,\dots,m\}\setminus B$. $B$ is a **basis**, $A_B$ the **basis matrix**. Associate with it

$$ x=A_B^{-1}b_B,\qquad y_B=cA_B^{-1},\quad y_N=0. $$

$x$ is a **basic solution** of P, $y$ of D; they automatically satisfy complementary slackness.

| Property | Condition | Meaning |
| :--- | :--- | :--- |
| primal feasible | $b_N-A_NA_B^{-1}b_B\ge0$ | the vertex lies inside all non-basic constraints |
| dual feasible | $cA_B^{-1}\ge0$ | all shadow prices are non-negative |
| degenerate | some component of $x_B$ or $y_B$ is $0$ | more than $n$ constraints active; basis not unique |

> [!important] Optimality test on a basis
> If $x$ is a basic feasible solution and $cA_B^{-1}\ge0$, then $x$ is optimal. If $x$ is non-degenerate, the converse also holds; if $x$ is degenerate, a particular basis may fail the test even though $x$ is optimal, and another basis associated with $x$ has to be found.

### 11.2. Reduced Costs

For P in the form $\max\{cx : Ax\le b\}$, add a slack $s_h\ge0$ to every constraint, so $Ax+s=b$. At a basis $B$ the constraints in $B$ are tight ($s_B=0$). The **reduced cost** associated with the slack of constraint $h\in B$ is

$$ \bar c_{s_h}=0-cA_B^{-1}u_h=-y_h. $$

A negative $y_h$ means this slack has positive reduced cost: letting it enter the basis (relaxing constraint $h$) increases the objective at rate $-y_h$, along the direction $\xi=-A_B^{-1}u_h$ used in §6.3. This is why the stopping rule is $y_B\ge0$.

### 11.3. Primal Simplex

The primal simplex is the primal-dual simplex restricted to basic solutions: it starts from a feasible basis and always pivots to an adjacent one.

```
B feasible basis
repeat
    x := A_B^{-1} b_B;  y_B := c A_B^{-1}
    if y_B ≥ 0: stop                      # optimal
    choose h with y_h < 0
    ξ := -A_B^{-1} u_h
    if A_i ξ ≤ 0 for all i ∉ B: stop      # P unbounded, D empty
    λ := min{(b_i - A_i x)/(A_i ξ) : i ∉ B, A_i ξ > 0}
    k := argmin
    B := B ∪ {k} \ {h}                    # pivot
```

- The ratio test preserves primal feasibility; the leaving constraint $h$ is chosen by a negative dual value, the entering constraint $k$ by the minimum ratio.
- **Bland's rule** (smallest index) guarantees termination; in practice one chooses the most negative $y_h$ for speed.
- Simplex is fast in practice but has exponential worst-case behaviour; polynomial-time interior-point methods exist but are outside this chapter.
- The optimal basis produced at the end is the certificate: $x=A_B^{-1}b_B$, $y=cA_B^{-1}$, and $cx=yb$.

## 12. Duality in Practice: Multicommodity Flow and Column Generation

The path formulation of the multicommodity flow problem (see [[Flows]] §4) has exponentially many variables:

$$ \text{R:}\quad \min\sum_{k\in K}\sum_{p\in P_k}c_px_p \quad\text{s.t.}\quad
\sum_{p\in P_k}x_p=d_k,\qquad \sum_{k}\sum_{p\ni(i,j)}x_p\le u_{ij},\qquad x_p\ge0. $$

Its dual has a variable $y_k$ per demand and $z_{ij}\le0$ per arc:

$$ \text{RD:}\quad \max\sum_k d_ky_k+\sum_{(i,j)}u_{ij}z_{ij} \quad\text{s.t.}\quad
y_k+\sum_{(i,j)\in p}z_{ij}\le c_p\quad\forall k,\ \forall p\in P_k. $$

Solve a **master** problem restricted to a small set $P'\subset P$ of paths. Its dual solution $(y,z)$ is feasible for RD iff no path violates its constraint. Checking this means finding a path with

$$ \sum_{(i,j)\in p}(z_{ij}-c_{ij})>-y_k, $$

a **longest path** problem with arc weights $z_{ij}-c_{ij}\le0$ (because $z\le0$ and $c\ge0$), which the algorithms of [[Graphs]] handle. If such a path exists, add it to $P'$ and re-solve; if none exists for any $k$, the master solution is optimal for R. This is **column generation**: the dual prices tell you which variable (path) is worth adding, instead of enumerating all of them.

## 13. Summary

| Result | Statement | What it gives |
| :--- | :--- | :--- |
| Vertex theorem | finite optimum ⇒ optimum at a vertex | search only basic solutions |
| Weak duality | $cx\le yb$ | equality of values certifies optimality |
| Strong duality | both feasible ⇒ $\max cx=\min yb$ | no duality gap |
| Farkas | exactly one of $\eta A=c,\eta\ge0$ or $A\xi\le0,c\xi>0$ | optimality certificate or growth direction |
| Complementary slackness | $y(b-Ax)=0$ (and $(c-yA)x=0$) | check optimality from active constraints |
| Shadow prices | $y_i=\partial z^*/\partial b_i$ | value of one more unit of resource |
| Basis test | $cA_B^{-1}\ge0$ and $b_N-A_NA_B^{-1}b_B\ge0$ | simplex stopping rule |

The whole chapter is one idea seen from four angles: **at an optimum, the cost vector is a non-negative combination of the active constraint gradients**. Geometry says "$c$ in the cone"; duality says "the dual is feasible"; complementary slackness says "tight constraints carry the positive prices"; the simplex says "the basis has non-negative reduced costs".

## 14. Common Mistakes

> [!warning] Check these before an exam
> - **Sign constraints are rows.** In canonical form, $x\ge0$ must be added explicitly; otherwise the dual is wrong and prices may come out negative.
> - **Dual variable signs follow the primal constraint type**, and dual constraint directions follow the primal variable signs. Write the table once and check every row.
> - Weak duality for a max primal with $Ax\le b$ reads $cx\le yb$; do not flip it when switching between min and max forms.
> - Equality $cx=yb$ proves optimality only if **both** points are feasible. Always check feasibility first.
> - The growth-direction test uses only the **active** constraints: $A_I\xi\le0$, not $A\xi\le0$.
> - A step $\lambda=+\infty$ means **unbounded**, not "no constraint found"; the dual is then infeasible.
> - In complementary slackness, a negative multiplier in the forced system means the candidate is **not** optimal — do not ignore the sign.
> - $y_i=0$ does not imply that constraint $i$ is slack: at a degenerate vertex a tight constraint can have zero price.
> - A shadow price is valid only while the **basis** (active set) stays the same. Outside the range, recompute.
> - In a basis test, dual feasibility is sufficient for optimality; for degenerate solutions it is not necessary. Find another basis before concluding.
> - The auxiliary problem detects infeasibility through a **negative** optimal value, not through the absence of a feasible point at $x=0$ — $x=0$ with artificial variables is always feasible.

## 15. Exam Checklist

1. Put an LP in canonical or standard form, including explicit sign constraints and slacks.
2. Draw the feasible polygon, list its vertices, and solve a two-variable LP by moving the level line.
3. Prove that a point is a vertex by exhibiting $n$ independent active constraints.
4. Write the dual of any LP using the correspondence table; check dimensions and signs.
5. Prove optimality of a given pair $(x,y)$ with weak duality ($cx=yb$).
6. Given $x$, build the restricted dual and either find $y\ge0$ or a feasible growth direction $\xi$.
7. Compute the maximum step $\lambda$ and the next vertex; recognize unboundedness when $\lambda=\infty$.
8. Run the primal-dual simplex on the doors example from memory.
9. Build the auxiliary problem and decide feasibility from the sign of its optimum.
10. Use complementary slackness to certify a candidate vertex and to recover the dual solution.
11. Interpret dual variables as shadow prices; compute the change in the optimum for a unit perturbation and the range where it is valid.
12. Find the range of a cost coefficient for which a vertex remains optimal.
13. Compute $x=A_B^{-1}b_B$ and $y=cA_B^{-1}$ for a basis, test primal/dual feasibility, and identify degeneracy.
14. Explain the link with [[Flows]]: max-flow/min-cut is weak duality on the flow LP; the transportation dual is the transporter's pricing problem.

---

Related: [[_Operational Research MOC]], [[Problem Optimization]], [[Graphs]], [[Flows]]
Source: [[LPnew.pdf]], [[chapter+3.pdf]] (chapter 3, §1.2–5)
