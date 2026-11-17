<h1 align="center">🦊 Render Firefox noVNC Desktop</h1>

<p align="center">
  <a href="https://github.com/itzxsahil">
    <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&size=28&pause=1000&color=FF7139&center=true&vCenter=true&width=900&lines=Firefox+Desktop+in+Docker+with+noVNC+Web+Access;Optimized+for+Render+%26+Railway+Cloud+Hosting;Fixed+IPv6+DNS+Hangs+%7C+Low+Memory+Footprint;Made+with+❤️+by+itzxsahil" alt="Typing SVG" />
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Firefox-Native%20Deb-FF7139?style=for-the-badge&logo=firefox-browser&logoColor=white"> <img src="https://img.shields.io/badge/noVNC-HTML5%20Client-00B4D8?style=for-the-badge&logo=novnc&logoColor=white"> <img src="https://img.shields.io/badge/Docker-Ubuntu%2024.04-2496ED?style=for-the-badge&logo=docker&logoColor=white"> <img src="https://img.shields.io/badge/Render-Cloud%20Ready-46E3B7?style=for-the-badge&logo=render&logoColor=white">
</p>

---

## 📸 Project Preview

<p align="center">
  <img src="https://raw.githubusercontent.com/itzxsahil/render-firefox-novnc/main/assets/project-banner.svg" width="100%" alt="Project Preview" />
</p>

---

# 🚀 Overview

Run a production-ready, secure instance of **Mozilla Firefox** directly in any web browser over **noVNC** and WebSockets, tailored for continuous cloud execution on **Render** and **Railway**.

---

# 🏗️ System Architecture & Data Flow

<p align="center">
  <img src="https://raw.githubusercontent.com/itzxsahil/render-firefox-novnc/main/assets/architecture.svg" width="100%" alt="System Architecture &amp; Data Flow" />
</p>

<br>

The client web browser communicates over WebSockets with **websockify**, forwarding RFB graphical display protocols to **x11vnc** which renders native Mozilla Firefox inside an isolated Xvfb display buffer.

---

# ✨ Features

✅ **Zero IPv6 DNS Hangs**: Prefers IPv4 DNS by default to prevent connection dropouts in cloud containers.\n✅ **Resource Friendly**: Optimized Fluxbox + Xvfb display consuming minimal RAM.\n✅ **VNC Password Authentication**: Enforces secure access via `VNC_PASSWORD`.\n✅ **Dynamic Port Support**: Works automatically with Render's assigned `$PORT`.

---

# 📦 Installation & Quickstart

### Cloud Deployment (Render)\n[![Deploy to Render](https://render.com/images/deploy-to-render.svg)](https://render.com)\n\nSet environment variables in Render:\n- `VNC_PASSWORD`: Set your custom password.\n- `START_URL`: Default homepage (e.g. `https://www.google.com`).\n\n### Local Docker Run\n```bash\ndocker build -t render-firefox-novnc .\ndocker run -p 10000:10000 -e VNC_PASSWORD="yourpassword" render-firefox-novnc\n```\nVisit `http://localhost:10000/vnc.html` in your browser.

---

# 👤 Author & Support
- Built with ❤️ by [@itzxsahil](https://github.com/itzxsahil)
- Star ⭐ this repository if you find it helpful!
