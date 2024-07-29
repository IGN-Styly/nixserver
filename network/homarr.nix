{pkgs, ...}: {
  virtualisation.oci-containers.containers.homarr = {
    image = "ghcr.io/ajnart/homarr:latest";
    volumes = [
      "/home/docker/homarr:./homarr/configs:/app/data/configs"
      "/home/docker/homarr:./homarr/icons:/app/public/icons"
      "/home/docker/homarr:./homarr/data:/data"
    ];
    ports=["7575:7575" "*:*"];

  };
}
