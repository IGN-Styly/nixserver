{pkgs, ...}: {
  services.adguardhome.enable = true;
  services.adguardhome.mutableSettings = true;
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
        answer = "192.168.122.226";
      }
      {
        domain = "*.nixie.org";
        answer = "192.168.122.226";
      }
    ];
  };
}
