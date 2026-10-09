---
date: 2026-10-09
subject: Formal Languages and Compilers
---
## Definitions

- **Alphabet** ($\Sigma$): finite set of atomic elements (symbols/letters)
  - e.g. $\Sigma = \{a, b, c\}$
- **String**: finite, ordered sequence of symbols of an alphabet; the same symbol can appear more than once (elements are repeatable)
  - the set of all strings over $\Sigma$ is denoted $\Sigma^*$
  - the set of **non-empty** strings is $\Sigma^+ = \Sigma^* \setminus \{\epsilon\}$
- **Language**: a set of strings over an alphabet, i.e. any subset $L \subseteq \Sigma^*$; its elements are called **phrases** of the language
- **Formal (Artificial) Language**: a language with a regular structure and well-defined rules

## String Properties

> [!info] Length
> Number of elements of the string: $|x|$
>
> e.g. $|bbc| = 3$

> [!info] Equality
> Two strings $x = a_1 a_2 \dots a_k$ and $y = b_1 b_2 \dots b_h$ are equal iff:
> - they have the same length: $k = h$
> - their elements coincide, in order, from left to right: $a_j = b_j$ for every $j = 1, \dots, k$
>
> $x = y \iff k = h \wedge a_j = b_j \quad (j = 1, \dots, k)$

> [!info] Substring, Prefix, Suffix
> $$x = u\,y\,v$$
> - $y$ is a **substring** of $x$ (contiguous block: $|x| = |u| + |y| + |v|$)
> - $u$ is a **prefix** of $x$ (initial segment)
> - $v$ is a **suffix** of $x$ (final segment)
>
> e.g. $x = abccbc$
> - prefixes: $a, ab, abc, abcc, abccb, abccbc$ (and $\epsilon$)
> - suffixes: $c, bc, cbc, ccbc, bccbc, abccbc$ (and $\epsilon$)
> - substrings: any contiguous block, e.g. $bcc, cc, cb, \dots$
>
> $\epsilon$ is a prefix and a suffix of every string; every string is a prefix and a suffix of itself.

> [!info] Empty String (or NULL string)
> $\epsilon$ is the neutral element with respect to concatenation: chaining $\epsilon$ on the left or right does not change the string.
> $$x\epsilon = \epsilon x = x \qquad |\epsilon| = 0$$
> *Pay attention: $\epsilon$ is NOT $\emptyset$:*
> - $\epsilon$ is a **string** (an element of $\Sigma^*$)
> - $\emptyset$ is the **empty language** (a set with no strings)
> - $\{\epsilon\}$ is the language containing exactly the empty string — different from both
## String Operations

> [!info] Concatenation
> - basic operation: joins two strings in sequence
> - is associative: $(xy)z = x(yz)$, so parenthesization is irrelevant
> - changes the length additively: $|xy| = |x| + |y|$, in general $|xyz| = |x| + |y| + |z|$
> - is **not** commutative: in general $xy \ne yx$


> [!info] Mirroring (Reflection)
> $$x = a_1 a_2 \dots a_h \ \Rightarrow\ x^R = a_h a_{h-1} \dots a_2 a_1$$
> - $(x^R)^R = x$ (mirroring is an involution)
> - $(xy)^R = y^R x^R$
> - $|x^R| = |x|$

> [!info] Repetition (Power, Iteration)
> The $m$-th power of a string (with $m \ge 0$) concatenates the string with itself $m$ times:
> $$x^m = x^{m-1}x \quad (m > 0) \qquad x^0 = \epsilon$$
> - $|x^m| = m\,|x|$
> - e.g. $(ab)^2 = abab \ne a^2b^2 = aabb$

> [!info] Precedence between Operators
> **Power** and **Mirroring** bind tighter than **Concatenation**:
> 1. Power / Mirroring
> 2. Concatenation
>
> e.g. $x y^2 = x(yy)$, while $(xy)^2 = xyxy$

## Language Operations

- **Union**: $L_1 \cup L_2 = \{ x \mid x \in L_1 \vee x \in L_2 \}$
- **Concatenation**: $L_1 L_2 = \{ xy \mid x \in L_1 \wedge y \in L_2 \}$ — associative, and $\emptyset$ is absorbent: $\emptyset L = L \emptyset = \emptyset$
- **Iteration**: $L^*$ (see Star Operator below)
- **Prefix**: $\mathrm{Prefix}(L) = \{ y \mid y \text{ is a prefix of some } x \in L \}$
- **Mirroring**: $L^R = \{ x^R \mid x \in L \}$
- A language over $\Sigma$ is any set $L \subseteq \Sigma^*$; the **void language** is $\emptyset$ (no phrases), which must not be confused with $\{\epsilon\}$ (one phrase: the empty string)

### Star Operator
- Also called **Kleene star** or **concatenation closure**
- Is the limit of the power operator: $L^* = \bigcup_{k \ge 0} L^k$, with $L^0 = \{\epsilon\}$
- The union of all the powers of a language, for every non-negative exponent
- **ε-Closure**: every star language contains $\epsilon$ (it comes from $L^0$)
- Every string in $L^*$ can be factored into substrings, each of which belongs to $L$
- Sometimes the star language happens to be identical to the base language: $L^* = L$ iff $L$ is closed under concatenation and contains $\epsilon$ (e.g. $L = \Sigma^*$ or $L = \{\epsilon\}$)
- $\emptyset^* = \{\epsilon\}$
- **Properties**: monotone; closed w.r.t. concatenation; idempotent; commutes with mirroring
  - monotone: $L \subseteq M \Rightarrow L^* \subseteq M^*$
  - closed w.r.t. concatenation: $L^* L^* = L^*$
  - idempotent: $(L^*)^* = L^*$
  - commutes with mirroring: $(L^R)^* = (L^*)^R$

### Cross Operator
- Called **Kleene plus** or **positive concatenation closure**
- Is the non-reflexive closure with respect to concatenation: $L^+ = \bigcup_{k \ge 1} L^k$
- Does **not** contain the null power ($L^0 = \{\epsilon\}$), hence in general $\epsilon \notin L^+$
- Sometimes very useful but not indispensable: it can be expressed as $L^+ = L L^* = L^* L$
- Consequently $L^* = L^+ \cup \{\epsilon\}$
- The same language can be defined in different ways by different combinations of the same or other operators

### Quotient Operator
- Shortens the phrases of a language $L'$ by stripping off a suffix that belongs to another language $L''$
- $$L' / L'' = \{ y \mid (x = yz \in L') \wedge z \in L'' \}$$
- e.g. $\{ab\} / \{b\} = \{a\}$

### Prefix-Free Language
- A language is **prefix-free** if no string of the language is a *proper* prefix of another string of the language: for all $x, y \in L$, if $x$ is a prefix of $y$ then $x = y$
- Equivalently, $L$ and $\mathrm{ProperPrefix}(L)$ are disjoint: $L \,\cap\, \mathrm{ProperPrefix}(L) = \emptyset$, where $\mathrm{ProperPrefix}(L)$ is the set of proper (strict) prefixes of strings of $L$
  - _Note: $L \subseteq \mathrm{Prefix}(L)$ always holds, since every string is a prefix of itself — so disjointness must be stated with **proper** prefixes_
- e.g. $\{ab, ba\}$ is prefix-free; $\{a, ab\}$ is not ($a$ is a proper prefix of $ab$)

## Key Identities

| Identity | Meaning |
| --- | --- |
| $L^* = L^+ \cup \{\epsilon\}$ | star adds the empty power to cross |
| $L^+ = L L^* = L^* L$ | cross expressed via star + concatenation |
| $(L^*)^* = L^*$ | idempotence of star |
| $L^* L^* = L^*$ | closure under concatenation |
| $|xy| = |x| + |y|$ | length is additive over concatenation |
| $(xy)^R = y^R x^R$ | mirroring reverses the order of factors |

---

Related: [[_Formal Languages and Compilers MOC]], [[Regular expressions and Languages]], [[Context free Grammars]]