{pkgs, ...}: {
  services.adguardhome.enable = true;
  services.adguardhome.mutableSettings = true;

  caddy = {
    virtualHosts."adguard.nixie.org".extraConfig = ''
      reverse_proxy :3000
               	tls internal
                header Authorization "Basic bml4Om5peA=="
    '';};




  # TODO : make Domain and IP configurable
  services.adguardhome.settings = {
    users = [
      {
        name = "nix";
        password = "$2a$12$jTU7NIXWekw2SQisJAr9sOh3GC4lbkhFEZlEKVgM0/2Kpy3Arjrg6";
      }
    ];
    rewrites = [
      {
        domain = "nixie.org";
        answer = "10.100.0.1";
      }
      {
        domain = "*.nixie.org";
        answer = "10.100.0.1";
      }
    ];
  };
}
