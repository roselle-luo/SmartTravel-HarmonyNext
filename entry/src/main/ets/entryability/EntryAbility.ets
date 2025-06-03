import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { display, window } from '@kit.ArkUI';
import webview from '@ohos.web.webview';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    display.getDefaultDisplay((err, disp) => {
      if (err) {
        console.error('Failed to get default display. Cause: ' + JSON.stringify(err));
        return;
      }
      console.info('Succeeded to get default display. display info: ' + JSON.stringify(disp));

      // 获取窗口信息并存储到AppStorage
      window.getLastWindow(this.context, (err, data) => {
        if (err) {
          console.error('Failed to get last window. Cause: ' + JSON.stringify(err));
          return;
        }
        console.info('Succeeded to get last window. Data: ' + JSON.stringify(data));

        const windowProperties = data.getWindowProperties();
        AppStorage.set<number>('width', windowProperties.windowRect.width);
        AppStorage.set<number>('height', windowProperties.windowRect.height);
        AppStorage.set<number>('density', disp.densityPixels); // 屏幕密度
        AppStorage.set<number>('screenHeight', disp.height); // 屏幕物理高度
        AppStorage.set<number>('screenWidth', disp.width);   // 屏幕物理宽度
        console.info('AppStorage: width = ' + AppStorage.get('width'));
        console.info('AppStorage: height = ' + AppStorage.get('height'));
      });
    });
    webview.WebviewController.initializeWebEngine()
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}