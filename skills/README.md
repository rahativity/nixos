# Canonical AI Agent Skills Catalog

A canonical, version-controlled repository of Agent Skills for web design, frontend UI/UX craftsmanship, web testing, security auditing, software engineering workflow, academic writing, LaTeX document preparation, research literature reviews, and computer science coursework.

Designed to be discovered and used simultaneously by:
- **GitHub Copilot in VS Code**: Discovered via `~/.agents/skills/<skill-name>/SKILL.md` (and `~/.copilot/skills/<skill-name>/SKILL.md`).
- **Google Antigravity**: Discovered via `~/.gemini/config/skills/<skill-name>/SKILL.md`.

---

## Canonical Skills Catalog

### Web Design & Software Engineering Skills

| Skill Name | Description | Upstream Source & Reference Commit |
|---|---|---|
| **`frontend-design`** | Distinctive, intentional visual design, aesthetic direction, bespoke typography, and non-templated layouts. | Vendored from [anthropics/skills](https://github.com/anthropics/skills) (`dbd4588f9e10`, Apache-2.0) |
| **`ui-ux-pro-max`** | UI/UX design intelligence with 79 styles, 192 product palettes, 74 font pairings, 119 UX guidelines, and 22 technology stack rules. | Vendored from [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) (`28b3b8dee8c9`, MIT) |
| **`webapp-testing`** | Playwright-based testing toolkit for interacting with local web applications, element discovery, UI debugging, and console logging. | Vendored from [anthropics/skills](https://github.com/anthropics/skills) (`dbd4588f9e10`, Apache-2.0) |
| **`premium-frontend-ui`** | Immersive digital environments, advanced CSS motion, typography hierarchy, micro-interactions, and architectural craftsmanship. | Vendored from [github/awesome-copilot](https://github.com/github/awesome-copilot) (`b1a00457c0b8`, MIT) |
| **`security-review`** | Codebase vulnerability scanning, data flow tracing, injection flaws, secrets detection, and OWASP Top 10 auditing. | Vendored from [github/awesome-copilot](https://github.com/github/awesome-copilot) (`b1a00457c0b8`, MIT) |
| **`web-accessibility`** | WCAG 2.2 Level AA/AAA engineering standard, WAI-ARIA 1.2 patterns, focus trapping, keyboard navigation, and contrast auditing. | Original engineering standard |
| **`software-engineering-workflow`** | Senior software engineering methodology: specification planning, test-driven iterations, defensive programming, and atomic git discipline. | Original (distilled from [obra/superpowers](https://github.com/obra/superpowers) & senior systems practices) |

### Academic & Research Skills

| Skill Name | Description | Upstream Source & Reference Commit |
|---|---|---|
| **`academic-writing`** | Scoping, structuring, drafting, and revising academic manuscripts, theses, dissertation chapters, and research essays. | Derived from [santifs/thesis-writing-skill](https://github.com/santifs/thesis-writing-skill) (`d2484deeff288da550222afc74fc939648d9288d`, MIT) |
| **`latex-academic`** | Publication-quality LaTeX authoring, mathematical typesetting, booktabs, figures, algorithms, and compilation error diagnostics. | Adapted from [yunshenwuchuxun/latex-paper-skills](https://github.com/yunshenwuchuxun/latex-paper-skills) (`7965fbc06cd2c34ef7a0a3a566c089f4757c3de5`, MIT) |
| **`research-literature-review`** | Systematic research literature reviews, claim-evidence mapping, taxonomies, and research gap identification. | Derived from [jin-s13/ai-research-writing-skill](https://github.com/jin-s13/ai-research-writing-skill) (`e8b5de964737350757b5b17d8a658a22943c9595`, MIT) |
| **`citation-verification`** | Strict citation integrity auditing, canonical BibTeX/BibLaTeX standardization, and anti-hallucination protocols. | Derived from [jin-s13/ai-research-writing-skill](https://github.com/jin-s13/ai-research-writing-skill) (`e8b5de964737350757b5b17d8a658a22943c9595`, MIT) |
| **`computer-science-assignment`** | Problem deconstruction, algorithmic paradigm selection, formal proofs (induction, invariants), complexity analysis ($O$), and rubric audits. | Original curriculum-aligned academic CS skill |
| **`code-review-and-testing`** | Static correctness, edge case detection, memory safety, test plan design, and automated test suite generation. | Adapted from [github/awesome-copilot](https://github.com/github/awesome-copilot) (`b1a00457c0b8794243883f387e7de71e88800e3e`, MIT) |
| **`technical-report`** | Engineering and laboratory report architecture, systems benchmarks, reproducible environment documentation, and design specifications. | Original engineering report standard (IEEE/ISO) |

---

## Architecture & Discovery

All skills reside canonically in this directory (`skills/<skill-name>/SKILL.md`) inside the Git repository.

When Home Manager evaluates and activates:
1. `modules/home/skills.nix` creates declarative symlinks from the Nix store into:
   - `~/.agents/skills/<skill-name>`
   - `~/.copilot/skills/<skill-name>`
   - `~/.gemini/config/skills/<skill-name>`
2. No runtime git clones or imperative downloads occur during activation.
3. Target directories are populated without overwriting existing user-managed configuration files.

---

## On-Demand Academic Development Shell

To compile LaTeX documents or convert markdown with Pandoc without polluting your system packages or pulling multi-gigabyte dependencies into your base NixOS closure:

```bash
# In this directory:
nix-shell shell.nix

# Then compile your document:
latexmk -pdf main.tex
```

---

## Maintenance Guide

### Adding a New Skill
1. Create a new directory under `skills/<new-skill-name>/`.
2. Create `skills/<new-skill-name>/SKILL.md` with standard YAML frontmatter:
   ```yaml
   ---
   name: <new-skill-name>
   description: <Clear description of capabilities and activation trigger>
   ---
   ```
3. Add the skill name to `skillNames` in `modules/home/skills.nix`.
4. Run `git add skills/<new-skill-name>` so Git tracks it.

### Updating a Skill
- Edit the corresponding `skills/<skill-name>/SKILL.md` directly.
- Git commit your changes.

### Disabling Skills
- Set `aiSkillsEnable = false;` in `hosts/<host>/variables.nix`.
