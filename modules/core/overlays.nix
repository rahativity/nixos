{inputs, ...}: let
  pangolinVersion = "0.15.0";
in {
  nixpkgs.overlays = [
    inputs.antigravity-nix.overlays.default

    (final: prev: let
      version = pangolinVersion;
    in {
      pangolin-cli = prev.pangolin-cli.overrideAttrs (_old: {
        inherit version;

        src = prev.fetchFromGitHub {
          owner = "fosrl";
          repo = "cli";
          tag = version;
          hash = "sha256-6TRO7tBrWH6EeMFEA6FrpvmlCkUcMtiZ5qr/LQjcLeY=";
        };

        ldflags = [
          "-X=github.com/fosrl/cli/internal/version.Version=${version}"
        ];

        vendorHash = "sha256-UmzzZDO2lz/HsrUlnV8Wa4GM8lYgoI0ggJlOvxrd79Q=";
      });
    })

    (_final: prev: {
      xfce =
        prev.xfce
        // {
          tumbler = prev.xfce.tumbler.overrideAttrs (old: {
            buildInputs = prev.lib.remove prev.libgepub old.buildInputs;
          });
        };
    })

    # Fix dwarfs-0.14.0 build: bundled folly/fbthrift need <cstring> and
    # <fmt/format.h> on GCC 15 / fmt 12. Inject includes into all C++ files.
    (_final: prev: {
      dwarfs = prev.dwarfs.overrideAttrs (oldAttrs: {
        postPatch = (oldAttrs.postPatch or "") + ''
          # Inject <cstring> and <fmt/format.h> into all C++ files in folly and fbthrift
          find folly fbthrift -type f \( -name "*.h" -o -name "*.cpp" -o -name "*.cc" \) \
            -exec sed -i '1i #include <cstring>\n#include <fmt/format.h>' {} +
        '';
      });
    })
  ];
}
