---
date: 07-10-2026
subject: Operational Research
---
Modeling a problem means translating it into an optimization problem by establishing three correspondences:

| Problem side |        Model side        |
| :----------: | :----------------------: |
|  Decisions   |        Variables         |
|    Rules     | Mathematical constraints |
|  Objective   |    Objective function    |

The result is an **optimization problem**: find the values of the variables that optimize (min/max) the objective while satisfying every constraint.

# Variables

The decisions become decision variables, and their domain is part of the model:

- **Non negative**: $x_i \geq 0$: natural for quantities such as amounts, flows, times.
- **Unrestricted**: free to take any sign.
	We can transform an unrestricted variable into a restricted one:
		$\pi_{ts}^+ \geq 0,\ \pi_{ts}^- \geq 0 \implies \pi_{ts} = \pi_{ts}^+ - \pi_{ts}^-$
	This way the model only contains non-negative variables (standard form).
- **Relative**: defined with respect to a reference value instead of in absolute terms, e.g. the normalized share
	$y_i = \dfrac{x_i}{\bar{x}_i} \in [0,1]$, where $\bar{x}_i$ is the upper bound of $x_i$ (as in [[Es.1]]).
- **Binary**: $x_i \in \{0,1\}$: yes/no, on/off decisions.
- **Discrete**: $x_i$ takes values in a discrete set (typically integers, possibly bounded): counting decisions.

## Optimization problem

General form:

$$\min_{x} \ f(x) \qquad \text{s.t.} \quad g_i(x) \leq 0,\ i = 1,\dots,m; \qquad h_j(x) = 0,\ j = 1,\dots,p; \qquad x \in X$$

- continuous variables + linear $f$, $g$, $h$ → **LP** (linear program), in standard form $\max\ c^\top x \ \text{s.t.}\ Ax \leq b,\ x \geq 0$
- integer/binary variables → **IP / MILP**, with a finite (possibly exponential) number of feasible solutions

Example:

![[Es.1]]
# Constraints

- Availability constraints
- Requirement constraints
- Blending constraints
- Logical constraints (0-1 and continuous case)
	- Satisfiability problem: Given a logical formula is needed to find a truth assignment that makes it true:	$$(P_{11}\vee\dots \vee P_{1r})\wedge\dots \wedge(P_{n1}\vee\dots \vee P_{nr})$$
		At least one literal must be true to be all true
- Flow conservation constraints
## Transformations

$A_{i}x\geq b_{i}\to A_{i}x-s_{i}=b_{i}$
$A_{i}x\leq b_{i}\to A_{i}x+s_{i}=b_{i}$
$\sum^n_{i=1}a_{i}x_{i}\leq b$
$\sum^n_{i=1}-a_{i}x_{i}\geq -b$
# Objective function

Function to optimize the objective (min/max) of a problem.

Bottleneck:$$\min\max(p_{ij}x_{ij})$$
A system can be characterized by multiple objective function:
$$\max \sum_{i}\left( \sum_{j} x_{j}-\sum_{j} c_{j}y_{i} \right)$$
![[Es. 2]]

![[Es. 3]]

---
Related: [[_Operational Research MOC]]
