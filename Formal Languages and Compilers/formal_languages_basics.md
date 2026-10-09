# Basics

- Alphabet: finite set of element

- Strings: atomic elements (repeatable)

- Language: node finite set of String

- Formal Language: Language with regular structure and well defined Rules

- Artificial Operations

- Message


## CONCATENATION (product of strings)
- is a basic operation

- is associative

- changes the length


## EMPTY STRING (or NULL string)
- is the neutral element with respect to concatenation: chaining $\epsilon$ on the left or right does not change the string

- Pay attention: $\epsilon$ is NOT the same as $\emptyset$ (the empty set)


## SUBSTRING: $x=uyv$
- y is a substring

- u is a prefix

- v is a suffix

- Proper substring: y if $u \neq \epsilon \vee v \neq \epsilon$

- $Start_{k}(x) = k \text{ prefix of } x$


## LENGTH OF A STRING $x$
- is the number of elements (letters)

- $\vert{}bbc\vert{} = 3$

- $\vert{}abbc\vert{} = 4$


## EQUALITY OF TWO STRINGS:
- two strings are equal if and only if (iff) they have the same length and their elements orderly coincide, from left to right

- $x=a_{1}a_{2}...a_{k}, y=b_{1}b_{2}...b_{i}$

- $x=y \leftrightarrow k=i \wedge a_{j}=b_{j}$ with $j=1,...k$


## MIRRORING or REFLECTION
- $(xy)z = x(yz)$

- $\vert{}xyz\vert{} = \vert{}x\vert{} + \vert{}y\vert{} + \vert{}z\vert{}$

- $x\epsilon = \epsilon x = x$

- $\vert{}\epsilon\vert{} = 0$


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