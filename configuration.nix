# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, meta, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Portugal";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #    font = "Lat2-Terminus16";
  #    keyMap = lib.mkForce "us";
  #    useXkbConfig = true; # use xkb.options in tty.
  #  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  system.autoUpgrade = {
    enable = true;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.styly = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
     btop
     ];
# mkpasswd -m sha512
     hashedPassword = "$6$zyI9LBX/4MLXu2J0$pkdtrESkCzEFfytzXfCYaaatZRDMjbTkwEXVq2DiQg9ZY33jIMlrIjgysGj2LU6ROPYnfuAGycA1apJXmWCRo/";
     openssh.authorizedKeys.keys=["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHQK+O1TOL2qDje6J/QyfyjdZXvVfx4h69HlVhZzMYUV styly@Archie"];
   };
  environment.systemPackages = with pkgs; [
	neovim
  fzf
	git
];
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
  networking.firewall.enable = false;
  services.openssh.enable = true;


  system.stateVersion = "24.05"; # Did you read the comment?
}
