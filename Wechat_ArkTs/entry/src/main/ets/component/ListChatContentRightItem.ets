import { ChatContentItemData } from '../pages/chat/ChatContentItemData'

@Preview
@Component
export default struct ListChatContentRightItem {
  data?: ChatContentItemData

  build() {
    Row() {
      Column() {
        if (this.data?.msgType === 0) {
          Text(this.data?.msg)
            .fontColor(Color.Black)
            .fontWeight(500)
            .fontSize(18)
            .padding(13.5)
            .borderRadius(4)
            .backgroundColor("#a9ea7a")
        } else if (this.data?.msgType === 1) {
          Text(this.data?.msg)
            .fontSize(24)
            .padding(10)
            .backgroundColor("#a9ea7a")
            .borderRadius(10)
            .textAlign(TextAlign.End)
        } else if (this.data?.msgType === 2) {
          Image($r("app.media.ic_voice"))
            .width(40)
            .height(40)
            .margin({ left: 10 })
            .objectFit(ImageFit.Contain)
            .onClick(() => {
              // 点击播放录音消息
            })
        }else if(this.data?.msgType === 3){
          Text(this.data?.msg)
            .fontSize(24)
            .padding(10)
            .backgroundColor("#a9ea7a")
            .borderRadius(10)
            .textAlign(TextAlign.End)
        }
      }
      .margin({ left: 80 })
      .alignItems(HorizontalAlign.End)
      .layoutWeight(1)

      Path()
        .commands(`M0 0 L${vp2px(10)} ${vp2px(7)} 0 ${vp2px(14)} Z`)
        .fill('rgb(169,234,122)')
        .margin({
          top: 18
        })
        .strokeWidth(0)

      Image(this.data?.headSrc)
        .width(40)
        .height(40)
        .borderRadius(20)
        .margin({ left: 8, right: 20 })
        .objectFit(ImageFit.Cover)

    }.alignItems(VerticalAlign.Top)
  }
}