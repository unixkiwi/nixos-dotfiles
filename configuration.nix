{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      # canTouchEfiVariables = true;
      # efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      efiInstallAsRemovable = true; # Conflicts with canTouchEfiVariables
    };
  };

  # Hostname
  networking.hostName = "nixos";

  # Networking
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Europe/Berlin";

  # Internatinalisation
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Keymap in X11
  services.xserver.xkb = {
    layout = "de";
    options = "caps:swapescape";
  };

  # Console keymap
  console.keyMap = "de-latin1";

  # User
  users.users.kiwi = {
    isNormalUser = true;
    description = "kiwi";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "kvm"
    ];
    packages = with pkgs; [];
  };

  # Shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    curl
    wget
    zip
    psmisc
    gcc
    glibc
    xdg-utils
    xdg-desktop-portal
    fzf
    bat
    eza
    nixfmt
    nixd
    efibootmgr

    # sddm
    sddm-astronaut
  ];

  # For nixd lsp
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  # Stylix
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  };

  # Services

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  # Disk/Mounting stuff
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Android
  programs.adb.enable = true;

  # Storage and Cleanup
  nix = {
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  # Updates
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    dates = "weekly";
  };

  # Flatpak
  xdg.portal = {
    enable = true;
  };

  services.flatpak.enable = true;

  # Git
  programs.git = {
    enable = true;
    config = {
      credential.helper = "store";
    };
  };

  # SSH
  services.openssh.enable = true;

  # Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Display Manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [pkgs.sddm-astronaut];
  };
  services.desktopManager.plasma6.enable = true;

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # When inside a VM
  # services.qemuGuest.enable = true;
  # services.spice-vdagentd.enable = true;

  # Backup NixOS cleanup
  system.userActivationScripts = {
    removeConflictionBkpFiles = {
      text = ''
        find /home/kiwi/ -type f -name "*.nixos-backup-file" -delete
      '';
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
