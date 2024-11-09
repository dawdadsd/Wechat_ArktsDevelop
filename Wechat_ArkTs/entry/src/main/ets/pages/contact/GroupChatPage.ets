import router from '@ohos.router';
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';

@Entry
@Component
struct GroupChatPage {
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#f1f1f1', false);
  }

  build() {
    Column() {
      // 状态栏占位
      Row().height(`${this.statusBarHeight}px`).width('100%').backgroundColor('#f1f1f1')

      // 导航栏
      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Text('群聊')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
        Blank()
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#f1f1f1')

      // 主要内容区域
      Column() {
        Blank()
        Text('在群聊右上角的「更多」中开启「保存到通讯录」，就可以将群聊保存在这里')
          .fontSize(14)
          .fontColor('#999999')
          .textAlign(TextAlign.Center)
          .margin({ left: 32, right: 32 })
        Blank()
      }
      .layoutWeight(1)
      .backgroundColor('#ffffff')

      // 底部占位
      Row().height(30).width('100%').backgroundColor('#ffffff')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f1f1f1')
  }
}
