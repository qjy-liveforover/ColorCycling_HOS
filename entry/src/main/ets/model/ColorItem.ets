/**
 * 颜色项数据模型
 * 使用@Observed装饰器实现对象级别的响应式更新
 */
@Observed
export class ColorItem {
  id: number = 0;
  name: string = '';
  color: string = '#FFFFFF';
  enabled: boolean = true;

  constructor(id: number, name: string, color: string, enabled: boolean = true) {
    this.id = id;
    this.name = name;
    this.color = color;
    this.enabled = enabled;
  }

  /**
   * 创建副本
   */
  clone(): ColorItem {
    return new ColorItem(this.id, this.name, this.color, this.enabled);
  }
}
