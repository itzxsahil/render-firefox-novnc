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

## 🎬 Video Tutorial & Interactive Walkthrough

<div align="center">
  <a href="https://www.youtube.com/results?search_query=itzxsahil+render+firefox+novnc">
    <img src="assets/tutorial-showcase.svg" width="100%" alt="Video Tutorial Showcase" style="border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.5);" />
  </a>
  <p><em>▶️ <strong>Interactive Project Tutorial</strong> — Click the player above to watch full setup guide &amp; demonstration!</em></p>
</div>

---

# 🚀 Overview

Run a production-ready, secure instance of **Mozilla Firefox** directly in any web browser over **noVNC** and WebSockets, tailored for continuous execution on **Render** and **Railway**.

---

## 🏗️ System Architecture & Data Flow

<div align="center">
  <img src="assets/architecture.svg" width="100%" alt="Architecture Diagram" style="border-radius: 12px;" />
</div>

<br>

The web browser connects to **noVNC** over HTTP/WebSockets, proxying RFB packets to the local **x11vnc** server attached to display `:1`, running native Mozilla Firefox inside an Xvfb virtual frame buffer.

---

# ✨ Features

✅ **Zero IPv6 DNS Hangs**: Prefers IPv4 DNS by default to prevent silent connection dropouts in cloud containers.\n✅ **Resource Friendly**: Optimized Fluxbox + Xvfb display consuming minimal RAM.\n✅ **VNC Password Authentication**: Enforces secure access via `VNC_PASSWORD`.\n✅ **Dynamic Port Support**: Works automatically with Render's assigned `$PORT`.

---

# 📦 Installation & Quickstart

### One-Click Cloud Deploy
[![Deploy to Render](https://render.com/images/deploy-to-render.svg)](https://render.com)

Set environment variables in Render:
- `VNC_PASSWORD`: Set your custom access password.
- `START_URL`: Default homepage (e.g. `https://www.google.com`).

### Local Docker Run
```bash
docker build -t render-firefox-novnc .
docker run -p 10000:10000 -e VNC_PASSWORD="yourpassword" render-firefox-novnc
```
Visit `http://localhost:10000/vnc.html` in your web browser.

---

# 👤 Author & Support
- Built with ❤️ by [@itzxsahil](https://github.com/itzxsahil)
- Star ⭐ this repository if you find it helpful!
