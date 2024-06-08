# NixOS Server
My simple Configuration of Nix OS for server deployments with an utility script.\

## The Script
It uses fzf as a tui enabling me to quckly execute commands to update/push/pull and more.
It also can displays errors nicely!
### Easy HTTPS
Caddy alows you to use https without having to deal with the pain of certificates. Modify the config for the certificate then use the `gen.sh` script located at the `certs` folder, to create a local domain certificate.
Assuming you have already overriden in Adguard.
## Deployments
- [x] Jellyfin
- [x] Jellyseerr
- [x] Jackett
- [x] Uptime Kuma
- [x] sonarr
- [ ] Deluge
- [x] AdGuard
- [x] Vaultwarder
- [x] Caddy
- [x] Homarr
And More to come like:
- A cli for install
- More tools
