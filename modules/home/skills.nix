{
  pkgs,
  lib,
  host,
  ...
}: let
  vars = import ../../hosts/${host}/variables.nix;
  aiSkillsEnable = vars.aiSkillsEnable or true;
  eccMinimalEnable = vars.eccMinimalEnable or false;
  academicToolsEnable = vars.academicToolsEnable or false;

  # 1. User's existing canonical custom skills (Preserved untouched)
  customSkillNames = [
    # Academic & Research Skills
    "academic-writing"
    "latex-academic"
    "research-literature-review"
    "citation-verification"
    "computer-science-assignment"
    "code-review-and-testing"
    "technical-report"

    # Web Design & Software Engineering Skills
    "frontend-design"
    "ui-ux-pro-max"
    "webapp-testing"
    "premium-frontend-ui"
    "security-review"
    "web-accessibility"
    "software-engineering-workflow"
  ];

  # 2. Everything Claude Code (ECC) Minimal Profile Skills (53 skills)
  eccMinimalSkillNames = [
    "agent-introspection-debugging"
    "agent-self-evaluation"
    "agent-sort"
    "ai-regression-testing"
    "architecture-decision-records"
    "brownfield-retrospective"
    "browser-qa"
    "ck"
    "click-path-audit"
    "codebase-onboarding"
    "codehealth-mcp"
    "code-tour"
    "config-gc"
    "configure-ecc"
    "context-budget"
    "continuous-learning"
    "continuous-learning-v2"
    "conventional-commit-review"
    "council"
    "council-multi-model"
    "deepseek-harness-setup"
    "delivery-gate"
    "dev-team"
    "e2e-testing"
    "ecc-guide"
    "ecc-recipes"
    "error-handling"
    "eval-harness"
    "git-workflow"
    "growth-log"
    "hookify-rules"
    "inherit-legacy-style"
    "intent-driven-development"
    "iterative-retrieval"
    "living-docs-governance"
    "loop-design-check"
    "plan-canvas"
    "plankton-code-quality"
    "production-audit"
    "product-lens"
    "repo-scan"
    "rules-distill"
    "santa-method"
    "skill-comply"
    "skill-host-compat"
    "skill-scout"
    "skill-stocktake"
    "story-lifecycle"
    "strategic-compact"
    "tdd-workflow"
    "unified-memory"
    "verification-loop"
    "windows-desktop-e2e"
  ];

  # Helper to generate declarative file mappings
  mkSkillLinks = sourceBase: skillList: targetPrefix:
    lib.listToAttrs (map (skillName: {
        name = "${targetPrefix}/${skillName}";
        value = {
          source = "${sourceBase}/${skillName}";
          recursive = true;
        };
      })
      skillList);
in {
  config = lib.mkIf aiSkillsEnable {
    home.file = lib.mkMerge [
      # 1. Custom skills (agents, copilot, antigravity)
      (mkSkillLinks ../../skills customSkillNames ".agents/skills")
      (mkSkillLinks ../../skills customSkillNames ".copilot/skills")
      (mkSkillLinks ../../skills customSkillNames ".gemini/config/skills")

      # 2. ECC Minimal components (when enabled)
      (lib.mkIf eccMinimalEnable (lib.mkMerge [
        (mkSkillLinks ../../skills/ecc-minimal/skills eccMinimalSkillNames ".agents/skills")
        (mkSkillLinks ../../skills/ecc-minimal/skills eccMinimalSkillNames ".copilot/skills")
        (mkSkillLinks ../../skills/ecc-minimal/skills eccMinimalSkillNames ".gemini/config/skills")
        {
          ".gemini/config/rules".source = ../../skills/ecc-minimal/rules;
          ".gemini/config/agents".source = ../../skills/ecc-minimal/agents;
          ".gemini/config/workflows".source = ../../skills/ecc-minimal/workflows;
          ".agents/rules".source = ../../skills/ecc-minimal/rules;
          ".agents/agents".source = ../../skills/ecc-minimal/agents;
          ".agents/workflows".source = ../../skills/ecc-minimal/workflows;
        }
      ]))
    ];

    # Optional: academic typesetting tools (LaTeX, Pandoc)
    # Disabled by default in variables.nix to keep system closure minimal.
    # Users can also run 'nix-shell skills/shell.nix' on demand.
    home.packages = lib.mkIf academicToolsEnable (with pkgs; [
      (texlive.combined.scheme-medium.withPackages (ps: [
        ps.latexmk
        ps.booktabs
        ps.tabularx
        ps.microtype
        ps.subcaption
        ps.algorithm2e
        ps.algorithmicx
      ]))
      pandoc
    ]);
  };
}
