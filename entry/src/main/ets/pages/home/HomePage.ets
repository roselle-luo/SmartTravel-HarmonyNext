// ExplorePage.ets
@Component
export struct HomePage {
  @State swiperIndex: number = 0;
  private recommendedImages: string[] = [
    'https://p3.img.cctvpic.com/photoworkspace/contentimg/2019/05/05/2019050515335593405.jpg', // 示例图片URL
    'https://askthescientists.com/wp-content/uploads/2018/07/Outdoors-AdobeStock_203673414-835x418.jpg', // 示例图片URL
    'https://cxfile.advences.com/CFAVOYAGES/photo/shutterstock_638541712.jpg'  // 示例图片URL
  ];

  build() {
    // 关键改进：将整个页面内容包裹在 Scroll 组件中，确保页面在内容溢出时可以滚动
    Scroll() {
      Column() {
        // 搜索栏
        TextInput({ placeholder: '搜索景点、活动、美食...' })
          .width('95%') // 宽度占父容器的95%
          .height(48) // 固定高度
          .borderRadius(24) // 圆角
          .backgroundColor(Color.White) // 背景色
          .padding({ left: 15, right: 15 }) // 内边距
          .margin({ top: 15, bottom: 15 }) // 外边距
          .fontSize(16) // 字体大小
          .fontColor(Color.Black) // 字体颜色
          .placeholderColor(Color.Gray) // 占位符颜色
          .border({ width: 1, color: '#cbd5e1', radius: 24 }) // 边框
          .shadow({ radius: 5, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 2 }) // 阴影

        // 热门推荐 - Swiper 轮播图
        Text('热门推荐')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#334155')
          .alignSelf(ItemAlign.Start) // 左对齐
          .margin({ left: '2.5%', bottom: 10 }) // 左侧外边距和底部外边距
          .padding({ left: 10 }) // 左侧内边距

        Swiper() {
          ForEach(this.recommendedImages, (item: string) => {
            Image(item)
              .width('100%')
              .height(200)
              .borderRadius(16)
              .objectFit(ImageFit.Cover) // 图片裁剪模式
          })
        }
        .width('95%')
        .height(200)
        .indicator(true) // 显示指示器（小圆点）
        .loop(true) // 循环播放
        .autoPlay(true) // 自动播放
        .interval(3000) // 播放间隔3秒
        .onChange((index: number) => {
          this.swiperIndex = index; // 更新当前轮播图索引
        })
        .borderRadius(10)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 4 }) // 阴影
        .margin({ bottom: 20 }) // 底部外边距

        // 热门分类 - GridRow (响应式网格布局)
        Text('热门分类')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#334155')
          .alignSelf(ItemAlign.Start)
          .margin({ left: '2.5%', bottom: 10 })
          .padding({ left: 10 })

        GridRow({
          columns: 12, // ArkUI GridRow 默认总列数为12，这里显式声明以提高可读性
          gutter: { x: 10, y: 10 } // 网格项之间的间距
        }) {
          // 手机窄屏 (xs): 每行 2 列 (每个占 6/12 宽度)
          // 平板宽屏 (md): 每行 4 列 (每个占 3/12 宽度)
          GridCol({ span: { xs: 6, md: 3 } }) { // xs for extra small (phone), md for medium (tablet)
            CategoryItem({ icon: '🏞️', text: '景点' })
          }
          GridCol({ span: { xs: 6, md: 3 } }) {
            CategoryItem({ icon: '🎉', text: '活动' })
          }
          GridCol({ span: { xs: 6, md: 3 } }) {
            CategoryItem({ icon: '🍔', text: '美食' })
          }
          GridCol({ span: { xs: 6, md: 3 } }) {
            CategoryItem({ icon: '🏨', text: '住宿' })
          }
          GridCol({ span: { xs: 6, md: 3 } }) {
            CategoryItem({ icon: '🛍️', text: '购物' })
          }
          GridCol({ span: { xs: 6, md: 3 } }) {
            CategoryItem({ icon: '🚌', text: '交通' })
          }
          GridCol({ span: { xs: 6, md: 3 } }) {
            CategoryItem({ icon: '🗺️', text: '路线' })
          }
          GridCol({ span: { xs: 6, md: 3 } }) {
            CategoryItem({ icon: '✨', text: '更多' })
          }
        }
        .width('95%')
        .margin({ bottom: 20 })

        // 精选推荐 - List (列表展示)
        Text('精选推荐')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#334155')
          .alignSelf(ItemAlign.Start)
          .margin({ left: '2.5%', bottom: 10 })
          .padding({ left: 10 })

        List() {
          ListItem() {
            RecommendedItem({
              image: 'https://placehold.co/80x80/FFDDC1/000000?text=景点1',
              title: '翠湖公园',
              description: '城市中心的绿洲，休闲散步好去处。'
            })
          }
          ListItem() {
            RecommendedItem({
              image: 'https://placehold.co/80x80/C1FFDD/000000?text=活动1',
              title: '城市文化节',
              description: '体验当地文化，感受城市魅力。'
            })
          }
          ListItem() {
            RecommendedItem({
              image: 'https://placehold.co/80x80/DDC1FF/000000?text=美食1',
              title: '老街美食街',
              description: '品尝地道小吃，满足您的味蕾。'
            })
          }
        }
        .width('95%')
        // 在 Scroll 组件内部，List 的高度会根据其内容自适应，通常不需要设置 layoutWeight(1)
        // .layoutWeight(1)
        .listDirection(Axis.Vertical) // 垂直列表
        .divider({ strokeWidth: 0, color: Color.Transparent }) // 无分隔线
        .scrollBar(BarState.Off) // 关闭列表自身的滚动条
      }
      .width('100%') // Column 宽度填充 Scroll
      // 在 Scroll 组件内部，Column 的高度不需要固定为100%，它会根据内容自适应
      // .height('100%')
      .backgroundColor('#f0f4f8') // 轻柔的背景色
      .padding({ bottom: 20 }) // 底部留白，防止内容被底部导航栏遮挡
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off) // 隐藏 Scroll 组件的滚动条
  }
}

// 热门分类项组件
@Component
struct CategoryItem {
  private icon: string = '';
  private text: string = '';

  build() {
    Column() {
      Text(this.icon)
        .fontSize(40)
        .margin({ bottom: 8 })
      Text(this.text)
        .fontSize(14)
        .fontColor('#334155')
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .padding(15)
    .backgroundColor('#e0f2fe') // 浅蓝色背景
    .borderRadius(8)
    .alignItems(HorizontalAlign.Center) // 水平居中
    .justifyContent(FlexAlign.Center) // 垂直居中
    .shadow({ radius: 3, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 2 }) // 阴影
  }
}

// 精选推荐项组件
@Component
struct RecommendedItem {
  private image: string = '';
  private title: string = '';
  private description: string = '';

  build() {
    Row() {
      Image(this.image)
        .width(80)
        .height(80)
        .borderRadius(6)
        .objectFit(ImageFit.Cover)
        .margin({ right: 15 })

      Column() {
        Text(this.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1f2937')
          .alignSelf(ItemAlign.Start) // 左对齐
          .margin({ bottom: 5 })
        Text(this.description)
          .fontSize(14)
          .fontColor('#4b5563')
          .alignSelf(ItemAlign.Start) // 左对齐
      }
      .alignItems(HorizontalAlign.Start) // 子组件水平左对齐
      .layoutWeight(1) // 允许内容填充剩余空间
    }
    .width('100%')
    .padding(15)
    .backgroundColor(Color.White)
    .borderRadius(10)
    .shadow({ radius: 5, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 2 }) // 阴影
    .margin({ bottom: 10 }) // 底部外边距
  }
}
