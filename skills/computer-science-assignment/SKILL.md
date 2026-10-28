---
name: computer-science-assignment
description: Analyze and solve computer science assignments, problem sets, and theoretical coursework. Deconstructs rubrics, explains algorithms and data structures, performs complexity analysis, and designs proofs with academic integrity.
license: MIT
metadata:
  category: academic-cs
  standard: university-cs-curriculum
---

# Computer Science Assignment & Coursework Skill

Use this skill when tackling computer science problem sets, programming assignments, algorithmic proofs, data structure designs, and exam preparation.

## Core Pedagogical Mandate & Academic Integrity

1. **Rubric-Driven Deconstruction**: Always unpack problem statements into explicit constraints, inputs, outputs, guarantees, and edge cases.
2. **First-Principles Conceptual Explanation**: Explain *why* an algorithm works, not just *how* to code it. Illuminate the underlying mathematical invariants and recurrence relations.
3. **Strict Academic Integrity**: Act as an expert teaching assistant or peer collaborator. Guide the student to understand the concepts, discover the proof steps, and write clean, original implementations. Never dump unsolicited complete assignment answers when conceptual guidance is sought.

---

## Assignment Problem Breakdown Framework

When presented with an assignment problem, follow this 5-stage deconstruction:

```
[1. Problem Formulation & Constraints]
                │
                ▼
  [2. Paradigm & Invariant Selection]
                │
                ▼
[3. Step-by-Step Algorithmic Derivation]
                │
                ▼
 [4. Formal Proof & Complexity Analysis]
                │
                ▼
    [5. Edge Cases & Rubric Audit]
```

### 1. Problem Formulation & Constraints
- **Input Specifications**: Format, constraints (e.g. $1 \le N \le 10^5$, weights $w_i \in [-10^9, 10^9]$).
- **Output Requirements**: Format, precision, error bounds.
- **Resource Constraints**: Maximum execution time (e.g., $1.0\text{ s}$ implying $\le 10^8$ operations, ruling out $O(N^2)$), memory limits (e.g., $256\text{ MB}$).

### 2. Algorithmic Paradigm Identification
Select the appropriate problem-solving pattern:
- **Divide and Conquer**: Independent subproblems, Master Theorem applies.
- **Dynamic Programming**: Optimal substructure + overlapping subproblems. Define state $DP[i][j]$ and base cases.
- **Greedy**: Greedy-choice property + optimal substructure (requires exchange argument proof).
- **Graph Traversal / Network Flow**: Modeling constraints as vertices/edges, finding shortest paths (Dijkstra, Bellman-Ford) or min-cut/max-flow.
- **Two Pointers / Sliding Window**: Monotonicity property on arrays.

---

## Formal Analysis & Proof Templates

### 1. Proof by Mathematical Induction
When proving correctness of recursive algorithms or discrete properties:
- **Base Case**: Show the claim holds for the smallest element (e.g., $n = 0$ or $n = 1$).
- **Inductive Hypothesis**: Assume the claim holds for an arbitrary $k \ge 1$ (or for all $j < k$ for strong induction).
- **Inductive Step**: Prove that if the hypothesis holds for $k$, it necessarily holds for $k + 1$.
- **Conclusion**: Conclude by mathematical induction that the claim holds for all $n \in \mathbb{N}$.

### 2. Loop Invariant Proof (Iterative Algorithms)
- **Initialization**: Prove the invariant holds prior to the first iteration of the loop.
- **Maintenance**: Prove that if the invariant holds before an iteration, it remains true before the subsequent iteration.
- **Termination**: Examine the invariant upon loop termination and show it implies the algorithm's post-condition.

### 3. Asymptotic Complexity Analysis
Provide rigorous Big-O ($O$), Big-Omega ($\Omega$), and Big-Theta ($\Theta$) derivations:
- **Recurrence Relations**:
  - **Master Theorem**: For $T(n) = a T(n/b) + f(n)$, compare $f(n)$ with $n^{\log_b a}$.
  - **Recursion Tree / Substitution Method**: Unroll recurrences that violate standard Master Theorem forms (e.g., $T(n) = T(n/3) + T(2n/3) + cn$).
- **Space Complexity**:
  - Separate auxiliary space from input space. Account for recursion call stack depth.

---

## Edge Case Matrix for CS Assignments

Before submitting code or solutions, verify behavior across these boundary cases:

| Domain | Critical Edge Cases |
|---|---|
| **Arrays / Lists** | Empty list ($N=0$), single element ($N=1$), all identical elements, sorted in ascending/descending order, alternating signs. |
| **Integers / Numerics** | 0, -1, 1, `INT_MIN`, `INT_MAX`, arithmetic overflow ($a + b > 2^{31}-1$, requiring 64-bit integers `long long` / `int64_t`). |
| **Strings** | Empty string `""`, single character, palindromes, repeated characters, whitespace/newline characters, Unicode. |
| **Graphs & Trees** | Empty graph ($V=0$), disconnected graph / forest, self-loops, multi-edges, directed acyclic vs cyclical, complete graph $K_n$, tree with single degenerate line (linked list). |
| **Pointers / References** | Null pointers, cyclic reference chains, dangling pointers, double frees. |

---

## Pre-Submission Rubric Checklist

- [ ] **Specification Compliance**: Does the solution match all function signatures, class interfaces, and naming conventions requested in the assignment?
- [ ] **Complexity Guarantees**: Does the implementation meet or beat the Big-O time and space requirements stated in the rubric?
- [ ] **Code Readability & Style**: Are variable names descriptive? Are complex algorithmic steps commented with invariants?
- [ ] **Test Coverage**: Have all edge cases from the edge case matrix been tested?
