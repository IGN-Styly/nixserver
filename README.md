# NIXSERVER
MVP(minimum viable product)
Also includes a simple bash script to be able to update/iterate over this cfg.
## Network:
  - [x] caddy // Still Mising other services
  - [x] adguard
  - [x] homarr
  - [x] authelia
  - [ ] Gatus
  - [ ] vaultwarden
## Media
  - [ ] jellyfin
  - [x] prowlarr // Missing reproducibility
  - [ ] deluge
  - [ ] overseerr
  - [ ] sonarr
  - [ ] radarr
## Development
  - [ ] Gitea
  - [ ] Coolify
# TODO
- [ ] Add All modules
- [ ] SECURE SECRETS
- [ ] Modularize secrets
- [ ] Modularize uri

# Caveats
Prowlarr is not reproducible, it requires a manual step to get the API key. And auth working.
```xml
<AuthenticationMethod>External</AuthenticationMethod>
```
Sonarr is not reproducible, it requires a manual step to get the API key. And auth working.
```xml
<AuthenticationMethod>External</AuthenticationMethod>
```
Homarr is also not fully reproducible, it requires a manual step to get the Integrations working.
And Setup the dashboard.
