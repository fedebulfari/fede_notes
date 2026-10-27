---
date: 08-10-2026
subject: Operational Research
---

# Graphs

## 1. Definitions and Notation

A graph $G = (N, A)$ is defined by a set of **nodes** $N$ and a set of **arcs** $A$.
An arc is defined by a pair of nodes called its **endpoints**.

- **Undirected graph:** pairs are unordered, $e = \{i,j\}$.
- **Directed graph (digraph):** pairs are ordered, $a = (i,j)$.
	- $i$ = **tail**, $j$ = **head**.
- **Simple graph:** no multiple arcs and no self-loops ($i \neq j$).

> [!tip] Directed vs undirected
> Many definitions below are stated for digraphs. When orientation does not matter they also apply to undirected graphs — just replace path with chain, cycle with circuit, etc.
> ![[Graphs-1791560716558.webp|353]]

### 1.1. Successors, Predecessors, Stars, Degree

For a digraph $G=(N,A)$:

- **Set of successors**: $FN(i) = \{j \in N : (i,j) \in A\}$
- **Set of predecessors**: $PN(j) = \{i \in N : (i,j) \in A\}$
- **Adjacent nodes**: $AD(i) = FN(i) \cup PN(i)$
- **Forward star(arcs)**: $FS(i) = \{(i,j) \in A\}$
- **Backward star(arcs)**: $BS(j) = \{(i,j) \in A\}$
- **Star(arcs)**: $S(i) = FS(i) \cup BS(i)$

- **out-degree** $= |FS(i)| = |FN(i)|$
- **in-degree** $= |BS(i)| = |PN(i)|$
- **degree** $=$ out-degree + in-degree

### 1.2. Subgraphs and Partial Graphs

- **Subgraph induced by $V \subseteq N$:** $G' = (V, A')$ with $A' = \{(i,j) \in A : i,j \in V\}$.
- **Partial graph defined by $B \subseteq A$:** $G' = (N, B)$.
- **Partial subgraph:** combine both.

## 2. Chain, Path, Cycle

### 2.1. Chain and Circuit

A **chain** is a sequence $i_1, a_1, i_2, \dots, i_{r-1}, a_{r-1}, i_r$ where each $a_k$ is either $(i_k, i_{k+1})$ or $(i_{k+1}, i_k)$.

- Arcs $(i_k, i_{k+1})$ are **in accordance** with orientation $i_1 \to i_r$.
- Arcs $(i_{k+1}, i_k)$ are **not in accordance**.
- **Closed chain / circuit:** $i_1 = i_r$.

### 2.2. Path

A **path** requires all arcs oriented forward: $a_k = (i_k, i_{k+1})$ for $k=1,\dots,r-1$.
	
- **Closed path:** $i_1 = i_r$.
	![[Graphs-1791560256435.webp|356]]
- **Simple path:** no repeated **arcs**. E.g. $2,4,5,4,3$.
	![[Graphs-1791560347791.webp|356]]
- **Elementary path:** no repeated **nodes**. E.g. $1,2,4,5$.
	![[Graphs-1791560389715.webp|358]]

### 2.3. Cycle

A **cycle** is a closed path where the only repeated node is the first one — i.e. an elementary path $i_1 \to i_r$ plus arc $(i_r, i_1)$. E.g. $2,4,2$.

- **Simple cycle:** no repeated arcs.
- **Elementary cycle:** no repeated nodes (except start/end).
- Graph with no cycles is **acyclic**.

> [!warning] Common confusion
> - Simple = no repeated arcs, Elementary = no repeated nodes.
> - Every elementary path is simple, not vice versa.

#### 2.3.1. Hamiltonian and Eulerian

- **Hamiltonian cycle:** cycle containing **all nodes** in $N$, exactly $|N|$ arcs. Does not always exist.
	Hamiltonian cycles are elementary cycles.
- **Eulerian cycle / tour:** closed simple path containing **all arcs**, exactly $|A|$ arcs. Does not always exist.
	Eulerian tours are simple cycles.
	Exists iff $|FS(i)| = |BS(i)|$, $\forall i \in N$.

## 3. Connectivity, Components, Cuts

- **Connected:** for every $i,j \in N$ there exists a **chain** from $i$ to $j$.
- **Strongly connected:** for every $i,j \in N$ there exists a **path** from $i$ to $j$.
- **Connected component:** maximal connected subgraph. Same for strongly connected component.
- **Cut:** partition $N = N' \cup N''$, $N' \cap N'' = \emptyset$.
	Direct arcs: tail in $N'$, head in $N''$.
	Inverse arcs: tail in $N''$, head in $N'$.

## 4. Bipartite, Tree, Matching

- **Bipartite graph:** $N = N_1 \cup N_2$ such that every arc $(i,j)$ has $i \in N_1, j \in N_2$ or vice versa.
- **Tree:** connected graph with no closed chains.
- **Spanning tree $T$:** tree containing all nodes of $G$.
- **Matching:** partial graph where no two arcs share a node. **Perfect matching** if every node is incident to one arc.

![[Es. 1]]

### 4.1. Minimum Spanning Tree

Given weighted undirected $G=(N,A)$ with weights $w_e > 0$, find spanning tree of minimum total weight.

### 4.2. Properties of a Spanning Tree $G' = (N, A')$

Let $|N| = n$:
1. No cycles
2. $G'$ is connected
3. $|A'| = n-1$
4. Adding one arc creates exactly one cycle
5. Removing one arc creates two connected components

#### 4.2.1. Kruskal Algorithm [1956]

> [!example] Idea
> Take arcs in increasing weight order. Add an arc iff it does not create a cycle.

1. Sort arcs in increasing order of $w_{ij}$
2. $A' = \emptyset$
3. Repeat:
	 1. Consider next arc $\{i,j\}$ in order
	 2. If $A' \cup \{\{i,j\}\}$ contains no cycle, then $A' \leftarrow A' \cup \{\{i,j\}\}$
4. Until $|A'| = n-1$

Key point from the book: stop when $|T| = |N|-1$, no need to scan all arcs.

See [[chapter+2.pdf##page=10]] for worked example and optimality proof (exchange argument).

## 5. Graph Search — Path or Cut

> [!info] Path-or-cut property
> Given a digraph $G=(N,A)$ and two nodes $s,t \in N$, exactly one holds:
> 1. there exists a directed path from $s$ to $t$;
> 2. there exists a cut $(N_s, N_t)$ with $s \in N_s$, $t \in N_t$ and **no arc in accordance** with the cut, i.e. every crossing arc $(i,j)$ has $i \in N_t$, $j \in N_s$.

The proof is constructive — it *is* the search algorithm below. See [[chapter+2.pdf##page=13]].

### 5.1. Search Procedure from Root $s$

Stores a predecessor vector $P$. $P[i]=0$ means $i$ not yet reachable from $s$.

```
Procedure Search(G=(N,A), s, P):
  for i in N do P[i] := 0
  P[s] := s; Q := {s}
  repeat
    select i from Q; Q := Q \ {i}
    for each (i,j) in FS(i) do
      if P[j] = 0 then
        P[j] := i; Q := Q ∪ {j}
  until Q = ∅
```

- If $P[t] \neq 0$, recover $s \to t$ path by backtracking predecessors.
- If $P[t] = 0$, let $N_s = \{i : P[i] \neq 0\}$, $N_t = N \setminus N_s$. This is the cut of case (2): no $(i,j)$ with $i \in N_s, j \in N_t$ could exist, otherwise $j$ would have been marked.

> [!tip] Complexity
> Each node extracted at most once, each arc examined at most once (it belongs to exactly one $FS$). With $Q$ as unordered list: $O(m)$, where $m=|A|$, $n=|N|$. This is the basis for all shortest-path and max-flow algorithms.

Choosing $Q$ as queue → BFS, as stack → DFS. For correctness of reachability the discipline does not matter.

## 6. Shortest Path

> [!info] Shortest $s-t$ path — general form
> Given directed $G=(N,A)$ with arc costs/lengths $c_{ij}$, $\forall (i,j) \in A$, and $s,t \in N$:
>
> Find the (elementary) path $p$ from $s$ to $t$ minimizing $\sum_{(i,j) \in p} c_{ij}$.
>
> Assume **no negative-length directed cycle**. Otherwise the optimum is unbounded — you could loop forever — unless elementarity is forced, which is hard.

Formulation with flow variables $x_{ij} \in \{0,1\}$ ($1$ if $(i,j) \in p$):

$$\min \sum_{(i,j)\in A} c_{ij}x_{ij}$$

$$ \sum_{(j,i)\in BS(i)} x_{ji} - \sum_{(i,j)\in FS(i)} x_{ij} = b_i \quad \forall i \in N $$

where $b_s = -1$, $b_t = +1$, $b_i = 0$ else. With no negative cycles, $x_{ij} \ge 0$ suffices.

> [!example] Rope intuition
> Cut a piece of rope of length $c_{ij}$ per arc, knot them at nodes. Hold knots $s$ and $t$ and pull apart: tight ropes = shortest path. Mathematically with potentials $\pi_i$ (heights):
>
> $$\max \ \pi_t - \pi_s \quad \text{s.t.} \quad -\pi_i + \pi_j \le c_{ij} \ \ \forall (i,j) \in A$$
>
> At optimum, arcs on the shortest path are tight: $\pi_j - \pi_i = c_{ij}$. With $\pi_s = 0$, $\pi_i$ = shortest distance $s \to i$.

See [[chapter+2.pdf##page=15]] and Fig. 5 for example graph $1 \to 7$.

### 6.1. Shortest Path Tree (SPT)

> [!info] SPT with root $r$
> Given directed $G=(N,A)$, costs $c_{ij}$, root $r \in N$:
>
> Find all shortest paths from $r$ to every other node.
>
> It is a tree because shortest paths share prefixes: if shortest $r \to s$ goes through $q$, then $r \to q$ subpath is also shortest.

Same flow model with $b_r = -(n-1)$, $b_i = 1$ else. Dual rope form:

$$\max \sum_{i \neq r} \pi_i - (n-1)\pi_r \quad \text{s.t.} \quad -\pi_i + \pi_j \le c_{ij}$$

With $\pi_r = 0$, optimal $\pi_i$ = shortest distance $r \to i$.

### 6.2. Bellman Optimality Conditions

Labels $d[i]$ estimate distances from $r$. Optimal iff:

$$d[j] \le d[i] + c_{ij} \quad \forall (i,j) \in A$$

All shortest-path algorithms just enforce these, updating $P[j]:=i$, $d[j]:=d[i]+c_{ij}$ when violated.

### 6.3. Algorithms

#### 6.3.1. SPT on Acyclic Graphs — $O(m)$

If $G$ is acyclic it can be **topologically numbered**: $(i,j) \in A \Rightarrow i < j$. Test with recursive stripping of sourceless nodes — see `Topological_numbering` in [[chapter+2.pdf##page=17]].

Then scan nodes in order, relax forward stars:

```
Procedure SPT_Acyclic(G,P,d): // assumes 1..n topological, root = 1
  P[1]:=1; d[1]:=0
  for i:=2 to n do P[i]:=0; d[i]:= +∞
  for i:=1 to n-1 do
    for each (i,j) in FS(i) do
      if d[i] + c_ij < d[j] then
        P[j]:=i; d[j]:=d[i]+c_ij
```

Key properties: when $FS(i)$ is examined, $d[i]$ is already optimal; each arc examined once → $O(m)$.

For **longest** path tree (critical path, DP-knapsack) just flip init and inequality:

```
Procedure LongestPT_Acyclic(G,P,d):
  P[1]:=1; d[1]:=0
  for i:=2 to n do P[i]:=0; d[i]:= -∞
  for i:=1 to n-1 do
    for each (i,j) in FS(i) do
      if d[i] + c_ij > d[j] then
        P[j]:=i; d[j]:=d[i]+c_ij
```

> [!tip] Dynamic programming = longest/shortest path on acyclic state graph
> Knapsack, purchase planning (§5.2), car renewal (§5.3), project scheduling / CPM (§5.7) all build an acyclic state graph and run the above. See [[chapter+2.pdf##page=18]].

#### 6.3.2. Dijkstra — Non-negative Costs, General Graph — $O(n^2) \land O(m \log n)$

Same scheme, but $Q$ holds frontier nodes and we always extract $\min d$:

```
Procedure SPT_Dijkstra(G,r,P,d):
  for i:=1 to n do P[i]:=0 d[i]:=+∞;
  P[r]:=r; d[r]:=0; Q:={r};
  repeat                                                   ---(n_times)
    select i from Q with d[i]=min{d[h]: h in Q};                  |
    Q:=Q\{i};                                                     |
    for each (i,j) in FS(i) do         ---(n_times(worst case))   |
      if d[i]+c_ij < d[j] then                      |             |
	    P[j]:=i; d[j]:=d[i]+c_ij; Q:=Q∪{j}          |             |
  until Q=∅                                                       |
```

Requires $c_{ij} \ge 0$. Then extracted label is definitive — node never re-enters $Q$.
	For $m=|A|, n=|N|$ the time cost is:

- $Q$ as unordered list: $O(n^2)$
- $Q$ as binary heap: $O(m \log n)$ — better when $m \log n < n^2$

Worked example with root $1$ (Fig. 6–11): see [[chapter+2.pdf##page=22]].

#### 6.3.3. SPT_Label-Correcting — $O(nm)$

If some $c_{ij} < 0$, Dijkstra fails. Keep correcting violations, using $Q$ as queue (FIFO) to get $O(nm)$ time complexity:

```
Procedure SPT_L(G,r,P,d):
  for i:=1 to n do P[i]:=0 d[i]:=+∞;
  P[r]:=r; d[r]:=0; Q:={r};
  repeat
    select i from Q(FIFO Policy); Q:=Q\{i}
    for each (i,j) in FS(i) do
      if d[i]+c_ij < d[j] then
        P[j]:=i; d[j]:=d[i]+c_ij; Q:=Q∪{j}
  until Q=∅
```

Worked example (Fig. 12–18): see [[chapter+2.pdf##page=26]].

> [!warning] Negative cycles
> If a directed cycle has total length $< 0$, shortest paths are undefined. Detect with SPT_L:
> - labels $d[j] < -(n-1)C$ where $C=\max|c_{ij}|$, or
> - some node enters $Q$ for the $n$-th time.
>
> Reconstruct cycle by backtracking $P$ from $j$. See [[chapter+2.pdf##page=28]].
> Further: Floyd-Warshall $O(n^3)$ for all-pairs, $d[i,i]<0$ signals negative cycle — see [[chapter+2.pdf##page=30]].

---
Related: [[_Operational Research MOC]]
Source: [[chapter+2.pdf]]
