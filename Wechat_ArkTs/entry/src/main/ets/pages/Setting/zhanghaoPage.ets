/**
 * 该组件为设置页面。
 * powered by yiyefangzhou24
 * 2022/5/16
 */
import { navigationBar } from './navigationBar'
import { optionItem } from './optionItem'
import router from '@ohos.router'
import {  isback } from './navigationBar'
import {  isnext } from './navigationBar'
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';

@Entry
@Component
struct zhanghaoPage {
  private scroller: Scroller = new Scroller()
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#f1f1f1', false);
  }
  build() {
    Column() {
      Row().height(`${this.statusBarHeight}px`).width('100%')
      /**
       * 功能列表
       */
      Scroll(this.scroller) {
        Column() {
          Row().height(`${this.statusBarHeight}px`).width('100%')
          Blank()
          Row() {
              Image($r('app.media.ic_back'))
                .onClick(
                  ()=>router.back()
                )
              Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
              Text("账号与安全")
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

          }.width('100%').height(60)
          .margin({ top: 10 })

          }
          .backgroundColor(($r('app.color.grey0')))
          .height(59)


          //微信号
          Row() {
            Text('微信号')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/wxhPage" })
              .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          Divider().color($r('app.color.grey2')).strokeWidth(0.8)

          Row() {
            Text('手机号')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/wxhPage" })
              .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          Divider().color($r('app.color.grey2')).strokeWidth(10)

          Row() {
            Text('微信密码')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/wxhPage" })
              .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          Divider().color($r('app.color.grey2')).strokeWidth(0.8)


          Row() {
            Text('声音锁')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/wxhPage" })
              .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          Divider().color($r('app.color.grey2')).strokeWidth(10)


          Row() {
            Text('应急联系人')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/wxhPage" })
              .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          Divider().color($r('app.color.grey2')).strokeWidth(0.8)

          Row() {
            Text('微信安全中心')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/wxhPage" })
              .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          Divider().color($r('app.color.grey2')).strokeWidth(0.8)


        }

      }
      Text("如果遇到账号信息泄露，忘记密码，诈骗等账号安全问题，可前往微信安全中心")
        .fontColor($r('app.color.grey2'))
    }

  }
}


        //手机号
       // optionItem({ context: "手机号", isNext: true, marginTop: 0 })
        //微信密码
      //  optionItem({ context: "微信密码", isNext: true, marginTop: 10 })
        //声音锁
       // optionItem({ context: "声音锁", isNext: true, marginTop: 10 })
        //应急联系人
       // optionItem({ context: "应急联系人", isNext: true, marginTop: 0 })
