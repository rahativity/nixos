---
name: citation-verification
description: Audit, format, and verify academic citations and BibTeX/BibLaTeX databases against genuine primary sources (DOI, arXiv, DBLP, CrossRef). Strictly prevents hallucinated or misattributed references.
license: MIT
metadata:
  upstream: https://github.com/jin-s13/ai-research-writing-skill
  commit: e8b5de964737350757b5b17d8a658a22943c9595
---

# Citation Verification & BibTeX Skill

Use this skill when compiling bibliographies, inserting citations, verifying source authenticity, standardizing BibTeX/BibLaTeX files, or auditing manuscripts for unverified references.

## Non-Negotiable Anti-Hallucination Policy

1. **Never Invent Citations**: Never hallucinate or synthesize author names, paper titles, publication years, conference proceedings, or DOIs.
2. **Explicit Verification Mandate**: Every reference entry must be cross-referenced against authoritative academic indexes:
   - **Computer Science**: DBLP, ACM Digital Library, IEEE Xplore, arXiv.
   - **General Sciences & Engineering**: CrossRef, Semantic Scholar, PubMed, Google Scholar.
3. **Handle Missing Evidence Transparently**: If a requested paper cannot be independently confirmed, explicitly warn the author:
   ```latex
   % UNVERIFIED: Query yielded no matching DOI/DBLP record. Do not submit without manual verification.
   \cite{MISSING_author_year}
   ```

---

## Canonical BibTeX Entry Patterns

Ensure all required fields are present and standardized:

### Conference Proceedings (`@inproceedings`)
```bibtex
@inproceedings{vaswani2017attention,
  author    = {Vaswani, Ashish and Shazeer, Noam and Parmar, Niki and Uszkoreit, Jakob and Jones, Llion and Gomez, Aidan N. and Kaiser, {\L}ukasz and Polosukhin, Illia},
  title     = {Attention Is All You Need},
  booktitle = {Advances in Neural Information Processing Systems (NeurIPS)},
  volume    = {30},
  pages     = {5998--6008},
  year      = {2017},
  doi       = {10.5555/3295222.3295349}
}
```

### Peer-Reviewed Journal Article (`@article`)
```bibtex
@article{lecun2015deep,
  author    = {LeCun, Yann and Bengio, Yoshua and Hinton, Geoffrey},
  title     = {Deep Learning},
  journal   = {Nature},
  volume    = {521},
  number    = {7553},
  pages     = {436--444},
  year      = {2015},
  publisher = {Nature Publishing Group},
  doi       = {10.1038/nature14539}
}
```

### Preprints / ArXiv Papers (`@article` or `@misc`)
```bibtex
@article{devlin2018bert,
  author        = {Devlin, Jacob and Chang, Ming-Wei and Lee, Kenton and Toutanova, Kristina},
  title         = {{BERT}: Pre-training of Deep Bidirectional Transformers for Language Understanding},
  journal       = {arXiv preprint arXiv:1810.04805},
  year          = {2018},
  eprint        = {1810.04805},
  archiveprefix = {arXiv},
  primaryclass  = {cs.CL}
}
```

---

## Standardization Rules for Clean Bibliographies

1. **Preserve Title Capitalization**: Wrap proper nouns, model names, acronyms, and dataset names in extra curly braces:
   - `title = {Evaluating {{BERT}} on the {{SQuAD}} Benchmark}`
   - *Why*: Without double braces, LaTeX bibliography styles (e.g. `unsrt`, `plain`) will force lowercase on "bert" and "squad".
2. **Author Name Formatting**:
   - Separate every individual author with `and` (never with commas).
   - Use either `Firstname Lastname and Firstname Lastname` or `Lastname, Firstname and Lastname, Firstname`.
   - Preserve accents using LaTeX escape sequences: `Erd{\H{o}}s`, `Sch{\"o}lkopf`, `{\L}ukasz`.
3. **Page Ranges**:
   - Always use double hyphens for ranges: `pages = {120--135}`.
4. **DOI & URL Cleanliness**:
   - Provide clean DOIs without the `https://doi.org/` prefix in the `doi = {...}` field.
   - For preprints, always include the `eprint = {...}` and `archivePrefix = {arXiv}` fields.

---

## Bibliography Audit Checklist

Run this audit on the target manuscript:

- [ ] **Orphan Key Check**: Identify any BibTeX key present in the `.bib` file that is never cited via `\cite{...}` in the text.
- [ ] **Undefined Citation Check**: Ensure every `\cite{key}` in the manuscript exists in the `.bib` file with exact case matching.
- [ ] **Duplicate Citation Check**: Search for duplicate keys or papers indexed twice under differing citation keys.
- [ ] **Source Authenticity**: Confirm author lists, publication venue, and publication year match the canonical version of record.
- [ ] **Special Characters**: Verify that `&`, `%`, `_`, and `#` in titles, abstracts, or notes are properly escaped or protected.

---

## Attribution & License
Adapted from [jin-s13/ai-research-writing-skill](https://github.com/jin-s13/ai-research-writing-skill) (commit `e8b5de964737350757b5b17d8a658a22943c9595`), licensed under the MIT License.
