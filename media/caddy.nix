{pkgs, ...}:{
  services.caddy = {
    enable=true;
    virtualHosts."nixoslab.duckdns.org".extraConfig=''
    reverse_proxy http://192.168.122.37:8096
    '';
  };
  }
