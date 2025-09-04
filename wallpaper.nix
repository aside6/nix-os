{ config, pkgs, ... }:

let
  # Generate the wpaperd.toml configuration file
  wpaperdConfig = pkgs.writeText "wpaperd.toml" ''
    [DP-1]
    path = "/usr/share/backgrounds"
    duration = "10s"  # Change wallpaper every 10 seconds (example)
    # Any other options you need to configure
  '';
in
{
  # Make sure wpaperd and other required packages are available
  environment.systemPackages = [
    pkgs.wpaperd
  ];

  # Place the wpaperd.toml file in /etc
 # environment.etc."wpaperd.toml" = {
 #   text = wpaperdConfig;
 # };

  

  # Create a systemd service to run wpaperd at startup
  systemd.services.wpmpaperd = {
    description = "Wallpaper Daemon";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.wpaperd}/bin/wpaperd --config ${wpaperdConfig}";
      Restart = "always";
      User = "root";
      Group = "root";
      WorkingDirectory = "/";
   };

    enable = true;
  };
}
