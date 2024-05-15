
{pkgs,...}:{
  services.traefik={
    enable=true;
  };
  environment.systemPackages =[
  pkgs.traefik
  ];

  }
