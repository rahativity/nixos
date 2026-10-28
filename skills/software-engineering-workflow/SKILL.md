---
name: software-engineering-workflow
description: Senior software engineering methodology for AI agents and developers. Enforces structured problem decomposition, specification planning, test-driven iteration, defensive programming, atomic git discipline, and rigorous verification.
license: MIT
metadata:
  inspiration: obra/superpowers & senior systems engineering patterns
  category: software-engineering
---

# Senior Software Engineering Workflow & Agentic Execution

Use this skill when tackling complex coding tasks, implementing features, refactoring architecture, debugging regressions, or managing system-level changes. It provides a disciplined, step-by-step methodology to eliminate errors, hallucinations, and unverified assumptions.

---

## 1. The Core Engineering Cycle

```
[1. Deconstruct & Inspect] ──► [2. Plan & Specify] ──► [3. Invariant & Test Design]
                                                              │
[6. Commit & Document] ◄── [5. Review & Polish] ◄── [4. Implement & Verify]
```

Never skip steps. Jumping straight to modifying code without inspecting existing architecture or defining invariants leads to regressions and unmaintainable technical debt.

---

## 2. Phase 1 — Discovery & System Inspection

Before editing any file:
1. **Locate Existing Architecture**: Find existing patterns, config files, type definitions, and conventions used across the codebase. Follow them strictly.
2. **Read the Tests**: Understand existing test suites and fixtures to determine how the current system behaves and how edge cases are handled.
3. **Trace Data & Control Flow**: Follow inputs through the caller, handler, parser, validation, and storage layers.
4. **Identify Constraints & Dependencies**: Pinpoint memory constraints, external API limits, network boundaries, and package dependency constraints.
5. **Verify Baseline State**: Ensure existing tests and builds pass before making any modifications.

---

## 3. Phase 2 — Specification & Implementation Planning

For any task involving more than a single trivial fix:
1. **Draft an Implementation Plan**:
   - Explicitly list which files will be created, modified, or deleted.
   - Define new types, interfaces, schemas, or function signatures.
   - Identify potential failure modes, breaking changes, or backward compatibility hazards.
2. **Break into Atomic Milestones**:
   - Divide work into small, independently verifiable phases.
   - Each phase must compile, pass tests, and leave the system in a consistent, working state.
3. **Seek Early Alignment**:
   - When trade-offs exist (e.g., performance vs. memory, simplicity vs. extensibility), document alternatives and decide deliberately.

---

## 4. Phase 3 — Test-Driven Iteration & Invariant Definition

1. **Define Invariants First**:
   - What must *always* be true before this function runs (preconditions)?
   - What must *always* be true after this function completes (postconditions)?
   - What states are strictly forbidden (invariants)?
2. **Write Failing Tests First (Red)**:
   - Create minimal tests reproducing the bug or asserting the new requirement.
   - Run the test to confirm it fails for the expected reason (not due to syntax or test harness error).
3. **Implement Minimum Viable Solution (Green)**:
   - Write the simplest code that satisfies the test and preserves invariants.
4. **Refactor & Harden (Refactor)**:
   - Eliminate duplication, improve naming, add type constraints, and simplify branching logic while keeping tests passing.

---

## 5. Phase 4 — Defensive Programming & Error Architecture

### Error Handling Protocols
- **Never swallow errors silently**: Always log with context or propagate upward with structured error wrappers.
- **Fail Fast & Explicitly**: Validate all external inputs, arguments, environment variables, and config values at system boundaries.
- **Guard Against Null / Undefined**: Use optional chaining, explicit null checks, or `Option`/`Maybe` types.
- **Resource Management (RAII / Contexts)**: Always acquire and release file descriptors, sockets, database transactions, and mutexes using scoped guards (`using`, `with`, `defer`, `try-finally`).

### Concurrency & State Invariants
- Avoid global mutable state.
- Treat data as immutable by default; isolate mutations within pure functions or atomic operations.
- Anticipate race conditions, out-of-order execution, and timeout scenarios.

---

## 6. Phase 5 — Verification & Regression Auditing

Before marking any task as complete:
1. **Automated Suite Execution**: Run the full project test suite, unit tests, integration tests, and linters.
2. **Negative Testing**: Explicitly test malformed inputs, boundary values ($0$, empty string, max integer, null, negative numbers, disconnected networks).
3. **Performance & Memory Check**: Verify that algorithmic complexity has not degraded (no accidental $O(n^2)$ loops or memory leaks).
4. **Diff Inspection (`git diff`)**:
   - Review every single line changed.
   - Remove leftover debug logs, commented-out dead code, temporary test files, and unintended formatting whitespace.

---

## 7. Phase 6 — Atomic Git Discipline & Documentation

### Atomic Commit Guidelines
- Each commit must represent **one logical change** that passes all tests on its own.
- Never mix formatting/refactoring changes with functional behavioral changes in the same commit.
- Use imperative, conventional commit messages:
  ```
  feat(auth): support PKCE in OAuth2 authorization flow
  fix(parser): handle trailing commas in multiline JSON arrays
  refactor(skills): decouple path resolution from execution context
  test(cart): add property-based test for currency rounding
  docs(api): document rate limiting headers and retry strategies
  ```

### Self-Documenting Architecture
- Update architectural diagrams, interface definitions, and user-facing README files whenever contracts or commands change.
- Write explanatory comments explaining *why* a non-obvious choice was made, not *what* the syntax does.
