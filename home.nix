{ config, pkgs, ... }:

let
  # mkOutOfStore = pkg: pkgs.lib.file.mkOutOfStoreSymLink pkg;
  # Fully persisted and backed up links
 #  mkPersistentLink = path: pkgs.runCommand "persistent-link" {} ''
 #   ln -s /etc/nixos/home/aside6/dotfiles/${path} $out
 # '';

in {
  home.username = "aside6";
  home.homeDirectory = "/home/aside6";

  programs.home-manager.enable = true;
  programs.hyprpanel.enable = true;  
 
  home.stateVersion = "25.05";
  
  # Home files with persistency
  # home.file.".config/hypr/hyprland.conf".source = mkOutOfStore "/aside6/dotfiles/.config/hypr/hyprland.conf";

  home.activation.mySimLinks = pkgs.lib.mkAfter ''
        rm -rf /home/aside6/.config/hypr
	rm -rf /home/aside6/.config/wpaperd
        rm -rf /home/aside6/.config/kitty
        rm -rf /home/aside6/.config/hyprpanel
        rm -rf /home/aside6/.config/cava
 	ln -sf /etc/nixos/home/aside6/dotfiles/.config/hypr /home/aside6/.config/hypr
        ln -sf /etc/nixos/home/aside6/dotfiles/.config/hyprpanel /home/aside6/.config/hyprpanel	
        ln -sf /etc/nixos/home/aside6/dotfiles/.config/wpaperd /home/aside6/.config/wpaperd
        ln -sf /etc/nixos/home/aside6/dotfiles/.config/kitty /home/aside6/.config/kitty
        ln -sf /etc/nixos/home/aside6/dotfiles/.config/cava /home/aside6/.config/cava
    ''; 
 }
