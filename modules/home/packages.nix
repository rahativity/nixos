{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;

  customPkgs = inputs.custom-packages.packages.${system};
in {
  home.packages =
    [
      #customPkgs.ab-download-manager # Download manager
    ]
    ++ (with pkgs; [
      #pangolin-cli # Pangolin reverse proxy client CLI
      #obsidian # Markdown note-taking and knowledge base app
      code-cursor # AI-powered code editor
    ]);
}
