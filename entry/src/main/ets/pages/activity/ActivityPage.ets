import webview from "@ohos.web.webview";

@Component
export struct ActivityPage {

  activityHtmlPath: Resource = $rawfile('activity.html');
  controller: webview.WebviewController = new webview.WebviewController();

  build() {
    Column() {
      Web({ src: this.activityHtmlPath, controller: this.controller })
    }
  }
}