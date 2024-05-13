{pkgs,...}:{

services.jellyseerr={
enable=true;
openFirewall=true;
};

environment.systemPackages = [
    pkgs.jellyseerr
  ];
}
