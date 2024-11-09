import { navigationBar } from './navigationBar'
import router from '@ohos.router';
@Entry
@Component
struct WxhPage {
  build() {
    Column(){
      navigationBar({isBack:true , isClose:false , isMenu: false , isSearch: false , isMore:false})


    Column() {

      Image($r('app.media.wxicon'))
        .width(200)
        .height(200)

     Text("微信号：ELEsssi"){

     }.fontSize(30)
     .fontWeight(FontWeight.Bold)


    }.height('100%')
     .width('100%')
    .justifyContent(FlexAlign.Center)

  }.onClick(() => {
      router.pushUrl({ url: "pages/zhanghaoPage" });
    } )

  }
}