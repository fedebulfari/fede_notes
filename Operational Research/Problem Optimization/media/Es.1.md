Given a set of financial instruments

|            |  1  |  2  |  3  |  4  |  5  |
|:----------:|:---:|:---:|:---:|:---:|:---:|
| max amount | 40  | 12  | 130 |  5  | 400 |
|   coupon   | 3.2 | 1.5 | 4.2 | 0.7 | 17  |
Decide how much to invest in each instrument to maximize the economical return from the coupons:

## Solution

- Budget: 137€ $\implies \sum ^5_{i=1}x_{i}\leq 137$
- Upper bounds: $x_{1}\leq40, x_{1}\leq 12, x_{1}\leq 180, x_{1}\leq 5, x_{1}\leq 400$
- Coupons($c_{i}$): $x_1=3.2, x_{2}=1.5,  x_{3}=4.2, x_{4}=0.7, x_{5}=17$
	$y_{i}=\frac{x_{i}}{upper\_bound(x_{i})}$
 $\implies$  ![[Es.1-1791390205262.webp|294x281]]