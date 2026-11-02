---
subject: Formal Languages and Compilers
description: Course map for formal languages and compilers — from alphabets, strings and regular languages through context-free grammars, pushdown automata and bottom-up parsing
---

# Formal Languages and Compilers

> [!summary] Overview
> The course has two complementary views of a language: the **generative** one, where rules produce exactly the strings of the language, and the **recognition** one, where a machine reads a string and answers yes or no. It starts from alphabets, strings and language operations, builds regular languages through regexps, generalises to context-free grammars for nested structure, and closes the loop with finite state automata and the conversions between the three formalisms. The recognition side then leaves REG behind: **pushdown automata** accept exactly the context-free languages, and their deterministic subclass $DET$ is what compilers use. The last note turns that machine into practice — the **ELR** construction of a bottom-up syntax analyser from a grammar's machine network.

## 1. Reading Path

1. [[Basics]] — alphabets, strings, length, concatenation, mirror and power, language operations, Kleene star, prefix-free languages and the main identities.
2. [[Regular Expressions and Languages]] — syntax and precedence, meaning and derivations, derived operators, closure properties of REG, lists and nested lists.
3. [[Finite State Automata]] — recognition, configurations, DFA, state-transition and syntax diagrams, cleaning and minimisation, uni-linear grammars, ε-moves, the BCM method.
4. [[Context-free Grammars]] — the 4-tuple, derivations, reduced forms, recursion, syntax trees, Dyck languages, ambiguity, normal forms, EBNF, Chomsky hierarchy.
5. [[Recognition of Free Languages]] — pushdown automata, configurations and acceptance, grammar ↔ automaton, acceptance modes, on-line mode, $CF$ and $DET \subset CF$, syntax analysis, the FSA network of a grammar.
6. [[ELR]] — systematic construction of the bottom-up analyser: pilot graph, items, closure and look-ahead, shift and reduction, determinism conflicts.

## 2. From Generators to Machines

| Formalism | Direction | Class | Key result |
|---|---|---|---|
| Regular expression | generates | REG | every regexp denotes a regular language |
| Finite state automaton | recognises | REG | DFA/minimisation, ε-NFA |
| Uni-linear grammar | generates | REG | bijective correspondence with automata |
| Context-free grammar | generates | CF | derivation trees, ambiguity, normal forms |
| Pushdown automaton | recognises | CF | unbounded stack; nondeterminism required |
| Deterministic PDA | recognises | DET | $DET \subset CF$, the class compilers use |

The **BCM method** converts an automaton back into a regular expression, so the three REG formalisms are interchangeable descriptions of REG. On the CF side the bridge is the grammar ↔ PDA translation: a grammar in extended form is a **network of finite state automata** $M_A$, one per non-terminal, and a transition labelled by $B$ is a call to $M_B$.

## 3. Core Ideas

- A grammar is a **generator**: derivations produce exactly the strings of the language, and syntax trees record the structure of a derivation.
- Regular languages cannot count or nest — **Dyck languages** are the canonical context-free, non-regular example; the pushdown stack is exactly the extra memory that buys nesting.
- **Ambiguity** is a property of the grammar, not the language; normal forms let grammars be compared and simplified.
- The **Chomsky hierarchy** places REG strictly inside the free family, which is in turn the family of languages accepted by unrestricted pushdown automata.
- **Bottom-up parsing** is the rightmost derivation read backwards: the ELR pilot graph is a DFA over $\Sigma \cup V$ whose m-states carry look-ahead items, and its determinism (no shift-reduce, reduce-reduce or convergence conflicts) decides whether the grammar can be parsed deterministically.
- The **ELR** method is the point where the theory becomes a parser: items $\langle q,a\rangle$, closure with look-ahead, shift (terminal reads vs. ε-moves after a reduction) and reductions at final states of the machine network.

## 4. Gaps and next Steps

- No notes yet on top-down parsing (LL, FIRST/FOLLOW, recursive descent) to balance the bottom-up ELR treatment, nor on semantic analysis or code generation.
- The connection between **ELR** and the classical **LR(0)/SLR/LALR** tables is not written down — worth mapping one example onto the other.
- [[Basics]] is deliberately short — the identities at the end are worth re-deriving by hand before the exam.
- Automata notes stop at recognition; no discussion of regular-language closure algorithms or the pumping lemma in depth.
- The course's exercise series live in `PDF/` (series 01–14) but are not yet summarised into notes; [[ELR]] cites series 08–09 and [[Recognition of Free Languages]] series 07.
