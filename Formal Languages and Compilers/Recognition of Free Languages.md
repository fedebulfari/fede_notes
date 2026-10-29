---
date: 28-10-2026
subject: Formal Languages and Compilers
description: Pushdown automata — stack operations and configurations, the formal 7-tuple and nondeterministic transition function with spontaneous moves and acceptance, the translation of a grammar into automaton moves and back, acceptance modes, on-line mode and spontaneous loops, the equivalence with free languages, deterministic automata and DET ⊂ CF, syntax analysis bottom-up and top-down, and the machine network of a grammar in extended form
---

# Recognition of Free Languages

> [!summary] Overview
> Free (context-free) languages are recognised by an abstract machine with an unbounded memory, the **pushdown stack automaton**: the note starts from the stack operations (push, pop, emptiness test, the unremovable bottom symbol $Z_0$ and the terminator ┤) and gives the formal definition as a set of states, input and stack alphabets, initial state and stack symbol, final states, plus a **nondeterministic transition function** whose domain admits spontaneous $\epsilon$-moves. Configurations, computation chains and acceptance by final state come next, followed by the two-way bridge with [[Context-free Grammars]]: each grammar rule becomes an automaton move, and the construction inverts for one-state automata — the reason $CF$ coincides with the languages accepted by unrestricted pushdown automata. A section on **variants** covers acceptance by final state, by empty stack and combined (all equivalent), spontaneous loops, and the always-possible on-line mode. The note closes with **deterministic** automata, where lack of nondeterminism still allows spontaneous moves but yields the strictly smaller class $DET \subset CF$ used by compilers, with **syntax analysis** (parsers, bottom-up rightmost derivations vs top-down leftmost ones, syntax trees and forests for ambiguous strings), and with the view of a grammar in extended form as a **network of finite state automata** whose transitions to non-terminals are calls. It complements the machine-side treatment of [[Finite State Automata]] and the generative view of [[Regular Expressions and Languages]].

## 1. Pushdown Stack Automaton

Pushdown stack automaton memorie is organized as an unbounded stack of symbols.

Operations:
- **push ($B$), push($B_{1,\dots,B_{n}}$)**: place a symbol on top of the stack
- **pop**: remove a symbol from the top of the stack — if empty reads $Z_{0}$
- **stack emptiness test**: yields true if stack is empty and false if otherwise.

“$Z_{0}$” is the stack bottom and it is not removable.
“┤” is the end-of-text (or terminator) character of the input string
A configuration is triple: **current state,** **current char**, **stack contents**

### 1.1. Definition

A pushdown automaton $M$ (in general nondeterministic) is defined by:

| Symbol | Meaning |
| --- | --- |
| $Q$ | a finite set of states of the control unit |
| $\Sigma$ | a finite input alphabet |
| $\Gamma$ | a finite stack alphabet |
| $\delta$ | a transition function |
| $q_0 \in Q$ | the initial state |
| $Z_0 \in \Gamma$ | the initial stack symbol |
| $F \subseteq Q$ | a set of final states (obviously finite) |

### 1.2. Transition Function

$$\delta: Q \times (\Sigma \cup \{\epsilon\}) \times \Gamma \;\to\; \wp\left(Q \times \Gamma^*\right)$$
- **Domain**: $Q \times (\Sigma \cup \{\epsilon\}) \times \Gamma$ — $\{\epsilon\}$: set of the spontaneous moves.
- **Image**: subset of $Q \times \Gamma^*$ ($\wp(Q \times \Gamma^*)$)

### 1.3. Reading Move

Starting from state $q$ with $Z_{0}$ on the stack top, the automaton reads char a and enters one of the states $p_i$ with $1 ≤ i ≤ n$, after orderly executing the operations **pop** and **push($γ_i$)**
$$
\delta(q,a,Z)=\{(p_{1},γ_{1}),\dots,(p_{n},γ_{n})\}
$$

### 1.4. Spontaneous Move

Starting from state $q$ with $Z_{0}$ on the stack top, the automaton does not read any input character and enters one of the states $p_i$ with $1 ≤ i ≤ n$, after orderly executing the operations **pop** and **push($γ_i$)**
$$
\delta(q,\epsilon,Z)=\{(p_{1},γ_{1}),\dots,(p_{n},γ_{n})\}
$$

> [!info] Indeterminism
> Choosing the i-th action out of the n possible ones is not deterministic; shifting the input head is automatic; the stack top symbol is always popped; and the pushed string may be empty

### 1.5. Non-Determinism

For a triple (state, input, stack top) there are two or more possible moves that consume none or one input character.

### 1.6. Configuration

A configuration is a triple
$$
(q,y,\eta)\in Q\times\Sigma^*\timesΓ^*
$$
that describes:
- $q$ the current state of the control unit 
- $y$ the part of the input string $x$ that still has to be scanned 
- $\eta$ the current contents (a string) of the pushdown stack

**Initial configuration**: $(q_{0},x,Z_{0})$

**Final configuration**: $(q,\epsilon,\lambda)$

> [!info] Multiple transitions
> A chain of multiple transitions is denoted by: $\to^{+}$

> [!note]
> Every move cancels the stack top symbol; if we wish to keep it on stack, it can be immediately placed again onto the stack top by the move itself

### 1.7. Acceptance

An input string x is accepted by final state if there is the following computation:
$$
(q_{0},x,Z_{0})\to^*(q.\epsilon,\lambda)
$$

> [!Example] Es.
> ![[Recognition of Free Languages-1793204084227.webp|449x290]]

## 2. Grammar → Pushdown Automaton

1. Grammar rules can be viewed as the instructions of a non-deterministic pushdown automaton 
2. The stack symbols can be both terminals and non-terminals of the grammar. If the stack contains the symbol sequence $A_1 … A_k$, then the automaton executes first the action associated with $A_k$, which should recognize if in the input string from the position of the current character $a_i$ there is a string $w$ that can be derived from $A_k$; if it is so, then the action shifts the input head of $| w |$ positions
3. An action can be recursively divided into a series of sub-actions, if to recognize the non-terminal symbol A k it is necessary to recognise other (non-)terminals

### 2.1. From Grammar Rules to Automaton Moves

Given a grammar $G = (V, \Sigma, P, S)$, with $A, B \in V$, $b \in \Sigma$ and $A_i \in V \cup \Sigma$:

| Grammar rule | Automaton move | Comment |
| --- | --- | --- |
| $A \to B\,A_1 \dots A_n$<br>with $n \ge 0$ | if $top = A$ then pop; push ($A_n \dots A_1 B$) | to recognize $A$ first recognize $B\,A_1 \dots A_n$ |
| $A \to b\,A_1 \dots A_n$<br>with $n \ge 0$ | if $cc = b$ and $top = A$ then pop; push ($A_n \dots A_1$); shift reading head | character $b$ was expected as next one and has been read, so it remains to recognize $A_1 \dots A_n$ |
| $A \to \varepsilon$ | if $top = A$ then pop | the empty string deriving from $A$ has been recognized |
| for every character $b \in \Sigma$ | if $cc = b$ and $top = b$ then pop; shift reading head | character $b$ was expected as next one and has been read |
| — — — | if $cc = ┤$ and the stack is empty then accept; halt | the string has been entirely scanned and the agenda contains no goals |

The initial action is the grammar axiom

### 2.2. Grammar ← Pushdown Automaton

The construction from grammar to automaton can be inverted and used to obtain the grammar by starting from the pushdown automaton, if this is one-state.

> [!tips] Propertie
> The family of free languages generated by free grammars coincides with the family of the languages recognized by one-state pushdown automata 

> [!Warning] Note
> the construction does not work for multi-state pushdown automata; however the property holds in general, for the automata with any number of states.

## 3. Various Pushdown Automaton

The pusdown automaton defined in the previous example differs from that directly obtainable from the grammar for two reasons: it has two or more states and uses a different acceptance condition.

Possible **acceptance modes**:
1. by final state: accepts when enters a final state independently of the stack contents 
2. by empty stack: accepts when the stack gets empty independently of the current state 
3. combined: by final state and empty stack

> [!info] Property
> For the family of (non-deterministic) pushdown automata with states, the three acceptance modes listed above are equivalent

### 3.1. Operation without Spontaneous Loops and On-lineù

Iff the pushdown automaton enter a loop made by only spontaneous moves, it may execute indefinitely.

This prevent the reading of the rest of the input.

If so is the case, is therefore needed to build an equivalent automaton with no spontaneous moves(**always possible**), idealy in one that works in an **on-line mode**(**also always possible**).

> [!info] On-Line mode
> A pushdown automaton is such if it decides whether to accept or reject the string as soon as it reads the last character of the input, and then it does not execute any other move.

## 4. Pushdown Automaton and Free Languages

The language accepted by a generic pushdown automaton is free. Since every free language can be recognized by a non-deterministic one-state pushdown automaton, it follows

> [!info] Properties
> -  The family $CF$ of (context-)free languages coincides with that of the languages recognized by unrestricted pushdown automaton
> -  the family $CF$ of (context-)free languages coincides with that of the languages recognized by the one-state non-deterministic pushdown automata

## 5. Pushdown Automaton and Deterministic Languages

They are the most used in the compilers thanks to their efficiency

If the transition function does not exhibit any form of non-determinism, then the automaton is deterministic and the recognized language is deterministic, too

> [!info] Non-determinism Absence
>
> Non-determinism is absent if $\delta$ is one-valued and:
> - if $δ (q, a, A)$ is defined then $δ (q, ε, A)$ is undefined
> - if $δ (q, ε, A)$ is defined then $δ (q, a, A)$ is undefined for every $a ∈ Σ$

> [!Warning] Note
> A deterministic pushdown automaton may have spontaneous moves

> [!tips] $DET\subset CF$
> The family DET of the deterministic free languages is strictly contained in the family CF of all the free language

## 6. Syntax Analysis

Given a grammar $G$, the syntax analyser (parser):

```
reads a source string 
if the string belongs to the language L(G), then 
	exhibits a derivation 
	or builds a syntax tree of the string
else stops and notifies the error, possibly with a diagnostic 
```

If the source string is ambiguous, then the result is a forest of trees or a set of derivations

### 6.1. Bottom-Up and Top-Down Analysis

A syntax tree corresponds to different derivation orders: rightmost, leftmost,…

There are two analyser classes depending on whether the derivation is rightmost or leftmost, and on the reconstruction order of the derivation:
**Bottom-Up**: Rightmost derivation in inverse order; Tree from leaves to root through reductions
***Top-Down Analysis** Leftmost derivation in direct order; Tree from root to leaves through expansion

> [!Example] Es.
>
> | ![[Recognition of Free Languages-1793209106798.webp\|371x254]] | ![[Recognition of Free Languages-1793209122545.webp\|379x255]] |
> | -------------------------------------------------------------- | -------------------------------------------------------------- |

> [!Example] Top-down Analysis by means of Reduction Procedure
> ![[Recognition of Free Languages-1793274301848.webp|415x261]]

## 7. Grammar as a Network of FSA

Supposing $G$ grammar in extended form, each non-terminal has one rule $A\to\alpha$ (_$\alpha$: regexp_).
Since $\alpha$ defines a regular language => there is an FSA $M_{A}$ recognising $\alpha$

A transition of $M_{A}$ labeled with a non-terminal B is interpreted as a call to the automaton $M_B$

> [!info] **Terminology**
>
> | Notation | Meaning |
> | --- | --- |
> | $\Sigma$ | terminal alphabet |
> | $V = \{S, A, B, \dots\}$ | nonterminal alphabet |
> | $S \to \sigma$, $A \to \alpha$, $B \to \beta$, … | grammar rules |
> | $R_S$, $R_A$, $R_B$, … | regular languages over $\Sigma \cup V$ defined by $\sigma$, $\alpha$, $\beta$, … |
> | $M_S$, $M_A$, $M_B$, … | deterministic finite machines recognizing $R_S$, $R_A$, $R_B$, … |
> | $\mathcal{M} = \{M_S, M_A, M_B, \dots\}$ | machine network |
> |$M_{A},\ Q_{A},\ 0_{A}, \ F_{A}$|machine $A$, state set, initial state, final state set|
> |$R(M_{A},q)=R_{A}$|regular language $\subseteq(\Sigma\cup V)^*$ accepted by $M_{A}$

> [!Note] Normalized/Non-reentering Automaton
> Automaton $M_{A}$ that do not re-enter the initial state $0_{A}$

---
Related: [[_Formal Languages and Compilers MOC]]
Source: [[FLC - series 07 - new.pdf]]