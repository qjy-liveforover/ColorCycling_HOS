# Signing Configuration Guide

This project has removed signing configuration to protect privacy. You **MUST** configure your own signing before running the project.

## ⚠️ Common Error: Install Failed (code:9568332)

If you see this error:
```
Install Failed: error: failed to install bundle.
code:9568332
error: install sign info inconsistent.
```

**Cause**: The app with the same bundle name is already installed on the device with a different signature.

**Solution**: Uninstall the existing app first, then reinstall:

### Method 1: Uninstall via DevEco Studio
1. In DevEco Studio, right-click the connected device
2. Select `Uninstall Application`
3. Or use the terminal command below

### Method 2: Uninstall via HDC Command
```bash
hdc shell bm uninstall -n com.qjy.oneapplication
```

### Method 3: Uninstall on Device
1. Long press the app icon on the device
2. Select `Uninstall`
3. Confirm the uninstallation

After uninstalling, run the project again.

---

## Configuration Steps

### Method 1: Automatic Signing (Recommended)

1. Open project in **DevEco Studio**
2. Click `File` → `Project Structure` → `Project` → `Signing Configs`
3. Check ✅ `Automatically generate signature`
4. Click `OK` to save
5. DevEco Studio will automatically generate signing and update `build-profile.json5`

### Method 2: Manual Signing

If you have existing signing certificates, follow these steps:

1. Open `build-profile.json5` file
2. Find the `signingConfigs` section
3. Fill in the following information:

```json5
{
  "app": {
    "signingConfigs": [
      {
        "name": "default",
        "type": "HarmonyOS",
        "material": {
          "certpath": "your_certificate_path.cer",
          "keyAlias": "your_key_alias",
          "keyPassword": "your_key_password",
          "profile": "your_profile_path.p7b",
          "signAlg": "SHA256withECDSA",
          "storeFile": "your_keystore_path.p12",
          "storePassword": "your_keystore_password"
        }
      }
    ]
  }
}
```

## Important Notes

- **Never upload** signing files (.p12, .cer, .p7b) to public repositories
- Auto-generated signing files are typically located at `C:\Users\{username}\.ohos\config\`
- For local debugging, automatic signing is recommended
- Each developer must configure their own signing - do not share signing files

## Troubleshooting

### Error: "sign info inconsistent"
- **Cause**: App with same bundle name exists on device with different signature
- **Solution**: Uninstall existing app first, then reinstall

### Error: "signing config not found"
- **Cause**: Signing not configured
- **Solution**: Follow automatic signing steps above

### Error: "certificate expired"
- **Cause**: Debug certificate expired (valid for 1 year)
- **Solution**: Delete old certificate and regenerate via automatic signing

### Error: "bundle name already exists"
- **Cause**: Different app with same bundle name installed
- **Solution**: Uninstall the conflicting app or change bundle name in `app.json5`

## Quick Fix Commands

```bash
# Uninstall app from device
hdc shell bm uninstall -n com.qjy.oneapplication

# Check if app is installed
hdc shell bm dump -n com.qjy.oneapplication

# List all installed packages
hdc shell bm dump -a
```
