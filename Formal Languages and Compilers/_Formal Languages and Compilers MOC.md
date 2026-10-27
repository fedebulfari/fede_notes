---
subject: Formal Languages and Compilers
description: Course map for formal languages and compilers — from alphabets, strings and regular languages through context-free grammars to automata and recognition
---

# Formal Languages and Compilers

> [!summary] Overview
> The course has two complementary views of a language: the **generative** one, where rules produce exactly the strings of the language, and the **recognition** one, where a machine reads a string and answers yes or no. It starts from alphabets, strings and language operations, builds regular languages through regexps, generalises to context-free grammars for nested structure, and closes the loop with finite state automata and the conversions between the three formalisms. The "Compilers" half of the course is not yet covered in the vault.

## Reading path

1. [[Basics]] — alphabets, strings, length, concatenation, mirror and power, language operations, Kleene star, prefix-free languages and the main identities.
2. [[Regular Expressions and Languages]] — syntax and precedence, meaning and derivations, derived operators, closure properties of REG, lists and nested lists.
3. [[Finite State Automata]] — recognition, configurations, DFA, state-transition and syntax diagrams, cleaning and minimisation, uni-linear grammars, ε-moves, the BCM method.
4. [[Context-free Grammars]] — the 4-tuple, derivations, reduced forms, recursion, syntax trees, Dyck languages, ambiguity, normal forms, EBNF, Chomsky hierarchy.

## The three views of a regular language

| Formalism | Direction | Key result |
|---|---|---|
| Regular expression | generates | every regexp denotes a regular language |
| Finite state automaton | recognises | DFA/minimisation, ε-NFA |
| Uni-linear grammar | generates | bijective correspondence with automata |

The **BCM method** converts an automaton back into a regular expression, so the three formalisms are interchangeable descriptions of REG.

## Core ideas

- A grammar is a **generator**: derivations produce exactly the strings of the language, and syntax trees record the structure of a derivation.
- Regular languages cannot count or nest — **Dyck languages** are the canonical context-free, non-regular example.
- **Ambiguity** is a property of the grammar, not the language; normal forms let grammars be compared and simplified.
- The **Chomsky hierarchy** places REG strictly inside the context-free family.

## Gaps and next steps

- No notes yet on parsing and compiler construction (LL/LR, FIRST/FOLLOW, semantic analysis, code generation), despite the course title.
- [[Basics]] is deliberately short — the identities at the end are worth re-deriving by hand before the exam.
- Automata notes stop at recognition; no discussion of regular-language closure algorithms or pumping lemma in depth.
