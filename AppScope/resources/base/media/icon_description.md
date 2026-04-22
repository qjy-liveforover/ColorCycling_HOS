# 图标要求

## 应用名称：ColcorCyclingHOS

## 图标设计建议：

### 背景图标 (background.png)
- 尺寸：192x192像素
- 建议设计：圆形渐变背景，使用彩虹色渐变
- 颜色：从红色到紫色的彩虹渐变
- 透明度：不透明

### 前景图标 (foreground.png)
- 尺寸：192x192像素
- 建议设计：循环箭头符号，表示颜色循环
- 颜色：白色或浅色
- 透明度：可以透明背景

### 图标设计示例：
1. 背景：彩虹色圆形渐变
2. 前景：白色循环箭头（↻）或颜色轮盘

## 如何创建图标：
1. 使用图像编辑软件（如Photoshop、GIMP等）创建192x192像素的PNG文件
2. 保存为：
   - background.png（背景）
   - foreground.png（前景）
3. 将文件放置在：AppScope/resources/base/media/ 目录下

## 当前图标配置：
- 应用使用分层图标（layered_image）
- 背景：$media:background
- 前景：$media:foreground
- 配置文件：layered_image.json

## 临时解决方案：
如果无法创建图标，可以使用以下方法：
1. 使用简单的纯色图标
2. 使用文字图标（如"CC"表示Color Cycling）
3. 使用系统默认图标