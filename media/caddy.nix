{pkgs, ...}:{
  services.caddy = {
    enable=true;
    virtualHosts."jellyfin.t3labs.io".extraConfig=''
    reverse_proxy http://192.168.122.37:8096
    '';
  };
  }
