# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
#      ./hardware-configuration.nix
#      ./wallpaper.nix
#      ./steam.nix
#       ./home.nix  
#      <home-manager/nixos>
#       /nix/var/nix/profiles/per-user/aside6/channels/home-manager/nixos
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
 # programs.home-manager.enable = true;
  
  #home-manager.users.aside6 = import ./home.nix;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
 # services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  hardware.graphics.extraPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

#  systemd.services.xow = {
#    description = "Xbox One Wireless Controller Driver";
#    wantedBy = [ "multi-user.target" ];
#    serviceConfig.ExecStart = "${pkgs.xow}/bin/xow";
#  };


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  fileSystems."/media/ssd" = {
    device = "/dev/disk/by-uuid/DABED870BED84723";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" "gid=1000" "umask=000" ];
  };

  fileSystems."/media/data" = {
    device = "/dev/disk/by-uuid/9E5A93D65A93A993";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" "gid=1000" "umask=000" ];
  };

  fileSystems."/media/samples" = {
    device = "/dev/disk/by-uuid/7CD66DE9D66DA3DC";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" "gid=1000" "umask=000" ];
  };

  fileSystems."/media/games" = {
    device = "/dev/disk/by-uuid/AA566AF4566AC125";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" "gid=1000" "umask=000" ];
  };

  fileSystems."/shares/storage" = {
    device = "//192.168.4.133/storage";
    fsType = "cifs";
    options = [ "guest" "uid=1000" "gid=1000" ];
  };

  fileSystems."/shares/games" = {
    device = "//192.168.4.133/games";
    fsType = "cifs";
    options = [ "guest" "uid=1000" "gid=1000" ];
  };

  fileSystems."/shares/roothome" = {
    device = "//192.168.4.133/roothome";
    fsType = "cifs";
    options = [ "guest" "uid=1000" "gid=1000" ];
  };
  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aside6 = {
    isNormalUser = true;
    description = "aside6";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "aside6";

#  services.upower.enable = true;  # optional, for battery events
#  services.logind.extraConfig = ''
#    IdleAction=suspend
#    IdleActionSec=1h
#  '';

#  services.hyperidle.enable = true;


  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

  hardware.xone.enable = true;
  programs.waybar.enable = true;
  # Install firefox.
  programs.firefox.enable = true;
  programs.steam.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    git
    kitty
    vscode
    micro
    pkgs.ntfs3g
    nautilus
    ranger
    yazi
    wpaperd
    pavucontrol
    helvum
    thunderbird
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    vulkan-extension-layer
    lutris
    waydroid
    mpv
    dunst
    neovim
    rofi-wayland
    hypridle
    discord
    pyprland
    p3x-onenote
    slurp
    grim
    wl-clipboard
    feishin
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?


  #system.activationScripts.symlinks.text = builtins.readFile /etc/nixos/create_symlinks.sh;
}
