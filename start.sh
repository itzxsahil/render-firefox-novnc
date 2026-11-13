#!/usr/bin/env bash
set -euo pipefail

: "${VNC_PASSWORD:?Set VNC_PASSWORD in Render environment variables}"

PORT="${PORT:-10000}"
START_URL="${START_URL:-https://www.google.com}"

# Validate the configured launch URL before passing it to Firefox.
python3 - "$START_URL" <<'PY'
import sys
from urllib.parse import urlparse
u = urlparse(sys.argv[1])
if u.scheme not in ("http", "https") or not u.netloc:
    raise SystemExit("START_URL must be a valid http:// or https:// URL")
PY

# Disable content and GPU sandboxing in container environment to prevent network socket drops
export MOZ_DISABLE_CONTENT_SANDBOX=1
export MOZ_DISABLE_GPU_SANDBOX=1
export MOZ_DISABLE_RDD_SANDBOX=1
export MOZ_DISABLE_GMP_SANDBOX=1

# Configure system-wide enterprise policies to disable telemetry and prevent network/DNS timeouts
mkdir -p /etc/firefox/policies
cat << 'EOF' > /etc/firefox/policies/policies.json
{
  "policies": {
    "DisableAppUpdate": true,
    "DisableTelemetry": true,
    "DisableFirefoxStudies": true,
    "OverrideFirstRunPage": "",
    "OverridePostUpdatePage": "",
    "DontCheckDefaultBrowser": true,
    "Preferences": {
      "network.dns.disableIPv6": true,
      "network.trr.mode": 5,
      "security.sandbox.content.level": 0,
      "security.sandbox.gpu.level": 0
    }
  }
}
EOF

# Set up Firefox profile with tuned network preferences
PROFILE_DIR="/tmp/firefox-profile"
mkdir -p "$PROFILE_DIR"
cat << 'EOF' > "$PROFILE_DIR/user.js"
// Disable IPv6 lookups to prevent Docker/cloud network DNS timeouts and PR_CONNECT_RESET_ERROR
user_pref("network.dns.disableIPv6", true);

// Disable DNS-over-HTTPS (DoH) so Firefox uses standard host/container DNS resolvers
user_pref("network.trr.mode", 5);

// Direct connection (no proxy auto-detection delays)
user_pref("network.proxy.type", 0);

// Disable speculative pre-connections to prevent socket exhaustion
user_pref("network.http.speculative-parallel-limit", 0);

// Disable internal sandbox levels inside container to avoid socket permission errors
user_pref("security.sandbox.content.level", 0);
user_pref("security.sandbox.gpu.level", 0);

// Disable telemetry, first run pages, and update popups
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.sessionstore.resume_from_crash", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("app.update.auto", false);
user_pref("app.update.enabled", false);
user_pref("extensions.pocket.enabled", false);
EOF

# Initialize virtual X display
mkdir -p /tmp/.X11-unix
Xvfb :1 -screen 0 1366x768x24 -ac +extension GLX +render -noreset &
export DISPLAY=:1
sleep 2

# Start lightweight window manager so Firefox properly resizes and focuses
fluxbox &
sleep 1

# Setup VNC server
x11vnc -storepasswd "$VNC_PASSWORD" /tmp/vnc.pass >/dev/null
x11vnc -display :1 -forever -shared -rfbauth /tmp/vnc.pass -listen 127.0.0.1 -rfbport 5900 &
sleep 1

# Launch Firefox
firefox \
  --profile "$PROFILE_DIR" \
  --no-remote \
  --width 1366 \
  --height 768 \
  "$START_URL" &

# Render routes HTTP and WebSocket traffic through the same public port.
exec websockify --web=/usr/share/novnc --heartbeat=30 "$PORT" 127.0.0.1:5900
