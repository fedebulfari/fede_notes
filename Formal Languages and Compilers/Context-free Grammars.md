---
date: 09-10-2026
subject: Formal Languages and Compilers
description: Context-free grammars — 4-tuple definition and rule shapes, derivations and generated languages, reduced forms and nullables, recursion and infinity, syntax trees, Dyck languages, ambiguity, normal forms, EBNF and the Chomsky hierarchy
---

# Context-free Grammar

> [!summary] Overview
> Context-free grammars generate languages by applying production rules to non-terminals, and this note covers the whole toolkit: the 4-tuple definition, rule shapes, derivations and generated languages, reduced forms, nullables, and the link between recursion and infinite languages. It then treats syntax trees and canonical derivations, **Dyck languages** and regular composition, ambiguity with its catalogue of causes, normal forms (Chomsky, Greibach, uni-linear) and EBNF, before placing everything in the **Chomsky hierarchy**. It generalises [[Regular Expressions and Languages]] and sits above REG in that hierarchy, while [[Finite State Automata]] covers the machine side of recognition.

A **generative grammar** is a set of rules that, by repeated application, generate all and only the phrases of a language.

A **context-free grammar** (Type 2, BNF) is a 4-tuple $G = (V, \Sigma, P, S)$:

- $V$ — non-terminal alphabet (syntactic classes)
- $\Sigma$ — terminal alphabet, disjoint from $V$
- $P$ — set of production rules; each rule is an ordered pair $(X, \alpha)$ with $X \in V$, $\alpha \in (V \cup \Sigma)^*$, written $X \to \alpha$. Alternatives written $X \to \alpha_1 \mid \alpha_2 \mid \dots$
- $S \in V$ — axiom

> [!warning] To avoid confusion
> Meta-symbols $\to$, $\mid$, $\cup$, $\epsilon$ must not appear in $V \cup \Sigma$.

> [!example] Palindromes
> - A phrase is $\epsilon$
> - A phrase enclosed in $a \dots a$ is a phrase
> - A phrase enclosed in $b \dots b$ is a phrase
>
> Derivation chain: $phrase \Rightarrow a\,phrase\,a \Rightarrow ab\,phrase\,ba \Rightarrow abb\,phrase\,bba \Rightarrow abbbba$.

## 1. Conventions

1. `<if_phrase> ::= if <cond> then <phrase> else <phrase>`
2. `if_phrase -> if cond then phrase else phrase`
3. $F \to \text{if } C \text{ then } D \text{ else } D$

Used below:
- $a, b, \dots$ — terminals
- $A, B, \dots$ — non-terminals
- $r, s, \dots, z$ — strings over $\Sigma$
- $\alpha, \beta, \dots$ — strings over $V \cup \Sigma$
- $\sigma$ — strings over $V$ only

### 1.1. Rule Shapes

| **Terminal:** right part in $\Sigma^*$ or $\epsilon$                    | $\to u \| \epsilon$                         |
| ----------------------------------------------------------------------- | ------------------------------------------- |
| **Empty:** right part is $\epsilon$                                     | $\to\epsilon$                               |
| **Initial:** left part is the axiom $S$                                 | $S\to$                                      |
| **Recursive:** left part appears in right part, $A \Rightarrow^+ xAy$   | $A\to\alpha A\beta$                         |
| **Left / right / two-sided recursive:** $A$ is prefix / suffix / either | $A\to A\beta,\ A\to\beta A,\ A\to A\beta A$ |
| **Copy (renaming):** change of name                                     | $A\to B$                                    |
| **Linear:** at most one non-terminal on the right                       | $\to uBv\|w$                                |
| **Right / left linear:** that non-terminal is suffix / prefix           | $\to uB\|w,\ Bv\|w$                         |
| **Chomsky normal:** either one term. ot two nonterm.s                   | $\to BC\|a$                                 |
| **Greibach normal:**  prefix terminal, max length 2                     | $\to a\sigma\|b$                            |
| **Operator normal:** infix terminal                                     | $\to AaB$                                   |

## 2. Derivation and Generated Language

$\beta \Rightarrow_G \gamma$ if $\beta = hAd$, $\gamma = h\alpha d$ and $A \to \alpha$ is a rule of G. $\Rightarrow^*$ is its reflexive-transitive closure.
- **Form from $A$:** $\alpha$ with $A \Rightarrow^* \alpha$.$$L_{A}(G)=\{x\in \sum^*|A\Rightarrow^+x\}$$
- **Sentential form:** if $A$ is the axiom, then the form is called _sentential_$$L(G)=L_{s}(G)=\left\{ x\in \sum^*|S\Rightarrow^+x \right\}$$
- **Phrase:** sentential form with only terminals.
- $L_A(G) = \{x \in \Sigma^* \mid A \Rightarrow^+ x\}$, $L(G) = L_S(G)$.
- $G, G'$ are **equivalent** (weakly) iff $L(G) = L(G')$.

> [!example] Book structure
> $S \to fA$, $A \to AtB \mid tB$, $B \to lB \mid l$.
> $L_B = l^+$, $L(G)$ defined by $f(tl^+)^+$.
> A language is context-free iff some free grammar generates it. This example is also regular.

## 3. Reduced Form

$G$ is in **reduced form** iff **both**:
1. Every $A$ is **reachable** from $S$: $S \Rightarrow^* \alpha A \beta$
2. Every $A$ **generates** something: $L_A(G) \neq \emptyset$

Two-phase algorithm:
1. **Defined symbols:** 
	Start with$$DEF = \{A \mid (A \to u) \in P, u \in \Sigma^*\}$$then iterate $$DEF := DEF \cup \{B \mid (B \to D_1\dots D_n) \in P, \text{each } D_i \in \Sigma \text{ or } \in DEF\}$$
2. **Reachable symbols:** reachabiliy in graph of relation $A \Rightarrow A \to \alpha B \beta$. 
	Remove unreachable non-terminals and rules mentioning them.

Often also required:
- No **circular derivations** $A \Rightarrow^+ A$ — inessential and source of ambiguity.

### 3.1. Axiom on Right and Nullables

- We can forbid $S$ on right sides by adding new axiom $S_0 \to S$.
- $A$ is **nullable** iff $A \Rightarrow^+ \epsilon$.
	- Compute $Null \subseteq V$: $A \in Null$ if $A \to \epsilon \in P$, or if $A \to A_1\dots A_n$ with all $A_i \in Null$.
- **Non-nullable normal form:** no non-terminal $\neq S$ is nullable; $S$ is nullable iff $\epsilon \in L(G)$.

## 4. Recursion and Infinity

To generate infinitely many strings, rules must allow derivations of **unbounded length**, i.e. recursion: $A \Rightarrow^+ xAy$.

> [!important] Infinity criterion
> Let $G$ be reduced with no circular derivations. $L(G)$ is infinite **iff** $G$ admits recursive derivations.
>
> - Necessity: without recursion every derivation has bounded length.
> - Sufficiency: from $S \Rightarrow^* uAv$, $A \Rightarrow^+ xAy$, $A \Rightarrow^* w$ we get $S \Rightarrow^* ux^mwy^mv$ for $m \ge 1$.

- $G$ is **recursion-free** iff the `produce` graph is acyclic.
- Example: $E \to E+T \mid T$, $T \to T*F \mid F$, $F \to (E) \mid i$ — $E,T$ immediately left-recursive, $F$ indirectly recursive, hence infinite.

## 5. Syntax Tree and Canonical Derivations

- **Syntax tree:** connected acyclic graph (unique undirected path between nodes). Shows parent-child / root-leaf structure. Root = axiom, **frontier** (left-to-right leaves) = phrase. Node arity = rule length. **Subtree** rooted at $N$ = $N$ plus all descendants.
- **Leftmost derivation:** always expand leftmost non-terminal. **Rightmost:** always expand rightmost.

Strong vs weak equivalence:

- **Weak:** $L(G) = L(G')$ but trees may differ.
- **Strong / structural:** same language **and** structurally equivalent trees (same condensed skeleton). Strong $\implies$ weak, not vice versa. Structural adequacy matters for semantics, e.g. $3+5 \times 8+2$ must parse as $3+(5\times 8)+2$.

## 6. Dyck and Regular Composition

- **Dyck language:** paradigm of nested parentheses. $\Sigma = \{a,a',b,b',\dots\}$, e.g. $S \to aSa' \mid bSb' \mid \epsilon$. Cancellation test: repeatedly delete adjacent $aa'$, $bb'$ pairs; valid iff result is $\epsilon$.
- $L_1 = \{a^nc a^n\}$ is linear but non-regular, subset of Dyck with one nest level.
- Free languages are closed under **union, concatenation, star** (hence cross $^+$):
	- Union: $S \to S_1 \mid S_2$
	- Concat: $S \to S_1S_2$
	- Star: $S \to SS_1 \mid \epsilon$; Cross: $S \to SS_1 \mid S_1$
	- Keep $V_1 \cap V_2 = \emptyset$, else superset is generated.
- Closed under **mirror**: mirror every right-hand side.

## 7. Ambiguity

Phrase $x$ is **ambiguous** if it has $\ge 2$ distinct syntax trees / derivations. Grammar $G$ is ambiguous if it generates at least one ambiguous string.

- Ambiguity degree of $x$ = number of its trees (can be infinite with nullables). Degree of $G$ = max over strings, possibly unbounded.
- Deciding ambiguity is **undecidable** in general. Check ad hoc or bound derivation length in practice — avoid ambiguity **by construction**.

Catalogue:

1. **Two-sided recursion:** $E \to E+E \mid i$ gives $i+i+i$ two leftmost derivations. Fix with one-sided recursion: $E \to i+E \mid i+E i$ style / layered $E,T,C$.
2. **Left+right lists:** $A \to aA \mid Ab \mid c$ — generate lists separately ($S \to AcB$) or in fixed order.
3. **Union:** if $L_1 \cap L_2 \neq \emptyset$, union grammar is ambiguous on the intersection. Only $L_1 \setminus L_2$, $L_2 \setminus L_1$ stay clean.
4. **Concatenation:** ambiguous if a suffix of $L_1$ is a prefix of $L_2$. Fix with separator: $S \to S_1 \# S_2$.
5. **Regexp rules:** e.g. $S \to a^*b \mid ab^*$ overlapping, or ordering of $bSc \mid bbSc$.

> [!warning] Inherently ambiguous
> $L = \{a^ib^ic^j\} \cup \{a^ib^jc^k\} = \{a^ib^jc^k \mid i=j \lor j=k\}$. Strings $a^nb^nc^n$ are always derivable two ways (check $=_{a,b}$ vs $=_{b,c}$). No equivalent unambiguous grammar exists.

## 8. Normal Forms and Transformations

- **Non-terminal expansion:** $A \to \alpha B \gamma$, $B \to \beta_1 \mid \dots$ gives $A \to \alpha\beta_i\gamma$ — power unchanged.
- **Copy-rule elimination:** $Copy(A) = \{B \mid A \Rightarrow^+ B\}$. Removing copies flattens trees but loses sharing; e.g. arithmetic $E \to E+T \mid T+C$-style vs expanded $E \to E+T \mid T \times C$.
- **Chomsky normal form:** only $A \to BC$ (binary, homogeneous) and $A \to a$, plus $S \to \epsilon$ if needed. Internal nodes arity 2, parents of leaves arity 1.
- **Left $\to$ right recursion:** $A \to A\gamma_1 \mid \dots \mid \beta_1 \mid \dots$ becomes right-recursive with new $A'$; needed for top-down / recursive-descent parsers.
- **Real-time / Greibach:** every rule $A \to a\alpha$ starts with a terminal ($ \alpha \in (V\cup\Sigma)^*$ for real-time, $\alpha \in V^*$ for Greibach). One terminal consumed per step, steps = $|x|$.
- **Uni-linear (Type 3):** $A \to uB$ (right) or $A \to Bu$ (left), $u \in \Sigma^*$. Trees grow unbalanced. No self-inclusive $A \Rightarrow^+ uAv$ ($u,v \neq \epsilon$) — otherwise regular languages would need it; its absence characterizes regularity.

Closure summary ($R \in REG$, $L \in LIB$): $R \circ R \in REG$, $L \circ L \in LIB$ for union/concat; $R \cap R \in REG$ but $L_1 \cap L_2 \notin LIB$ in general; $R \cap L \in LIB$; complement flips out.

## 9. Extended Grammars (EBNF)

Right sides may be regexps: $A \to \eta$ with $\eta$ over $V \cup \Sigma$. Same power as BNF since LIB is closed under union/star/concat, but more readable; directly drawable as **syntax diagrams**.

- Derivation: $\eta_1 = \alpha A \gamma \Rightarrow \alpha \vartheta \gamma = \eta_2$ if $A \to \eta$ and $\vartheta \in L(\eta)$ (no regexp operators left in $\eta_1,\eta_2$).
- Tree nodes may have unbounded arity but lower depth, e.g. $E \to T(+T \mid -T)^*$.
- Ambiguity can come from the regexp itself (e.g. $(ab)^*$ vs $a^*b^*$ overlaps).

## 10. Chomsky Hierarchy

| Type | Rules | Languages | Recognizer |
|---|---|---|---|
| 0 | $\beta \to \alpha$, $\beta \neq \epsilon$ | Recursively enumerable | Turing machine |
| 1 | $\beta \to \alpha$, $\|\beta\| \le \|\alpha\|$ | Context-dependent | Linear-bounded TM |
| 2 | $A \to \alpha$ | Context-free / algebraic | Nondeterministic PDA |
| 3 | $A \to uB$ / $A \to Bu$ | Regular / rational | Finite automaton |

---
Related: [[_Formal Languages and Compilers MOC]]
Sources: [[FLC - series 03 - new.pdf]], [[FLC - series 04 - new.pdf]]
