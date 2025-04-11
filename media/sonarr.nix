{
  config,
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config.permittedInsecurePackages = [
                  "dotnet-sdk-6.0.428"
                  "aspnetcore-runtime-6.0.36"
                ];
  services.sonarr.enable = true;
}
