---
name: latex-academic
description: Produce and troubleshoot publication-quality LaTeX documents, assignments, problem sets, and technical articles. Covers equations, complex tables (booktabs), figures, pseudocode/algorithms, PDF compilation, and compiler error diagnosis.
license: MIT
metadata:
  upstream: https://github.com/yunshenwuchuxun/latex-paper-skills
  commit: 7965fbc06cd2c34ef7a0a3a566c089f4757c3de5
---

# LaTeX Academic Skill

Use this skill when authoring, formatting, or debugging LaTeX assignments, academic papers, lecture notes, lab reports, or technical manuscripts.

## Core Best Practices

1. **Modular Document Structure**: Split large documents into logical sections via `\input{sections/sec1}` or `\include{chapters/chap1}`.
2. **Professional Typography**:
   - Use `booktabs` for all tables (`\toprule`, `\midrule`, `\bottomrule`). Never use vertical lines (`|`).
   - Use `microtype` for enhanced spacing, kerning, and visual protrusion.
   - Use `hyperref` with `colorlinks=true` for clean, clickable links.
3. **Labels & References**:
   - Follow systematic labeling: `sec:`, `fig:`, `tab:`, `eq:`, `alg:`, `thm:`, `lem:`.
   - Always reference equations via `\eqref{eq:...}` (from `amsmath`) so parentheses `(...)` are included automatically.
   - Reference sections/figures with non-breaking spaces: `Section~\ref{sec:methods}`, `Figure~\ref{fig:arch}`.

---

## Standard Structural Elements

### 1. Mathematics & Equations
Always use standard AMS math environments:

```latex
\usepackage{amsmath,amssymb,amsfonts,amsthm}

% Multi-line aligned equation with single tag
\begin{equation}
\label{eq:optimization}
\begin{aligned}
    \min_{\theta} \quad & \mathcal{L}(\theta) = \frac{1}{N}\sum_{i=1}^N \ell(f(x_i; \theta), y_i) + \lambda \|\theta\|_2^2 \\
    \text{subject to} \quad & g_j(\theta) \le 0, \quad \forall j \in \{1, \dots, m\}
\end{aligned}
\end{equation}

% Piecewise function
\begin{equation}
\label{eq:activation}
\sigma(z) =
\begin{cases}
    z, & \text{if } z \ge 0, \\
    \alpha (e^z - 1), & \text{if } z < 0.
\end{cases}
\end{equation}
```

### 2. High-Quality Tables (`booktabs`)
Clean academic table format:

```latex
\usepackage{booktabs}
\usepackage{tabularx}

\begin{table}[htbp]
\centering
\caption{Model performance benchmark across standardized evaluation datasets.}
\label{tab:benchmark}
\begin{tabular}{lcccc}
\toprule
\textbf{Model} & \textbf{Parameters (M)} & \textbf{Latency (ms)} & \textbf{Accuracy (\%)} & \textbf{F1 Score} \\
\midrule
Baseline CNN   & 14.2 & 12.4 & 84.2 & 0.831 \\
ResNet-50      & 25.6 & 24.1 & 89.6 & 0.887 \\
Proposed Net   & \textbf{18.1} & \textbf{16.8} & \textbf{92.4} & \textbf{0.918} \\
\bottomrule
\end{tabular}
\end{table}
```

### 3. Figures & Subfigures
Using `subcaption` and `graphicx`:

```latex
\usepackage{graphicx}
\usepackage{subcaption}

\begin{figure}[htbp]
\centering
\begin{subfigure}[b]{0.48\textwidth}
    \centering
    \includegraphics[width=\textwidth]{figures/loss_curve.pdf}
    \caption{Training loss convergence.}
    \label{fig:loss}
\end{subfigure}
\hfill
\begin{subfigure}[b]{0.48\textwidth}
    \centering
    \includegraphics[width=\textwidth]{figures/accuracy_curve.pdf}
    \caption{Validation accuracy progression.}
    \label{fig:accuracy}
\end{subfigure}
\caption{Comparison of convergence metrics over 100 training epochs.}
\label{fig:training_curves}
\end{figure}
```

### 4. Algorithm & Pseudocode (`algorithm2e` or `algpseudocode`)
```latex
\usepackage{algorithm}
\usepackage{algpseudocode}

\begin{algorithm}[htbp]
\caption{Iterative Policy Refinement}
\label{alg:policy_refine}
\begin{algorithmic}[1]
\Require Dataset $\mathcal{D}$, Initial parameters $\theta_0$, Learning rate $\eta$
\Ensure Optimized policy parameter vector $\theta^*$
\State $\theta \gets \theta_0$
\While{not converged}
    \State Sample batch $\mathcal{B} \sim \mathcal{D}$
    \State Compute gradient $g \gets \nabla_\theta \mathcal{L}(\theta; \mathcal{B})$
    \State Update parameters $\theta \gets \theta - \eta \cdot g$
\EndWhile
\State \Return $\theta$
\end{algorithmic}
\end{algorithm}
```

---

## Compilation & Workflow Commands

In a terminal or automated runner:

```bash
# Recommended: Automated compilation handling multi-pass BibTeX and index updates
latexmk -pdf -synctex=1 -interaction=nonstopmode main.tex

# Clean auxiliary files (.aux, .log, .out, .bbl, .blg)
latexmk -c

# Full clean including final target PDF
latexmk -C
```

---

## Compilation Error Diagnostics & Solutions

When LaTeX compilation fails, diagnose the `.log` output with these verified fixes:

| Error Message | Typical Cause | Resolution |
|---|---|---|
| `! Undefined control sequence` | Typo in command or missing package. | Check package imports. For `\mathbb`, ensure `\usepackage{amssymb}` is loaded. For `\bm`, load `\usepackage{bm}`. |
| `! LaTeX Error: File 'xyz.sty' not found` | Missing LaTeX package in distribution. | Add the package to your Nix `texlive` scheme or use `nix-shell -p "texlive.combined.scheme-medium"`. |
| `! Runaway argument?` | Missing closing brace `}` in a macro, caption, or section title. | Inspect the line reported in the log; check balance of braces `{}` in preceding lines. |
| `! Missing $ inserted` | Math symbol (e.g. `_`, `^`, `\alpha`) used in text mode, or unescaped underscore in a file path/URL. | Wrap math in `$ ... $`, or escape literal characters (`\_`, `\&`, `\%`). |
| `! LaTeX Error: Environment XYZ undefined` | Environment package missing or name misspelled. | E.g. For `align`, import `amsmath`. For `algorithmic`, import `algpseudocode`. |
| `Overfull \hbox (XXpt too wide)` | Long equation, table, or verbatim block exceeds text margins. | Wrap long equations across lines with `align` or `multline`. For tables, switch fixed column widths `p{3cm}` or use `tabularx`. |
| `LaTeX Warning: Citation 'xyz' undefined` | BibTeX key missing from `.bib` or auxiliary file out-of-date. | Run `bibtex main` or rerun `latexmk -pdf` to trigger bibliography indexing. Check citation key spelling. |

---

## Attribution & License
Adapted from [yunshenwuchuxun/latex-paper-skills](https://github.com/yunshenwuchuxun/latex-paper-skills) (commit `7965fbc06cd2c34ef7a0a3a566c089f4757c3de5`), licensed under the MIT License.
