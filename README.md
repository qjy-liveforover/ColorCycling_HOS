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

## 📖 目录

- [✨ 特性](#-特性)
- [📋 环境要求](#-环境要求)
- [🚀 快速开始](#-快速开始)
- [📁 项目结构](#-项目结构)
- [🎯 使用指南](#-使用指南)
- [🛠️ 技术栈](#️-技术栈)
- [❓ 常见问题](#-常见问题)
- [🤝 贡献](#-贡献)
- [👤 作者](#-作者)
- [📄 许可证](#-许可证)

---

## ✨ 特性

<table>
<tr>
<td width="50%">

### 🎨 核心功能
- **8种纯色光循环**：白、红、橙、黄、绿、青、蓝、紫
- **可调节频率**：0.1-10秒色切换间隔
- **亮度控制**：0-100%亮度调节
- **正/反向循环**：支持两种循环方向

</td>
<td width="50%">

### 🌟 交互体验
- **全屏显示**：沉浸式全屏体验
- **拖拽排序**：自定义颜色循环顺序
- **控制面板**：便捷的参数调整界面
- **状态栏隐藏**：纯净的显示效果

</td>
</tr>
</table>

---

## 📋 环境要求

| 项目 | 版本要求 | 备注 |
|:-----|:---------|:-----|
| **DevEco Studio** | 5.0.0+ | 推荐使用最新版本 |
| **HarmonyOS SDK** | API 12 (6.0.2)+ | 需要通过DevEco Studio下载 |
| **目标设备** | HarmonyOS 手机 | 支持真机调试 |

---

## 🚀 快速开始

### 1️⃣ 克隆仓库

```bash
git clone https://github.com/qjy-liveforover/ColorCycling_HOS.git
cd ColorCycling_HOS
```

### 2️⃣ 打开项目

1. 启动 **DevEco Studio**
2. 点击 `File` → `Open`
3. 选择克隆的项目目录
4. 等待项目同步完成（依赖会自动下载）

### 3️⃣ 配置签名（必需）

> ⚠️ **重要提示**：出于隐私考虑，签名配置已从仓库中移除。运行前必须配置签名！

#### 自动签名（推荐）

<div align="center">

| 步骤 | 操作 |
|:----:|:-----|
| 1 | 点击 `File` → `Project Structure` |
| 2 | 选择 `Project` → `Signing Configs` |
| 3 | 勾选 ✅ `Automatically generate signature` |
| 4 | 点击 `OK` 保存 |

</div>

DevEco Studio 将自动生成调试签名并更新配置。

#### 手动签名

如需使用现有证书，请参考 [SIGNING_CONFIG.md](./SIGNING_CONFIG.md)

### 4️⃣ 连接设备

1. 通过 USB 线连接 HarmonyOS 设备到电脑
2. 在设备上启用开发者模式和 USB 调试
3. 在 DevEco Studio 工具栏中选择已连接的设备

### 5️⃣ 运行应用

点击 DevEco Studio 工具栏中的 ▶️ `Run` 按钮，或使用快捷键 `Shift + F10`

---

## 📁 项目结构

```
ColorCycling_HOS/
├── 📂 AppScope/                    # 应用全局配置
│   ├── 📄 app.json5               # 应用配置（包名、版本等）
│   └── 📂 resources/              # 应用级资源（图标、字符串）
│
├── 📂 entry/                       # 主模块
│   ├── 📂 src/
│   │   ├── 📂 main/
│   │   │   ├── 📂 ets/            # ArkTS 源代码
│   │   │   │   ├── 📂 entryability/      # 应用入口
│   │   │   │   ├── 📂 entrybackupability/ # 备份能力
│   │   │   │   ├── 📂 model/             # 数据模型
│   │   │   │   └── 📂 pages/             # 页面组件
│   │   │   ├── 📄 module.json5   # 模块配置
│   │   │   └── 📂 resources/     # 模块资源
│   │   ├── 📂 ohosTest/          # 测试代码
│   │   └── 📂 test/              # 单元测试
│   ├── 📄 build-profile.json5    # 模块构建配置
│   └── 📄 oh-package.json5       # 模块依赖
│
├── 📄 build-profile.json5         # 应用构建配置
├── 📄 oh-package.json5           # 项目依赖
├── 📂 hvigor/                    # 构建工具配置
├── 📄 .gitignore                 # Git 忽略规则
├── 📄 README.md                  # 项目文档（本文件）
└── 📄 SIGNING_CONFIG.md          # 签名配置指南
```

---

## 🎯 使用指南

### 基本操作

| 操作 | 说明 |
|:-----|:-----|
| 👆 **点击屏幕** | 显示/隐藏控制面板 |
| ▶️ **开始/停止按钮** | 启动/暂停颜色循环 |
| 🔄 **重置按钮** | 重置所有设置为默认值 |

### 控制面板功能

<div align="center">

| 功能 | 说明 |
|:-----|:-----|
| 🎚️ **频率调节** | 拖动滑块设置颜色切换间隔（0.1-10秒） |
| 💡 **亮度调节** | 拖动滑块设置显示亮度（0-100%） |
| 🔄 **循环方向** | 切换正向/反向循环 |
| 🎨 **颜色开关** | 点击颜色项启用/禁用该颜色 |
| ↕️ **拖拽排序** | 长按并拖动颜色项调整循环顺序 |

</div>

---

## 🛠️ 技术栈

<div align="center">

| 技术 | 说明 |
|:-----|:-----|
| **ArkTS** | TypeScript 扩展语言 |
| **ArkUI** | 声明式 UI 框架 |
| **Hvigor** | 构建工具 |
| **HarmonyOS Next** | 目标平台 |

</div>

---

## ❓ 常见问题

<details>
<summary><b>Q: 安装失败：error: failed to install bundle. code:9568332 error: install sign info inconsistent?</b></summary>

<br>

此错误表示设备上已安装相同包名但不同签名的应用。

**解决方案**：先卸载现有应用

```bash
# 方法1：HDC 命令
hdc shell bm uninstall -n com.qjy.oneapplication

# 方法2：在设备上长按应用图标选择卸载
```

卸载后重新运行项目。详见 [SIGNING_CONFIG.md](./SIGNING_CONFIG.md)

</details>

<details>
<summary><b>Q: 运行时出现签名错误？</b></summary>

<br>

请按照 [配置签名](#3️⃣-配置签名必需) 步骤重新配置后重试。

</details>

<details>
<summary><b>Q: 找不到设备？</b></summary>

<br>

1. 确保设备已启用开发者模式和 USB 调试
2. 检查 USB 线缆连接
3. 在终端运行 `hdc list targets` 检查设备连接

</details>

<details>
<summary><b>Q: 项目同步失败？</b></summary>

<br>

1. 检查网络连接
2. 尝试清除缓存：`File` → `Invalidate Caches / Restart`
3. 确保 DevEco Studio 版本符合要求

</details>

<details>
<summary><b>Q: 编译错误？</b></summary>

<br>

1. 检查 SDK 版本是否为 API 12 (6.0.2) 或更高
2. 尝试重新同步项目依赖
3. 检查代码中是否有语法错误

</details>

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

### 贡献步骤

1. 🍴 Fork 本仓库
2. 📥 克隆你的 Fork：`git clone <your-fork-url>`
3. 🌿 创建特性分支：`git checkout -b feature/AmazingFeature`
4. 💾 提交更改：`git commit -m 'Add some AmazingFeature'`
5. 📤 推送到分支：`git push origin feature/AmazingFeature`
6. 🔄 提交 Pull Request

---

## 👤 作者

<div align="center">

| 项目 | 信息 |
|:-----|:-----|
| **开发者** | qjy-liveforover |
| **GitHub** | [![GitHub](https://img.shields.io/badge/GitHub-Profile-blue?style=flat-square&logo=github)](https://github.com/qjy-liveforover) |
| **仓库** | [ColorCycling_HOS](https://github.com/qjy-liveforover/ColorCycling_HOS) |

</div>

---

## 📄 许可证

本项目仅供学习和研究使用。

---

<div align="center">

### 🌟 如果这个项目对你有帮助，请考虑给它一个 Star！

**⭐ Star ⭐**

Made with ❤️ by qjy-liveforover

</div>
