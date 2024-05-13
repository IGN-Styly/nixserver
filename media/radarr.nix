{pkgs,...}:{
services.radarr={
enable=true;
openFirewall=true;
};
environment.systemPackages = with pkgs;[
radarr
]

}
