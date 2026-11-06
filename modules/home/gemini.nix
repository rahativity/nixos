{ pkgs, config, lib, ... }:

{
  home.file.".gemini/GEMINI.md".text = ''
    # Global Agent Operational Directives & Guardrails

    ## 1. Safety & File Protection
    - NEVER delete, remove (`rm`), or wipe files without explicit confirmation.
    - NEVER modify container specs, Dockerfiles, or compose files unless explicitly asked.
    - DO NOT generate redundant scratchpads, mock files, or demo boilerplate.

    ## 2. Git & Version Control Guardrails
    - DO NOT run git commit (`git commit`), create branches (`git branch`, `git checkout -b`), or merge (`git merge`).
    - Staging/editing is permitted if instructed, but commit and branch operations belong to the user.

    ## 3. UI, Styling & Design Stability
    - DO NOT alter UI designs, CSS/Tailwind classes, layouts, or component styling unless visual changes are explicitly requested.
    - Keep styling untouched when solving logic, backend, or bug-fix tasks.

    ## 4. Sub-Agent Delegation & Domain Specialization
    - Leverage available specialized skills and sub-agents by delegating domain-specific tasks to their corresponding expert agents (e.g., dedicated testing, code review, or planning sub-agents).
    - Do not attempt monolithic execution when a specialized sub-agent or workflow exists for that phase of the task.

    ## 5. Execution Discipline & Anti-Overengineering
    - Follow YAGNI: deliver the minimal clean diff required to solve the task.
    - Read existing code and conventions first; avoid `TODO` placeholders or mock stubs.

    ## 6. Iteration Reporting
    - Report concisely after each step (under 4 lines):
      * What was modified or checked
      * Sub-agent/skill utilized (if delegated)
      * Test/verification status
      * Next action or awaiting input
  '';
}