<h1 align="center">🦊 Render Firefox noVNC Desktop</h1>

<p align="center">
  <a href="https://github.com/itz-spidy">
    <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&size=28&pause=1000&color=FF7139&center=true&vCenter=true&width=900&lines=Firefox+in+Docker+with+noVNC+Web+Access;Ready+for+Render%2C+Railway+%26+Cloud+Deployments;No+IPv6+DNS+Hangs+%7C+Low+Memory+%7C+Xvfb+%2B+Fluxbox;Made+with+%E2%9D%A4%EF%B8%8F+by+itz-spidy" alt="Typing SVG" />
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Firefox-Native%20Deb-FF7139?style=for-the-badge&logo=firefox-browser&logoColor=white">
  <img src="https://img.shields.io/badge/noVNC-HTML5%20Client-00B4D8?style=for-the-badge&logo=novnc&logoColor=white">
  <img src="https://img.shields.io/badge/Docker-Ubuntu%2024.04-2496ED?style=for-the-badge&logo=docker&logoColor=white">
  <img src="https://img.shields.io/badge/Render-Cloud%20Ready-46E3B7?style=for-the-badge&logo=render&logoColor=white">
</p>

---

## 🎬 Video Tutorial & Interactive Preview

<div align="center">
  <a href="https://www.youtube.com/results?search_query=novnc+docker+render+tutorial">
    <img src="https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png" width="100%" />
    <br><br>
    <img src="https://media.giphy.com/media/qgQUggAC3Pfv687qPC/giphy.gif" width="700" alt="Browser Demo Animation" style="border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.5);" />
    <br><br>
    <img src="https://img.shields.io/badge/%E2%96%B6%EF%B8%8F%20WATCH%20TUTORIAL-CLICK%20TO%20RUN%20BROWSER-FF0000?style=for-the-badge&logo=youtube&logoColor=white" />
  </a>
</div>

---

# 🚀 Overview

Run a full-featured, secure instance of **Mozilla Firefox** directly in your browser over **noVNC** and WebSockets, specifically optimized for cloud platforms like **Render** and **Railway**.

### 🌟 Key Highlights & Fixes
- ⚡ **No IPv6 DNS Hangs**: Disables IPv6 DNS by default (`network.dns.disableIPv6 = true`) to prevent cloud timeouts.
- 🛡️ **Container Optimized**: Stripped of telemetry, Pocket, and background overhead for minimum RAM usage.
- 🔒 **VNC Password Protection**: Enforced authentication via `VNC_PASSWORD` environment variable.
- 🌐 **Dynamic Port Binding**: Seamlessly hooks into Render's dynamic `$PORT` (default `10000`).

---

# 🏗️ Architecture

```
User Web Browser
      │
      ▼  (HTTP / WebSocket)
   [noVNC (websockify)]  Port: $PORT (10000)
      │
      ▼  (RFB Protocol)
   [x11vnc Server]       Display: :1
      │
      ▼
   [Fluxbox + Xvfb] ───► [Mozilla Firefox Native]
```

---

# ⚡ Deploy to Cloud

### Deploy to Render
[![Deploy to Render](https://render.com/images/deploy-to-render.svg)](https://render.com)

1. Create a **New Web Service** connected to this repository.
2. Select **Docker** environment.
3. Configure Environment Variables:
   - `VNC_PASSWORD`: Set a strong access password (e.g., `SecurePass123!`).
   - `START_URL`: Default URL to open (e.g., `https://www.google.com`).

---

# 🐳 Local Docker Run

```bash
# Clone the repository
git clone https://github.com/itz-spidy/render-firefox-novnc.git
cd render-firefox-novnc

# Build the image
docker build -t render-firefox-novnc .

# Run container
docker run -p 10000:10000 -e VNC_PASSWORD="yourpassword" render-firefox-novnc
```

Open your browser at `http://localhost:10000/vnc.html` and enter your password!

---

# 👤 Author & Support
- Built with ❤️ by [@itz-spidy](https://github.com/itz-spidy)
- Star ⭐ this repo if you find it helpful!
