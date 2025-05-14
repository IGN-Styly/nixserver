{...}:{  services.openssh = {
  enable = true;
  settings = {
    # https://www.digitalocean.com/community/tutorials/how-to-harden-openssh-on-ubuntu-20-04
    PermitRootLogin = "no";
    MaxAuthTries = 3;
    PasswordAuthentication = false;
    PermitEmptyPasswords = false;
    ChallengeResponseAuthentication = false;
    PermitUserEnvironment = false;
    AllowAgentForwarding = false;
    AllowTcpForwarding = false;
    PermitTunnel = false;
  };
};
}
