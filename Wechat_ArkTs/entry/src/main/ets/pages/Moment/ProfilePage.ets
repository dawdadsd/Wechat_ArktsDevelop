import { router } from '@kit.ArkUI'
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';
import {CreateMomentPage} from './CreateMomentPage'
@Entry
@Component
struct ProfilePage {
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#F7F7F7', true);
  }
  build() {
    Column() {
      Row().height(`${this.statusBarHeight}px`).width('100%').backgroundColor('#F7F7F7')
      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .margin({ left: 16 })
          .onClick(()=>{
            router.back()
          })
        Blank()
      }
      .width('100%')
      .height(56)
      .backgroundColor(Color.White)

      Row() {
        Image($r('app.media.jay'))
          .width(60)
          .height(60)
          .borderRadius(30)
        Column() {
          Text('不喝饮料')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
          Text('微信号：qq1399092218')
            .fontSize(14)
            .fontColor(Color.Gray)
            .margin({ top: 4 })
          Text('地区：日本 我孙子市')
            .fontSize(14)
            .fontColor(Color.Gray)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 16 })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color.White)
      Column() {
        Row() {
          Text('朋友圈')
            .fontSize(16)
          Blank()
          Image($r('app.media.ic_next'))
            .width(20)
            .height(20)
        }
        .onClick(()=>{
          router.pushUrl({url:
          "pages/Moment/SelfMoment"})
        })
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })

        Row() {
          ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], (item:number) => {
            Image($r('app.media.jay'))
              .width(60)
              .height(60)
              .margin({ right: 8, bottom: 8 })
          })
        }
        .width('100%')
        .padding({ left: 16, right: 16, bottom: 16 })
      }
      .backgroundColor(Color.White)
      .margin({ top: 8 })
      Row() {
        Text('更多信息')
          .fontSize(16)
        Blank()
        Image($r('app.media.ic_next'))
          .width(20)
          .height(20)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(Color.White)
      .margin({ top: 8 })

      Button('发消息', { type: ButtonType.Capsule })
        .width('90%')
        .height(48)
        .backgroundColor('#07C160')
        .margin({ top: 20 })
        .onClick(()=>{
          router.pushUrl({
            url:'pages/chat/ChatPage'
          })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F7F7')
  }
}
