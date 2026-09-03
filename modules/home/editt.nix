{pkgs, ...}: let
  editt = pkgs.stdenv.mkDerivation rec {
    pname = "editt";
    version = "0.4.0";

    src = pkgs.fetchurl {
      url = "https://github.com/mirarr-app/editt/releases/download/${version}/editt.tar.gz";
      sha256 = "185832c2db5e12aa5ccaa9b93a9c1ece7a87c6ae5b78c53ab9f080cd8c44c8f9";
    };

    sourceRoot = ".";

    nativeBuildInputs = with pkgs; [
      autoPatchelfHook
      makeWrapper
    ];

    buildInputs = with pkgs; [
      gtk3
      glib
      gdk-pixbuf
      pango
      harfbuzz
      cairo
      atk
      zlib
      libepoxy
    ];

    runtimeDependencies = with pkgs; [
      gtk3
      glib
      gdk-pixbuf
      pango
      harfbuzz
      cairo
      atk
      zlib
      libepoxy
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      libGL
      vulkan-loader
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/opt/editt
      cp -r editt data lib $out/opt/editt/

      mkdir -p $out/bin
      makeWrapper $out/opt/editt/editt $out/bin/editt \
        --prefix LD_LIBRARY_PATH : "$out/opt/editt/lib"

      mkdir -p $out/share/applications
      cat > $out/share/applications/editt.desktop <<EOF
      [Desktop Entry]
      Name=Editt
      Comment=Beautiful Image Viewer and Editor
      Exec=$out/bin/editt %f
      Icon=image-x-generic
      Terminal=false
      Type=Application
      Categories=Graphics;Photography;ImageProcessing;
      MimeType=image/jpeg;image/png;image/webp;image/gif;image/bmp;
      EOF

      runHook postInstall
    '';

    meta = with pkgs.lib; {
      description = "Beautiful Image Viewer and Editor";
      homepage = "https://github.com/mirarr-app/editt";
      license = licenses.mit;
      platforms = ["x86_64-linux"];
    };
  };
in {
  home.packages = [editt];
}
