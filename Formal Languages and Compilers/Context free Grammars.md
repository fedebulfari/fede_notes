# Context free Grammars

* A Generative Grammar is constituted by rules that allow to generate all and only the phrases of the chosen Language

* Derivation chain

* A Context free grammar is defined by means of four entities:

  * non-terminal alphabet, is a set of non-terminal symbols (or syntactic classes)
  * terminal alphabet, is the set of the characters that constitute the phrases
  * is a set of syntactic rules (also called production rules or simply rules)
  * a particular non-terminal, called axiom
* each rule of P is an ordered pair

* In order to avoid confusion, the metasymbols must not appear among the terminal and non-terminal symbols; moreover, the terminal and non-terminal alphabets must not share elements (must be disjoint sets)


## Conventions
* 1 CONVENTION: `<phrase> ::= if <cond> then <phrase> else <phrase>`

* 2 CONVENTION: `phrase -> if cond then phrase else phrase`

* CONVENTIONS USED IN THE FOLLOWING:

  * terminal symbols (for characters or letters)
  * non-terminal symbols (A, B)
  * strings over $\Sigma$ that contain only terminal characters
  * strings over $V \cup \Sigma$ that contain terminal and non-terminal elements $\alpha, \beta$
  * strings over $V$ that contain only non-terminal symbols

## Forms and Generated Languages
* **TERMINAL:** the right part contains terminals or empty string

* **EMPTY:** the right part is the empty string

* **INITIAL:** the left part is the axiom

* **RECURSIVE:** the left part appears in the right part

* **LEFT RECURSIVE:** the left part is prefix of the right part

* **RIGHT RECURSIVE:** the left part is suffix of the right part

* **TWO-SIDED RECURSIVE:** superposition of previous cases

* **COPY (or RENAMING):** simply a change of name

* **LINEAR:** the right part contains at most one nonterminal

* **RIGHT LINEAR:** like linear, but the nonterminal is suffix

* **LEFT LINEAR:** like linear, but the nonterminal is prefix

* **CHOMSKY NORMAL:** either one term or two nonterm.s

* **GREIBACH NORMAL:** always a prefix term, max length 2

* **OPERATOR NORMAL:** always an infix terminal


## Reduced Form
* A grammar is in reduced form if:

  * All nonterminals are reachable from axiom
  * All nonterminals generate a set of strings
* Two phases Algorithm:

  * Construct the set of defined non-terminals
  * Unreachable terminal symbols can be removed from the grammar

## Restriction
* It's possible to restrict the right member of a rule, it is allowed to the axiom and the node $S \rightarrow \epsilon$

* Symbol Nullable: A non-terminal is nullable if it derives to empty string ($\epsilon$)

* Every rule symbol and the axiom itself is nullable if the Language contains $\epsilon$


## A Grammar
* Grammar is a finite set of rules that produce infinitely many strings

* In order to produce infinitely many strings the rules have to allow of unbounded length

* A NECESSARY AND SUFFICIENT CONDITION for a language L(G) to be infinite, where G is a grammar in the reduced form and does not have any circular derivations, is that G admits recursive derivations

* PROOF OF NECESSITY: if there were not any recursive derivation, then every derivation would be of bounded length, hence L(G) would be finite (would contain finitely many strings)

* PROOF OF SUFFICIENCY: If there were such a derivation... since G is in the reduced form, it follows that A is reachable from S, hence from A at least one terminal string w can be derived, whence there exist infinitely many derivations that yield different strings


## Syntax Tree
* Directed acyclic graph such that for every pair of nodes there exists one and only one path

* Graphical representation of the derivation process

* Gives parent-child/root-leaf relation

* The root is the axiom and the frontier is the generated phrase

* Frontier: The sequence of leaves, scanned left to right

* Degree of a node: length of the rule

* Sub Tree: Tree that has root N and the descendants of N

* LEFTMOST DERIVATION

* RIGHTMOST DERIVATION


## Notes
* As already seen, Grammars are used to express the rules of a Formal Language

* We can exclude Circular Derivations ($A \rightarrow A$) and Copy Rules ($A \rightarrow B$)

* We can therefore remove nullable terms and modify the rules with $\epsilon$ to obtain minimal grammars

* Use Null $\{E, A, ...\}$ to specify the nullification of some elements


## Syntax Tree
* Graphical method to represent the derivation of a grammar


## Ambiguity
* Given the output string, the way to write it is ambiguous

* It will occur when we eliminate these ambiguities

* To eliminate them I can use different methods, although incomplete since it is an undecidable problem


## Chomsky Normal Form
* Form to which all grammars can be reduced

* They are characterized only by null and binary rules


## Left-Recursive / Right Recursive
* $A \rightarrow A \beta_{1} \vert{} A \beta_{2}$

* Real time form

* Every rule begins with a terminal