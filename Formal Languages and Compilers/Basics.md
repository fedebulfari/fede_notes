---
date: 2026-10-09
subject: Formal Languages and Compilers
---

## Definitions

- **Alphabet** ($\Sigma$): finite set of atomic elements (symbols / letters)
  - e.g. $\Sigma = \{a, b, c\}$
- **String**: finite, ordered sequence of symbols from an alphabet; symbols may repeat
  - the set of all strings over $\Sigma$ is denoted $\Sigma^*$
  - the set of **non-empty** strings is $\Sigma^+ = \Sigma^* \setminus \{\epsilon\}$
- **Language**: a set of strings over an alphabet, i.e. any subset $L \subseteq \Sigma^*$; its elements are called **phrases**
- **Formal (artificial) language**: a language with regular structure and well-defined rules

## String Properties

> [!info] Length
> Number of symbols in the string: $|x|$
>
> e.g. $|bbc| = 3$

> [!info] Equality
> Two strings $x = a_1 a_2 \dots a_k$ and $y = b_1 b_2 \dots b_h$ are equal iff:
> - they have the same length: $k = h$
> - symbols coincide left-to-right: $a_j = b_j$ for every $j = 1, \dots, k$
>
> $x = y \iff k = h \land a_j = b_j \quad (j = 1, \dots, k)$

> [!info] Substring, Prefix, Suffix
> Let $x = u\,y\,v$:
> - $y$ is a **substring** of $x$ (contiguous block)
> - $u$ is a **prefix** of $x$ (initial segment)
> - $v$ is a **suffix** of $x$ (final segment)
>
> e.g. $x = abccbc$
> - prefixes: $\epsilon, a, ab, abc, abcc, abccb, abccbc$
> - suffixes: $\epsilon, c, bc, cbc, ccbc, bccbc, abccbc$
> - substrings: any contiguous block, e.g. $bcc, cc, cb$
>
> $\epsilon$ is a prefix and suffix of every string; every string is a prefix and suffix of itself.

> [!warning] Empty string vs empty language
> $\epsilon$ is the neutral element for concatenation: $x\epsilon = \epsilon x = x$ and $|\epsilon| = 0$.
>
> Do not confuse:
> - $\epsilon$ — a **string** (element of $\Sigma^*$)
> - $\emptyset$ — the **empty language** (set with no strings)
> - $\{\epsilon\}$ — the language containing only the empty string

## String Operations

> [!info] Concatenation
> - basic operation: joins two strings in sequence
> - associative: $(xy)z = x(yz)$, so parentheses are irrelevant
> - length is additive: $|xy| = |x| + |y|$
> - **not** commutative: in general $xy \ne yx$

> [!info] Mirroring (Reflection)
> $$x = a_1 a_2 \dots a_h \Rightarrow x^R = a_h a_{h-1} \dots a_2 a_1$$
> - $(x^R)^R = x$ (involution)
> - $(xy)^R = y^R x^R$
> - $|x^R| = |x|$

> [!info] Repetition (Power)
> The $m$-th power ($m \ge 0$) concatenates the string with itself $m-1$ times:
> $$x^m = x^{m-1}x \quad (m > 0), \qquad x^0 = \epsilon$$
> e.g. $(ab)^2 = abab \ne a^2b^2 = aabb$

> [!tip] Operator precedence
> **Power** and **mirroring** bind tighter than **concatenation**:
> 1. Power / mirroring
> 2. Concatenation
>
> e.g. $xy^2 = x(yy)$, while $(xy)^2 = xyxy$

## Language Properties

> [!info] Universal Language
> the set of ALL the strings defined over the alphabet Σ, of any length (including also length 0)
>$$L= \sum^0 ∪ \sum^1 ∪ \sum^2 ∪\dots$$
> _Sometimes called the **Free Monoid**_


## Language Operations

- **Union**: $L_1 \cup L_2 = \{ x \mid x \in L_1 \lor x \in L_2 \}$
- Intersection: $L_{1}\cap L_{2}$
- Complement: $¬L=L_{universal}-L$
- **Concatenation**: $L_1 L_2 = \{ xy \mid x \in L_1 \land y \in L_2 \}$ — associative; 
	$\emptyset$ is absorbent: $\emptyset L = L \emptyset = \emptyset$
- **Iteration**: $L^*$ — see [[#Star operator (Kleene star)]] below
- **Prefix**: $\mathrm{Prefix}(L) = \{ y \mid y \text{ is a prefix of some } x \in L,\ x=yz \}$
- **Mirroring**: $L^R = \{ x^R \mid x \in L \}$
- 

### Star operator (Kleene star)

> [!info] Star operator
> Also called **concatenation closure**. Limit of the power operator:
> $$L^* = \bigcup_{k \ge 0} L^k, \quad \text{with } L^0 = \{\epsilon\}$$
>
> - **$\epsilon$-closure**: every star language contains $\epsilon$ (from $L^0$)
> - every string in $L^*$ factors into pieces, each belonging to $L$
> - $L^* = L$ iff $L$ is closed under concatenation and contains $\epsilon$ (e.g. $L = \Sigma^*$ or $L = \{\epsilon\}$)
> - $\emptyset^* = \{\epsilon\}$
>
> **Properties:**
> - monotone: $L \subseteq M \Rightarrow L^* \subseteq M^*$
> - closed under concatenation: $L^* L^* = L^*$
> - idempotent: $(L^*)^* = L^*$
> - commutes with mirroring: $(L^R)^* = (L^*)^R$

### Cross operator (Kleene plus)

- positive concatenation closure: $L^+ = \bigcup_{k \ge 1} L^k$
- excludes the null power, so in general $\epsilon \notin L^+$
- expressible via star: $L^+ = L L^* = L^* L$
- hence $L^* = L^+ \cup \{\epsilon\}$

### Quotient operator

- strips a suffix belonging to $L''$ from phrases of $L'$:
$$L' / L'' = \{ y \mid yz \in L' \land z \in L'' \}$$
- e.g. $\{ab\} / \{b\} = \{a\}$

### Prefix-free language

A language is **prefix-free** if no string is a *proper* prefix of another: for all $x, y \in L$, if $x$ is a prefix of $y$ then $x = y$.

Equivalently: $L \cap \mathrm{ProperPrefix}(L) = \emptyset$, where $\mathrm{ProperPrefix}(L)$ is the set of proper (strict) prefixes of strings in $L$.

> [!note] Prefix vs proper prefix
> $L \subseteq \mathrm{Prefix}(L)$ always holds, since every string is a prefix of itself — so disjointness must use **proper** prefixes.
>
> e.g. $\{ab, ba\}$ is prefix-free; $\{a, ab\}$ is not ($a$ is a proper prefix of $ab$).

## Key identities

| Identity | Meaning |
| --- | --- |
| $L^* = L^+ \cup \{\epsilon\}$ | star adds the empty power to cross |
| $L^+ = L L^* = L^* L$ | cross expressed via star + concatenation |
| $(L^*)^* = L^*$ | idempotence of star |
| $L^* L^* = L^*$ | closure under concatenation |
| $\|xy\| = \|x\| + \|y\|$ | length is additive over concatenation |
| $(xy)^R = y^R x^R$ | mirroring reverses factor order |

---

Related: [[_Formal Languages and Compilers MOC]], [[Regular expressions and Languages]], [[Context free Grammars]]
