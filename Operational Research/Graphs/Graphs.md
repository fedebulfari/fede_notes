---
date: 08-10-2026
subject: Operational Research
---
A Graph is defined by its arcs and its nodes.
# Notation
- Path: sequence of consecutive of consecutive arcs.
	Given a graph, we can define a Path to link it's nodes.
	![[Graphs-1791560256435.webp|346]]
	
- Simple Path: link nodes not repeating arcs
	![[Graphs-1791560347791.webp|350]]
- Elementary Path: link nodes passing through them  up to one time
	![[Graphs-1791560389715.webp|350]]
- Cycle: Path that links backkto starting nodes
- Elementary Cycle:  No repeated nodes
- Hemiltonian Cycle: Cycle linking all nodes
	Hemiltonian Cycles are an Elementary Cycle.
- Simple Cycle: No repeated arcs
- Eulerian Tour: All arcs are visited
	Eulerian Tours are  Simple Cycle.
- Graphs can be directional or not
	![[Graphs-1791560716558.webp|353]]
	
![[Es. 1]]
# Minimal feasible Solution

A Minimal Solution has the following properties:
- No cycles
- $G'$ is connected
- if $|N|=n\implies|A'|=n-1$
- $G'$ is spanning tree
- Adding one arc to $G'$ make it a cycle
- Removing one arc from $G'$ give us two connected components
## Kruskal Algorithm [1956]
1) Sort arcs in increasing order of $w_{ij}$
2) $A'=∅$
3) repeat
	1) consider the next arc $\{i,j\}$ in order
	2) if $A'\cup  \{i,j\}$does not include a cycle
	3) then $A'←A'\{i,j\}$
4) Until $|A'|=n-1$
---
Related: [[_Operational Research MOC]]