<div align="center">

# 🌈 ColorCycling_HOS

### HarmonyOS Color Cycling Application

**Constructing Light Sources for Simulated Spectrum Generation**

[![HarmonyOS](https://img.shields.io/badge/HarmonyOS-Next-blue?style=for-the-badge&logo=harmonyos)](https://www.harmonyos.com/)
[![API](https://img.shields.io/badge/API-12%2B-green?style=for-the-badge)](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/application-dev-guide-V5)
[![License](https://img.shields.io/badge/License-Educational-orange?style=for-the-badge)](./LICENSE)
[![Language](https://img.shields.io/badge/Language-ArkTS-blueviolet?style=for-the-badge)](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-getting-started-V5)

</div>

---

## 📖 Table of Contents

- [✨ Features](#-features)
- [📋 Requirements](#-requirements)
- [🚀 Quick Start](#-quick-start)
- [📁 Project Structure](#-project-structure)
- [🎯 Usage Guide](#-usage-guide)
- [🛠️ Tech Stack](#️-tech-stack)
- [❓ FAQ](#-faq)
- [🤝 Contributing](#-contributing)
- [👤 Author](#-author)
- [📄 License](#-license)

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🎨 Core Features
- **8 Pure Color Cycling**: White, Red, Orange, Yellow, Green, Cyan, Blue, Purple
- **Adjustable Frequency**: 0.1-10 seconds color switching interval
- **Brightness Control**: 0-100% brightness adjustment
- **Forward/Reverse Cycling**: Two cycling directions supported

</td>
<td width="50%">

### 🌟 User Experience
- **Full-Screen Display**: Immersive full-screen experience
- **Drag-and-Drop Reordering**: Customize color cycling sequence
- **Control Panel**: Convenient parameter adjustment interface
- **Hidden Status Bar**: Pure display effect

</td>
</tr>
</table>

---

## 📋 Requirements

| Item | Version | Notes |
|:-----|:--------|:------|
| **DevEco Studio** | 5.0.0+ | Latest version recommended |
| **HarmonyOS SDK** | API 12 (6.0.2)+ | Download via DevEco Studio |
| **Target Device** | HarmonyOS Phone | Supports real device debugging |

---

## 🚀 Quick Start

### 1️⃣ Clone Repository

```bash
git clone https://github.com/qjy-liveforover/ColorCycling_HOS.git
cd ColorCycling_HOS
```

### 2️⃣ Open Project

1. Launch **DevEco Studio**
2. Click `File` → `Open`
3. Select the cloned project directory
4. Wait for project synchronization (dependencies will be downloaded automatically)

### 3️⃣ Configure Signing (Required)

> ⚠️ **Important**: Signing configuration has been removed for privacy. You must configure signing before running!

#### Automatic Signing (Recommended)

<div align="center">

| Step | Action |
|:----:|:-------|
| 1 | Click `File` → `Project Structure` |
| 2 | Select `Project` → `Signing Configs` |
| 3 | Check ✅ `Automatically generate signature` |
| 4 | Click `OK` to save |

</div>

DevEco Studio will automatically generate debug signing and update the configuration.

#### Manual Signing

If you have existing certificates, please refer to [SIGNING_CONFIG.md](./SIGNING_CONFIG.md)

### 4️⃣ Connect Device

1. Connect HarmonyOS device to computer via USB cable
2. Enable Developer Mode and USB Debugging on the device
3. Select the connected device in DevEco Studio toolbar

### 5️⃣ Run Application

Click the ▶️ `Run` button in DevEco Studio toolbar, or use shortcut `Shift + F10`

---

## 📁 Project Structure

```
ColorCycling_HOS/
├── 📂 AppScope/                    # Application global configuration
│   ├── 📄 app.json5               # App config (bundle name, version, etc.)
│   └── 📂 resources/              # App-level resources (icons, strings)
│
├── 📂 entry/                       # Main module
│   ├── 📂 src/
│   │   ├── 📂 main/
│   │   │   ├── 📂 ets/            # ArkTS source code
│   │   │   │   ├── 📂 entryability/      # Application entry
│   │   │   │   ├── 📂 entrybackupability/ # Backup ability
│   │   │   │   ├── 📂 model/             # Data models
│   │   │   │   └── 📂 pages/             # Page components
│   │   │   ├── 📄 module.json5   # Module configuration
│   │   │   └── 📂 resources/     # Module resources
│   │   ├── 📂 ohosTest/          # Test code
│   │   └── 📂 test/              # Unit tests
│   ├── 📄 build-profile.json5    # Module build configuration
│   └── 📄 oh-package.json5       # Module dependencies
│
├── 📄 build-profile.json5         # Application build configuration
├── 📄 oh-package.json5           # Project dependencies
├── 📂 hvigor/                    # Build tool configuration
├── 📄 .gitignore                 # Git ignore rules
├── 📄 README.md                  # Project documentation (this file)
└── 📄 SIGNING_CONFIG.md          # Signing configuration guide
```

---

## 🎯 Usage Guide

### Basic Operations

| Operation | Description |
|:----------|:------------|
| 👆 **Tap Screen** | Show/hide control panel |
| ▶️ **Start/Stop Button** | Start/pause color cycling |
| 🔄 **Reset Button** | Reset all settings to default |

### Control Panel Features

<div align="center">

| Feature | Description |
|:--------|:------------|
| 🎚️ **Frequency Adjustment** | Drag slider to set color switching interval (0.1-10s) |
| 💡 **Brightness Adjustment** | Drag slider to set display brightness (0-100%) |
| 🔄 **Cycling Direction** | Toggle forward/reverse cycling |
| 🎨 **Color Toggle** | Tap color item to enable/disable that color |
| ↕️ **Drag Reordering** | Long press and drag color item to adjust sequence |

</div>

---

## 🛠️ Tech Stack

<div align="center">

| Technology | Description |
|:-----------|:------------|
| **ArkTS** | TypeScript extension language |
| **ArkUI** | Declarative UI framework |
| **Hvigor** | Build tool |
| **HarmonyOS Next** | Target platform |

</div>

---

## ❓ FAQ

<details>
<summary><b>Q: Install Failed: error: failed to install bundle. code:9568332 error: install sign info inconsistent?</b></summary>

<br>

This error occurs when an app with the same bundle name is already installed on the device with a different signature.

**Solution**: Uninstall the existing app first:

```bash
# Method 1: HDC command
hdc shell bm uninstall -n com.qjy.oneapplication

# Method 2: On device - long press app icon and select Uninstall
```

After uninstalling, run the project again. See [SIGNING_CONFIG.md](./SIGNING_CONFIG.md) for more details.

</details>

<details>
<summary><b>Q: Signing error when running?</b></summary>

<br>

Please follow the [Configure Signing](#3️⃣-configure-signing-required) steps and try again.

</details>

<details>
<summary><b>Q: Device not found?</b></summary>

<br>

1. Ensure Developer Mode and USB Debugging are enabled on the device
2. Check USB cable connection
3. Try running `hdc list targets` in terminal to check device connection

</details>

<details>
<summary><b>Q: Project sync failed?</b></summary>

<br>

1. Check network connection
2. Try clearing cache: `File` → `Invalidate Caches / Restart`
3. Ensure DevEco Studio version meets requirements

</details>

<details>
<summary><b>Q: Compilation error?</b></summary>

<br>

1. Check if SDK version is API 12 (6.0.2) or higher
2. Try re-syncing project dependencies
3. Check for syntax errors in code

</details>

---

## 🤝 Contributing

Issues and Pull Requests are welcome!

### Contributing Steps

1. 🍴 Fork this repository
2. 📥 Clone your fork: `git clone <your-fork-url>`
3. 🌿 Create feature branch: `git checkout -b feature/AmazingFeature`
4. 💾 Commit changes: `git commit -m 'Add some AmazingFeature'`
5. 📤 Push to branch: `git push origin feature/AmazingFeature`
6. 🔄 Submit Pull Request

---

## 👤 Author

<div align="center">

| Item | Info |
|:-----|:-----|
| **Developer** | qjy-liveforover |
| **GitHub** | [![GitHub](https://img.shields.io/badge/GitHub-Profile-blue?style=flat-square&logo=github)](https://github.com/qjy-liveforover) |
| **Repository** | [ColorCycling_HOS](https://github.com/qjy-liveforover/ColorCycling_HOS) |

</div>

---

## 📄 License

This project is for learning and research purposes only.

---

<div align="center">

### 🌟 If this project helps you, please consider giving it a Star!

**⭐ Star ⭐**

Made with ❤️ by qjy-liveforover

</div>