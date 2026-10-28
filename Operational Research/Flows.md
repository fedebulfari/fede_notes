---
date: 27-10-2026
subject: Operational Research
description: Network flows — maximum flow and minimum cut, residual graphs and augmenting paths, Edmonds–Karp and capacity scaling, matching as max flow, minimum cost flow with cycle canceling and successive shortest paths, multicommodity flows
---

# Flows

> [!summary] Overview
> [[Graphs]] ended with the **path-or-cut** property. This note turns it into an optimization theory. A flow assigns a quantity $x_{ij}$ to every arc subject to **capacity** ($x_{ij}\le u_{ij}$) and **conservation** (nothing accumulates at intermediate nodes). Maximizing the $s$–$t$ flow gives the **maximum-flow problem**; its dual certificate is an **$s$–$t$ cut** of minimum capacity. The constructive proof is the **residual graph + augmenting path** algorithm: a path in the residual graph means the flow can still grow, its absence exhibits a cut whose capacity equals the flow value. Path choice matters — **Edmonds–Karp** (shortest augmenting path) and **capacity scaling** restore polynomial time. Adding costs yields the **minimum cost flow** model, which contains max flow and shortest paths as special cases; optimality is the absence of **negative-cost cycles** in the residual graph, or equivalently the existence of a **potential** making all residual reduced costs non-negative. The note closes with **multicommodity flows**, where capacities are shared and the integrality property disappears.

## 1. Where Flows Come From

A flow model is the right language whenever a **quantity moves through a network** and every arc has a **maximum rate**, while intermediate nodes only route what they receive.

| Application         | What flows                          | Capacity on an arc                      | Objective                      |
| :------------------ | :---------------------------------- | :-------------------------------------- | :----------------------------- |
| Building evacuation | people                              | corridor / stairway width per unit time | maximize evacuated people      |
| Machine scheduling  | processing time                     | machine-time in each interval           | fit all jobs before due dates  |
| Job assignment      | workers ↔ jobs                      | one job per worker, one worker per job  | maximize pairs / minimize cost |
| Waste disposal      | waste                               | truck / plant capacity                  | minimize disposal cost         |
| Road construction   | truckloads of earth                 | none between adjacent sections          | minimize transport cost        |
| Network design      | terminals → concentrator → computer | ports on a concentrator                 | minimize line cost             |
| Routing             | packets per commodity               | link bandwidth                          | minimize delay / cost          |

Three questions distinguish the models:

1. **Only capacities** → maximum flow.
2. **Capacities + costs + supplies/demands** → minimum cost flow.
3. **Several commodities sharing arcs** → multicommodity flow (no longer a pure network problem).

> [!example]- Building evacuation
> Nodes are offices, corridor and stairway junctions, and exits. Arcs are walkable connections whose capacity is the number of people per unit time they can carry; a super-source feeds the offices and a super-sink collects at the meeting point. The maximum flow is the maximum evacuation rate, and the minimum cut names the corridors or stairways that limit it. Comparing cut capacities tells you which connection is worth widening.

> [!tip] Modelling recipe
> 1. Decide what one unit of flow represents (a person, a truckload, an hour of work, a packet).
> 2. Create a node for every state the flow can be in — including **time slices** if timing matters.
> 3. Create an arc for every allowed transition; its capacity is the maximum rate, its cost the unit price.
> 4. Add a **super-source** for all origins and a **super-sink** for all destinations, or use node balances $b_i$ (see §5).
> 5. Check that the question is "how much?" (max flow) or "how, at least cost?" (min cost flow).

## 2. Maximum Flow Problem

### 2.1. Definition and Formulation

Given a digraph $G=(N,A)$, a source $s\in N$, a sink $t\in N$, and integer capacities $u_{ij}\ge 0$ for every $(i,j)\in A$, send as much flow as possible from $s$ to $t$.

Variables: $x_{ij}$ = flow on arc $(i,j)$.

$$ \max \ v=\sum_{(s,j)\in FS(s)} x_{sj} $$

$$ 0\le x_{ij}\le u_{ij} \qquad \forall (i,j)\in A \qquad \text{(capacity)} $$

$$ \sum_{(j,i)\in BS(i)} x_{ji}-\sum_{(i,j)\in FS(i)} x_{ij}=0 \qquad \forall i\in N\setminus\{s,t\} \qquad \text{(conservation)} $$

- **Capacity constraints** — no arc carries more than its capacity.
- **Flow conservation** — at every intermediate node, inflow $=$ outflow. Only $s$ and $t$ may create or absorb flow.
- The value $v$ equals the net outflow of $s$, and by conservation also the net inflow of $t$.

> [!note] Dummy arc $(t,s)$
> Add an arc $(t,s)$ with capacity $u_{ts}=M$ larger than any possible flow value, and maximize $x_{ts}$ subject to conservation at **all** nodes. The problem becomes a **circulation**: nothing is created or destroyed anywhere, and the flow on the dummy arc measures the value. This is the form used to embed max flow into min cost flow (§5.2), where the dummy arc gets cost $-1$.

> [!important] Integrality
> If all capacities are integers, there is an **integer optimal flow**. The augmenting-path algorithm preserves integrality because $\theta$ is a minimum of integers, and the constraint matrix of a network is totally unimodular. This is what makes max flow a combinatorial, not a fractional, problem — and why matching reduces to it.

### 2.2. Cuts and the Max-Flow/Min-Cut Theorem

An **$s$–$t$ cut** is a partition $N=N_s\cup N_t$, $N_s\cap N_t=\emptyset$, with $s\in N_s$ and $t\in N_t$.
![[Flows-1793180716477.webp|325]]
The arcs crossing the cut split into:

- **Forward arcs** $A^+(N_s,N_t)=\{(i,j)\in A: i\in N_s,\ j\in N_t\}$.
- **Backward arcs** $A^-(N_s,N_t)=\{(i,j)\in A: i\in N_t,\ j\in N_s\}$.

The **flow crossing the cut** and the **cut capacity** are:

$$ x(N_s,N_t)=\sum_{(i,j)\in A^+} x_{ij}-\sum_{(i,j)\in A^-} x_{ij} $$

$$ U(N_s,N_t)=\sum_{(i,j)\in A^+} u_{ij} $$

> [!info] Three properties
> For every feasible flow $x$ of value $v$ and every $s$–$t$ cut $(N_s,N_t)$:
> 1. $v=x(N_s,N_t)$ — sum conservation over all nodes of $N_s$; internal arcs cancel.
> 2. $x(N_s,N_t)\le U(N_s,N_t)$ — each forward flow is at most its capacity, and backward terms only subtract.
> 3. If $v=U(N_s,N_t)$ for some cut, then $x$ is optimal: no flow can beat the bottleneck.

> [!important] Max-flow/min-cut theorem
> The maximum flow value equals the minimum $s$–$t$ cut capacity:
> $$ \max_x v(x)=\min_{(N_s,N_t)} U(N_s,N_t). $$
> The proof is constructive — it is exactly the augmenting-path algorithm of §3.

> [!tip] How to read a cut
> Only **forward** arcs contribute to capacity. A backward arc contributes *negatively* to the flow crossing, never to the capacity. At a **tight** cut ($v=U$), every forward arc is saturated ($x_{ij}=u_{ij}$) and every backward arc is empty ($x_{ij}=0$).

The cut viewpoint is also the modelling intuition for "destroying" the network: if cutting an arc costs proportional to its capacity, the cheapest way to disconnect $s$ from $t$ is the minimum cut.

> [!Example] Modelling Example — Scheduling with Release Dates and Deadlines
>
> The repair-shop example from the lecture shows how far the max-flow model reaches. There are $m$ identical machines and a set of jobs $J=\{1,\dots,n\}$, each with processing time $p_j$, release time $r_j$ and due date $d_j$. Jobs may be **preempted** and resumed without loss of time, but only one machine can work on a job at a time.
>
> 1. Sort all release times and due dates into a single list of **events** and remove repetitions. Consecutive events define maximal intervals $T_{kl}$ of length $l-k$ during which no job arrives or leaves.
> 2. Nodes: source $s$, sink $t$, one node per job $j$, one node per interval $T_{kl}$.
> 3. Arcs:
> 	- $s\to j$ with capacity $p_j$ — the total processing the job needs;
> 	- $j\to T_{kl}$ with capacity $l-k$ whenever $r_j\le k$ and $d_j\ge l$ — the job is available throughout the interval;
> 	- $T_{kl}\to t$ with capacity $m(l-k)$ — the machines' total working time in the interval.
> 1. The flow on $j\to T_{kl}$ is the amount of job $j$ processed in interval $T_{kl}$.

All jobs meet their deadlines **iff** the maximum flow equals $\sum_j p_j$. If it is smaller, the minimum cut identifies the set of jobs and intervals that cannot be scheduled — a compact infeasibility certificate, not just a "no".

## 3. Residual Graph and Augmenting Paths

Given a feasible flow $x$, two things can be done on an arc $(i,j)\in A$:
![[Flows-1793180701449.webp|313]]
- **Increase** its flow if $x_{ij}<u_{ij}$.
- **Decrease** its flow if $x_{ij}>0$ — which is equivalent to sending flow back along $(j,i)$.

The **residual graph** $G_R(x)=(N,A(x))$ encodes both moves:

$$ A^+(x)=\{(i,j)\in A: x_{ij}<u_{ij}\}, \qquad A^-(x)=\{(j,i): (i,j)\in A,\ x_{ij}>0\} $$

$$ A(x)=A^+(x)\cup A^-(x) $$

For an arc $(i,j)\in A(x)$:

- If $(i,j)\in A^+$, its **residual capacity** is $u_{ij}-x_{ij}$.
- If $(i,j)\in A^-$ comes from $(j,i)\in A$, its residual capacity is $x_{ji}$.

> [!warning] Backward arcs are cancellations
> An arc of $A^-$ does **not** mean negative flow and does **not** create a new physical arc. Sending one unit on $(j,i)\in A^-$ means *reducing* $x_{ij}$ by one unit, freeing capacity on $(i,j)$ for a different use downstream. This rerouting is the whole power of the residual graph.

### 3.1. Augmenting Path Algorithm

An **augmenting path** is an $s$–$t$ path in $G_R(x)$. Its bottleneck is

$$ \theta=\min\Bigl(\{u_{ij}-x_{ij}:(i,j)\in A^+(x)\cap P\},\ \{x_{ji}:(i,j)\in A^-(x)\cap P\}\Bigr)>0. $$

The flow update is:

$$ x'_{ij}= \begin{cases} x_{ij}+\theta & (i,j)\in A^+(x)\cap P\\ x_{ij}-\theta & (j,i)\in A^-(x)\cap P\\ x_{ij} & \text{otherwise} \end{cases} $$

```
Procedure Augmenting_paths(G, s, t, x):
  x := 0
  repeat
    G_R := Residual_graph(x)
    Search(G_R, s, P)              // BFS/DFS from Graphs §5
    if P[t] ≠ 0 then
      Augment_flow(P, x)           // θ = bottleneck of P, update as above
  until P[t] = 0
```

**Correctness.**

- If a path exists, $\theta>0$, so the flow value increases — $x$ was not optimal.
- If no path exists, let $N_s$ be the nodes reachable from $s$ in $G_R(x)$ and $N_t=N\setminus N_s$. For any original arc $(i,j)$ with $i\in N_s$, $j\in N_t$: if $x_{ij}<u_{ij}$, then $(i,j)$ would be a residual arc and $j$ would be reachable, contradiction. Hence $x_{ij}=u_{ij}$. Similarly, if $i\in N_t$, $j\in N_s$ and $x_{ij}>0$, the backward residual arc $(j,i)$ would make $i$ reachable, contradiction; hence $x_{ij}=0$. Therefore
	$$ x(N_s,N_t)=\sum_{A^+} u_{ij}=U(N_s,N_t), $$
	so $v=U$ and $x$ is optimal. The unreachable set **is** the minimum cut.

This is the algorithmic version of the path-or-cut property in [[Graphs]]: the search either marks $t$ (augment) or leaves $t$ unmarked (certificate of optimality).

### 3.2. Worked Example — Why Rerouting Is Needed

Network with $s,a,b,t$:

| Arc | Capacity |
| :--- | :---: |
| $s\to a$ | 2 |
| $s\to b$ | 2 |
| $a\to b$ | 1 |
| $a\to t$ | 2 |
| $b\to t$ | 2 |

Maximum flow is $4$: send $2$ on $s\to a\to t$ and $2$ on $s\to b\to t$.

A greedy sequence can do worse:

1. Send $s\to a\to b\to t$: bottleneck $\min(2,1,2)=1$. Flow: $x_{sa}=1$, $x_{ab}=1$, $x_{bt}=1$.
2. Send $s\to b\to t$: bottleneck $\min(2,1)=1$. Flow: $x_{sb}=1$, $x_{bt}=2$.
3. Send $s\to a\to t$ with the remaining capacity of $s\to a$: bottleneck $\min(1,2)=1$. Flow: $x_{sa}=2$, $x_{at}=1$. The value is now $3$.
4. Now $s\to a$, $a\to b$ and $b\to t$ are saturated, so no path using only forward arcs remains. In the residual graph the backward arc $b\to a$ exists. Send $s\to b\to a\to t$: bottleneck $\min(1,1,1)=1$. This **cancels** $x_{ab}$ and reroutes: $x_{sb}=2$, $x_{ab}=0$, $x_{at}=2$.

Final flow value $2+2=4$. The min cut is $(\{s\},\{a,b,t\})$ with capacity $u_{sa}+u_{sb}=4$, matching the flow. Without the backward arc of step 4 the algorithm would stop at value $3$ — a valid flow, but not maximum.

### 3.3. Path Choice and Complexity

The plain augmenting-path algorithm (Ford–Fulkerson) is correct for any path choice, but not polynomial in the input size: capacities are encoded in binary, while each augmentation may add only one unit.

> [!warning] Pathological case
> In a network with two large capacities $M$ and a central arc of capacity $1$, choosing augmenting paths that alternately use and cancel the central arc forces one-unit augmentations — about $2M$ iterations instead of $2$. With $M=1000$ this is the difference between $2$ and $2000$ augmentations.

**Edmonds–Karp.** Always choose a **shortest** augmenting path (fewest arcs), found by BFS:

- path lengths are non-decreasing over the iterations;
- an arc can be saturated and later reused only after the distance to its head has grown by at least $2$;
- hence each arc is saturated at most $n/2$ times, giving $O(nm)$ augmentations;
- each BFS costs $O(m)$, so the total is

$$ O(nm^2). $$

**Capacity scaling.** Only use residual arcs with capacity at least $\Delta$, starting from $\Delta=2^{\lfloor\log U\rfloor}$ and halving it. Each scaling phase performs $O(m)$ augmentations, and there are $O(\log U)$ phases:

$$ O(m^2\log U). $$

## 4. Maximum Cardinality Matching as Max Flow

Given a bipartite graph $G=(S,T,A)$ with $A\subseteq S\times T$, a **matching** $M\subseteq A$ is a set of arcs no two of which share a node. The **maximum cardinality matching** problem asks for a matching of maximum size.

Build a flow network:

- arc $s\to i$ with capacity $1$ for every $i\in S$;
- arc $i\to j$ with capacity $1$ for every $(i,j)\in A$;
- arc $j\to t$ with capacity $1$ for every $j\in T$.

A flow of value $k$ uses $k$ disjoint $S$–$T$ arcs, i.e. a matching of size $k$. Conversely, any matching gives such a flow. Capacities are integral, so the optimal flow is $0/1$ on the middle arcs.

> [!tip] Complexity
> Every augmentation increases the matching by exactly one unit, and the matching has size at most $\min\{|S|,|T|\}$. With $m=|A|$, the algorithm runs in $O(m\min\{|S|,|T|\})$.

This is the "workers and jobs" example: compatibility arcs, at most one job per worker and one worker per job, maximize the number of pairs. The **minimum cost** version — assign every worker exactly one job while minimizing total cost — is a min cost flow problem (§7.4).

## 5. Minimum Cost Flow

### 5.1. Model

The maximum-flow model ignores that different routings have different prices. The **minimum cost flow** model adds unit costs and node balances.

Data:

- digraph $G=(N,A)$;
- **balance** $b_i$ for each node: $b_i<0$ = origin/supply, $b_i>0$ = destination/demand, $b_i=0$ = transshipment;
- unit cost $c_{ij}$ and capacity $u_{ij}\ge 0$ for each arc.

Assume $\sum_{i\in N} b_i=0$ (total supply equals total demand).

$$ \min \sum_{(i,j)\in A} c_{ij}x_{ij} $$

$$ \sum_{(j,i)\in BS(i)} x_{ji}-\sum_{(i,j)\in FS(i)} x_{ij}=b_i \qquad \forall i\in N \qquad \text{(balance)} $$

$$ 0\le x_{ij}\le u_{ij} \qquad \forall (i,j)\in A \qquad \text{(capacity)} $$

> [!note] Sign convention
> With this convention, a source has $b_i<0$: it sends out more than it receives, so inflow $-$ outflow is negative. A sink has $b_i>0$. Do not flip the sign halfway through an exercise — the dual and the algorithms depend on it.

If all $b_i=0$, the problem is a **circulation**: the flow is driven only by costs, so some arc must have a negative cost for a non-zero optimal flow.

### 5.2. Special Cases

| Problem | Balances $b_i$ | Costs $c_{ij}$ | Capacities $u_{ij}$ |
| :--- | :--- | :--- | :--- |
| Max flow $s\to t$ | all $0$; add $(t,s)$ | $c_{ts}=-1$, others $0$ | original, $u_{ts}=\infty$ |
| Shortest path tree from $r$ | $b_r=-(n-1)$, $b_i=1$ else | arc lengths | $\infty$ |
| Shortest $s$–$t$ path | $b_s=-1$, $b_t=1$, others $0$ | arc lengths | $\infty$ |
| Transportation | supplies $<0$, demands $>0$ | transport costs | $\infty$ or finite |
| Assignment | $b_i=-1$ on $S$, $b_j=1$ on $T$ | assignment costs | $1$ |
| Circulation | all $0$ | possibly negative | finite |

The max-flow reduction uses the dummy arc: minimizing $-x_{ts}$ is maximizing the flow, and conservation at all nodes makes the dummy arc carry exactly the flow value.

### 5.3. Applications

> [!example]- Road construction — earth moving at minimum cost
> Divide the road into sections, one node per section. A **hump** must be excavated: the section supplies truckloads, so $b_i<0$. A **depression** must be filled: it demands truckloads, so $b_i>0$. Adjacent sections are connected by arcs with **infinite capacity** (no limit on the number of trucks) and cost equal to the transport cost per truckload. The flow on an arc is the number of truckloads moved between the two sections. Minimizing $\sum c_{ij}x_{ij}$ distributes the material at minimum cost. The Pedemontana case moves about $35\times 10^6\ \mathrm{m}^3$ of earth.

> [!example]- Waste disposal
> Piles of waste are supply nodes; processing centres, recycling centres, the burner and the landfill are intermediate or demand nodes. Each arc has a cost and a capacity (e.g. how much a plant can treat). The minimum cost flow decides how much waste goes where.

> [!example]- Communications network design
> Terminals $1,\dots,n$ must reach a central computer, either directly or through one of $p$ concentrators. Model: terminal nodes have $b_i=-1$, the computer has $b_0=n$, concentrators are transshipment. Arcs terminal $\to$ computer cost $c_{i0}$; terminal $\to$ concentrator $h$ cost $c_{ih}$; concentrator $\to$ computer capacity $k$. The optimal flow is $0/1$: $x_{ij}=1$ means "build this line". Integrality follows from the network structure, so no separate binary constraints are needed.

## 6. Optimality for Minimum Cost Flow

### 6.1. Only Cycles Preserve Feasibility

Start from a feasible flow $x$. A variation $d$ preserves the balance constraints iff $d$ is a **circulation**: inflow equals outflow at every node. Every circulation decomposes into simple cycles (flow decomposition theorem), so any improvement can be described as sending a quantity $\theta$ around one or more cycles.

In the **residual graph**, attach a **residual cost** to each arc:

$$ g_{ij}= \begin{cases} c_{ij} & (i,j)\in A^+(x)\\ -c_{ji} & (i,j)\in A^-(x),\ (j,i)\in A \end{cases} $$

Sending $\theta$ around a cycle $C$ changes the objective by

$$ \sum_{(i,j)\in A} c_{ij}x'_{ij}-\sum_{(i,j)\in A} c_{ij}x_{ij} =\sum_{(i,j)\in C} g_{ij}\,\theta. $$

> [!important] Optimality condition
> A feasible flow $x$ is optimal **iff** its residual graph $G_R(x)$ contains **no negative-cost cycle**.

**Why it is a theorem, not just intuition.** If $x^*$ is a better feasible flow, then $x^*-x$ is a circulation and decomposes into at most $m$ simple circulations. At least one of them must have negative cost (otherwise the total change would not improve the objective), and it corresponds to a negative cycle in $G_R(x)$.

### 6.2. Cycle-Canceling Algorithm

```
Procedure Negative_cycle_elimination(G, x):
  G_R := Residual_graph(x)
  while ∃ negative cycle C in G_R do
    θ := Residual_capacity(C, x)
    Update_flow(C, θ, x)          // +θ on A+, -θ on A-
    Update(G_R)
```

- **Detecting a negative cycle:** run the label-correcting shortest-path algorithm ([[Graphs]] §6.3.3) from any node. If a node enters the queue for the $n$-th time, a negative cycle exists; backtrack the predecessor vector to reconstruct it.
- **Complexity:** with non-negative integer costs and capacities bounded by $C_{\max}$ and $U_{\max}$, the objective decreases by at least $1$ per iteration from at most $mC_{\max}U_{\max}$, and each negative-cycle detection costs $O(nm)$:
	$$ O(nm^2C_{\max}U_{\max}). $$
	This is pseudo-polynomial. Choosing cycles by a special rule (e.g. minimum mean cycle) gives a polynomial algorithm.

### 6.3. Finding a Feasible Starting Flow

Cycle canceling needs a feasible flow. Build an **auxiliary graph** $G'=(N\cup\{s,t\},A')$:

- add $s\to i$ with capacity $-b_i$ for every node with $b_i<0$;
- add $i\to t$ with capacity $b_i$ for every node with $b_i>0$;
- keep all original arcs with their capacities;
- set all node balances to $0$.

Solve a maximum flow from $s$ to $t$. If

$$ v_{\max}=\sum_{i:b_i<0}(-b_i)=\sum_{i:b_i>0}b_i, $$

then the flow on the original arcs is feasible. Otherwise **no feasible flow exists**, and the minimum cut tells you which demand nodes cannot be reached from the supply side.

> [!tip] Flow to solve flow
> The feasibility question of a min cost flow instance is itself a max-flow question. This is a common exam trick: do not try to guess a feasible flow; build the auxiliary graph and run Edmonds–Karp.

## 7. Successive Shortest Paths

Cycle canceling starts from any feasible flow and repairs its cost. The **successive shortest path** algorithm does the opposite: it starts from an infeasible but cost-optimal pseudoflow and repairs feasibility.

### 7.1. Reduced Costs and Potentials

For a potential vector $\pi$ on the nodes, the **reduced cost** of arc $(i,j)$ is

$$ \bar c_{ij}=c_{ij}+\pi_i-\pi_j. $$

For any path $P_{xy}$,

$$ \sum_{(i,j)\in P_{xy}}\bar c_{ij}=\sum_{(i,j)\in P_{xy}}c_{ij}+\pi_x-\pi_y, $$

and for any cycle the extra terms cancel:

$$ \sum_{(i,j)\in C}\bar c_{ij}=\sum_{(i,j)\in C}c_{ij}. $$

So a cycle is negative in reduced costs iff it is negative in original costs.

> [!important] Equivalent optimality condition
> A feasible flow $x$ is optimal **iff** there exists a potential $\pi$ such that
> $$ \bar c_{ij}\ge 0 \qquad \forall (i,j)\in A(x). $$

**Equivalence with "no negative cycle".** If such a $\pi$ exists, every residual cycle has non-negative reduced cost, hence non-negative original cost. Conversely, if $G_R(x)$ has no negative cycle, compute shortest-path labels $d$ from any root; setting $\pi_i=d_i$ gives Bellman's inequalities $c_{ij}+d_i-d_j\ge 0$ on every residual arc.

### 7.2. Pseudoflows and Excess

A **pseudoflow** satisfies capacity constraints but not necessarily conservation. Define the **excess** of node $i$:

$$ g_i=\sum_{(j,i)\in BS(i)}x_{ji}-\sum_{(i,j)\in FS(i)}x_{ij}-b_i. $$

- $g_i>0$: excess — supply still to be routed out (or more inflow than the balance requires).
- $g_i<0$: defect — demand still to be met.
- $g_i=0$: balanced.

The algorithm sends flow from excess nodes to defect nodes while preserving the reduced-cost optimality condition.

### 7.3. Algorithm

```
Procedure Shortest_path_sequence(G, x, π):
  x := 0; π := 0
  D := ∅; O := ∅
  for each i ∈ N do
    g_i := -b_i
    if g_i < 0 then D := D ∪ {i}     // defect
    else if g_i > 0 then O := O ∪ {i} // excess
  while O ≠ ∅ do
    select i from O
    SPT(i, P, d, G_R(x))              // shortest path tree in residual graph
    for each reachable j ∈ N do π_j := π_j + d_j
    if no k ∈ D is reachable then stop   // no feasible flow
    let P_ik be the shortest path from i to some reachable k ∈ D
    θ := min{g_i, -g_k, min residual capacity on P_ik}
    Augment_flow(θ, P_ik, x)
    update O, D
```

Key points:

- The potential update $\pi\leftarrow\pi+d$ makes every arc of the shortest-path tree have **zero reduced cost**, so flow can be sent along it without creating negative reduced costs.
- $\theta$ is limited by the excess at $i$, the defect at $k$, and the residual capacity of the path.
- The algorithm starts with $x=0$, $\pi=0$, which is valid only if all $c_{ij}\ge 0$: then all residual arcs at $x=0$ are original arcs with non-negative cost.

> [!warning] Negative original costs
> If some $c_{ij}<0$, the null pseudoflow with $\pi=0$ does **not** satisfy $\bar c_{ij}\ge 0$. Standard fix: **saturate every negative-cost arc first** ($x_{ij}:=u_{ij}$) and update the balances. The residual graph then has only non-negative residual costs, so $\pi=0$ is valid again. Equivalently, keep $x=0$ and compute initial potentials with a label-correcting SPT from a dummy root connected to all nodes by zero-cost arcs.

**Complexity.** Let $B=\sum_{i\in O}g_i$ be the total excess to send. Each iteration sends at least one unit, so there are at most $B$ iterations, each dominated by one shortest-path tree:

$$ O\bigl(B\cdot S(n,m)\bigr), $$

where $S(n,m)$ is the complexity of the SPT subroutine. With Dijkstra and a binary heap, $S=O(m\log n)$.

### 7.4. Minimum Cost Assignment

A bipartite complete graph $G=(S,T,A)$ with $A=S\times T$, $|S|=|T|=n$, and costs $c_{ij}$. Choose exactly one arc incident to every node, minimizing total cost.

As a min cost flow: $b_i=-1$ for $i\in S$, $b_j=1$ for $j\in T$, capacities $1$ on all arcs. Successive shortest paths sends one unit per iteration from an **exposed origin** to an **exposed destination**; after $n$ iterations all nodes are matched. Each iteration is a Dijkstra on $2n$ nodes with $O(n^2)$ arcs, so the total is

$$ O(n^3). $$

## 8. Multicommodity Flows

All models above assume a **single homogeneous commodity**: one unit of flow is interchangeable with any other. In many applications, different commodities share the same arcs but cannot be converted into one another.

Data: commodities $k\in K$, each with its own flow $x^k_{ij}$, origin $s_k$, destination $t_k$ and demand $d_k$. Capacities are **shared**:

$$ \sum_{k\in K} x^k_{ij}\le u_{ij} \qquad \forall (i,j)\in A. $$

Each commodity obeys its own conservation:

$$ \sum_{(j,i)\in BS(i)} x^k_{ji}-\sum_{(i,j)\in FS(i)} x^k_{ij}= \begin{cases} -d_k & i=s_k\\ +d_k & i=t_k\\ 0 & \text{otherwise} \end{cases} $$

$$ x^k_{ij}\ge 0. $$

Path formulation (the one used in [[chapter+3.pdf]] §4.4): let $P_k$ be the set of paths from $s_k$ to $t_k$, and $x_p$ the flow on path $p$:

$$ \min \sum_{k\in K}\sum_{p\in P_k} c_p x_p $$

$$ \sum_{p\in P_k} x_p=d_k \quad \forall k\in K, \qquad \sum_{k\in K}\sum_{p\ni(i,j)} x_p\le u_{ij} \quad \forall (i,j)\in A, \qquad x_p\ge 0. $$

> [!warning] What breaks
> The constraint matrix is **no longer a network matrix**, so total unimodularity is lost. The LP may have fractional optimal solutions, and the integer version is **NP-hard** in general. The max-flow/min-cut duality, the integrality of flows and the combinatorial algorithms above do **not** carry over. One solves the LP (or a MILP if integral routing is required), not a max-flow.

Typical instance: routing traffic on the Politecnico intranet, given an origin/destination matrix and link capacities in both directions — send all required flows, respect capacities, minimize total cost. This is the multi-terminal routing problem that reappears in the LP duality chapter via complementary slackness.

## 9. Summary

| Problem | Model | Algorithm | Complexity |
| :--- | :--- | :--- | :--- |
| Maximum flow | capacities + conservation | augmenting paths (any) | pseudo-polynomial, $O(v)$ augmentations |
| Maximum flow | capacities + conservation | **Edmonds–Karp** (BFS) | $O(nm^2)$ |
| Maximum flow | capacities + conservation | **Capacity scaling** | $O(m^2\log U)$ |
| Max cardinality matching | unit-capacity max flow | augmenting paths | $O(m\min\{\lvert S\rvert,\lvert T\rvert\})$ |
| Min cost flow | balances + costs + capacities | **cycle canceling** | $O(nm^2C_{\max}U_{\max})$ |
| Min cost flow | balances + costs + capacities | **successive shortest paths** | $O(B\cdot S(n,m))$ |
| Min cost assignment | unit balances | SSP + Dijkstra | $O(n^3)$ |
| Multicommodity flow | shared capacities | LP / MILP | no combinatorial max-flow |

## 10. Common Mistakes

> [!warning] Check these before an exam
> - **Augmenting paths live in the residual graph**, not in the original graph. A backward residual arc is a legitimate move.
> - A backward arc does **not** carry negative flow; it cancels existing flow on the opposite arc.
> - The value of a flow is the **net** outflow of $s$: $\sum_{FS(s)}x_{sj}-\sum_{BS(s)}x_{is}$, not the gross sum of all arcs leaving $s$.
> - **Cut capacity counts only forward arcs.** Backward arcs reduce the flow crossing but add nothing to $U(N_s,N_t)$.
> - Conservation is **not** imposed at $s$ and $t$ in the standard formulation; it is imposed everywhere only after adding the dummy arc $(t,s)$.
> - Integer capacities imply an integer optimal flow, but this is a property of **network matrices**, not of LP in general.
> - Ford–Fulkerson with an arbitrary path is correct but not polynomial; the pathological example needs $O(M)$ augmentations. State **Edmonds–Karp** when asked for a polynomial bound.
> - In min cost flow, the sign of $b_i$ matters: $b_i<0$ is supply, $b_i>0$ is demand. A feasible flow exists only if $\sum b_i=0$ and the auxiliary max flow saturates all supply arcs.
> - A negative-cost **arc** is harmless; a negative-cost **cycle** in the residual graph is what makes a flow improvable.
> - Do not apply max-flow/min-cut to multicommodity flow: shared capacities destroy total unimodularity.

## 11. Exam Checklist

1. Given a flow, draw $G_R(x)$, compute $\theta$ on a path, update $x$, and verify conservation.
2. If the search from $s$ fails, extract the cut $N_s$ = reachable nodes and check $v=U(N_s,N_t)$.
3. Model an evacuation / scheduling / assignment problem: nodes, arcs, capacities, super-source/sink, and the meaning of a unit of flow.
4. Prove that no augmenting path implies optimality (the two-case argument of §3.1).
5. Compare path-choice rules: arbitrary, shortest (Edmonds–Karp), high-capacity (capacity scaling).
6. Write the min cost flow formulation of a road-construction or network-design problem, including the sign of $b_i$.
7. Find a negative cycle in a residual graph, compute $\theta$, update the flow, and recompute the objective change $\sum g_{ij}\theta$.
8. Build the auxiliary graph for a feasible starting flow and interpret a max flow below total supply.
9. Explain reduced costs and why $\bar c_{ij}\ge 0$ on residual arcs is equivalent to optimality.
10. Explain why multicommodity flow is not a network flow problem.

---

Related: [[_Operational Research MOC]], [[Graphs]], [[Problem Optimization]]
Source: [[flowsnew.pdf]], [[chapter+2.pdf]] (chapter 2, §6–8)
