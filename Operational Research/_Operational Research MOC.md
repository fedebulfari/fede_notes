---
subject: Operational Research
description: Map of contents for Operational Research — modelling optimization problems, graph theory, and network flows as taught in the course
---

# Operational Research

> [!summary] Overview
> The course moves from **modelling** to **algorithms**: first a decision problem is translated into variables, constraints and an objective, then the combinatorial structure of that problem is studied on graphs, and finally the graph machinery is applied to network flows. The three notes form a chain — [[Problem Optimization]] states the language, [[Graphs]] supplies the structures and the path-or-cut view, [[Flows]] develops the network-flow models and algorithms.

## 1. Reading Path

1. [[Problem Optimization]] — decisions → variables, rules → constraints, objectives → functions; general LP form, variable domains, slack transformations, linear/bottleneck/multi-objective goals.
2. [[Graphs]] — nodes, arcs, stars, paths and cycles, connectivity and cuts, trees, bipartite graphs, matchings and Kruskal, graph search as *path or cut*, shortest paths.
3. [[Flows]] — maximum flow and min cut, residual graphs and augmenting paths, Edmonds–Karp and capacity scaling, matching as max flow, minimum cost flow with cycle canceling and successive shortest paths, and multicommodity flows.

## 2. Themes

- **Modelling** — the translation table between the problem and the model is the core skill; every later algorithm assumes the model is right.
- **Structure** — cuts, trees and bipartiteness are not definitions to memorise but the properties that make optimisation tractable.
- **Duality in disguise** — the *path-or-cut* property is the graph-level statement of the same duality that will reappear as max-flow/min-cut.

## 3. Core Ideas

- An LP has continuous variables; **integer or binary domains** turn it into a MILP, and that is what makes most real problems hard.
- Constraints can be rewritten (slack variables, absolute values, min/max) without changing the feasible set — the art is choosing the formulation the solver handles best.
- Graph search either **finds a path** or **exhibits a cut**: the certificate of failure is as informative as the certificate of success.
- A flow is feasible when capacities hold on every arc and conservation holds at every intermediate node.
- A maximum flow is certified optimal by a **minimum cut**; the residual graph is the bridge between the two.

## 4. Gaps and next Steps

- [[Flows]] now covers the whole flow module: max flow/min cut, residual graphs and Edmonds–Karp, matching, min cost flow and multicommodity flows. Its worked example is a rerouting example rather than the slide exercise — replace it with the lecture instance if one is assigned.
- No notes yet on LP solution methods — simplex, branch-and-bound, or LP duality beyond the max-flow/min-cut case.
- [[Graphs]] ends at shortest paths; spanning trees are sketched, while max-flow and matching algorithms now live in [[Flows]].
