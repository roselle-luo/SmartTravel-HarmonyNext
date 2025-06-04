import { routerParams } from "../../model/ActivityModel";
import { Prompt, router } from "@kit.ArkUI";

interface SignupInfo {
  id: string;
  name: string;
  sex: string;
  age: number;
  activity: string;
  activityId: number;
}


@Entry
@Component
export struct SignUpPage {
  @State params: routerParams = router.getParams() as routerParams;
  @State activity: string = this.params.src;
  @State signupInfo: SignupInfo = {} as SignupInfo;

  aboutToAppear(): void {
    Prompt.showToast({
      message: this.activity
    })
  }

  build() {
    Column() {
      Text('表单报名表')
      Text(this.activity)
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}