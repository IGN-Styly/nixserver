{pkgs, ...}:{
  services.gitea={
   enable=true;
   settings.server={
    SSH_PORT=222;
    HTTP_PORT=3005;
   };
  };
  environment.systemPackages = [
    pkgs.gitea
  ];
}
