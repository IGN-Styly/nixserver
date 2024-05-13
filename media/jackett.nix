{pkgs, ...}:{
  services.jacket = {
    enable=true;
    openFirewall=true;
  };
environment.systemPackages = [
pkgs.jackett
  ];
  }
