{pkgs, ...}:{
  services.caddy = {
    enable=true;
   extraConfig = ''
pki {
ca master {
    name "T3 Labs CA"
    root_cn "T3 Labs CA - 2024 ECC Root"
}
    '';
    virtualHosts."jellyfin.t3labs.io".extraConfig=''
    reverse_proxy http://192.168.122.37:8096
    '';
  };
  }
