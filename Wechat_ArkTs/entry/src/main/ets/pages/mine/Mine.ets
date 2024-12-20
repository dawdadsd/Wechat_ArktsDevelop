import router from '@ohos.router'
import ListMenuItem from '../../component/ListMenuItem'
import { PhotoPickerUtils } from '../../utils/PhotoPickerUtils'
import { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager'
import { ToastUtils } from '../../utils/ToastUtils'

@Preview
@Component
export default struct Mine {
  @StorageLink(STATUS_BAR_HEIGHT) statusBarHeight: number = 0
  @State imgPath: string = ""

  build() {
    Column() {
      // 在界面顶部放置一个与状态栏同高度的组件，用于占位，可避免界面内容与状态栏内容重叠
      Row().width("100%")
        .height(px2vp(this.statusBarHeight))
        .backgroundColor(Color.White)

      Row() {
        Image(this.imgPath ? this.imgPath : $r('app.media.jay'))
          .width(70)
          .height(70)
          .margin({ left: 25, right: 10 })
          .borderRadius(8)
          .onClick(() => {
            PhotoPickerUtils.openGallery(
              uri => {
                this.imgPath = uri;
              }, errMsg => {
              ToastUtils.show(errMsg)
            })
          })

        Column() {
          Text("只喝饮料")
            .fontColor(Color.Black)
            .fontSize(26)
            .fontWeight(700)

          Text("微信号：JayChou")
            .fontColor(Color.Grey)
            .fontSize(16)
            .margin({ top: 15 })

          Text('+ 状态')
            .fontColor(Color.Grey)
            .margin({ top: 20 })
            .padding({ left: 8, right: 8 })
            .height(25)
            .fontSize(15)
            .borderRadius(20)
            .height(26)
            .textAlign(TextAlign.Center)
            .borderWidth(0.7)
            .borderColor('#666')
            .backgroundColor(Color.White)
        }
        .margin({ top: 40 })
        .alignItems(HorizontalAlign.Start)

        Blank()
        Image($r('app.media.ic_qrcode'))
          .width(16)
          .height(16)
          .margin({ top: 38, right: 20 })


        Image($r("app.media.ic_more"))
          .width(9)
          .height(16.364)
          .margin({ top: 38, right: 15 })

      }.width("100%")
      .height(203)
      .backgroundColor(Color.White)
      .onClick(() => {
        router.pushUrl({ url: 'pages/qrcode/MyQrCodePage' })
      })

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)
      ListMenuItem({
        title: "服务",
        iconSrc: $r('app.media.ic_service')
      })
        .onClick(()=>{
          router.pushUrl(
            {url
            :    "pages/mine/ServicePage"}
          )
        })
      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)
      ListMenuItem({
        title: "收藏",
        iconSrc: $r("app.media.ic_collect")
      })
        .onClick(()=>{
          router.pushUrl({
            url:"pages/mine/FavoritesPage"
          })
        })

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(1)
        .lineCap(LineCapStyle.Round)
      ListMenuItem({
        title: "朋友圈",
        iconSrc: $r('app.media.ic_moment_pic')
      })
        .onClick(()=>{
          router.pushUrl({
            url:"pages/Moment/mineMomentPage"
          })
        })
      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(1)
        .lineCap(LineCapStyle.Round)
      ListMenuItem({
        title: "卡包",
        iconSrc: $r('app.media.ic_card_pkg')
      })
        .onClick(()=>{
          router.pushUrl(
            {url:"pages/mine/CardPage"}
          )
          })
      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(1)
        .lineCap(LineCapStyle.Round)
      ListMenuItem({
        title: "表情",
        iconSrc: $r('app.media.ic_face_icon')
      })
      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)
      ListMenuItem({
        title: "设置",
        iconSrc: $r('app.media.ic_setting')
      })
        .onClick(()=>{
          router.pushUrl({
            url:"pages/Setting/Setting"
          })
        })

    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f0f0f0")
  }
}
