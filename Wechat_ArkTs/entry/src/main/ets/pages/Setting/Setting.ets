/**
 * 该组件为设置页面。
 * powered by yiyefangzhou24
 * 2022/5/16
 */
import { navigationBar } from './navigationBar'
import { optionItem } from './optionItem'
import router from '@ohos.router';
import {  isnext } from './navigationBar'

@Entry
@Component
struct Setting {
  private scroller: Scroller = new Scroller()

  build() {
    Column(){
      navigationBar({title: "设置" , isBack:true , isClose:false , isMenu: false , isSearch: false , isMore:false})
      /**
     * 功能列表
     */
      Scroll(this.scroller) {
        Column() {
            //账号与安全
          //  optionItem({ context: "账号与安全", isNext: true, marginTop: 0 })
          Row() {
            Text('账号与安全')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/zhanghaoPage" })
            .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          .backgroundColor(Color.White)
         Divider().color($r('app.color.grey2')).strokeWidth(10)


          //青少年模式
          Row() {
            Text('青少年模式')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/zhanghaoPage" })
              .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          .backgroundColor(Color.White)
          Divider().color($r('app.color.grey2')).strokeWidth(10)

          //关怀模式

          Row() {
            Text('关怀模式')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/zhanghaoPage" })
              .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          .backgroundColor(Color.White)
          Divider().color($r('app.color.grey2')).strokeWidth(10)

          //消息通知
          Row() {
            Text('消息通知')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/zhanghaoPage" })
              .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          .backgroundColor(Color.White)
          Divider().color($r('app.color.grey2')).strokeWidth(0.8)
          //通用
          Row() {
            Text('通用')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/zhanghaoPage" })
              .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          .backgroundColor(Color.White)
          Divider().color($r('app.color.grey2')).strokeWidth(0.8)

          Text("隐私")
            .fontSize(14)
            .fontColor($r('app.color.grey3'))

            .margin({ top: 5, left: 10 })
          //朋友权限
          Row() {
            Text('朋友权限')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/zhanghaoPage" })
              .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          .backgroundColor(Color.White)
          Divider().color($r('app.color.grey2')).strokeWidth(0.8)

          //个人隐私政策
          Row() {
            Text('个人隐私政策')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/zhanghaoPage" })
              .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          .backgroundColor(Color.White)
          Divider().color($r('app.color.grey2')).strokeWidth(0.8)
          //个人信息收集清单
          Row() {
            Text('个人信息收集清单')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/zhanghaoPage" })
              .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          .backgroundColor(Color.White)
          Divider().color($r('app.color.grey2')).strokeWidth(0.8)
          //关于微信
          Row() {
            Text('关于微信')
              .fontSize(20)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .layoutWeight(1)
            isnext({ myUrl: "pages/zhanghaoPage" })
              .width(18)
              .height(18)
              .margin(10)
          }.height(59)
          .backgroundColor(Color.White)
          Divider().color($r('app.color.grey2')).strokeWidth(0.8)


          //注销按钮
          Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
            Text("注销")
              .fontSize(19)
              .maxLines(1)
          }.width('100%').height(60)
          .margin({ top: 10 })
          .backgroundColor($r('app.color.white'))
          .onClick(()=>{
            router.pushUrl(
              {
                url: "pages/LoginPage/shouye"
              }
            )
          })
          //退出按钮
          Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
            Text("退出")
              .fontSize(19)
              .maxLines(1)
          }.width('100%').height(60)
          .backgroundColor($r('app.color.white'))
          .margin({ top: 10  , bottom: 60})
          .onClick(()=>{
            router.pushUrl(
              {
                url: "pages/LoginPage/LoginPage"
              }
            )
          })//这里必须加上60的底部高度，否则Scroll组件不能检测出已经超过屏幕，无法正常开启滑动
        }
        .alignItems(HorizontalAlign.Start)
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      //.scrollBarColor(Color.Gray).scrollBarWidth(30)
    }
    .width('100%').height('100%')
    .backgroundColor($r('app.color.grey2'))
  }
}