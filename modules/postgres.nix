{ lib, ... }:

{
  services = {
    postgresql = {
      enable = true;
      ensureDatabases = [
        "authelia-nixie"
        "lldap"
      ];
      ensureUsers = [
        {
          name = "root";
          ensureClauses.superuser = true;
        }
        {
          name = "authelia-nixie";
          ensureDBOwnership = true;
        }
        {
          name = "lldap";
          ensureDBOwnership = true;
        }

      ];
      # TODO: Required for Vikunja, but can I tighten it up?
      authentication = lib.mkForce ''
        # TYPE  DATABASE        USER            ADDRESS                 METHOD
        local   all             all                                     trust
        host    all             all             127.0.0.1/32            trust
        host    all             all             ::1/128                 trust
      '';
    };

    # Automatically run a database dump daily, to be backed up by Restic
    postgresqlBackup = {
      enable = true;
      backupAll = true;
      # Restic already compresses backups, so no need to do it here too
      compression = "none";
      startAt = "*-*-* 00:00:00";
    };
  };

  # Run the database dump before performing a Restic backup
  systemd.services.postgresqlBackup.before = [ "restic-backups-borgbase.service" ];
}
