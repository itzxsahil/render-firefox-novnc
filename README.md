# URL Firefox on Render (No Network Issue)

This service runs Mozilla Firefox in a virtual desktop and exposes the desktop through noVNC.

## What Was Fixed (Addressing Network Issues)

1. **IPv6 DNS Hangs & Resets**: Firefox by default queries IPv6 first (`network.dns.disableIPv6 = false`). In Docker/cloud container environments without IPv6 routing, this causes long connection hangs or `PR_CONNECT_RESET_ERROR` / `PR_END_OF_FILE_ERROR`. IPv6 DNS is explicitly disabled (`network.dns.disableIPv6 = true`).
2. **DNS-over-HTTPS (DoH / TRR)**: Firefox's default DoH mode interferes with container DNS resolvers. DoH is set to mode `5` (disabled) to ensure stable resolution via container/host DNS.
3. **Container Sandboxing Permission Denials**: Without privileged mode or user namespace capability, Firefox's multi-process content sandboxing (`MOZ_DISABLE_CONTENT_SANDBOX=1`, `security.sandbox.content.level = 0`) drops socket and IPC permissions, causing tabs to crash or network requests to fail. These sandboxing restrictions have been properly tuned for Docker environments.
4. **Native Firefox Deb (No Snap)**: Ubuntu 24.04 packages Firefox as a Snap by default, which fails completely inside Docker. This Dockerfile pulls official native `.deb` binaries directly from the official Mozilla APT repository (`packages.mozilla.org`).
5. **Window Manager Added (Fluxbox)**: Unlike Chrome which can pseudo-maximize, Firefox requires an X11 window manager to properly size windows, give focus, and manage dialogs/popups.
6. **Direct Root URL Access**: Added symlink from `vnc.html` to `index.html` so accessing `https://<your-service>.onrender.com/` works out-of-the-box without manual `/vnc.html` navigation.
7. **Keepalive Heartbeat**: Added `--heartbeat=30` to `websockify` to prevent Render's reverse proxy from terminating idle WebSocket connections.

---

## Deploy

1. In Render, create a **New + → Blueprint** service and select this repository, or create a Docker Web Service from the repository.
2. Set `START_URL` to the website Firefox should open (for example, `https://example.com`).
3. Set `VNC_PASSWORD` to a strong password. Do not leave it blank or share it.
4. Deploy. Open your service's URL `https://<your-service>.onrender.com/` (or `https://<your-service>.onrender.com/vnc.html`).
5. Enter the VNC password when prompted. Firefox will open the configured `START_URL`.

## Environment Variables

- `START_URL`: initial page opened in Firefox; must be an `http://` or `https://` URL (default: `https://www.google.com`).
- `VNC_PASSWORD`: required VNC password used to protect remote desktop access.
- `PORT`: provided by Render automatically; do not hardcode it.
