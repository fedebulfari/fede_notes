---
date: 09-10-2026
subject: Formal Languages and Compilers
---

# Basics

- **Alphabet**: finite set of elements
- **Strings**: ordered set of atomic elements (repeatable)
- **Language**: set of strings
- **Formal (Artificial) Language**: a language with a regular structure and well-defined rules

## Strings Properties

> [!info] Length
> Number of elements
> _Es. $|bbc| = 3$_

> [!info] Equality
> Two strings are equal iff:
> - they have the same length
> - their elements coincide, in order, from left to right
>
> _Es. $x = y \leftrightarrow k = i \wedge a_j = b_j$ with $j = 1, \dots, k$_

> [!info] Substring
> $$x = u\,y\,v$$
> $y$ is a **substring**, $u$ is a **prefix**, $v$ is a **suffix**
>
> _Es. $x = abccbc$_
> - prefix: $a, ab, abc, abcc, abccb, abccbc$
> - suffix: $c, bc, cbc, ccbc, bccbc, abccbc$
> - substring: $\dots, bc, cc, cb, \dots$
>
> ![[Basics-1791567228274.webp|279x101]]

## Strings Operations

> [!info] Concatenation
> - is a basic operation
> - is associative: $(xy)z = x(yz)$
> - changes the length: $|xyz| = |x| + |y| + |z|$

> [!info] Empty String (or NULL string)
> $\epsilon$ is the neutral element with respect to concatenation: chaining $\epsilon$ on the left or right does not change the string.
> $$x\epsilon = \epsilon x = x \qquad |\epsilon| = 0$$
> _Pay attention: $\epsilon$ is NOT the same as $\emptyset$ (the empty set)_

> [!info] Mirroring (Reflection)
> $x = a_1 a_2 \dots a_h \ \Rightarrow\ x^R = a_h a_{h-1} \dots a_2 a_1$
> - $(x^R)^R = x$
> - $(xy)^R = y^R x^R$

> [!info] Repetition (or Iteration)
> The $m$-th power of a string (with $m \ge 0$) concatenates the string to itself $m$ times:
> $$x^m = x^{m-1}x \quad (m > 0) \qquad x^0 = \epsilon$$

> [!info] Precedence between Operators
> Power precedes Concatenation; Mirroring precedes Concatenation

## Language Operations

- **Prefix**: $\mathrm{Prefix}(L) = \{ y \mid y \text{ is a prefix of some } x \in L \}$
- **Concatenation**: $L_1 L_2 = \{ xy \mid x \in L_1 \wedge y \in L_2 \}$
- **Iteration**: $L^*$
- **Union**: $L_1 \cup L_2$
- A language over $\Sigma$ is any set $L \subseteq \Sigma^*$; the **void language** is $\emptyset$

### Star Operator
- Also called Kleene star or concatenation closure
- Is the limit of the power operator: $L^* = \bigcup_{k \ge 0} L^k$, with $L^0 = \{\epsilon\}$
- The union of all the powers of a language, for every non-negative exponent
- $\epsilon$-CLOSURE
- Every string in the star language of $L$ can be factored into substrings, each of which belongs to the language $L$
- Sometimes the star language happens to be identical to the base language
- **Properties**: monotone; closed w.r.t. concatenation; idempotent; commutes with mirroring

### Cross Operator
- Called Kleene cross or positive concatenation closure
- Is the non-reflexive closure with respect to concatenation
- Does not contain the null power
- Sometimes very useful but not indispensable
- The same language can be defined in different ways by different combinations of the same or other operators

### Quotient Operator
- Shortens the phrases of a language $L'$ by stripping off a suffix out of another language $L''$
- $L'/L'' = \{ y \mid (x = yz \in L') \wedge z \in L'' \}$

### Prefix-Free Language
- In the language there is not any string that is a prefix of another string of the language
- Equivalently, $\mathrm{Prefix}(L)$ and $L$ are disjoint sets (i.e., $\mathrm{Prefix}(L) \cap L = \emptyset$)

---
Related: [[_Formal Languages and Compilers MOC]]
