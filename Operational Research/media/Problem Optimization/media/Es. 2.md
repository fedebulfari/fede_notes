![[grafo1]]
### Solution

To check whether the system of constraints is feasible we optimize with a **zero objective** ($c = 0$):

1. Take $A_{1}x \leq b_{1}$ as the objective function.
2. Its optimal solution is $x' = \min\{A_{1}x \leq b_{1},\dots,A_{n}x \leq b_{n}\}$.

Does $x'$ solve the system?

- If $A_{1}x' \leq b_{1}$, then $x'$ solves the system.
- If $A_{1}x' > b_{1}$, then the system has no solution.
