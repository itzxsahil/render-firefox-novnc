FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies, display server (Xvfb), VNC, noVNC, window manager (fluxbox), and utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates wget curl xvfb x11vnc novnc websockify \
    dbus-x11 fonts-liberation fonts-noto-color-emoji fluxbox python3 \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install official native Firefox deb from Mozilla APT repository (prevents Ubuntu snap package issues)
RUN install -d -m 0755 /etc/apt/keyrings \
    && wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null \
    && echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee /etc/apt/sources.list.d/mozilla.list > /dev/null \
    && printf 'Package: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000\n' | tee /etc/apt/preferences.d/mozilla \
    && apt-get update \
    && apt-get install -y --no-install-recommends firefox \
    && rm -rf /var/lib/apt/lists/*

# Symlink index.html to vnc.html so root URL loads noVNC directly
RUN ln -sf /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 10000

CMD ["/start.sh"]
