---
date: 07-10-2026
subject: Operational Research
description: LP and MILP modelling — decisions mapped to variables, rules to constraints, objectives to functions, with variable domains, constraint families, slack transformations and linear, bottleneck and multi-objective goals
---

# Problem Optimization

> [!summary] Overview
> This note is the entry point of the course: it shows how a real decision problem becomes an **optimization problem** through three correspondences — decisions to variables, rules to constraints, objective to objective function. It develops the general form $\min f(x)$ subject to $g_i(x) \leq 0$ and $h_j(x)=0$, then details variable domains, typical constraint families (availability, requirement, blending, flow conservation, logical and big-$M$ linking), the standard slack and surplus transformations, and the main objective types. It closes with small LP examples whose vertex enumeration motivates the efficient algorithms developed in [[Graphs]] and [[Flows]].

## 1. Definitions

Modeling a problem means translating it into an optimization problem via three correspondences:

| Problem side | Model side |
| :----------: | :----------------------: |
| Decisions | Variables |
| Rules | Mathematical constraints |
| Objective | Objective function |

The result is an **optimization problem**: find values of the variables that optimize (min or max) the objective while satisfying every constraint.

> [!note] Decision process
> 1. Detect the decision problem
> 2. Analyse facts and collect data
> 3. Build the model (abstraction)
> 4. Determine solution(s) via algorithms / solvers
> 5. Interpret results on the real case — with feedback loops.
>
> A model is only an abstraction: validate that it captures the aspects relevant to the decision.

## 2. General Form

$$\min_{x} \ f(x) \quad \text{s.t.} \quad g_i(x) \leq 0,\ i=1,\dots,m; \quad h_j(x)=0,\ j=1,\dots,p; \quad x \in X$$

- Continuous variables + linear $f, g, h$ → **LP**, e.g. standard form $\max c^\top x \ \text{s.t.} \ Ax \leq b,\ x \geq 0$.
- Integer / binary variables → **IP / MILP**, finite but possibly exponential feasible set.

> [!example] Farmer
> $x_L, x_P$ = hectares of lettuce / potatoes.
> $$\max 3000x_L+5000x_P$$
> $$\text{s.t. } x_L+x_P \leq 12,\ 7x_L \leq 70,\ 3x_P \leq 18,\ 10x_L+20x_P \leq 160,\ x_L,x_P \geq 0$$
> 2-variable LP: feasible region is intersection of half-planes; optimum at a vertex — here $(8,4)$ with value $44000$. With $n$ variables and $m$ inequalities, vertices can be up to $\binom{m}{n}$, so enumeration fails — need efficient algorithms. See `chapter+1.pdf` pp. 7–10.

> [!Example]- Es.1
> Given a set of financial instruments:
>
> |            |  1  |  2  |  3  |  4  |  5  |
> |:----------:|:---:|:---:|:---:|:---:|:---:|
> | max amount | 40  | 12  | 130 |  5  | 400 |
> |   coupon   | 3.2 | 1.5 | 4.2 | 0.7 | 17  |
>
> Decide how much to invest in each instrument to maximize the economic return from the coupons.
>
> **Solution:**
>
> Let $x_i$ be the amount invested in instrument $i$, $\bar{x}_i$ its max amount and $c_i$ its coupon:
>
> - **Budget** (137€): $\sum_{i=1}^{5} x_{i} \leq 137$
> - **Upper bounds**: $x_{1} \leq 40,\ x_{2} \leq 12,\ x_{3} \leq 130,\ x_{4} \leq 5,\ x_{5} \leq 400$
> - **Non-negativity**: $x_{i} \geq 0$
> - **Objective**: $\max \sum_{i=1}^{5} c_{i} y_{i}$ with $c = (3.2,\ 1.5,\ 4.2,\ 0.7,\ 17)$
>
> With relative variables $y_{i}=\dfrac{x_{i}}{\bar{x}_{i}}$, $\ 0\leq y_{i}\leq 1$ (fraction of each instrument's maximum):
>
> ![[Es.1-1791390205262.webp|218x208]]
>
> If the decisions were binary ($y_{i}\in{\{0,1\}}$, i.e. invest the full max amount in instrument $i$ or nothing at all, $x_{i}\in{\{0,\bar{x}_{i}\}}$),
> then the solution strategy would have been different:
>
> ![[Es.1-1791401200992.webp|221]]
>
> The continuous model admits infinitely many feasible solutions (an LP, solved at a vertex of the feasible region), while the binary one has only $2^n$ combinations 
> Here $2^5 = 32$ — so the solution strategy becomes combinatorial.
> 

## 3. Variables

Decisions become **decision variables**; domain and sign are part of the model:

- **Non-negative**: $x_i \geq 0$ — quantities, flows, times.
- **Non-positive / free**: $x \leq 0$ or unrestricted. A free variable splits into two non-negative ones, e.g. train timetable perturbation:$$\pi_{ts} = \pi_{ts}^+ - \pi_{ts}^-,\qquad \pi_{ts}^+ \geq 0,\ \pi_{ts}^- \geq 0$$ where $\pi_{ts}^+$ is delay and $\pi_{ts}^-$ is advance. Similarly $x \leq 0$ becomes $x'=-x \geq 0$.
- **Relative**: $y_i = x_i / \bar{x}_i \in [0,1]$ — shares, percentages, e.g. capital investment with $0 \leq x_i \leq 1$ (as in Es.1).
- **Binary / logical**: $x_i \in \{0,1\}$ — yes/no, e.g. burglar knapsack $\max \sum v_i x_i \ \text{s.t.} \ \sum p_i x_i \leq 8$.
- **Discrete choice**: $w_l \in \{d_1,\dots,d_r\}$, modeled as $w_l = \sum_k d_k y_k$, $\sum_k y_k = 1$, $y_k \in \{0,1\}$. With $\sum_k y_k \leq 1$ the $0$ (no allocation) option is also allowed.
- Complement of a logical variable: $x' = 1-x$.

## 4. Constraints

Typical families:

- **Availability**: e.g. $x_L+x_P \leq 12$, $10x_L+20x_P \leq 160$.
- **Requirement**: e.g. diet $\sum c_i x_i \geq 700$ calories.
- **Blending / quality**: share constraints, e.g. vegetables $\geq 30\%$ of calories — multiply out the denominator to linearize: $$-90x_{\text{pasta}}-75x_{\text{rice}}-60x_{\text{loin}}+49x_{\text{carrots}}+126x_{\text{potatoes}}+70x_{\text{pear}} \geq 0$$
- **Flow conservation**: inflow = outflow at intermediate nodes; $\leq$ supply at wells, $\geq$ demand at refineries. See oil pipeline example pp. 14–15.
- **Logical** (0–1 and continuous case):
	- Exclusion: $\sum y_i \leq 1$ (exactly one if $=1$).
	- Linking continuous to logical with big-$M$: $x \leq M y$, $y \in \{0,1\}$, then $y_{\text{pasta}}+y_{\text{rice}} \leq 1$.
	- Implication $x_1 \Rightarrow x_2$: $x_1 \leq x_2$; $x_1 \Rightarrow \lnot x_2$: $x_1+x_2 \leq 1$.
	- Generalized: if at least $m$ of $x_1,\dots,x_n$ are $1$ then $y=1$:$$y \geq \frac{\sum x_i - m + 1}{\,n-m+1\,}$$
		- *Satisfiability*: clause $P_1 \lor \lnot P_2 \lor P_3 \lor \lnot P_4$ becomes $x_1+(1-x_2)+x_3+(1-x_4) \geq 1$, i.e. $ax \geq 1-n(a)$. CNF $A$ is SAT iff the corresponding 0–1 system $Ax \geq b$ is feasible; MAX-SAT maximizes satisfied clauses.

### 4.1. Transformations

$$A_i x \geq b_i \to A_i x - s_i = b_i, \qquad A_i x \leq b_i \to A_i x + s_i = b_i, \quad s_i \geq 0$$

$s_i$ is slack (unused resource) or surplus (excess over requirement).

$$\sum_{i=1}^n a_i x_i \leq b \to \sum_{i=1}^n -a_i x_i \geq -b$$

## 5. Objective Function

- **Linear**: $\max \sum c_j x_j = -\min \sum (-c_j)x_j$ — only the optimal *value* changes sign, not the optimizer.
- **Bottleneck**: $\min \max_{i,j} p_{ij}x_{ij}$. Improving one aspect make less optimized an other
	![[Es. 3-1791478780648.webp|281]]
- **Multi-objective**: we can have multiple obljective function

> [!Example]- Es.2
>
> ![[grafo1]]
>
> **Solution:**
>
> To check whether the system of constraints is feasible we optimize with a **zero objective** ($c = 0$):
>
> 1. Take $A_{1}x \leq b_{1}$ as the objective function.
> 2. Its optimal solution is $x' = \min\{A_{1}x \leq b_{1},\dots,A_{n}x \leq b_{n}\}$.
>
> Does $x'$ solve the system?
>
> - If $A_{1}x' \leq b_{1}$, then $x'$ solves the system.
> - If $A_{1}x' > b_{1}$, then the system has no solution.
> 

> [!Example]- Es.3
>
> ![[Es. 3-1791473777167.webp|362]]
>
> **Solution:**
>
> - **Sets**:
> 	- $S=\{1\dots m\}$ → candidate systems (antennas)
> 	- $C=\{1\dots m\}$ → customers
> - **Parameters**:
> 	- $\mu$ → capacity of one antenna
> 	- $p_{ij}$ → emission power, $\forall i\in C,\ \forall j \in S$
> - **Variables**:
> 	- Activate a subset of antennas:
> 		$$y_j=\begin{cases}
> 		1 & \text{if } j \text{ is active} \\
> 		0 & \text{otherwise}
> 		\end{cases}$$
> 	- Assign a customer to an antenna:
> 		$$x_{ij}=\begin{cases}
> 		1 & \text{if } i \text{ is connected to } j\\
> 		0 & \text{otherwise}
> 		\end{cases}$$
> - **Constraints**:
> 	- Serve all customers:
> $$\sum_{j\in S} x_{ij}=1, \quad \forall i\in C$$
> $$~~\cancel{\sum_{i\in C}\sum_{j \in S} x_{ij}=\mu}~~l\text{→ wrong}$$~~ 
> 	- Capacity:
> $$\sum_{i\in C}x_{ij}\leq\mu$$
> 	- Avoid $x_{ij}=1$ when $y_j=0$:
> $$\sum_{i\in C}x_{ij}\leq\mu\, y_j \quad \vee \quad x_{ij}\leq y_j$$
> The second one is the better formulation.
> - **Objective**:
> $$\min \max_{\,i\in C,\ j\in S}\left(p_{ij}x_{ij}\right)$$
> This can be reduced to a linear problem using a dummy variable $d$:
> $$d \geq p_{ij}x_{ij} \quad\text{(dummy variable tracking the max)}$$
> $$\min d = \min \max\left(p_{ij}x_{ij}\right) \quad\to\quad d^* \text{: optimal value} = \min\max$$
> ![[grafi2]]


---
Related: [[_Operational Research MOC]]
Source: [[chapter+1.pdf]]
