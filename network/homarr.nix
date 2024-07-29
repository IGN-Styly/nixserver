{pkgs, ...}: {
  virtualisation.oci-containers.containers.homarr = {
    image = "ghcr.io/ajnart/homarr:latest";
    volumes = [
      "- ./homarr/configs:/app/data/configs"
      "- ./homarr/icons:/app/public/icons"
      "- ./homarr/data:/data"
    ];
  };
}
