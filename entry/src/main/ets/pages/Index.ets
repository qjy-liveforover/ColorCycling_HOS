import window from '@ohos.window';

@Entry
@Component
struct Index {
  // 颜色定义 - 最纯的纯色光 (RGB最大值)
  // 正循环顺序：白光 → 红 → 橙 → 黄 → 绿 → 青 → 蓝 → 紫
  // 反循环顺序：紫 → 蓝 → 青 → 绿 → 黄 → 橙 → 红 → 白光
  private readonly pureColors: ColorItem[] = [
    { id: 0, name: 'White', color: '#FFFFFF', enabled: true } as ColorItem,      // 复色白光 (R:255, G:255, B:255)
    { id: 1, name: 'Red', color: '#FF0000', enabled: true } as ColorItem,        // 最纯红色 (R:255, G:0, B:0)
    { id: 2, name: 'Orange', color: '#FF8000', enabled: true } as ColorItem,     // 最纯橙色 (R:255, G:128, B:0)
    { id: 3, name: 'Yellow', color: '#FFFF00', enabled: true } as ColorItem,     // 最纯黄色 (R:255, G:255, B:0)
    { id: 4, name: 'Green', color: '#00FF00', enabled: true } as ColorItem,      // 最纯绿色 (R:0, G:255, B:0)
    { id: 5, name: 'Cyan', color: '#00FFFF', enabled: true } as ColorItem,       // 最纯青色 (R:0, G:255, B:255)
    { id: 6, name: 'Blue', color: '#0000FF', enabled: true } as ColorItem,       // 最纯蓝色 (R:0, G:0, B:255)
    { id: 7, name: 'Purple', color: '#FF00FF', enabled: true } as ColorItem      // 最纯紫色 (R:255, G:0, B:255)
  ];

  // 状态管理
  @State currentColorIndex: number = 0;
  @State isPlaying: boolean = true;
  @State showControlPanel: boolean = false;
  @State colors: ColorItem[] = [];
  @State frequency: number = 1.0; // 秒
  @State colorBrightness: number = 1.0; // 0.0 - 1.0
  @State isNormalOrder: boolean = true;
  @State isSliderInitialized: boolean = false;  // 防止Slider初始化时触发onChange

  // 拖拽排序相关状态
  @State dragOffsetY: number = 0;
  @State dragFromIndex: number = -1;
  @State dragToIndex: number = -1;  // 拖拽目标位置指示
  private itemHeight: number = 80; // 每个列表项高度

  // 定时器
  private timerId: number = -1;
  private isTimerActive: boolean = false;  // 定时器是否活跃的标志
  
  // Mate 70 Pro+ 最大亮度设置 (使用屏幕最大亮度)
  private readonly MAX_COLOR_BRIGHTNESS: number = 1.0;
  
  // 根据亮度值调整颜色
  getAdjustedColor(hexColor: string, brightness: number): string {
    // 将十六进制颜色转换为RGB
    const r = parseInt(hexColor.slice(1, 3), 16);
    const g = parseInt(hexColor.slice(3, 5), 16);
    const b = parseInt(hexColor.slice(5, 7), 16);
    
    // 应用亮度调整
    const adjustedR = Math.min(255, Math.round(r * brightness));
    const adjustedG = Math.min(255, Math.round(g * brightness));
    const adjustedB = Math.min(255, Math.round(b * brightness));
    
    // 转换回十六进制
    return `#${adjustedR.toString(16).padStart(2, '0')}${adjustedG.toString(16).padStart(2, '0')}${adjustedB.toString(16).padStart(2, '0')}`;
  }

  // 设置屏幕亮度
  async setScreenBrightness(brightness: number) {
    try {
      // 获取当前窗口并设置亮度
      window.getLastWindow(getContext(this)).then((win: window.Window) => {
        win.setWindowBrightness(brightness);
      }).catch(() => {});
    } catch (error) {
      // 忽略错误
    }
  }

  // 设置全屏显示
  async setFullScreen() {
    try {
      window.getLastWindow(getContext(this)).then((win: window.Window) => {
        // 隐藏状态栏和导航栏
        win.setWindowSystemBarEnable([]);
        // 设置全屏布局
        win.setWindowLayoutFullScreen(true);
        console.log('Set window to full screen');
      }).catch((error: Error) => {
        console.error(`Failed to set full screen: ${error.message}`);
      });
    } catch (error) {
      console.error(`Failed to set full screen: ${JSON.stringify(error)}`);
    }
  }

  aboutToAppear() {
    // 初始化颜色数组
    this.colors = this.pureColors.slice();
    // 设置初始屏幕亮度
    this.setScreenBrightness(this.colorBrightness);
    // 设置窗口全屏
    this.setFullScreen();
    // 启动时默认Start状态（按钮显示Start，程序正在播放）
    this.isPlaying = true;
    this.startColorCycle();
    // 延迟设置初始化标志，避免Slider初始化时触发onChange
    setTimeout(() => {
      this.isSliderInitialized = true;
    }, 100);
  }

  aboutToDisappear() {
    this.stopColorCycle();
  }

  // 开始颜色循环 - 使用setTimeout递归确保稳定的定时
  startColorCycle() {
    // 先停止现有的定时器
    this.stopColorCycle();
    
    this.isTimerActive = true;
    
    const scheduleNextColor = () => {
      if (!this.isTimerActive) {
        return;
      }
      
      // 使用setTimeout而不是setInterval，确保每个颜色显示准确的时间
      this.timerId = setTimeout(() => {
        if (!this.isTimerActive) {
          return;
        }
        
        // 切换到下一个颜色
        this.nextColor();
        
        // 递归调用自己，实现循环
        scheduleNextColor();
      }, this.frequency * 1000);
    };
    
    // 立即开始第一个定时
    scheduleNextColor();
  }

  // 停止颜色循环
  stopColorCycle() {
    // 先标记为不活跃，防止回调继续执行
    this.isTimerActive = false;
    if (this.timerId > 0) {
      clearTimeout(this.timerId);
      this.timerId = -1;
    }
  }

  // 切换到下一个颜色
  nextColor() {
    if (this.colors.length === 0) return;
    
    let nextIndex = this.currentColorIndex;
    let attempts = 0;
    
    do {
      nextIndex = this.isNormalOrder ? 
        (nextIndex + 1) % this.colors.length : 
        (nextIndex - 1 + this.colors.length) % this.colors.length;
      attempts++;
      
      if (attempts > this.colors.length) {
        // 没有启用的颜色
        return;
      }
    } while (!this.colors[nextIndex].enabled);
    
    this.currentColorIndex = nextIndex;
  }

  // 获取当前颜色（应用亮度调整）
  getCurrentColor(): string {
    if (this.colors.length === 0 || this.currentColorIndex >= this.colors.length) {
      return '#FF00FF'; // 默认紫色
    }
    return this.getAdjustedColor(this.colors[this.currentColorIndex].color, this.colorBrightness);
  }

  // 开始播放
  startPlay() {
    if (!this.isPlaying) {
      this.isPlaying = true;
      this.startColorCycle();
    }
  }

  // 停止播放
  stopPlay() {
    if (this.isPlaying) {
      this.isPlaying = false;
      this.stopColorCycle();
    }
  }

  // 切换播放/暂停状态
  togglePlay() {
    if (this.isPlaying) {
      // 当前正在播放，点击后停止循环
      this.isPlaying = false;
      this.stopColorCycle();  // 停止循环，颜色保持不动
    } else {
      // 当前已停止，点击后继续循环
      this.isPlaying = true;
      this.startColorCycle();  // 从停止位置继续循环
    }
  }

  // 从头开始播放
  restartPlay() {
    // 重置到第一个启用的颜色
    this.currentColorIndex = 0;
    // 找到第一个启用的颜色
    for (let i = 0; i < this.colors.length; i++) {
      if (this.colors[i].enabled) {
        this.currentColorIndex = i;
        break;
      }
    }
    // 确保正在播放
    if (!this.isPlaying) {
      this.isPlaying = true;
    }
    this.startColorCycle();
  }

  // 一键全亮 - 开启所有颜色
  toggleAllColors() {
    // 创建全新数组，确保每个对象都是新创建的
    const newColors: ColorItem[] = [];
    for (let i = 0; i < this.colors.length; i++) {
      newColors.push({
        id: this.colors[i].id,
        name: this.colors[i].name,
        color: this.colors[i].color,
        enabled: true  // 所有颜色都亮
      } as ColorItem);
    }
    this.colors = newColors;
  }

  // 恢复正循环顺序
  restoreNormalOrder() {
    this.colors = this.pureColors.slice();
    this.isNormalOrder = true;
    this.currentColorIndex = 0;
    // 确保所有颜色开关都打开
    this.toggleAllColors();
  }

  // 恢复反循环顺序
  restoreReverseOrder() {
    // 反转数组：Purple → Blue → ... → White，从第一个开始正向遍历
    this.colors = this.pureColors.slice().reverse();
    this.isNormalOrder = true;  // 保持正向遍历
    this.currentColorIndex = 0;  // 从第一个（Purple）开始
    // 确保所有颜色开关都打开
    this.toggleAllColors();
  }

  // 设置单个颜色开关状态
  setColorEnabled(index: number, enabled: boolean) {
    // 创建新数组以触发UI更新
    this.colors = this.colors.map((item, i) => {
      return {
        id: item.id,
        name: item.name,
        color: item.color,
        enabled: i === index ? enabled : item.enabled
      } as ColorItem;
    });
  }

  // 切换单个颜色开关
  toggleColor(index: number) {
    // 创建新数组以触发UI更新
    this.colors = this.colors.map((item, i) => {
      return {
        id: item.id,
        name: item.name,
        color: item.color,
        enabled: i === index ? !item.enabled : item.enabled
      } as ColorItem;
    });
  }

  // 移动颜色项
  moveColor(fromIndex: number, toIndex: number) {
    if (fromIndex === toIndex) return;
    
    const draggedItem = this.colors[fromIndex];
    const newColors: ColorItem[] = [];
    
    // 复制数组
    for (let i = 0; i < this.colors.length; i++) {
      newColors.push({
        id: this.colors[i].id,
        name: this.colors[i].name,
        color: this.colors[i].color,
        enabled: this.colors[i].enabled
      } as ColorItem);
    }
    
    // 移除拖拽项
    newColors.splice(fromIndex, 1);
    
    // 插入到目标位置
    newColors.splice(toIndex, 0, draggedItem);
    
    this.colors = newColors;
    
    // 更新当前颜色索引
    if (this.currentColorIndex === fromIndex) {
      this.currentColorIndex = toIndex;
    } else if (this.currentColorIndex > fromIndex && this.currentColorIndex <= toIndex) {
      this.currentColorIndex--;
    } else if (this.currentColorIndex < fromIndex && this.currentColorIndex >= toIndex) {
      this.currentColorIndex++;
    }
  }

  // 向上移动颜色项
  moveColorUp(index: number) {
    if (index > 0) {
      this.moveColor(index, index - 1);
    }
  }

  // 向下移动颜色项
  moveColorDown(index: number) {
    if (index < this.colors.length - 1) {
      this.moveColor(index, index + 1);
    }
  }

  // 频率变化处理
  onFrequencyChange(value: number) {
    // 忽略初始化前的触发
    if (!this.isSliderInitialized) {
      return;
    }
    this.frequency = value;
    // 只有在播放状态且定时器正在运行时才重启
    if (this.isPlaying && this.timerId > 0) {
      this.startColorCycle();
    }
  }

  // 亮度变化处理
  onBrightnessChange(value: number) {
    // 忽略初始化前的触发
    if (!this.isSliderInitialized) {
      return;
    }
    this.colorBrightness = value;
    // 设置屏幕亮度
    this.setScreenBrightness(value);
  }

  build() {
    Stack() {
      // 颜色背景（可点击显示控制面板）
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.getCurrentColor())
        .onClick(() => {
          // 点击全屏区域显示控制面板
          this.showControlPanel = true;
        })
      

      
      // 控制面板（从底部滑入，顶部留出极小缝隙显示颜色）
      if (this.showControlPanel) {
        Column() {
          // 顶部预留极小缝隙，用于显示当前颜色
          Column()
            .width('100%')
            .height('5%') // 顶部5%的空间用于显示颜色（进一步减少透明区域）
            .backgroundColor(this.getCurrentColor())
            .onClick(() => {
              // 点击顶部区域隐藏控制面板
              this.showControlPanel = false;
            })
          
          // 控制面板内容
          Stack() {
            this.ControlPanel()
          }
          .width('100%')
          .height('95%') // 控制面板占据95%的高度（最大化显示区域）
        }
        .position({ x: 0, y: 0 })
        .width('100%')
        .height('100%')
        .onAppear(() => {
          // 控制面板显示后，允许Slider触发onChange
          if (!this.isSliderInitialized) {
            setTimeout(() => {
              this.isSliderInitialized = true;
            }, 200);
          }
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Transparent)
  }

  @Builder
  ControlPanel() {
    Column() {
      // 标题栏
      Row() {
        Text('ColcorCyclingHOS')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .layoutWeight(1)

        Button('✕ Hide Panel')
          .width(120)
          .height(36)
          .backgroundColor('#FF5722')
          .fontColor('#FFFFFF')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(18)
          .onClick(() => {
            this.showControlPanel = false;
          })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor('rgba(26, 26, 26, 0.85)') // 增加透明度，从0.95改为0.85

      // 控制区域
      Scroll() {
        Column() {
          // 控制按钮 - 使用FlexWrap确保所有按钮完全显示
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
            // Start/Stop切换按钮
            Button(this.isPlaying ? '⏹ Stop' : '▶ Start')
              .width(100)
              .height(44)
              .backgroundColor(this.isPlaying ? '#FF5722' : '#4CAF50')
              .fontColor('#FFFFFF')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .borderRadius(10)
              .margin({ right: 8, bottom: 8 })
              .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.3)', offsetX: 0, offsetY: 2 })
              .onClick(() => this.togglePlay())

            // Restart按钮 - 从头开始循环
            Button('🔄 Restart')
              .width(110)
              .height(44)
              .backgroundColor('#9C27B0')
              .fontColor('#FFFFFF')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .borderRadius(10)
              .margin({ right: 8, bottom: 8 })
              .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.3)', offsetX: 0, offsetY: 2 })
              .onClick(() => this.restartPlay())

            // All On按钮
            Button('All On')
              .width(90)
              .height(44)
              .backgroundColor('#2196F3')
              .fontColor('#FFFFFF')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .borderRadius(10)
              .margin({ right: 8, bottom: 8 })
              .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.3)', offsetX: 0, offsetY: 2 })
              .onClick(() => this.toggleAllColors())

            // Normal按钮
            Button('Normal')
              .width(90)
              .height(44)
              .backgroundColor('#9C27B0')
              .fontColor('#FFFFFF')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .borderRadius(10)
              .margin({ right: 8, bottom: 8 })
              .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.3)', offsetX: 0, offsetY: 2 })
              .onClick(() => this.restoreNormalOrder())

            // Reverse按钮
            Button('Reverse')
              .width(90)
              .height(44)
              .backgroundColor('#FF9800')
              .fontColor('#FFFFFF')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .borderRadius(10)
              .margin({ bottom: 8 })
              .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.3)', offsetX: 0, offsetY: 2 })
              .onClick(() => this.restoreReverseOrder())
          }
          .width('100%')
          .padding({ top: 20, bottom: 20 })

          // 频率控制
          Column() {
            Row() {
              Text('Speed')
                .fontSize(18)
                .fontColor('#FFFFFF')
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)

              Text(`${this.frequency.toFixed(1)}s`)
                .fontSize(16)
                .fontColor('#4CAF50')
                .fontWeight(FontWeight.Bold)
            }
            .width('100%')
            .padding({ bottom: 12 })

            Slider({
              value: this.frequency,
              min: 0.1,
              max: 4.0,
              step: 0.1,
              style: SliderStyle.OutSet
            })
            .width('95%')
            .height(40)
            .trackColor('#333333')
            .selectedColor('#4CAF50')
            .blockColor('#FFFFFF')
            .blockSize({ width: 28, height: 28 })
            .showSteps(true)
            .showTips(true)
            .onChange((value: number) => {
              this.onFrequencyChange(value);
            })
          }
          .width('100%')
          .padding({ left: 24, right: 24, bottom: 24 })
          .backgroundColor('rgba(255, 255, 255, 0.05)')
          .borderRadius(12)
          .margin({ left: 16, right: 16, bottom: 16 })

          // 亮度控制
          Column() {
            Row() {
              Text('Brightness')
                .fontSize(18)
                .fontColor('#FFFFFF')
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)

              Text(`${Math.round(this.colorBrightness * 100)}%`)
                .fontSize(16)
                .fontColor('#FF9800')
                .fontWeight(FontWeight.Bold)
            }
            .width('100%')
            .padding({ bottom: 12 })

            Slider({
              value: this.colorBrightness,
              min: 0.1,
              max: this.MAX_COLOR_BRIGHTNESS,
              step: 0.05,
              style: SliderStyle.OutSet
            })
            .width('95%')
            .height(40)
            .trackColor('#333333')
            .selectedColor('#FF9800')
            .blockColor('#FFFFFF')
            .blockSize({ width: 28, height: 28 })
            .showSteps(true)
            .showTips(true)
            .onChange((value: number) => {
              this.onBrightnessChange(value);
            })
          }
          .width('100%')
          .padding({ left: 24, right: 24, bottom: 24 })
          .backgroundColor('rgba(255, 255, 255, 0.05)')
          .borderRadius(12)
          .margin({ left: 16, right: 16, bottom: 16 })

          // 亮度测试按钮
          Row() {
            Button('Test Max Brightness')
              .width('70%')
              .height(52)
              .fontSize(16)
              .fontColor('#FFFFFF')
              .fontWeight(FontWeight.Bold)
              .backgroundColor('#FF5722')
              .borderRadius(26)
              .shadow({ radius: 6, color: 'rgba(0, 0, 0, 0.3)', offsetX: 0, offsetY: 3 })
              .onClick(() => {
                // 测试最大亮度
                this.setScreenBrightness(1.0);
                this.colorBrightness = 1.0;
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ bottom: 16 })

          // 颜色顺序标题
          Text('Color Sequence')
            .fontSize(18)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Bold)
            .margin({ top: 10, bottom: 10 })

          // 颜色顺序列表（可拖拽）- 使用List组件支持拖拽排序
          List({ space: 8 }) {
            ForEach(this.colors, (color: ColorItem, index: number) => {
              ListItem() {
                Column() {
                  // 拖拽目标位置指示线（在目标位置上方显示）
                  if (this.dragFromIndex >= 0 && this.dragToIndex === index && this.dragToIndex !== this.dragFromIndex) {
                    Row()
                      .width('100%')
                      .height(4)
                      .backgroundColor('#FF9800')
                      .borderRadius(2)
                      .margin({ bottom: 4 })
                  }
                  
                  this.ColorItemRow(color, index)
                  
                  // 拖拽目标位置指示线（在列表末尾显示）
                  if (this.dragFromIndex >= 0 && this.dragToIndex === index && 
                      this.dragToIndex !== this.dragFromIndex && 
                      this.dragToIndex > this.dragFromIndex) {
                    Row()
                      .width('100%')
                      .height(4)
                      .backgroundColor('#FF9800')
                      .borderRadius(2)
                      .margin({ top: 4 })
                  }
                }
                .width('100%')
              }
            }, (color: ColorItem) => color.id.toString())
            .onMove((from: number, to: number) => {
              // 拖拽排序：直接修改数据源
              let tmp = this.colors.splice(from, 1);
              this.colors.splice(to, 0, tmp[0]);
            })
          }
          .width('100%')
          .height(520)
          .padding({ left: 12, right: 12 })
          .nestedScroll({
            scrollForward: NestedScrollMode.SELF_FIRST,   // 向下：内层优先，到底后传给外层
            scrollBackward: NestedScrollMode.SELF_FIRST   // 向上：内层优先，到顶后传给外层
          })
          
          // 使用说明 - 优化对齐
          Column() {
            Text('How to Use:')
              .fontSize(16)
              .fontColor('#4CAF50')
              .fontWeight(FontWeight.Bold)
              .margin({ top: 20, bottom: 8 })
              .textAlign(TextAlign.Start)
              .width('100%')
            
            Text('• Tap screen to show/hide panel')
              .fontSize(13)
              .fontColor('#CCCCCC')
              .margin({ bottom: 3 })
              .textAlign(TextAlign.Start)
              .width('100%')
            
            Text('• Start/Stop: toggle color cycling')
              .fontSize(13)
              .fontColor('#CCCCCC')
              .margin({ bottom: 3 })
              .textAlign(TextAlign.Start)
              .width('100%')
            
            Text('• Restart: restart from first color')
              .fontSize(13)
              .fontColor('#CCCCCC')
              .margin({ bottom: 3 })
              .textAlign(TextAlign.Start)
              .width('100%')
            
            Text('• All On: enable all colors')
              .fontSize(13)
              .fontColor('#CCCCCC')
              .margin({ bottom: 3 })
              .textAlign(TextAlign.Start)
              .width('100%')
            
            Text('• Normal/Reverse: set cycling direction')
              .fontSize(13)
              .fontColor('#CCCCCC')
              .margin({ bottom: 3 })
              .textAlign(TextAlign.Start)
              .width('100%')
            
            Text('• Drag ⋮⋮ to reorder color sequence')
              .fontSize(13)
              .fontColor('#CCCCCC')
              .margin({ bottom: 3 })
              .textAlign(TextAlign.Start)
              .width('100%')
            
            Text('• Toggle switch to skip/exclude color')
              .fontSize(13)
              .fontColor('#CCCCCC')
              .margin({ bottom: 3 })
              .textAlign(TextAlign.Start)
              .width('100%')
            
            Text('• Click color to jump immediately')
              .fontSize(13)
              .fontColor('#CCCCCC')
              .margin({ bottom: 3 })
              .textAlign(TextAlign.Start)
              .width('100%')
            
            Text('• Speed: color change interval (0.1-4s)')
              .fontSize(13)
              .fontColor('#CCCCCC')
              .margin({ bottom: 3 })
              .textAlign(TextAlign.Start)
              .width('100%')
            
            Text('• Brightness: screen brightness level')
              .fontSize(13)
              .fontColor('#CCCCCC')
              .margin({ bottom: 3 })
              .textAlign(TextAlign.Start)
              .width('100%')
            
            Text('• Test Max Brightness: for Mate 70 Pro+')
              .fontSize(13)
              .fontColor('#FF9800')
              .margin({ bottom: 3 })
              .textAlign(TextAlign.Start)
              .width('100%')
          }
          .width('100%')
          .padding({ left: 20, right: 20, bottom: 24 })
          .backgroundColor('rgba(255, 255, 255, 0.05)')
          .borderRadius(12)
          .margin({ top: 10, bottom: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
      }
      .width('100%')
      .height('95%')
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
    }
    .width('100%')
    .backgroundColor('rgba(30, 30, 30, 0.95)')
    .backdropBlur(20)
    .borderRadius({ topLeft: 24, topRight: 24 })
    .border({ width: 1, color: 'rgba(255, 255, 255, 0.1)' })
    .shadow({ radius: 20, color: 'rgba(0, 0, 0, 0.5)', offsetX: 0, offsetY: -4 })
    .margin({ bottom: 0 })
  }

  @Builder
  ColorItemRow(color: ColorItem, index: number) {
    Row() {
      // 拖拽手柄
      Column() {
        Text('⋮⋮')
          .fontSize(20)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
      }
      .width(40)
      .height(50)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('rgba(255, 255, 255, 0.15)')
      .borderRadius(8)
      .margin({ right: 12 })

      // 颜色预览
      Column()
        .width(44)
        .height(44)
        .backgroundColor(color.color)
        .borderRadius(10)
        .border({ width: 2, color: 'rgba(255, 255, 255, 0.3)' })
        .margin({ right: 12 })
        .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.3)', offsetX: 0, offsetY: 2 })

      // 颜色名称
      Text(color.name)
        .fontSize(15)
        .fontColor('#FFFFFF')
        .fontWeight(FontWeight.Medium)
        .layoutWeight(1)

      // 当前标记
      if (index === this.currentColorIndex) {
        Text('●')
          .fontSize(12)
          .fontColor('#4CAF50')
          .margin({ right: 8 })
      }

      // 开关
      Toggle({ type: ToggleType.Switch, isOn: this.colors[index].enabled })
        .width(50)
        .height(28)
        .selectedColor('#4CAF50')
        .switchPointColor(Color.White)
        .onChange((isOn: boolean) => {
          this.setColorEnabled(index, isOn);
        })
        .margin({ right: 8 })

      // 上移按钮 - 直线带箭头相连
      Button() {
        Column({ space: 0 }) {
          // 箭头尖端
          Text('▲')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .height(10)
            .padding({ top: 2 })
          // 直线
          Column()
            .width(2)
            .height(12)
            .backgroundColor('#FFFFFF')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width(40)
      .height(32)
      .backgroundColor(index > 0 ? '#4CAF50' : '#444444')
      .borderRadius(6)
      .enabled(index > 0)
      .onClick(() => {
        this.moveColorUp(index);
      })
      .margin({ right: 4 })

      // 下移按钮 - 直线带箭头相连
      Button() {
        Column({ space: 0 }) {
          // 直线
          Column()
            .width(2)
            .height(12)
            .backgroundColor('#FFFFFF')
          // 箭头尖端
          Text('▼')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .height(12)
            .margin({ top: -2 })
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width(40)
      .height(32)
      .backgroundColor(index < this.colors.length - 1 ? '#2196F3' : '#444444')
      .borderRadius(6)
      .enabled(index < this.colors.length - 1)
      .onClick(() => {
        this.moveColorDown(index);
      })
    }
    .width('100%')
    .height(68)
    .padding({ left: 12, right: 12 })
    .backgroundColor(this.dragFromIndex === index ? 'rgba(255, 152, 0, 0.3)' : 'rgba(255, 255, 255, 0.08)')
    .borderRadius(12)
    .border({ width: this.dragFromIndex === index ? 2 : 1, color: this.dragFromIndex === index ? '#FF9800' : 'rgba(255, 255, 255, 0.15)' })
    .scale({ x: this.dragFromIndex === index ? 1.02 : 1, y: this.dragFromIndex === index ? 1.02 : 1 })
    .zIndex(this.dragFromIndex === index ? 10 : 0)
    .translate({ y: this.dragFromIndex === index ? this.dragOffsetY : 0 })
    .shadow(this.dragFromIndex === index ? { radius: 12, color: 'rgba(0, 0, 0, 0.4)', offsetX: 0, offsetY: 6 } : { radius: 0, color: 'transparent', offsetX: 0, offsetY: 0 })
    .gesture(
      GestureGroup(GestureMode.Sequence,
        LongPressGesture({ repeat: false, duration: 300 })
          .onAction(() => {
            // 开始拖拽
            this.dragFromIndex = index;
            this.dragOffsetY = 0;
          }),
        PanGesture({ fingers: 1, direction: PanDirection.Vertical, distance: 5 })
          .onActionUpdate((event: GestureEvent) => {
            if (this.dragFromIndex === index) {
              this.dragOffsetY = event.offsetY;
              // 计算目标位置并实时更新指示
              let targetIndex = index + Math.round(event.offsetY / this.itemHeight);
              if (targetIndex < 0) targetIndex = 0;
              if (targetIndex >= this.colors.length) targetIndex = this.colors.length - 1;
              this.dragToIndex = targetIndex;
            }
          })
          .onActionEnd((event: GestureEvent) => {
            if (this.dragFromIndex >= 0) {
              // 计算最终目标位置
              let targetIndex = index + Math.round(event.offsetY / this.itemHeight);
              if (targetIndex < 0) targetIndex = 0;
              if (targetIndex >= this.colors.length) targetIndex = this.colors.length - 1;
              
              if (targetIndex !== index) {
                // 执行移动
                let tmp = this.colors.splice(index, 1);
                this.colors.splice(targetIndex, 0, tmp[0]);
              }
              
              // 重置状态
              this.dragFromIndex = -1;
              this.dragOffsetY = 0;
              this.dragToIndex = -1;
            }
          })
      )
    )
    .onClick(() => {
      if (this.dragFromIndex < 0) {
        this.currentColorIndex = index;
      }
    })
  }

  // 拖拽预览视图
  @Builder
  DragPreviewBuilder(color: ColorItem) {
    Row() {
      Column()
        .width(40)
        .height(40)
        .backgroundColor(color.color)
        .borderRadius(8)
        .border({ width: 2, color: '#FFFFFF' })
      
      Text(color.name)
        .fontSize(12)
        .fontColor('#FFFFFF')
        .fontWeight(FontWeight.Bold)
        .margin({ left: 10 })
    }
    .padding(8)
    .backgroundColor('rgba(60, 60, 60, 0.95)')
    .borderRadius(8)
    .border({ width: 2, color: '#FF9800' })
  }
}

interface ColorItem {
  id: number;
  name: string;
  color: string;
  enabled: boolean;
}