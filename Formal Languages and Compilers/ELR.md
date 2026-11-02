---
date: 29-10-2026
subject: Formal Languages and Compilers
description:
---

# ELR — Bottom-up Syntax Analysis

## 1. Systematic Construction of the Bottom-up Syntax Analyser (PDA)

1. construction of the pilot graph 
	- the pilot drives (pilots) the PDA 
	- in each macro-state (m-state) the pilot incorporates all the information about any possible phrase form that reaches the m-state 
		- each m-state contains machine states with look-ahead (prospection) 
			- look-ahead: which chars we expect to see in the input at reduction time; it corresponds to the followers follow (A) we have seen before 
2. the m-states are used to build a few analysis threads in the stack, which correspond to possible derivations 
	- ≡ computations of the machine network
	- ≡ paths with ε-arcs at each machine change, labeled with the scanned string 
3. verification of determinism conditions on the pilot graph: three problems 
	- shift-reduce conflict 
	- reduce-reduce conflict 
	- (less frequently) two or more paths that merge into one state with non-disjoint look-ahead: convergence conflict 
4. if the determinism test is passed, the PDA can analyse the string deterministically 
5. the PDA uses the information stored in the pilot graph and in the stack

## 2. Definitions

- **Set of initials**: Set of chars found starting from state $q_{A}$ of machine $M_{A}$ of the net $M$
	$$Ini(q_A) = Ini(L(q_A)) = \{a \in \Sigma \mid a\Sigma^* \cap L(q_A) \neq \emptyset\}$$
	Where $a \in Ini(q_A)$ if any of the following holds:
	1. there is an arc $q_A \xrightarrow{a} r_A$
	2. there is an arc $q_A \xrightarrow{B} r_A$ **and** $a \in Ini(0_B)$ — where $0_B$ is the initial state of machine $M_B$
	3. there is an arc $q_A \xrightarrow{B} r_A$ **and** $L(0_B)$ is nullable **and** $a \in Ini(r_A)$

- **Item**: $$〈q, a〉 \in Q \times (\Sigma\cup{\dashv})$$
	An item with a machine final state is called **reduction item**

- **Closure**: Function that compute a kind of closure of a set $C$ of items with look-ahead
	$$
   〈0_{B}, b〉\in closure(C) \text{ if } \begin{cases}
   \exists \text{ candidate }  〈q, a〉\in C \quad \ \text{ and} \\
   \exists \text{ arc } q\to^B \in \mathcal{M} \qquad \qquad \text{and}\\ 
   b\in Ini(L(r)\cdot a)
   \end{cases}
   $$

- **Shift Operation**: A shift corresponds to a transition in a machine Y
	- if $X = c$ is a terminal symbol, then shift is a PDA move that reads a char $c$ in the input 
	- if $X$ is a non-terminal symbol, then shift is a PDA ε-move after a reduction $z → X$ and it does not read any input 
	- machine $Y$ runs a transition with non-terminal label $X$ 
	- the analysis goes on after recognizing an input substring $z ∈ L (X)$ derivable from the non-terminal $X$

## 3. Pilot Graph Build Process

The pilot is a DFA, named $\mathcal{P}$, defined by the following entities:

- the set $R$ of m-states
- the **pilot alphabet** is the union $\Sigma \cup V$ of the terminal and nonterminal alphabets, to be also named the **grammar symbols**
- the initial m-state, $I_0$, is the set:
	$$I_0 = closure(\langle 0_S, \dashv \rangle)$$
- the m-state set $R = \{I_0, I_1, \dots\}$ and the state-transition function
	$$\vartheta : R \times (\Sigma \cup V) \to R$$
	are computed starting from $I_0$

> [!info] m-state
> A **macro-state** (shortly m-state) is defined as a set of items

### 3.1. Terminology

- **Incremental construction:** it ends when nothing changes any longer
- **No final m-state**: the pilot does not recognize strings, it controls the PDA 
- The items in each m-state $I$ of the pilot are parted into two groups 
	- **base**, contains the items obtained after a shift ⇒ non-initial states 
	- **closure**, contains the items obtained after a closure ⇒ initial states 
- Call **kernel** of a m-state $I$ the set of the m-states of $I$ without look-ahead

### 3.2. Computation Algorithm

```text
R' := { I₀ }                      -- prepare the initial m-state I₀
-- loop that updates the m-state set and the state-transition function
do
    R := R'                       -- update the m-state set R
    -- loop that computes possibly new m-states and arcs
    for ( each m-state I ∈ R and symbol X ∈ Σ ∪ V ) do
        -- compute the base of a m-state and its closure
        I' := closure( ϑ(I, X) )
        -- check if the m-state is not empty and add the arc
        if ( I' ≠ ∅ ) then
            add arc I --X--> I' to the graph of ϑ
            -- check if the m-state is a new one and add it
            if ( I' ∉ R ) then
                add m-state I' to the set R'
            end if
        end if
    end for
while ( R ≠ R' )                   -- repeat if the graph has grown
```

Notes:
- $\vartheta(I, X)$ gives the base of the new m-state (the move of the pilot DFA on symbol $X$), and $closure(\cdot)$ expands it with the look-ahead items
- empty m-states are discarded, so no arc is added for them
- the fixed-point loop stops when a pass adds no new m-state ($R = R'$)

> [!Example] Es.
>
> |![[ELR-1793290659911.webp\|493x325]]|![[ELR-1793290680656.webp\|469x323]]|
> |---------------------------|---------------------------|

---
Related: [[_Formal Languages and Compilers MOC]]
Source: [[FLC - series 08 - new.pdf]], [[FLC - series 09 - new.pdf]]
