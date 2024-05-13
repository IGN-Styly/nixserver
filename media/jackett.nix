{pkgs, ...}:{
  services.jackett = {
    enable=true;
    openFirewall=true;
  };
environment.systemPackages = [
pkgs.jackett
  ];
  }
