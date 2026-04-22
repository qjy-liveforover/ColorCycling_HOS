# ColorCycling_HOS - HarmonyOS Color Cycling Application

An application for **Constructing Light Sources for Simulated Spectrum Generation** on HarmonyOS platform. Features full-screen pure color light cycling, suitable for screen testing, ambient light simulation, and spectrum visualization scenarios.

## Features

- 🎨 **8 Pure Color Light Cycling**: White, Red, Orange, Yellow, Green, Cyan, Blue, Purple
- ⏱️ **Adjustable Frequency**: Color switching interval from 0.1 to 10 seconds
- 🌟 **Brightness Control**: 0-100% brightness adjustment
- 🔄 **Forward/Reverse Cycling**: Two cycling directions supported
- 📱 **Full-Screen Display**: Immersive full-screen experience with hidden status bar
- ✋ **Drag-and-Drop Reordering**: Customize color cycling sequence
- 🎛️ **Control Panel**: Convenient parameter adjustment interface

## Requirements

| Item | Version |
|------|---------|
| DevEco Studio | 5.0.0 or higher |
| HarmonyOS SDK | API 12 (6.0.2) or higher |
| Target Device | HarmonyOS phone device |

## Quick Start

### 1. Clone Repository

```bash
git clone https://github.com/qjy-liveforover/ColorCycling_HOS.git
cd ColorCycling_HOS
```

### 2. Open Project

1. Launch **DevEco Studio**
2. Click `File` → `Open`
3. Select the cloned project directory
4. Wait for project synchronization (dependencies will be downloaded automatically)

### 3. Configure Signing (Required)

> ⚠️ **Important**: Signing configuration has been removed for privacy. You must configure signing before running!

#### Automatic Signing (Recommended)

1. Click `File` → `Project Structure`
2. Select `Project` → `Signing Configs`
3. Check ✅ `Automatically generate signature`
4. Click `OK` to save

DevEco Studio will automatically generate debug signing and update the configuration.

#### Manual Signing

If you have existing certificates, please refer to [SIGNING_CONFIG.md](./SIGNING_CONFIG.md)

### 4. Connect Device

1. Connect HarmonyOS device to computer via USB cable
2. Enable Developer Mode and USB Debugging on the device
3. Select the connected device in DevEco Studio toolbar

### 5. Run Application

Click the ▶️ `Run` button in DevEco Studio toolbar, or use shortcut `Shift + F10`

## Project Structure

```
ColorCycling_HOS/
├── AppScope/                    # Application global configuration
│   ├── app.json5               # App config (bundle name, version, etc.)
│   └── resources/              # App-level resources (icons, strings)
├── entry/                       # Main module
│   ├── src/
│   │   ├── main/
│   │   │   ├── ets/            # ArkTS source code
│   │   │   │   ├── entryability/      # Application entry
│   │   │   │   ├── entrybackupability/ # Backup ability
│   │   │   │   ├── model/             # Data models
│   │   │   │   └── pages/             # Page components
│   │   │   ├── module.json5   # Module configuration
│   │   │   └── resources/     # Module resources
│   │   ├── ohosTest/          # Test code
│   │   └── test/              # Unit tests
│   ├── build-profile.json5    # Module build configuration
│   └── oh-package.json5       # Module dependencies
├── build-profile.json5         # Application build configuration
├── oh-package.json5           # Project dependencies
├── hvigor/                    # Build tool configuration
├── .gitignore                 # Git ignore rules
├── README.md                  # Project documentation (this file)
└── SIGNING_CONFIG.md          # Signing configuration guide
```

## Usage

### Basic Operations

| Operation | Description |
|-----------|-------------|
| Tap screen | Show/hide control panel |
| Start/Stop button | Start/pause color cycling |
| Reset button | Reset all settings to default |

### Control Panel Features

- **Frequency Adjustment**: Drag slider to set color switching interval (0.1-10 seconds)
- **Brightness Adjustment**: Drag slider to set display brightness (0-100%)
- **Cycling Direction**: Toggle forward/reverse cycling
- **Color Toggle**: Tap color item to enable/disable that color
- **Drag Reordering**: Long press and drag color item to adjust cycling sequence

## Tech Stack

- **Language**: ArkTS (TypeScript extension)
- **Framework**: ArkUI (Declarative UI)
- **Build Tool**: Hvigor
- **Target Platform**: HarmonyOS Next

## FAQ

### Q: Install Failed: error: failed to install bundle. code:9568332 error: install sign info inconsistent?

A: This error occurs when an app with the same bundle name is already installed on the device with a different signature.

**Solution**: Uninstall the existing app first:

```bash
# Method 1: HDC command
hdc shell bm uninstall -n com.qjy.oneapplication

# Method 2: On device - long press app icon and select Uninstall
```

After uninstalling, run the project again. See [SIGNING_CONFIG.md](./SIGNING_CONFIG.md) for more details.

### Q: Signing error when running?

A: Please follow the [Configure Signing](#3-configure-signing-required) steps and try again.

### Q: Device not found?

A: 
1. Ensure Developer Mode and USB Debugging are enabled on the device
2. Check USB cable connection
3. Try running `hdc list targets` in terminal to check device connection

### Q: Project sync failed?

A:
1. Check network connection
2. Try clearing cache: `File` → `Invalidate Caches / Restart`
3. Ensure DevEco Studio version meets requirements

### Q: Compilation error?

A:
1. Check if SDK version is API 12 (6.0.2) or higher
2. Try re-syncing project dependencies
3. Check for syntax errors in code

## Author

- **Developer**: qjy-liveforover
- **Repository**: [GitHub](https://github.com/qjy-liveforover/ColorCycling_HOS)

## License

This project is for learning and research purposes only.

---

If this project helps you, please consider giving it a ⭐ Star!
