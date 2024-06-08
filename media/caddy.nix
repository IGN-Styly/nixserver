{pkgs, ...}:{
  services.caddy = {
    enable=true;
    globalConfig = ''
pki {
ca master {
    name "T3 Labs CA"
    root_cn "T3 Labs CA - 2024 ECC Root"
    root {
        cert /etc/nixos/certs/t3labs.crt
        key /etc/nixos/certs/t3labs.key
    }
}}
    '';
    virtualHosts."jellyfin.t3labs.io".extraConfig=''
    reverse_proxy http://192.168.122.37:8096
    '';
  };
  }
