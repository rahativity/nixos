---
name: code-review-and-testing
description: Review programming assignments and research code for correctness, edge cases, algorithmic efficiency, security, and test coverage. Generates comprehensive unit tests and automated test suites.
license: MIT
metadata:
  upstream: https://github.com/github/awesome-copilot
  commit: b1a00457c0b8794243883f387e7de71e88800e3e
---

# Code Review & Testing Skill

Use this skill when auditing source code, generating unit test suites, preparing assignment submissions, debugging memory or logical issues, and conducting peer reviews.

## Core Review Priorities

Review code in strict order of importance:

1. **Logical Correctness & Invariants**: Does the code implement the intended algorithm without flaws, off-by-one errors, or incorrect conditional branches?
2. **Safety & Security**: Are there memory safety violations, buffer overflows, integer overflows, unhandled null references, or injection risks?
3. **Boundary & Edge Case Handling**: How does the code handle empty collections, zero division, extreme values, or malformed inputs?
4. **Algorithmic Efficiency**: Are the time and space complexities optimal? Are there hidden performance traps (e.g., unintended copies, quadratic operations inside loops)?
5. **Testability & Test Suite Quality**: Is the code modular? Are comprehensive automated tests present?
6. **Maintainability & Documentation**: Clean naming conventions, self-documenting code, descriptive comments for non-trivial logic.

---

## Code Review Audit Matrix

```
[1. Static Correctness & Logic Verification]
                     │
                     ▼
  [2. Memory Safety & Resource Management]
                     │
                     ▼
[3. Algorithmic Complexity & Performance Traps]
                     │
                     ▼
  [4. Test Plan Design & Coverage Analysis]
                     │
                     ▼
 [5. Automated Test Generation (Unit/Fuzz/Prop)]
```

### 1. Common Defect Patterns to Detect

- **Off-By-One Errors**: In loop boundaries (`<=` vs `<`), array indexing, binary search intervals (`low + (high - low) / 2`).
- **Integer Overflow**: Multiplication or addition of large signed integers without 64-bit casting (`int64_t`, `long long`, `BigInt`).
- **Resource Leaks**: Unclosed file descriptors, database connections, or unreleased heap allocations (`RAII` or `with` statements).
- **Floating-Point Equality**: Using `a == b` directly on floating-point numbers instead of `fabs(a - b) < epsilon`.
- **Accidental Complexity**: Calling `.size()` or linear search operations inside a nested loop where hash lookup $O(1)$ is required.

---

## Test Plan & Suite Design

When designing a test suite for any component, generate tests across four distinct tiers:

### Tier 1: Happy Path & Canonical Examples
- Standard inputs provided in problem specifications or user stories.
- Verify exact expected outputs for representative valid data.

### Tier 2: Boundary & Extreme Values
- Minimum possible values, maximum possible values.
- Empty structures (`[]`, `""`, `null`), single-element structures (`[x]`).
- Monotonic data (all elements identical, already sorted, reverse sorted).

### Tier 3: Negative & Error Cases
- Invalid formats, negative dimensions, out-of-range indices.
- Verify that proper exceptions, errors, or sentinel values (`std::nullopt`, `Result::Err`, `ValueError`) are raised.

### Tier 4: Property-Based & Stress Tests
- Large-scale inputs ($N = 10^5$) to verify execution within time limits ($< 1.0\text{ s}$).
- Invariant testing (e.g., in a sort routine, output length equals input length and output is monotonically non-decreasing).

---

## Unit Test Framework Implementations

### Python (`pytest`)
```python
import pytest
from solution import solve_problem

@pytest.mark.parametrize("inputs, expected", [
    ([], 0),
    ([5], 5),
    ([3, 1, 4, 1, 5], 14),
    ([-2, -5, -1], -1),
])
def test_solve_problem_cases(inputs, expected):
    assert solve_problem(inputs) == expected

def test_invalid_input_raises():
    with pytest.raises(ValueError):
        solve_problem(None)
```

### C++ (`GoogleTest` / `Catch2`)
```cpp
#include <gtest/gtest.h>
#include "solution.hpp"

TEST(SolutionTest, HandlesEmptyVector) {
    std::vector<int> data = {};
    EXPECT_EQ(solveProblem(data), 0);
}

TEST(SolutionTest, HandlesNegativeValues) {
    std::vector<int> data = {-5, -1, -10};
    EXPECT_EQ(solveProblem(data), -1);
}
```

### Rust (`#[test]`)
```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_empty_input() {
        assert_eq!(solve_problem(&[]), 0);
    }

    #[test]
    fn test_large_values() {
        assert_eq!(solve_problem(&[1_000_000_000, 2_000_000_000]), 3_000_000_000);
    }
}
```

---

## Pre-Review Delivery Checklist

- [ ] Every non-trivial function has unit tests exercising nominal, boundary, and error cases.
- [ ] Memory leaks checked with AddressSanitizer (`-fsanitize=address`) or Valgrind where applicable.
- [ ] No hardcoded temporary file paths, magic numbers, or debug print statements left in production code.
- [ ] Code passes compiler warnings without diagnostic suppression (`-Wall -Wextra -Werror`).

---

## Attribution & License
Adapted from [github/awesome-copilot](https://github.com/github/awesome-copilot) (`.github/skills/code-review/SKILL.md`, commit `b1a00457c0b8794243883f387e7de71e88800e3e`), licensed under the MIT License.
