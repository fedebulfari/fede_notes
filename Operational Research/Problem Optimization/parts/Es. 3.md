![[Es. 3-1791473777167.webp|362]]

### Solution
- Sets: $$S=\{1\dots m\}\to\text{candidates system}\\ C=\{1\dots m\}\to\text{customers}$$
- Parameters: $$\mu\to \text{capacity of one antenna}\\ p_{ij}\to \text{emission power, }\forall i\in C,\forall j \in S$$
- Variables: 
	Activate a subnet of antennas:$$y_j=\begin{cases}
	1 \text{ if }j \text{ is active} \\
	0
	\end{cases}$$$$x_{ij}=\begin{cases}
	1 \text{ if } i \text{ is  connected to } j\\
	0
	\end{cases}$$
- Constraints:
	Save all customer $$\sum_{j\in S} x_{ij}=1 , \forall j\in S 
	\\ \cancel{\sum_{i\in C}\sum_{j \in S} x_{ij}=\mu}\to\text{Wrong}$$
	Capacity:$$\sum_{i\in C}x_{ij}\leq\mu$$
		Need to avoid  $x_{ij}=1$ if $y_{j=0}$$$\sum_{i\in C}x_{ij}\leq\mu y_{i}\\\vee\\ x_{ij}\leq y_{j}$$
		The second one is the better solution.$$\implies\min\max_{i\in C\\j\in S}(p_{ij}x_{ij})\to \text{Objective function}$$ ![[grafi2]]
	We can reduce it a linear problem using a dummy variable$$d\geq p_{ij}x_{ij}\to\text{Dummy variable to trak the max}\\ \min d=\min\max(p_{ij}x_{ij})\to d^*\text{:optimal solution}=\min\max$$![[Es. 3-1791478758471.webp|369]]![[Es. 3-1791478780648.webp|370]]