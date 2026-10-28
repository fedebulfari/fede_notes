---
date: 23-10-2026
subject: Formal Languages and Compilers
description: Finite state automata — recognition algorithms and configurations, deterministic automata, state transition and syntax diagrams, cleaning and minimisation, uni-linear grammars, non-determinism with epsilon-moves, and the BCM method back to regexps
---

# Finite State Automata

> [!summary] Overview
> Recognition is framed as an abstract machine reading an input tape, and the note then specialises it to the **finite state automaton**: definitions, configurations, acceptance, state transition graphs and their dual syntax diagrams. It covers deterministic automata, cleaning and **minimisation** through undistinguishable states, the bijective correspondence with uni-linear grammars, and non-determinism with spontaneous $\epsilon$-moves. It ends with the **BCM method** for turning an automaton back into a regular expression, completing the round trip with [[Regular Expressions and Languages]] and complementing the generative view of [[Context-free Grammars]].

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

> [!tip] Euivalence
> The uniqueness of the minimal automaton offers a way to check whether two deterministic finite state automata are equivalent.

#### 3.3.2. Undistinguishable and Distinguishable

**Undistinguishable**: A state $p$ is undistinguishable from a state $q$ iff, for every input string $x$ either both the next states $δ (p ,x)$ and $δ (q, x)$ are final, or neither one is; equivalently, if one starts from $p$ and $q$, scans the string $x$, but does not reach a final state in either case

**Distinguishable**: $p$ is distinguishable from $q$ iff:
- $p$ is final and $q$ is not (or vice-versa) 
- $δ (p, a)$ is distinguishable from $δ (q, a)$

## 4. Uni-Linear Grammar

Procedure to construct a finite automaton corresponding to a right-linear grammar:
1. Modify the definition of finite automaton in order to include the notion of indeterminism
2. Make the correspondences:
	- **automaton states → non-terminal symbols**
	- **initial state → axiom**

There is a one-to-one (or bijective) correspondence between the computations of the automaton and the derivations of the right-linear grammar 

![[Finite State Automata-1793030966965.webp|470]]

> [!tip] Important
> A language is generated by a uni-linear grammar iff it is recognised by a FSA

## 5. Non-Deterministic Automata

A right-linear grammar may contain alternative rules, i.e., rules from the same state and with the same label, which cause a non-deterministic behaviour

We need a non-deterministic automaton if:
- The **correspondence between grammars and automata** suggests to have 
	- moves with two or more destination states 
	- spontaneous moves (or ε-moves) 
	- two or more initial states, i.e., the grammar has two or more axioms
- **Concision**: defining a language by means of a non-deterministic automaton may be more readable and compact than using a deterministic one
- **Left-to-right duality**: when passing from the deterministic recognizer of a language $L$ to that of the mirror language $L^R$, where all the strings are reversed, indeterminism may originate from the pairs of converging moves with the same label, or by swapping the initial and final states, thus having two or more initial states
- Passing through a non-deterministic automaton **may be convenient** to construct the deterministic automaton equivalent to a regular expression

> [!info] Definition
> A non-deterministic finite state automaton $N$ without spontaneous moves has: 
> 1. a finite set of states $Q$ 
> 2. a finite input (or terminal) alphabet $Σ$
> 3. two subsets of $Q$, namely 
> 	- the set $I$ of initial states
> 	- the set $F$ of final states 
> 1. a set $δ$ of transitions, which is a subset of the set product $Q × Σ × Q$

The moves of the non-deterministic automaton can be defined by means of a many-valued transition function

### 5.1. Spontaneous Transitions

Spontaneous moves ($\epsilon$-moves) are moves executed without reading any input symbol

These are represented by arc labeled with an $\epsilon$ ($\epsilon$-arcs), and they are helpful to make modular FSA constructions

### 5.2. Initial State Uniqueness

A non-deterministic automaton may have more than one initial state. This is fixed creating a new initial state $q_{0}$ and connecting it via $\epsilon$-arcs to the already existing initial states, therefore constructing an equivalent ned automaton with only one initial stage.

## 6. FSA → Regexp — Brzozowski and McCluskey(BCM) Method

We can go from the automaton to the regexp directly:
1. Assume the initial and final states ($i$ and $t$) are unique and, respectively, not have incoming and outcoming arcs.
2. After constructing the **Generalised finite automaton**, eliminate the **internal nodes** one by one, adding for each a **compensation arc** labeled by regexp.
3. At the end only $i$ and $t$ will be left with one single arc connecting them.

The regexp that labels such an arc generates the complete language recognized by the original finite automaton.

> [!info] Generalised finite automaton
> FSA whose arcs can be labeled by regexps and not only individual terminal characters

> [!info] Internal nodes
> all the other states different from $i$ and $t$

> [!tip] Important
> The elimination order is not relevant. However different orders may generate different regexps, all equivalent to one another but of different complexity

### 6.1. Elimination of Indeterminism

Every non-deterministic FSA can be transformed in a deterministic one.

For this purpose we need to:
1. Eliminate the spontaneous moves(same algorithm as for removing copy rules)
2. Replace the non-deterministic multiple transitions with a subset construction.

## 7. Regexp → FSA

There are two main algorithms:
- **Thompson**:
	1. Decompose the regexp into subexpression until it reaches the atomic constituent(terminal symbol).
	2. Connects them and builds up a network of recognizers that implement the union, concatenation and star operator

- **Berry-Sethi(BS) Method**: Constructs a det. recognizer without spontaneous moves, but of size often larger than Thompson

### 7.1. Thompson

- Recognizers of atomic regexps
	![[Finite State Automata-1793111716526.webp|441]]
- Concatenation of two regexps
	![[Finite State Automata-1793111726584.webp|444]]
- Union of two regexps
	![[Finite State Automata-1793111741362.webp|309]]
- Star closure of a regexp 
	![[Finite State Automata-1793111914085.webp|538]]
	_in case of closed closure we have to omit the upper arc_

In general the outcome of the Thomson method is a non-deterministic automaton with spontaneous moves.

> [!info] Via optimization is possible to avoid adding redundant states.

#### 7.1.1. Local Sets of a Language

It constructs the automaton equivalent to a given regexp.

> [!Definition]
> Given a language $L$ over alphabet $\Sigma$:
> - Start set $Ini(L)=\{a\in\Sigma|\quad a\Sigma^*\cap L\neq \emptyset\}$
> - End set $Fin(L)=\{a\in\Sigma|\quad\Sigma^*a\cap L\neq \emptyset\}$
> - Adjacency set $Dig(L)=\{x\in\Sigma^2|\quad\Sigma^*x\Sigma^*\cap L\neq \emptyset\}$
> - Complement set $\overline{Dig(L)}=\Sigma^2 \setminus Dig(L)$

##### Computing Local Set of Languages

First we compute $Null$ predicate, than $Ini$ and $Fin$ sets, finally $Dig$ set.

- **Null Predicate:** _Recursive rules that compute the predicate $Null$ of a regexp._

$$\begin{aligned}
\mathit{Null}(\emptyset) &= \textbf{false}\\
\mathit{Null}(\varepsilon) &= \textbf{true}\\
\mathit{Null}(a) &= \textbf{false} && \text{for every character } a\\
\mathit{Null}(e \cup e') &= \mathit{Null}(e) \lor \mathit{Null}(e')\\
\mathit{Null}(e \cdot e') &= \mathit{Null}(e) \land \mathit{Null}(e')\\
\mathit{Null}(e^{*}) &= \textbf{true}\\
\mathit{Null}(e^{+}) &= \mathit{Null}(e)
\end{aligned}$$

- **Set of Initials**: _Recursive rules that compute the set $Ini$ of a regexp._

$$\begin{aligned}
\mathit{Ini}(\emptyset) &= \emptyset\\
\mathit{Ini}(\varepsilon) &= \emptyset\\
\mathit{Ini}(a) &= \{a\} && \text{for every character } a\\
\mathit{Ini}(e \cup e') &= \mathit{Ini}(e) \cup \mathit{Ini}(e')\\
\mathit{Ini}(e \cdot e') &= \textbf{if}\ \mathit{Null}(e)\ \textbf{then}\ \mathit{Ini}(e) \cup \mathit{Ini}(e')\ \textbf{else}\ \mathit{Ini}(e)\ \textbf{end if}\\
\mathit{Ini}(e^{*}) &= \mathit{Ini}(e^{+}) = \mathit{Ini}(e)
\end{aligned}$$

- **Set of Finals**: _Recursive rules that compute the set $Fin$ of a regexp._

$$\begin{aligned}
\mathit{Fin}(\emptyset) &= \emptyset\\
\mathit{Fin}(\varepsilon) &= \emptyset\\
\mathit{Fin}(a) &= \{a\} && \text{for every character } a\\
\mathit{Fin}(e \cup e') &= \mathit{Fin}(e) \cup \mathit{Fin}(e')\\
\mathit{Fin}(e \cdot e') &= \textbf{if}\ \mathit{Null}(e')\ \textbf{then}\ \mathit{Fin}(e) \cup \mathit{Fin}(e')\ \textbf{else}\ \mathit{Fin}(e')\ \textbf{end if}\\
\mathit{Fin}(e^{*}) &= \mathit{Fin}(e^{+}) = \mathit{Fin}(e)
\end{aligned}$$

- **Set of Adjacency**: _Recursive rules that compute the set $Dig$ of a regexp._

$$\begin{aligned}
\mathit{Dig}(\emptyset) &= \emptyset\\
\mathit{Dig}(\varepsilon) &= \emptyset\\
\mathit{Dig}(a) &= \emptyset && \text{for every character } a\\
\mathit{Dig}(e \cup e') &= \mathit{Dig}(e) \cup \mathit{Dig}(e')\\
\mathit{Dig}(e \cdot e') &= \mathit{Dig}(e) \cup \mathit{Dig}(e') \cup \mathit{Fin}(e) \cdot \mathit{Ini}(e')\\
\mathit{Dig}(e^{*}) &= \mathit{Dig}(e^{+}) = \mathit{Dig}(e) \cup \mathit{Fin}(e) \cdot \mathit{Ini}(e)
\end{aligned}$$


> [!info] Generation of empty string of a regexp
$$\text{if} \ Null(e)=true \ \text{then} \ \epsilon \in L(e)\\ \text{if } Null(e)=false \text{ then } \epsilon \notin L(e)$$

### 7.2. Construction of Deterministic Recognizer (BS Algorithm)

To go from a generic regexp to an FSA is needed to enumerate the generators by applying an index on them:$$e = (a b)^* a \quad \text{becomes} \quad e_{\#} = (a_1 b_2 )^* a_3$$

	$e_\#$: numbered version of e over $\Sigma_\#$ with predicate $Null$ and local sets $Ini$, $Fin$ and $Dig$

Considering now $e_\#$ we can define $Fol(c_{\#})$ as the set of the followers of $c_{\#}\in\Sigma_{\#}$:

$$Fol(c_{\#}) \in \wp\left(\Sigma_{\#} \cup \{\dashv\}\right) \qquad \text{and} \qquad Fol(\dashv) = \Phi \\ Fol(a_i) = \{\, b_j \mid a_i b_j \in \mathit{Dig}(e_{\#} \dashv) \,\} \qquad a_i \text{ and } b_j \text{ may coincide}$$
	in practice the set Fol is a different way to express the digram set Dig, and it is usually presented in the form of a table

Each state is denotated by a subset of $\Sigma_{\#}R┤$. The algorithm examines the states, and constructs their destination states and outgoing moves, by the subset construction

Set $Ini (e_\# ┤)$ is the initial state, final states contain ┤, and the state set $Q$ starts with the initial state

**Algorithm**:

1. $q_0 := \mathit{Ini}(e_{\#}\dashv)$![[Finite State Automata-1793124015188.webp|186x83]]
2. $Q := \{q_0\}$
3. $\delta := \emptyset$
4. **while** $(\exists q \in Q$ s.t. $q$ is unmarked$)$ **do**
	1. mark state $q$ as visited
	2. **for** (each character $c \in \Sigma$) **do**![[Finite State Automata-1793124181539.webp]]
		1. $q' := \bigcup_{\forall c_{\#} \in \Sigma_{\#}\ \text{s.t.}\ c_{\#} \in q} Fol(c_{\#})$
		2. **if** $(q' \neq \emptyset)$ **then**
			- **if** $(q' \notin Q)$ **then**
				- set $q'$ as a new unmarked state
				- $Q := Q \cup \{q'\}$
			- **end if**
			- $\delta := \delta \cup \{q \xrightarrow{c} q'\}$
		3. **end if**![[Finite State Automata-1793124221665.webp|425x68]]
	3. **end for**
	4. **end while** $\square$


>[!example] Es.
>![[Finite State Automata-1793123892896.webp|493x329]]

## 8. Expansion of Regexp

Regexps may also contain the operators of complement, intersection and set difference, which are very useful to make the regexp more concise

The family $REG$ is  closed under complement and intersection$$\text{if } L’, L’’ ∈ REG \text{ then } ¬ L’ ∈ REG \text{ and } L’ ∩ L’’ ∈ REG$$
Assume the recognizer M of L is deterministic, with initial state q0, state set Q, set of final states F and transition function δ


---
Related: [[_Formal Languages and Compilers MOC]]
Source: [[FLC - series 05 - new.pdf]]