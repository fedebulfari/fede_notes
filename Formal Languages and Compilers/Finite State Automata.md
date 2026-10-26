---
date: 23-10-2026
subject: Formal Languages and Compilers
description:
---

# Finite State Automata

## 1. Recognition Algorithms

**Domain**: a set of sting over the alphabet $\Sigma$.
**Image**: the answer (yes/no).

Appling a recognition algorithms $\alpha$ to string $x$ ($\alpha(x)$), string $x$ is recognized or not by $\alpha$ if:
$$\alpha(x)=yes \ \land  \alpha(x)=no$$
The language $L(\alpha)$ is defined as:
$$L(\alpha)=\{x|\ x\in\Sigma^*\land\alpha(x)=yes\}$$
If $L$ is semidecidable, it may happen that for some incorrect string $x$ the algorithm $\alpha$ will not terminate

Almost all problems have solution with linear or polynomial time complexity.

> [!info] 
> In Formal languages one computation step is a single atomic operation of the abstract recognition machine(Automaton).

## 2. The Automaton

The Automaton analyse the input string and execute a series of moves. Each move depend on the symbol pointed by the head and by the state.

All possible moves:
1. Shift head position of one to left or right
2. Replacing the current memory symbol then shifting the memory head by one on left or right
3. Changing the current state

Variation of the general Automaton can make unavailable some of the above moves:
- One-way Automaton: the input head can be shifted only to the right.
- Finite State Automaton: has no auxiliary Memory. Well recognize **regular languages**
- Pushdown Stack: has auxiliary memory. Well recognized **free languages**

### 2.1. Configuration

A Configuration is the set of three components that determine the behaviour of the automaton:
- The not yet read part of the input
- The contents an position of memory tape and head
- The current state of control unit

**Initial Configuration**: the input head is positioned on the symbol right after the start-marker.

If the possible new movement is only one than the Automaton is Deterministic, otherwise is not.

**Final Configuration**: the input head is positioned on the end-mark.(Can be also characterized by a condition of the memory tape).

### 2.2. Acceptance

A sting $x$ is **accepted** if:
- Starts from the initial configuration $├ \ x\  ┤$
- Executes a series of transitions
- Reach a Final configuration

If the automaton cannot execute more step ‘cause there aren't new possible moves then the string is **rejected**.

> [!info] Recognised Language 
> Set off all the accepted strings.
>
> Two Automaton that accept the same language are said to be **equivalent**.
>
> > [!warning] 
> > Having an equivalent Recognised Language does not mean that two Automatons are modelled equivalently.

## 3. Finite State Automaton

Automaton composed by:
- Input tape containing the input string $x\in\Sigma^*$
- Control unit and Finite memory containing the state table
- Input head movable only to the right

The state is updated after reading an input character.

The set of languages recognised by the FSA is named **Family** or **Finite State Languages**:
$$L(M)=\{x\in\Sigma|x\text{ is recognised by} M\}$$

> [!info] Equivalence
> Two finite automata are equivalent if they recognize the same language.

### 3.1. State Transition Graph

Directed graph that represent the automaton using **Arcs** and **Nodes**.

![[Finite State Automata-1792948061195.webp|554]]
_NOTE: in the drawing, a few topologically identical arcs are grouped into one (in fact from q0 to q1 nine arcs should be drawn)_.

> [!important] Syntax Diagrams
> Dual of the state transition graph, used to represent the EBNF rules.
> transform nodes into vertices and vertices into nodes.
> ![[Finite State Automata-1792948318460.webp|538x169]]

### 3.2. Deterministic FSA

A Deterministic FSA consists of five elements:
- $Q$ the set of states (finite and not empty) 
- $Σ$ the input alphabet (or terminal alphabet) 
- $δ: (Q × Σ) → Q$ the transition function; encodes the automaton moves:$\delta(q_{i},a)=q_{j}\ ,\ a\in\Sigma \land \{q_{i},q_{j}\}\in Q$
- $q_0 ∈ Q$ the initial state 
- $F ⊆ Q$ the set of final states (it may be empty)

A string $x$ is accepted if, starting from the initial state, the automaton moves through a path labeled by $x$ and ends at one of the final states:
$$\delta(q_{0},a)\in F$$

> [!info] Empty string
> The empty string is accepted if, and only if, the initial state is final as well

### 3.3. Optimization

The time complexity of FSA is already optimal since the input string is elaborated in a number of moves equal to the sting length.

To complete the deterministic automaton is possible to add an error state.

Is possible then to clean the automaton from useless parts by following these instructions:
- A state $q$ is said to be **Accessible/Reachable** from the state $p$ if there is a computation that moves the automaton from state $p$ to state $q$ 
- A state $q$ is said to be **Accessible/Reachable** if it can be reached from the initial state 
- A state $q$ said to be **Postaccessible/Defined** if some final state can be reached from state $q$
- A state $q$ is said to be **Useful** if it is both accessible and postaccessible, i.e., if it is placed on a path that connects the initial state to a final state 
- An automaton $A$ is said to be in **Clean/Reduced form** if every state of $A$ is useful, i.e., both accessible and postaccessible

> [!tip] Cleaning
> Every finite state automaton has an equivalent clean form. 
> To reduce an automaton: 
> 1. First identify all the useless states
> 2. Then strip them off the automaton along with all their incoming and outgoing arcs

#### 3.3.1. Minimal Automaton

For every finite state language, there exists one, and only one, deterministic finite state recognizer that has the smallest possible number of states, which is called the minimal automaton.

The minimal automaton is unique(iff deterministic)

**Reduction of the Number of States**:
	Given an automaton $M$ and it’s minimal form $M'$, the transition function of $M'$ is defined by stating that:
		There is an arc from class $C_1 = […, p_r, …]$ to class $C_2 = […, q_s, …]$ iff in $M$ there is an arc from state $p_r$ to state $q_s$ 

> [!warning]
> The same arc of M’ may originate from two or more arcs of M

>[!tip] Euivalence
>The uniqueness of the minimal automaton offers a way to check whether two deterministic finite state automata are equivalent.
#### 3.3.2. Undistinguishable and Distinguishable

**Undistinguishable**: A state $p$ is undistinguishable from a state $q$ iff, for every input string $x$ either both the next states $δ (p ,x)$ and $δ (q, x)$ are final, or neither one is; equivalently, if one starts from $p$ and $q$, scans the string $x$, but does not reach a final state in either case

**Distinguishable**: $p$ is distinguishable from $q$ iff:
- $p$ is final and $q$ is not (or vice-versa) 
- $δ (p, a)$ is distinguishable from $δ (q, a)$



---
Related: [[_Formal Languages and Compilers MOC]]
Source: [[FLC - series 05 - new.pdf]]