import { router } from '@kit.ArkUI'
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../../utils/StatusBarManager';

@Entry
@Component
struct LabelCreatedPage {
  @State labelName: string = '家人'
  @State memberCount: number = 0
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#f1f1f1', false);
  }
  build() {
    Column() {
      Row().height(`${this.statusBarHeight}px`).width('100%').backgroundColor('#f1f1f1')

      // 顶部导航栏
      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .onClick(()=>{
            router.back()
          })

        Text(`${this.labelName}（${this.memberCount}）`)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 24, right: 24 })
      .backgroundColor(Color.White)

      // 中间内容区域
      Column() {
        Text('暂无成员')
          .fontSize(16)
          .fontColor('#999999')
          .margin({ top: 8 })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F1F3F5')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
