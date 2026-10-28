---
name: academic-writing
description: Guide structuring, drafting, and revising academic manuscripts, theses, dissertation chapters, and scholarly essays with rigorous argumentative flow, hypothesis framing, and academic tone.
license: MIT
metadata:
  upstream: https://github.com/santifs/thesis-writing-skill
  commit: d2484deeff288da550222afc74fc939648d9288d
---

# Academic Writing Skill

Use this skill when planning, drafting, restructuring, or revising academic manuscripts, theses, dissertation chapters, research essays, or course papers.

## Core Principles

1. **Claim-Evidence Grounding**: Every factual, empirical, or theoretical assertion must be supported by citations, data, or formal proof. Never make unsubstantiated claims.
2. **Academic Tone**: Maintain an objective, precise, and analytical tone. Eliminate colloquialisms, conversational fillers, and hyperbolic AI buzzwords ("revolutionary", "game-changing", "delve", "testament").
3. **Structured Flow**: Every chapter and section must have a clear rhetorical purpose:
   - What is the claim or question?
   - What is the context and theoretical foundation?
   - What evidence or methodology supports it?
   - What are the limitations or alternative interpretations?
4. **Format & Tool Agnostic**: Respect the user's target document format (LaTeX, Typst, Markdown, or Word). Do not force LaTeX if the project is in Markdown or Typst, and vice versa.

---

## Academic Manuscript Architecture

When drafting or evaluating a comprehensive academic document, adhere to this structural blueprint:

### 1. Title, Abstract, and Keywords
- **Abstract Structure (4-part model)**:
  - **Context & Problem**: What specific problem is addressed and why is it significant?
  - **Proposed Approach / Methodology**: What was done, designed, or measured?
  - **Key Findings / Results**: What are the concrete, quantified outcomes?
  - **Significance / Contribution**: What is the impact or implication for the field?
- Keep length strictly within venue/department guidelines (typically 150–250 words).

### 2. Introduction
- **Hook & Background**: Broad context leading directly to the specific research gap.
- **Problem Statement**: Explicit definition of the unresolved challenge.
- **Research Questions / Hypotheses**: Numbered or bulleted questions ($RQ_1, RQ_2, \dots$) or testable hypotheses ($H_1, H_2$).
- **Summary of Contributions**: Explicit list of 3–4 novel contributions (theoretical, algorithmic, empirical, or artifact).
- **Roadmap**: Brief paragraph mapping subsequent sections.

### 3. Related Work / Theoretical Framework
- Group prior literature by thematic concept or methodology, **not** as a chronological bibliography summary.
- Highlight specific limitations in existing literature that motivate the current work.
- Position the current work clearly against the closest competitors.

### 4. Methodology / System Model
- Formulate the problem mathematically or formally.
- State all assumptions, domain constraints, and scope boundaries explicitly.
- Provide step-by-step descriptions of algorithms, experimental protocols, or system architecture.
- Ensure sufficient detail for independent reproducibility.

### 5. Empirical Results / Evaluation
- Report experimental data objectively with proper units, error bounds, and statistical significance.
- Present results using clean tables and clear figures; reference each in the prose.
- Clearly separate factual observations ("Figure 3 shows that latency decreased by 18%") from interpretation.

### 6. Discussion
- Interpret the results in the context of the original research questions ($RQ_1, RQ_2$).
- Address rival hypotheses and potential confounding factors.
- Discuss threats to validity:
  - *Internal validity*: experimental controls, measurement accuracy.
  - *External validity*: generalizability, dataset limitations.
- Acknowledge genuine limitations candidly.

### 7. Conclusion & Future Directions
- Succinctly synthesize the principal findings (do not merely repeat the abstract).
- State concrete, actionable recommendations for future research.

---

## Writing & Editing Checklist

Before finalizing any section, verify against this checklist:

- [ ] **Paragraph Unity**: Each paragraph begins with a clear topic sentence and discusses a single idea.
- [ ] **Signposting & Transitions**: Logical transition words connect paragraphs (`Consequently`, `In contrast`, `Furthermore`).
- [ ] **Hedged Claims**: Distinguish between established facts and tentative inferences (`suggests`, `indicates`, `is consistent with` rather than `proves`).
- [ ] **Terminology Consistency**: Use uniform terms throughout (do not alternate between "node", "vertex", and "host" when referring to the same entity).
- [ ] **Citation Verification**: Every citation key corresponds to an authentic, verified reference in the bibliography.

---

## Attribution & License
Adapted from [santifs/thesis-writing-skill](https://github.com/santifs/thesis-writing-skill) (commit `d2484deeff288da550222afc74fc939648d9288d`), licensed under the MIT License.
