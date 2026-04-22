# ColorCycling_HOS - HarmonyOS 颜色循环应用

一款运行在 HarmonyOS 平台上的颜色循环展示应用，支持全屏显示纯色光循环效果，可用于屏幕测试、氛围灯模拟等场景。

## 功能特性

- 🎨 **8种纯色光循环**：白光、红、橙、黄、绿、青、蓝、紫
- ⏱️ **可调节频率**：支持 0.1-10 秒的颜色切换间隔
- 🌟 **亮度调节**：支持 0-100% 的亮度控制
- 🔄 **正/反循环**：支持正向和反向两种循环顺序
- 📱 **全屏显示**：沉浸式全屏体验，隐藏状态栏
- ✋ **拖拽排序**：支持自定义颜色循环顺序
- 🎛️ **控制面板**：便捷的参数调节界面

## 环境要求

| 项目 | 版本要求 |
|------|----------|
| DevEco Studio | 5.0.0 或更高版本 |
| HarmonyOS SDK | API 12 (6.0.2) 或更高版本 |
| 目标设备 | HarmonyOS 手机设备 |

## 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/qjy-liveforover/ColorCycling_HOS.git
cd ColorCycling_HOS
```

### 2. 打开项目

1. 启动 **DevEco Studio**
2. 点击 `File` → `Open`
3. 选择克隆下来的项目目录
4. 等待项目同步完成（首次打开会自动下载依赖）

### 3. 配置签名（必须）

> ⚠️ **重要**：项目已移除签名配置，运行前必须配置签名！

#### 自动签名（推荐）

1. 点击菜单 `File` → `Project Structure`
2. 选择 `Project` → `Signing Configs`
3. 勾选 ✅ `Automatically generate signature`
4. 点击 `OK` 保存

DevEco Studio 会自动生成调试签名并更新配置文件。

#### 手动签名

如需使用已有证书，请参考 [SIGNING_CONFIG.md](./SIGNING_CONFIG.md)

### 4. 连接设备

1. 使用 USB 数据线连接 HarmonyOS 设备到电脑
2. 在设备上开启开发者模式和 USB 调试
3. 在 DevEco Studio 顶部工具栏选择已连接的设备

### 5. 运行应用

点击 DevEco Studio 顶部的 ▶️ `Run` 按钮，或使用快捷键 `Shift + F10`

## 项目结构

```
ColorCycling_HOS/
├── AppScope/                    # 应用全局配置
│   ├── app.json5               # 应用配置（包名、版本等）
│   └── resources/              # 应用级资源（图标、字符串）
├── entry/                       # 主模块
│   ├── src/
│   │   ├── main/
│   │   │   ├── ets/            # ArkTS 源代码
│   │   │   │   ├── entryability/      # 应用入口
│   │   │   │   ├── entrybackupability/ # 备份能力
│   │   │   │   ├── model/             # 数据模型
│   │   │   │   └── pages/             # 页面组件
│   │   │   ├── module.json5   # 模块配置
│   │   │   └── resources/     # 模块资源
│   │   ├── ohosTest/          # 测试代码
│   │   └── test/              # 单元测试
│   ├── build-profile.json5    # 模块构建配置
│   └── oh-package.json5       # 模块依赖配置
├── build-profile.json5         # 应用构建配置
├── oh-package.json5           # 项目依赖配置
├── hvigor/                    # 构建工具配置
├── .gitignore                 # Git 忽略规则
├── README.md                  # 项目说明（本文件）
└── SIGNING_CONFIG.md          # 签名配置详细说明
```

## 使用说明

### 基本操作

| 操作 | 说明 |
|------|------|
| 点击屏幕 | 显示/隐藏控制面板 |
| Start/Stop 按钮 | 开始/暂停颜色循环 |
| Reset 按钮 | 重置所有设置到默认值 |

### 控制面板功能

- **频率调节**：拖动滑块设置颜色切换间隔（0.1-10秒）
- **亮度调节**：拖动滑块设置显示亮度（0-100%）
- **循环方向**：切换正向/反向循环
- **颜色开关**：点击颜色项启用/禁用该颜色
- **拖拽排序**：长按并拖动颜色项调整循环顺序

## 技术栈

- **语言**：ArkTS (TypeScript 扩展)
- **框架**：ArkUI (声明式 UI)
- **构建工具**：Hvigor
- **目标平台**：HarmonyOS Next

## 常见问题

### Q: 运行时提示签名错误？

A: 请按照 [配置签名](#3-配置签名必须) 步骤配置签名后重试。

### Q: 找不到设备？

A: 
1. 确保设备已开启开发者模式和 USB 调试
2. 检查 USB 数据线连接是否正常
3. 尝试在终端执行 `hdc list targets` 检查设备连接

### Q: 项目同步失败？

A:
1. 检查网络连接是否正常
2. 尝试清理缓存：`File` → `Invalidate Caches / Restart`
3. 确保 DevEco Studio 版本满足要求

### Q: 编译报错？

A:
1. 检查 SDK 版本是否为 API 12 (6.0.2) 或更高
2. 尝试重新同步项目依赖
3. 检查代码是否有语法错误

## 开发者信息

- **作者**：qjy-liveforover
- **仓库**：[GitHub](https://github.com/qjy-liveforover/ColorCycling_HOS)

## 许可证

本项目仅供学习和研究使用。

---

如果这个项目对您有帮助，欢迎 ⭐ Star 支持！
