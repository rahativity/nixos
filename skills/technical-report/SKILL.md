---
name: technical-report
description: Draft and format engineering and scientific technical reports, project documentation, lab writeups, and system architecture evaluations. Formats benchmarks, architectures, and experimental findings.
license: MIT
metadata:
  category: academic-engineering
  standard: ieee-iso-technical-reports
---

# Technical Report Writing Skill

Use this skill when drafting, structuring, or reviewing technical reports, laboratory writeups, engineering design documents, systems benchmark analyses, or formal project deliverables.

## Core Engineering Documentation Standards

1. **Precision & Objectivity**: Quantify all claims. Avoid vague adjectives ("fast", "lightweight", "robust"). Use concrete metrics ("reduced 99th percentile latency from 45ms to 12ms under 1,000 req/sec load").
2. **Reproducibility**: Document exact environment parameters (hardware specifications, compiler flags, kernel version, operating system, dataset seeds) required to reproduce the results.
3. **Structured Visuals**: Every diagram, schematic, and table must be explicitly referenced in the text and accompanied by a self-contained explanatory caption.

---

## Technical Report Architecture

```
[1. Executive Summary & Objective]
               │
               ▼
[2. Requirements & Problem Statement]
               │
               ▼
[3. System Architecture & Methodology]
               │
               ▼
[4. Implementation Details & Artifacts]
               │
               ▼
[5. Experimental Evaluation & Metrics]
               │
               ▼
[6. Discussion, Trade-Offs & Conclusion]
```

### 1. Executive Summary
- Standalone 1-page or 2-paragraph synthesis for technical leadership or grading instructors.
- Clearly states: Primary objective, architectural approach, quantified benchmark results, and final recommendation.

### 2. Requirements & Problem Definition
- **Functional Requirements ($FR_1, FR_2, \dots$)**: What the system must do.
- **Non-Functional Requirements ($NFR_1, NFR_2, \dots$)**: Latency, throughput, memory budget, fault tolerance, availability.
- **Assumptions & Operating Constraints**: Operating boundaries and environmental dependencies.

### 3. System Architecture & Design
- **High-Level Block Diagram**: Illustrating major components, data pipelines, and interface boundaries.
- **Component Breakdown**:
  - Ingestion / Interface Layer
  - Core Processing / Algorithmic Engine
  - Persistence / Storage Layer
- Data flow and communication protocols (e.g., gRPC, REST, shared memory).

### 4. Implementation Details
- Programming languages, frameworks, build systems.
- Key algorithmic optimizations or hardware-specific techniques (SIMD vectorization, cache-line alignment, asynchronous I/O).
- Safety and reliability mechanisms (watchdogs, rollback procedures, error handling).

### 5. Experimental Evaluation & Benchmark Results
- **Testbed Environment**:
  - *CPU*: Exact processor model and clock frequency.
  - *Memory*: RAM size and channels.
  - *OS*: NixOS / Linux kernel version.
  - *Workload*: Synthetic vs realistic trace generator.
- **Performance Evaluation Table**:

| Benchmark Workload | Concurrency Level | Throughput (ops/sec) | Mean Latency ($\mu\text{s}$) | p99 Latency ($\mu\text{s}$) | CPU Utilization (\%) |
|---|---|---|---|---|---|
| Synthetic Read | 16 Threads | 1,240,000 | 12.8 | 34.2 | 84.1\% |
| Mixed Read/Write | 16 Threads | 890,000 | 17.5 | 52.1 | 89.6\% |
| Stress Ingestion | 32 Threads | 650,000 | 24.1 | 118.4 | 98.2\% |

- **Graphs & Charts**: Line graphs for scaling curves; bar charts for categorical comparisons with error bars (standard deviation or 95% confidence intervals).

### 6. Discussion of Trade-Offs
- Candidly analyze where the system performs suboptimally.
- Discuss space vs time trade-offs, consistency vs availability trade-offs, and scalability bottlenecks.

### 7. Recommendations & Future Work
- Actionable conclusions and concrete next engineering steps.

---

## Technical Report Verification Checklist

- [ ] **Quantified Executive Summary**: Includes numeric highlights rather than generic summaries.
- [ ] **Caption Completeness**: All figures and tables include descriptive captions and are cited in the body text (`Figure 2 shows...`).
- [ ] **Units on All Metrics**: Every number has proper SI or computing units ($\text{ms}$, $\text{MB/s}$, $\text{GB}$, $\text{kHz}$).
- [ ] **Reproducible Setup**: Hardware, software versions, and configuration flags are completely documented.
- [ ] **Rubric Alignment**: Explicitly addresses all prompts and deliverables listed in the project prompt or specification.
