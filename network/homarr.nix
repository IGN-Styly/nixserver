# Auto-generated using compose2nix v0.3.2-pre.
{ pkgs, lib, config, ... }:

{
  # Runtime
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
  };


  # Create the User
  users.users.homarr = {
    isSystemUser = true;
    home = "/var/lib/homarr";
    group = "homarr";
    createHome = true;
  };
  users.groups.homarr = {};

  # Enable container name DNS for all Podman networks.


  virtualisation.oci-containers.backend = "podman";

  # Containers
  virtualisation.oci-containers.containers."homarr" = {
    image = "ghcr.io/homarr-labs/homarr:latest";
    environment = {
      "SECRET_ENCRYPTION_KEY" = "9b8bb4ade1712fef1dcb5cbaea2c0e8d253377c4376e62be4ee93e387cdbf89e";
      "AUTH_PROVIDER" = "oidc";
      "AUTH_OIDC_URI" = "https://auth.nixie.org";
      "AUTH_OIDC_CLIENT_SECRET" = config.sops.secrets.oidcSecret.path;
      "AUTH_OIDC_CLIENT_ID" = "K20Km6uT4oS2qQmds7zo89EnjGIM-aEKpb0ficIb43J-xkmYE5ANu1gKCuUPYz5OtvyfgKvx";
      "AUTH_OIDC_CLIENT_NAME"="Authelia";
      "AUTH_OIDC_ADMIN_GROUP"="homarr-admins";
      "AUTH_OIDC_OWNER_GROUP"="homarr-owners";
      "NEXTAUTH_URL"="https://homarr.nixie.org";
    };
    volumes = [
      "/home/styly/homarr/appdata:/appdata:rw"
    ];
    ports = [
      "7575:7575/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=homarr"
      "--network=homarr_default"
    ];
  };
  systemd.services."podman-homarr" = {
    serviceConfig = {
      User = "homarr";
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-homarr_default.service"
    ];
    requires = [
      "podman-network-homarr_default.service"
    ];
    partOf = [
      "podman-compose-homarr-root.target"
    ];
    wantedBy = [
      "podman-compose-homarr-root.target"
    ];
  };

  # Networks
  systemd.services."podman-network-homarr_default" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f homarr_default";
    };
    script = ''
      podman network inspect homarr_default || podman network create homarr_default
    '';
    partOf = [ "podman-compose-homarr-root.target" ];
    wantedBy = [ "podman-compose-homarr-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-homarr-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
