import { ActivityPage } from './activity/ActivityPage';
import { HomePage } from './home/HomePage';
import { ProfilePage } from './profile/ProfilePage';

@Entry
@Component
struct Index {
  @State selected: number = 0;

  build() {
    Column() {
      Tabs({ index: this.selected, barPosition: BarPosition.End }) {
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
      .barWidth('100%')
      .barHeight(60) // 底部导航栏高度
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
