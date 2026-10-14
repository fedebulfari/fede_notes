---
date: 08-10-2026
subject: Operational Research
---

# 1. Definitions and Notation

A graph $G = (N, A)$ is defined by a set of **nodes** $N$ and a set of **arcs** $A$.
An arc is defined by a pair of nodes called its **endpoints**.

- **Undirected graph:** pairs are unordered, $e = \{i,j\}$.
- **Directed graph (digraph):** pairs are ordered, $a = (i,j)$.
  - $i$ = **tail**, $j$ = **head**.
- **Simple graph:** no multiple arcs and no self-loops ($i \neq j$).

> [!tip] Directed vs undirected
> Many definitions below are stated for digraphs. When orientation does not matter they also apply to undirected graphs — just replace path with chain, cycle with circuit, etc.
> ![[Graphs-1791560716558.webp|353]]

## Successors, predecessors, stars, degree

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

## Subgraphs and partial graphs

- **Subgraph induced by $V \subseteq N$:** $G' = (V, A')$ with $A' = \{(i,j) \in A : i,j \in V\}$.
- **Partial graph defined by $B \subseteq A$:** $G' = (N, B)$.
- **Partial subgraph:** combine both.

# 2. Chain, Path, Cycle

## Chain and circuit

A **chain** is a sequence $i_1, a_1, i_2, \dots, i_{r-1}, a_{r-1}, i_r$ where each $a_k$ is either $(i_k, i_{k+1})$ or $(i_{k+1}, i_k)$.

- Arcs $(i_k, i_{k+1})$ are **in accordance** with orientation $i_1 \to i_r$.
- Arcs $(i_{k+1}, i_k)$ are **not in accordance**.
- **Closed chain / circuit:** $i_1 = i_r$.

## Path

A **path** requires all arcs oriented forward: $a_k = (i_k, i_{k+1})$ for $k=1,\dots,r-1$.
	
- **Closed path:** $i_1 = i_r$.
	![[Graphs-1791560256435.webp|356]]
- **Simple path:** no repeated **arcs**. E.g. $2,4,5,4,3$.
	![[Graphs-1791560347791.webp|356]]
- **Elementary path:** no repeated **nodes**. E.g. $1,2,4,5$.
	![[Graphs-1791560389715.webp|358]]

## Cycle

A **cycle** is a closed path where the only repeated node is the first one — i.e. an elementary path $i_1 \to i_r$ plus arc $(i_r, i_1)$. E.g. $2,4,2$.

- **Simple cycle:** no repeated arcs.
- **Elementary cycle:** no repeated nodes (except start/end).
- Graph with no cycles is **acyclic**.

> [!warning] Common confusion
> - Simple = no repeated arcs, Elementary = no repeated nodes.
> - Every elementary path is simple, not vice versa.

### Hamiltonian and Eulerian

- **Hamiltonian cycle:** cycle containing **all nodes** in $N$, exactly $|N|$ arcs. Does not always exist.
	Hamiltonian cycles are elementary cycles.
- **Eulerian cycle / tour:** closed simple path containing **all arcs**, exactly $|A|$ arcs. Does not always exist.
	Eulerian tours are simple cycles.
	Exists iff $|FS(i)| = |BS(i)|$, $\forall i \in N$.

# 3. Connectivity, components, cuts

- **Connected:** for every $i,j \in N$ there exists a **chain** from $i$ to $j$.
- **Strongly connected:** for every $i,j \in N$ there exists a **path** from $i$ to $j$.
- **Connected component:** maximal connected subgraph. Same for strongly connected component.
- **Cut:** partition $N = N' \cup N''$, $N' \cap N'' = \emptyset$.
	Direct arcs: tail in $N'$, head in $N''$.
	Inverse arcs: tail in $N''$, head in $N'$.

# 4. Bipartite, tree, matching

- **Bipartite graph:** $N = N_1 \cup N_2$ such that every arc $(i,j)$ has $i \in N_1, j \in N_2$ or vice versa.
- **Tree:** connected graph with no closed chains.
- **Spanning tree $T$:** tree containing all nodes of $G$.
- **Matching:** partial graph where no two arcs share a node. **Perfect matching** if every node is incident to one arc.

## Minimum Spanning Tree

Given weighted undirected $G=(N,A)$ with weights $w_e > 0$, find spanning tree of minimum total weight.

## Properties of a spanning tree $G' = (N, A')$

Let $|N| = n$:
1. No cycles
2. $G'$ is connected
3. $|A'| = n-1$
4. Adding one arc creates exactly one cycle
5. Removing one arc creates two connected components

### Kruskal Algorithm [1956]

> [!example] Idea
> Take arcs in increasing weight order. Add an arc iff it does not create a cycle.

1. Sort arcs in increasing order of $w_{ij}$
2. $A' = \emptyset$
3. Repeat:
   1. Consider next arc $\{i,j\}$ in order
   2. If $A' \cup \{\{i,j\}\}$ contains no cycle, then $A' \leftarrow A' \cup \{\{i,j\}\}$
4. Until $|A'| = n-1$

Key point from the book: stop when $|T| = |N|-1$, no need to scan all arcs.

See [[chapter+2.pdf#page=10]] for worked example and optimality proof (exchange argument).

# 5. Graph Search

``` 
for i ∈ N do P[i]←0 
	P[s]←s; Q←{s};
repeat 
	select i from Q; Q←Q\{i}; 
	foreach (i,j) ∈ FS(i) do 
		if P[j]=0 then P[j]← i 
			Q←Q∪{j} 
until Q=∅
``` 

>[!info] Propertie
>Given a directed graph $G = (N, A)$ 
>and t wo nodes $s, t ∈ N$
>either there is a path pst or there is a cut $(N_s, N_t), s ∈ N_s, t ∈ N_t$
>such that each arc of the cutset is $(i, j) : i ∈ N_t, j ∈ Ns$
# 6. Shortest Path path
 General form:
 >[!info]
Given a direct graph $G=(N,A)$
with cost $c_{ij},\forall(i,j)\in A$
and one node(root) $s,t\in N$
>
>Find the(elementary) path $p$ from $s$ to $t$ 
>minimizing $\sum_{(i,j)\in p} c_{ij}$

## Shortest Path Tree (SPT)

 >[!info]
Given a direct graph $G=(N,A)$
with cost $c_{ij},\forall(i,j)\in A$
and one node(root) $r \in N$
>
>Find the collection of all shortest path from $r$

## Algorithms
### SPT_Acyclic(G,P,d)

```
for i←2,…,n do P[i]←0; d[i]←+∞;
P[1]←1; d[1]←0;
for i←1,…,n-1 do
	foreach (i,j) ∈ FS(i) do
		if d[i]+cij < d[j] then P[j]← i 
			d[j] ← d[i]+cij
```

### LongestPT_Acyclic(G, P, d)

```
for i←2,…,n do P[i]←0; d[i]←-∞;
P[1]←1; d[1]←0;
for i←1,…,n-1 do
	foreach (i,j) ∈ FS(i) do
		if d[i]+cij > d[j] then P[j]← i
			d[j] ← d[i]+cij
```

---
Related: [[_Operational Research MOC]]
Source: [[chapter+2.pdf]]
