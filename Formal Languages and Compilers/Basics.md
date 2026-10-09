---
date: 09-10-2026
subject: Formal Languages and Compilers
---
- Alphabet: finite set of elements
- Strings: ordered set of atomic elements (repeatable)
- Language: unordered set of String
- Formal(Artificial) Language: Language with regular structure and well defined Rules
# Strings Properties

>[!info] Length
>Number of elements
>_Es. $\vert{}bbc\vert{} = 3$_

>[!info] Equality
Two strings are equal iif :
>- they have the same length
>- thier elements orderly coincide from left to right
>_Es. $x=y \leftrightarrow k=i \wedge a_{j}=b_{j}$ with $j=1,...k$_
# Strings Operations
>[!info] Concatenation
>is a basic operation
>is associative
>changes the length

>[!info] Empty String (or NULL string)
$\epsilon$ is the neutral element with respect to concatenation: chaining $\epsilon$ on the left or right does not change the string
>
>_Pay attention: $\epsilon$ is NOT the same as $\emptyset$ (the empty set)_

>[!info] Substring
>$$x=u \ y \ v$$
>$y$ is a **substrigs**, $u$ is a **prefix**, $v$ is a **suffix**
>_Es. $$x=abccbc\\
>prefix= a, ab,abc, abcc, abccb, abccbc\\
>suffix= c, bc, cbc, ccbc, bccbc, abccbc\\
>substring= \dots,bc,cc ,cb ,\dots$$

>[!info] Mirroring (Reflection)
>$(xy)z = x(yz)$
$\vert{}xyz\vert{} = \vert{}x\vert{} + \vert{}y\vert{} + \vert{}z\vert{}$
$x\epsilon = \epsilon x = x$
$\vert{}\epsilon\vert{} = 0$

>[!info] Repetition 
>the $m_{th}$power of a string (with m ≥ 1) concatenates the string to itself for m−1 times

>[!info] Percentage between operators
>Power precedes Concatenation, Mirroring precedes Concatenation
## String Operators
- Prefix(L): $\{y \vert{} y \text{ is prefix of } x \in L\}$

- Concatenation $L_{1}L_{2} = \{xy \vert{} x \in L_{1} \wedge y \in L_{2}\}$

- Iteration $L^*$

- Void Languages: $L \subseteq \Sigma^*$

- Union $\cup$


## STAR OPERATOR
- also called Kleene star or concatenation closure

- is the limit of the power operator

- The union of all the powers of a language, for every positive or null exponent

- $\epsilon$-CLOSURE

- Every string in the star language of L can be factored into substrings each of which belongs to the language L

- Sometimes, the star language happens to be identical to the base language


## OPERATIONS ON STRINGS / 2
- $x=a_{1}a_{2}...a_{h}$

- $x^R = a_{h}a_{h-1}...a_{2}a_{1}$

- $(x^R)^R = x$

- $(xy)^R = y^R x^R$


## REPETITION (or ITERATION):
- the m-th power of a string (with $m \ge 0$) concatenates the string to itself for $m-1$ times

- $x^m = x^{m-1}x, m>0$

- $x^0 = \epsilon$


## PRECEDENCE BETWEEN OPERATORS
- power precedes concatenation

- mirroring precedes concatenation


## PREFIX-FREE LANGUAGE:
- in the language there is not any string that is a prefix of another string of the language

- Equivalently, prefix(L) and L are disjoint sets (i.e., prefix(L) $\cap$ L = $\emptyset$)


## PROPERTIES OF THE STAR OPERATOR
- monotonic

- closed w.r.t. concatenation

- idempotent

- commutes with mirroring


## CROSS OPERATOR
- called Kleene cross or positive concatenation closure

- is the non-reflexive closure with respect to concatenation

- The unitary closure does not contain the null power

- Sometimes very useful but not indispensable

- The same language can be defined in different ways by different combinations of the same or other operators


## QUOTIENT OPERATOR:
- it shortens the phrases of a language L by stripping off a suffix out of another language L'

- $L = L'/L'' = \{y \vert{} (x = yz \in L') \wedge z \in L''\}$

---
Related: [[_Formal Languages and Compilers MOC]]