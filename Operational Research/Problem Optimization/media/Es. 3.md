![[Es. 3-1791473777167.webp|362]]

### Solution

- **Sets**:
	- $S=\{1\dots m\}$ → candidate systems (antennas)
	- $C=\{1\dots m\}$ → customers
- **Parameters**:
	- $\mu$ → capacity of one antenna
	- $p_{ij}$ → emission power, $\forall i\in C,\ \forall j \in S$
- **Variables**:
	- Activate a subset of antennas:
		$$y_j=\begin{cases}
		1 & \text{if } j \text{ is active} \\
		0 & \text{otherwise}
		\end{cases}$$
	- Assign a customer to an antenna:
		$$x_{ij}=\begin{cases}
		1 & \text{if } i \text{ is connected to } j\\
		0 & \text{otherwise}
		\end{cases}$$
- **Constraints**:
	- Serve all customers:
		$$\sum_{j\in S} x_{ij}=1, \quad \forall i\in C$$
		$$~~\sum_{i\in C}\sum_{j \in S} x_{ij}=\mu~~\canc\text{→ wrong}$$~~ 
	- Capacity:
		$$\sum_{i\in C}x_{ij}\leq\mu$$
	- Avoid $x_{ij}=1$ when $y_j=0$:
		$$\sum_{i\in C}x_{ij}\leq\mu\, y_j \quad \vee \quad x_{ij}\leq y_j$$
		The second one is the better formulation.
- **Objective**:
	$$\min \max_{\,i\in C,\ j\in S}\left(p_{ij}x_{ij}\right)$$
	This can be reduced to a linear problem using a dummy variable $d$:
	$$d \geq p_{ij}x_{ij} \quad\text{(dummy variable tracking the max)}$$
	$$\min d = \min \max\left(p_{ij}x_{ij}\right) \quad\to\quad d^* \text{: optimal value} = \min\max$$
	![[grafi2]]

![[Es. 3-1791478758471.webp|369]]
![[Es. 3-1791478780648.webp|370]]
