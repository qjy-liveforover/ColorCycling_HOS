# 签名配置说明

本项目已移除签名配置信息以保护隐私。在运行项目前，您需要配置自己的签名。

## 配置步骤

### 方法一：自动签名（推荐）

1. 使用 DevEco Studio 打开项目
2. 点击菜单 `File` → `Project Structure` → `Project` → `Signing Configs`
3. 勾选 `Automatically generate signature`
4. 点击 `OK` 保存
5. DevEco Studio 会自动生成签名并更新 `build-profile.json5`

### 方法二：手动签名

如果您已有签名证书，请按以下步骤配置：

1. 打开 `build-profile.json5` 文件
2. 找到 `signingConfigs` 部分
3. 填写以下信息：

```json5
{
  "app": {
    "signingConfigs": [
      {
        "name": "default",
        "type": "HarmonyOS",
        "material": {
          "certpath": "您的证书路径(.cer)",
          "keyAlias": "密钥别名",
          "keyPassword": "密钥密码",
          "profile": "配置文件路径(.p7b)",
          "signAlg": "SHA256withECDSA",
          "storeFile": "密钥库文件路径(.p12)",
          "storePassword": "密钥库密码"
        }
      }
    ]
  }
}
```

## 注意事项

- 签名文件（.p12, .cer, .p7b）包含敏感信息，请勿上传到公开仓库
- 自动生成的签名文件通常位于 `C:\Users\{用户名}\.ohos\config\` 目录
- 如果只是本地调试，推荐使用自动签名方式
