{
  pkgs,
  lib,
  host,
  ...
}: let
  vars = import ../../hosts/${host}/variables.nix;
  aiSkillsEnable = vars.aiSkillsEnable or true;
  academicToolsEnable = vars.academicToolsEnable or false;

  skillNames = [
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

  # Helper to generate declarative file mappings for a target agent directory
  mkSkillLinks = targetPrefix:
    lib.listToAttrs (map (skillName: {
        name = "${targetPrefix}/${skillName}";
        value = {
          source = ../../skills/${skillName};
          recursive = true;
        };
      })
      skillNames);
in {
  config = lib.mkIf aiSkillsEnable {
    home.file =
      # 1. VS Code / GitHub Copilot global personal skills directory (agentskills.io standard)
      (mkSkillLinks ".agents/skills")
      # 2. GitHub Copilot user-level directory
      // (mkSkillLinks ".copilot/skills")
      # 3. Google Antigravity global customizations skills directory
      // (mkSkillLinks ".gemini/config/skills");

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
