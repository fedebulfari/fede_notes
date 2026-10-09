---
date: 09-10-2026
subject: Formal Languages and Compilers
---
* Alphabet finite set of element
* Strings: atomic elements (repeatable)
* Language: potentially finite set of Strings[cite: 1]
* Formal Language: Language with regular structure and well defined Rules[cite: 1]
  * $\hookrightarrow$ Artificial[cite: 1]

## Operations[cite: 1]
### Strings[cite: 1]

* CONCATENATION (product of strings)[cite: 1]
  * is a basic operation[cite: 1]
  * is associative[cite: 1]
  * changes the length[cite: 1]
* EMPTY STRING (or NULL string)[cite: 1]
  * is the neutral element with respect to concatenation: chaining $\epsilon$ on the left or right does not change the string[cite: 1]
  * Pay attention: $\epsilon$ is NOT the same as $\emptyset$ (the empty set)[cite: 1]
* SUBSTRING: $x=uyv$[cite: 1]
  * y is a substring[cite: 1]
  * u is a prefix[cite: 1]
  * v is a suffix[cite: 1]
  * Proper substring: y if $u \neq \epsilon \vee v \neq \epsilon$[cite: 1]
* LENGTH OF A STRING $|x| \ge 0$[cite: 1]
  * is the number of elements (letters)[cite: 1]
* EQUALITY OF TWO STRINGS: two strings are equal if and only if (iff)[cite: 1]
  * they have the same length[cite: 1]
  * their elements orderly coincide, from left to right[cite: 1]
* MIRRORING or REFLECTION[cite: 1]
  * $(xy)^R=y^R x^R$[cite: 1]
* REPETITION (or ITERATION): the n-th power of a string[cite: 1]
* PRECEDENCE BETWEEN OPERATORS[cite: 1]
  * power precedes concatenation[cite: 1]
  * mirroring precedes concatenation[cite: 1]
* PREFIX-FREE LANGUAGE: in the language there is not any string that is a prefix of another string of the language[cite: 1]

### Operators[cite: 1]

* STAR OPERATOR (also called Kleene star or concatenation closure)[cite: 1]
  * is the limit of the power operator[cite: 1]
  * The union of all the powers of a language, for every positive or null [UNREADABLE][cite: 1]
  * PROPERTIES OF THE STAR OPERATOR: monotonic, closed w.r.t. concatenation, idempotent, commutes with mirroring[cite: 1]
* CROSS OPERATOR (called Kleene cross or non-reflexive concatenation closure)[cite: 2]
  * is the non reflexive closure with respect to concatenation[cite: 2]
  * The unitary does not contain the null power[cite: 2]
* QUOTIENT OPERATOR: it shortens the phrases of a language L by stripping off a suffix out of another language L'[cite: 2]
  * $L=L'/L''=\{y|(x=yz \in L') \wedge z \in L''\}$[cite: 2]


---
Related: [[_Formal Languages and Compilers MOC]]