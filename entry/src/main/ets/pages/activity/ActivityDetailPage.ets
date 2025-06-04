import webview from "@ohos.web.webview";
import Prompt from "@system.prompt";
import { BusinessError } from "@kit.BasicServicesKit";
import util from "@ohos.util";
import { ActivityDetail, MessageModel, routerParams } from "../../model/ActivityModel";
import { router } from "@kit.ArkUI";

@Entry
@Component
export struct ActivityDetailPage {
  activityDetailPath: Resource = $rawfile('activity_detail.html')
  controller: webview.WebviewController = new webview.WebviewController();
  ports: webview.WebMessagePort[] = [];
  nativePort: webview.WebMessagePort | null = null;
  @State activitiesDetail: ActivityDetail = {} as ActivityDetail;
  @State receiveMessage: MessageModel = {} as MessageModel;
  @State params: routerParams = router.getParams() as routerParams;
  @State activityId: number = Number(this.params.src);

  async aboutToAppear() {
    await this.loadActivitiesDetailFromFile();
  }

  initWebviewPort() {
    try {
      this.ports = this.controller.createWebMessagePorts();
      this.ports[1].onMessageEvent((result: webview.WebMessage) => {
        let msg: MessageModel;
        if (typeof (result) === "string") {
          console.log("received string message from html5, string is:" + result);
          // 收到 HTML 发送过来的活动 ID
          let message: MessageModel = JSON.parse(result);
          msg = message;
          if (message.type == 'back') {
            router.back();
          } else if (message.type == 'event') {
            const content = message.content;
            this.selectEvent(content);
          } else {
            console.error("消息的type是：", message.type)
            console.error("消息的内容是：", message.content)
          }
        } else {
          console.log("received unknown message type from html5");
          msg = {
            type: 'error',
            content: '收到的消息类型未知'
          };
        }
        this.receiveMessage = msg;
      });
      this.controller.postMessage('__init_port__', [this.ports[0]], '*');
    } catch (error) {
      console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
    }
  }

  async loadActivitiesDetailFromFile() {
    try {
      getContext().resourceManager.getRawFileContent("data/activity_details.json").then((value: Uint8Array) => {
        let rawFile = value;
        let decoder = util.TextDecoder.create('utf-8');
        let content = decoder.decodeToString(rawFile);
        let json: ActivityDetail[] = JSON.parse(content);
        this.activitiesDetail = json[this.activityId - 1];
        console.error(JSON.stringify(this.activitiesDetail));
      }).catch((error: BusinessError) => {
        console.error("getRawFileContent promise error is " + error);
      });
    } catch (error) {
      let code = (error as BusinessError).code;
      let message = (error as BusinessError).message;
      console.error(`promise getRawFileContent failed, error code: ${code}, message: ${message}.`);
    }
  }

  postMessageToHtml(content: string) {
    try {
      if (this.ports && this.ports[1]) {
        this.ports[1].postMessageEvent(content);
      } else {
        console.error(`ports is null, Please initialize first`);
      }
    } catch (error) {
      console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
    }
  }

  selectEvent(event: string) {
    switch (event) {
      case 'signup':
        router.pushUrl({
          url: 'pages/activity/SignUpPage',
          params: new routerParams(this.activitiesDetail.activityId.toString() + this.activitiesDetail.title)
        })
        break
      default:
        return
    }
  }

  build() {
    Column() {
      Web({ src: this.activityDetailPath, controller: this.controller })
        .onPageEnd(() => {
          this.initWebviewPort();
          this.postMessageToHtml(JSON.stringify(this.activitiesDetail));
        })
      Row() {
        Text('⬅️')// 使用左箭头 emoji
          .fontSize(24)// 调整 emoji 大小
          .onClick(() => {
            router.back();
          })
      }
      .width(36) // 按钮宽度
      .height(36) // 按钮高度
      .backgroundColor(Color.Gray) // 灰色背景
      .borderRadius(24) // 圆角，使其看起来像一个圆形按钮
      .opacity(0.8) // 半透明效果
      .position({ x: 16, y: 16 }) // 定位到左上角，距离左边和顶部各16vp
      .zIndex(1) // 确保按钮在 WebView 上层
      .alignItems(VerticalAlign.Center) // 居中图片
      .justifyContent(FlexAlign.Center)
    }

  }
}