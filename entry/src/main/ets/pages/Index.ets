import { ActivityPage } from './activity/ActivityPage';
import { HomePage } from './home/HomePage';
import { ProfilePage } from './profile/ProfilePage';
import { display } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State selected: number = 0;

  aboutToAppear() {
    this.updateBarPosition(); // 首次加载时更新导航栏位置
  }

  // 监听屏幕尺寸变化
  onConfigurationUpdate(config: Configuration) {
    this.updateBarPosition();
  }

  // 根据屏幕宽度更新导航栏位置
  private updateBarPosition() {
    const deviceWidth = display.getDefaultDisplaySync().width
    console.debug(deviceWidth?.toString())
    // 检查 deviceWidth 是否为有效的数字
    if (deviceWidth !== undefined && deviceWidth !== null && typeof deviceWidth === 'number') {
      console.log(deviceWidth.toString())
    } else {
      // 如果 deviceWidth 不存在或不是数字，可以设置一个默认值
      // 或者根据你的应用逻辑进行错误处理，例如：
      console.error("AppStorage 'width' is undefined or not a number, defaulting to BarPosition.End.");
    }
  }

  build() {
    Column() {
      Tabs({ index: this.selected, barPosition: BarPosition.End }) { // 使用动态的 barPosition
        TabContent() {
          HomePage()
        }.tabBar(this.TabBuilder('首页', '🏠', 0))
        TabContent() {
          ActivityPage()
        }.tabBar(this.TabBuilder('活动', '🔍', 1))
        TabContent() {
          ProfilePage()
        }.tabBar(this.TabBuilder('主页', '👤', 2))
      }
      .width('100%')
      .height('100%')
      .barMode(BarMode.Fixed) // 固定Tab栏模式
      // 当导航栏在左侧时，调整 barWidth 和 barHeight
      .barHeight(60)
      .backgroundColor(Color.White)
      .onChange((index: number) => {
        this.selected = index;
      })
    }
    .width('100%')
    .height('100%')
  }

  // 自定义 TabBar 布局
  @Builder TabBuilder(title: string, icon: string, index: number) {
    Column() {
      Text(icon) // 图标 (这里使用Emoji模拟)
        .fontSize(24)
        .fontColor(this.selected === index ? '#3b82f6' : '#64748b') // 选中蓝色，未选中灰色
      Text(title) // 标题
        .fontSize(12)
        .fontColor(this.selected === index ? '#3b82f6' : '#64748b')
        .fontWeight(this.selected === index ? FontWeight.Medium : FontWeight.Normal)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}