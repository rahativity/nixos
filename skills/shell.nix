# Standalone, optional academic development shell
# Run with: nix-shell (or nix-shell skills/shell.nix)
# Provides LaTeX (medium scheme with latexmk and key academic packages), Pandoc, Typst, and Python for document compilation.
# Keeps the base NixOS / Home Manager closure lean without downloading multi-gigabyte TeX distributions globally.
{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "academic-research-env";
  buildInputs = with pkgs; [
    (texlive.combined.scheme-medium.withPackages (ps: [
      ps.latexmk
      ps.booktabs
      ps.tabularx
      ps.microtype
      ps.subcaption
      ps.algorithm2e
      ps.algorithmicx
      ps.amsmath
      ps.listings
    ]))
    pandoc
    typst
    python3
  ];

  shellHook = ''
    echo "=========================================================="
    echo " Academic & Research LaTeX / Document Environment"
    echo " Available: pdflatex, latexmk, bibtex, pandoc, typst"
    echo " Run 'latexmk -pdf main.tex' or 'typst compile main.typ'"
    echo "=========================================================="
  '';
}
