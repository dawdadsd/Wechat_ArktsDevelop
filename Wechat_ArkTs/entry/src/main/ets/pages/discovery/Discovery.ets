//未开发部分：1.视频号：允许用户自己上传视频到数据库里，然后可以看到别人上传的视频
//2.看一看（显示再看文章，视频，热点等），搜一搜（可以搜索东西）--这两个功能需要添加到添加好友的额外选项
//3.附近：不知道怎么做
//4.搜索和添加功能的完善


import router from '@ohos.router';

import ListMenuItem from '../../component/ListMenuItem'
import WechatToolbar from '../../component/WechatToolbar'
@Entry
@Preview
@Component
export default struct Discovery {
  build() {
    Column() {
      WechatToolbar({ title: "发现" })
        ListMenuItem({ title: "朋友圈", iconSrc: $r('app.media.ic_moment') })
          .onClick(()=>{
            router.pushUrl({
              url:"pages/Moment/MomentPage"
            })
      })
      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)

      ListMenuItem({ title: "扫一扫",
        iconSrc: $r('app.media.ic_scan') })
        .onClick(()=>{
          router.pushUrl({
            url:    "pages/qrcode/ScanPage"
          })
        })
      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(1)
        .lineCap(LineCapStyle.Round)

      ListMenuItem({ title: "听一听", iconSrc: $r('app.media.ic_listen') })
        .onClick(()=>{
          router.pushUrl({
            url:"pages/Music/MusicPage"
          })
        })
      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)


      ListMenuItem({
        title: "游戏",
        news: "小巫的五杀时刻",
        newsIconSrc: $r('app.media.jay'),
        iconSrc: $r('app.media.ic_game')
      })
        .onClick(() => {
          router.pushUrl({ url: "pages/Game/CandyCrushGame" })
        })
      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)

      ListMenuItem({ title: "小程序",
        iconSrc: $r('app.media.ic_miniprogram')
      })
        .onClick(()=>{
          router.pushUrl({
            url:"pages/MineProgramPage/MinProgramPage"
          })
        })
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f0f0f0")
  }
}