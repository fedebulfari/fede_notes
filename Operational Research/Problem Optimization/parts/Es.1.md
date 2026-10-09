Given a set of financial instruments:

|            |  1  |  2  |  3  |  4  |  5  |
|:----------:|:---:|:---:|:---:|:---:|:---:|
| max amount | 40  | 12  | 130 |  5  | 400 |
|   coupon   | 3.2 | 1.5 | 4.2 | 0.7 | 17  |

Decide how much to invest in each instrument to maximize the economic return from the coupons.

## Solution

Let $x_i$ be the amount invested in instrument $i$, $\bar{x}_i$ its max amount and $c_i$ its coupon:

- **Budget** (137€): $\sum_{i=1}^{5} x_{i} \leq 137$
- **Upper bounds**: $x_{1} \leq 40,\ x_{2} \leq 12,\ x_{3} \leq 130,\ x_{4} \leq 5,\ x_{5} \leq 400$
- **Non-negativity**: $x_{i} \geq 0$
- **Objective**: $\max \sum_{i=1}^{5} c_{i} y_{i}$ with $c = (3.2,\ 1.5,\ 4.2,\ 0.7,\ 17)$

With relative variables $y_{i}=\dfrac{x_{i}}{\bar{x}_{i}}$, $\ 0\leq y_{i}\leq 1$ (fraction of each instrument's maximum):

![[Es.1-1791390205262.webp|218x208]]

If the decisions were binary ($y_{i}\in{\{0,1\}}$, i.e. invest the full max amount in instrument $i$ or nothing at all, $x_{i}\in{\{0,\bar{x}_{i}\}}$),
	then the solution strategy would have been different:

![[Es.1-1791401200992.webp|221]]

The continuous model admits infinitely many feasible solutions (an LP, solved at a vertex of the feasible region), while the binary one has only $2^n$ combinations 
	Here $2^5 = 32$ — so the solution strategy becomes combinatorial.
