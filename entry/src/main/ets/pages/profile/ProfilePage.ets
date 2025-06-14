import { Prompt, router } from "@kit.ArkUI";
import { resourceManager } from "@kit.LocalizationKit";

interface FeatureItem {
  icon: string;
  name: string;
}

@Component
export struct ProfilePage {
  @State userName: string = '旅行者小粲';
  @State userAvatar: Resource = $r('app.string.AvatarUrl');
  @State userBio: string = '热爱探索世界，记录美好生活';
  private featureList: FeatureItem[] = [
    { icon: '🗺️', name: '报名情况' },
    { icon: '📸', name: '我的相册' },
    { icon: '❤️', name: '我的收藏' },
    { icon: '📝', name: '我的攻略' },
    { icon: '🏷️', name: '优惠券' },
    { icon: '⚙️', name: '设置' },
    { icon: '❓', name: '帮助与反馈' },
    { icon: '🗺️', name: '我的行程' },
    { icon: '📸', name: '我的相册' },
    { icon: '❤️', name: '我的收藏' },
    { icon: '📝', name: '我的攻略' },
    { icon: '🏷️', name: '优惠券' },
    { icon: '⚙️', name: '设置' },
    { icon: '❓', name: '帮助与反馈' }
  ];

  build() {
    Scroll() {
      Column() {
        // 顶部用户信息区域
        Column() {
          Image(this.userAvatar)
            .width(80)
            .height(80)
            .borderRadius(40)
            .border({ width: 2, color: Color.White })
            .objectFit(ImageFit.Cover)
            .margin({ top: 40 })

          Text(this.userName)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .margin({ top: 10 })

          Text(this.userBio)
            .fontSize(14)
            .fontColor(Color.White)
            .textAlign(TextAlign.Center)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .margin({ left: 20, right: 20, bottom: 20 })
        }
        .width('100%')
        .backgroundColor('#3b82f6')
        .alignItems(HorizontalAlign.Center)

        // 功能列表区域

        GridRow({
          columns: 20,
          gutter: { x: 12, y: 12 }
        }) {
          ForEach(this.featureList, (item: FeatureItem) => {
            GridCol({ span: { xs: 10, md: 5, lg: 4 } }) {
              functionEntry({ item: item })
            }
          })
        }
        .width('95%')
        .margin({ top: 20, bottom: 20 })

      }
      .width('100%')
      .backgroundColor('#f2f2f2')
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off) // 隐藏 Scroll 组件的滚动条
  }
}

@Component
struct functionEntry {
  @Prop item: FeatureItem;

  build() {
    Column() {
      Text(this.item.icon)
        .fontSize(36)
        .margin({ bottom: 8 })

      Text(this.item.name)
        .fontSize(16)
        .fontColor(Color.Black)
    }
    .width('100%')
    .height(120)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .shadow({
      radius: 4,
      color: Color.Gray,
      offsetX: 0,
      offsetY: 2
    })
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      router.pushUrl({
        url: "pages/signup_data/SignUpData"
      })
      Prompt.showToast({
        message: `点击了：${this.item.name}`
      })
    })
  }
}
