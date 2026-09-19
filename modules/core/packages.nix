{
  inputs,
  pkgs,
  host,
  ...
}:
let
  vars = import ../../hosts/${host}/variables.nix;
  inherit (vars) barChoice;
  # Noctalia-specific packages
  noctaliaPkgs =
    if barChoice == "noctalia" then
      with pkgs;
      [
        matugen # color palette generator needed for noctalia-shell
        #app2unit # launcher for noctalia-shell
        gpu-screen-recorder # needed for nnoctalia-shell
      ]
    else
      [ ];
in
{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    kdeconnect.enable = true; # KDE Connect For Phone Integration
    firefox.enable = false; # Firefox is not installed by default
    hyprland = {
      enable = true; # set this so desktop file is created
      withUWSM = false;
    };
    dconf.enable = true; # GNOME configuration database system
    seahorse.enable = true; # GNOME GUI for managing encryption keys and passwords
    fuse.userAllowOther = true; # Allow non-root users to access FUSE mounts
    mtr.enable = true; # Network diagnostic tool (traceroute + ping)
    hyprlock.enable = true; # Hyprland screen locker
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w" ];

  environment.systemPackages =
    with pkgs;
    [
      awww # Animated/efficient wallpaper daemon for Wayland
      inputs.synfetch.packages.${pkgs.stdenv.hostPlatform.system}.default # Fast system information fetch tool
    ]
    ++ noctaliaPkgs
    ++ [
      alejandra # nix formatter
      #appimage-run # Needed For AppImage Support
      brave # Brave Browser
      brightnessctl # For Screen Brightness Control
      duf # Utility For Viewing Disk Usage In Terminal
      dysk # Disk space util nice formattting
      eza # Beautiful ls Replacement
      ffmpeg # Terminal Video / Audio Editing
      file-roller # Archive Manager
      #gearlever # Manage / run Appimages
      icu # dep for gearlever
      gpu-screen-recorder # needed for nnoctalia-shell
      mesa-demos # needed for inxi diag util
      tuigreet # The Login Manager (Sometimes Referred To As Display Manager)
      htop # Simple Terminal Based System Monitor
      killall # For Killing All Instances Of Programs
      libnotify # For Notifications
      lm_sensors # Used For Getting Hardware Temps
      lolcat # Add Colors To Your Terminal Command Output
      mpv # Incredible Video Player
      nixfmt # Nix Formatter
      nwg-displays # configure monitor configs via GUI
      rustc # Rust compiler
      cargo # Rust package manager and build tool
      google-chrome # Google Chrome Browser
      docker # Docker For Containerization
      docker-compose # Docker Compose For Containerization
      #nwg-dock-hyprland # Dock for hyprland
      #nwg-menu # App menu for waybar
      onefetch # provides zsaneyos build info on current system
      pavucontrol # For Editing Audio Levels & Devices
      pciutils # Collection Of Tools For Inspecting PCI Devices
      playerctl # Allows Changing Media Volume Through Scripts
      rhythmbox # audio player
      socat # Needed For Screenshots
      unrar # Tool For Handling .rar Files
      unzip # Tool For Handling .zip Files
      usbutils # Good Tools For USB Devices
      upower # noctalia shell battery
      uwsm # Universal Wayland Session Manager (optional must be enabled)
      waypaper # Change wallpaper
      wget # Tool For Fetching Files With Links
      python3 # Python 3 programming language
      telegram-desktop # Telegram messaging client
      nautilus # GNOME file manager
      freerdp # Remote Desktop Protocol (RDP) client
      kdePackages.krdc # KDE Remote Desktop Client (VNC and RDP)
      kdePackages.okular # Universal document and PDF viewer
      localsend # Local network file sharing tool
      gcc # GNU Compiler Collection (C/C++)
      gdb # GNU Project Debugger
      cmake # Cross-platform build system generator
      gnumake # GNU Make build automation tool
      libreoffice # Office productivity suite
      typst # Modern markup-based typesetting system
      jq # Command-line JSON processor
      slurp # Wayland screen region selector
      hyprpicker # Wayland color picker
      tesseract # Optical character recognition (OCR) engine
      #gnome-calculator # GNOME desktop calculator
      coreutils # Basic GNU file, shell, and text utilities
      gnugrep # GNU grep pattern searching tool
      gawk # GNU awk pattern scanning and processing language
      procps # Process monitoring utilities (ps, top, free, etc.)
      qimgv # Fast image viewer with video support
      webp-pixbuf-loader # WebP support for GTK file picker thumbnails
      shared-mime-info # Proper MIME type detection for thumbnails
      azuredatastudio # Data management and SQL editor
      #distrobox # Run containerized Linux distributions
      android-tools # Android debugging and fastboot utilities
      nodejs # JavaScript runtime environment
      #waydroid # Android container for Linux
      qbittorrent # BitTorrent client
      guvcview # GTK webcam capture and viewing tool
    ];
}
