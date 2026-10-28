---
name: research-literature-review
description: Execute systematic research literature reviews, comparative taxonomies, and claim-evidence mapping for computer science and scientific research. Ground all literature claims in verified papers and identify research gaps.
license: MIT
metadata:
  upstream: https://github.com/jin-s13/ai-research-writing-skill
  commit: e8b5de964737350757b5b17d8a658a22943c9595
---

# Research Literature Review Skill

Use this skill when conducting systematic literature searches, surveying state-of-the-art developments, organizing related work sections, or performing claim-evidence audits.

## Core Directives

1. **Evidence-First Literature Mapping**: Never make sweeping assertions about the literature (e.g., "Existing methods fail to scale...") without citing concrete, representative papers that substantiate the specific limitation.
2. **Never Fabricate Sources or Results**: Every cited paper must be genuine and verified via its canonical identifier (DOI, arXiv ID, DBLP). If a paper cannot be confirmed, do not invent metadata or citations.
3. **Thematic Taxonomy over Chronology**: Synthesize prior work according to theoretical frameworks, algorithmic paradigms, problem formulations, or architectural models—never as a simple chronological list of papers.

---

## Systematic Review Workflow

```
[Define Topic & Research Questions]
               │
               ▼
   [Literature Search & Filtering]
   (Inclusion / Exclusion Criteria)
               │
               ▼
     [Claim-Evidence Matrix]
  (Extracting findings & guarantees)
               │
               ▼
   [Taxonomy & Comparative Synthesis]
(Categorization, trade-offs, benchmarks)
               │
               ▼
 [Identify Gaps & Position Contributions]
```

---

## 1. Claim-Evidence Matrix

Before drafting a related work section or literature survey, construct a structured claim-evidence table:

| Core Claim in Draft | Primary Evidence / Citation | Venue & Year | Empirical Basis / Dataset | Known Limitations / Edge Cases |
|---|---|---|---|---|
| Attention mechanisms reduce inductive bias compared to convolutions | Vaswani et al. [1] | NeurIPS 2017 | WMT 2014 En-De / En-Fr | Requires larger training data to outperform CNNs on small sets |
| Residual connections mitigate vanishing gradients in deep networks | He et al. [2] | CVPR 2016 | ImageNet classification | Increases memory footprint during backpropagation |
| Transformer attention scales quadratically $O(N^2)$ with sequence length | Tay et al. [3] | ACM CSUR 2022 | Benchmark across 30+ efficient models | Approximations (linear, sparse) often incur quality degradation on long-context tasks |

---

## 2. Comparative Taxonomy Template

Structure related work sections around meaningful axes of comparison:

```markdown
### Taxonomy of Approaches:
1. **Classical / Heuristic Methods**:
   - *Strengths*: Deterministic execution, low computational overhead, strong theoretical bounds.
   - *Representative works*: Author et al. (2018), Author et al. (2020).
   - *Limitations*: Inflexible to out-of-distribution shifts.

2. **Learning-Based / Neural Approaches**:
   - *Strengths*: High representational capacity, end-to-end differentiability.
   - *Representative works*: Author et al. (2021), Author et al. (2023).
   - *Limitations*: Heavy computational requirement, lack of worst-case safety guarantees.

3. **Hybrid Architectures**:
   - Combining formal verification with learned priors.
   - Positioning for current research.
```

---

## 3. Literature Synthesis Table

For survey papers, thesis background chapters, or competitive benchmarking:

| Method | Paradigm | Asymptotic Complexity | Benchmark Accuracy | Open-Source Artifact? | Primary Trade-off |
|---|---|---|---|---|---|
| Approach A | Dynamic Programming | $O(N^3)$ | 88.4\% | Yes | Exact solution, slow scaling |
| Approach B | Monte Carlo Sampling | $O(N \cdot K)$ | 85.1\% | No | Fast, high variance |
| Approach C | Graph Neural Network | $O(\|V\| + \|E\|)$ | 91.2\% | Yes | High accuracy, requires GPU |
| **Proposed** | **Hierarchical GNN** | **$O(\|V\| \log \|V\|)$** | **93.8\%** | **Yes** | **Optimal scalability & accuracy** |

---

## 4. Gap Identification & Novelty Formulation

When formulating the research gap, use precise technical contrast rather than generic dismissals:

- **Unaddressed Constraint**: "While Method A achieves real-time inference, it assumes full channel state information, which is unavailable in asynchronous distributed topologies."
- **Theoretical Limitation**: "Existing bounds derived by Author et al. apply exclusively to convex objective functions; their applicability to non-convex landscapes remains unproven."
- **Benchmark / Generalization Gap**: "Prior evaluations focus exclusively on synthetic datasets ($D_1$); performance on real-world industrial traces ($D_2$) has not been quantified."

---

## Attribution & License
Adapted from [jin-s13/ai-research-writing-skill](https://github.com/jin-s13/ai-research-writing-skill) (commit `e8b5de964737350757b5b17d8a658a22943c9595`), licensed under the MIT License.
