import webview from "@ohos.web.webview";
import Prompt from "@system.prompt";
import { BusinessError } from "@kit.BasicServicesKit";
import util from "@ohos.util";

@Component
export struct ActivityPage {
  activityPath: Resource = $rawfile('activity.html');
  activityDetailPath: Resource = $rawfile('activity_detail.html')
  controller: webview.WebviewController = new webview.WebviewController();
  ports: webview.WebMessagePort[] = [];
  nativePort: webview.WebMessagePort | null = null;
  @State activitiesData: string = '';
  @State activitiesDetail: string = '';
  @State receiveMessage: string = '阿萨阿萨';

  initWebviewPort() {
    try {
      // 1、创建两个消息端口。
      this.ports = this.controller.createWebMessagePorts();
      // 2、在应用侧的消息端口(如端口1)上注册回调事件。
      this.ports[1].onMessageEvent((result: webview.WebMessage) => {
        let msg = 'Got msg from HTML:';
        if (typeof (result) == "string") {
          console.log("received string message from html5, string is:" + result);
          msg = msg + result;
        } else if (typeof (result) == "object") {
          if (result instanceof ArrayBuffer) {
            console.log("received arraybuffer from html5, length is:" + result.byteLength);
            msg = msg + "length is " + result.byteLength;
          } else {
            console.log("not support");
          }
        } else {
          console.log("not support");
        }
        this.receiveMessage = msg;
        Prompt.showToast({
          message: this.receiveMessage
        });
      })
      // 3、将另一个消息端口(如端口0)发送到HTML侧，由HTML侧保存并使用。
      this.controller.postMessage('__init_port__', [this.ports[0]], '*');
    } catch (error) {
      console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
    }
  }

  async loadActivitiesDataFromFile() {
    try {
      getContext().resourceManager.getRawFileContent("data/activities.json").then((value: Uint8Array) => {
        let rawFile = value;
        let decoder = util.TextDecoder.create('utf-8');
        let json = decoder.decodeToString(rawFile);
        this.activitiesData = json
      }).catch((error: BusinessError) => {
        console.error("getRawFileContent promise error is " + error);
      });
    } catch (error) {
      let code = (error as BusinessError).code;
      let message = (error as BusinessError).message;
      console.error(`promise getRawFileContent failed, error code: ${code}, message: ${message}.`);
    }
  }

  async loadActivitiesDetailFromFile() {
    try {
      getContext().resourceManager.getRawFileContent("data/activity_details.json").then((value: Uint8Array) => {
        let rawFile = value;
        let decoder = util.TextDecoder.create('utf-8');
        let json = decoder.decodeToString(rawFile);
        this.activitiesDetail = json
      }).catch((error: BusinessError) => {
        console.error("getRawFileContent promise error is " + error);
      });
    } catch (error) {
      let code = (error as BusinessError).code;
      let message = (error as BusinessError).message;
      console.error(`promise getRawFileContent failed, error code: ${code}, message: ${message}.`);
    }
  }

  async aboutToAppear() {
    Promise.all([this.loadActivitiesDataFromFile(), this.loadActivitiesDetailFromFile()])
      .then(results => {
        console.error('所有 Promise 都成功了:', results); // [ 'Data from api/data1', 'Data from api/data2', 'Data from api/data3' ]
      })
      .catch((error: BusinessError) => {
        console.error('有 Promise 失败了:', error);
      });
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

  build() {
    Column() {
      Text(this.receiveMessage)
      Web({ src: this.activityPath, controller: this.controller })
        .onPageBegin((e) => {
          this.initWebviewPort();
          this.postMessageToHtml(this.activitiesData);
        })
    }

  }
}