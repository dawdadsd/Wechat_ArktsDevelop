import { router } from '@kit.ArkUI'
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';

@Entry
@Component
struct CardPage {
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#f1f1f1', false);
  }

  build() {
    Column() {
      Row().height(`${this.statusBarHeight}px`).width('100%')
      Row() {
          Image($r('app.media.ic_back'))
            .width(24)
            .height(24)
            .onClick(() => router.back())
        Text('卡包')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column() {
          this.CardItem('VIP', $r('app.media.jay'), '会员卡')
          this.CardItem('', $r('app.media.jay'), '交通卡')
          this.CardItem('', $r('app.media.jay'), '券和礼品卡')
          this.CardItem('', $r('app.media.jay'), '票证')
        }
        .width('100%')
      }
      .layoutWeight(1)

      Text('最近30天未使用卡片')
        .fontSize(14)
        .fontColor('#999999')
        .width('100%')
        .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  CardItem(label: string, icon: Resource, title: string) {
    Row() {
      Image(icon)
        .width(24)
        .height(24)
        .margin({ right: 16 })

      Column() {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)

        if (label) {
          Text(label)
            .fontSize(12)
            .fontColor('#999999')
            .margin({ top: 4 })
        }
      }
      .alignItems(HorizontalAlign.Start)

      Image($r('app.media.ic_next'))
        .width(16)
        .height(16)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .margin({ bottom: 8 })
    .onClick(() => {
      // 处理卡片点击事件
    })
  }
}