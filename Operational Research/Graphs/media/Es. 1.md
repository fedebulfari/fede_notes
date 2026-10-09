![[Es. 1-1791561061335.webp|391]]

# Problem Abstraction

| Given an undirected graph <br>with weights on the arcs  <br>find a connected subgraph  | $G = (N, A)$ <br>$w_{ij} ≥ 0 ∀(i, j) \in A$<br>$G' = (N, A'), A' ⊆ A$ |
| ------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
We do this minimizing $$\sum_{(i,j)\in A'}w_{ij}$$
# Solution

- Parameters: $$w_{ij}\geq 0, \forall\{i,j\}\in A$$
- Variables:$$x_{ij}\begin{cases}
1[i,j]
\end{cases}$$