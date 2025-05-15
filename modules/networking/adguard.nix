{pkgs, ...}: {
  services.adguardhome.enable = true;
  services.adguardhome.mutableSettings = false;

  services.caddy = {
    virtualHosts."adguard.nixie.org".extraConfig = ''
      reverse_proxy :3000
               	tls internal
                header Authorization "Basic bml4Om5peA=="
    '';};

networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];


  # TODO : make Domain and IP configurable
  services.adguardhome.settings = {
    dns={
      bootstrap_dns=[
        "9.9.9.10"
        "149.112.112.10"
        "2620:fe::10"
        "2620:fe::fe:10"
      ];
    };
    users = [
      {
        name = "nix";
        password = "$2a$12$jTU7NIXWekw2SQisJAr9sOh3GC4lbkhFEZlEKVgM0/2Kpy3Arjrg6";
      }
    ];
    filtering.rewrites = [
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
