import { ChatContentItemData } from '../pages/chat/ChatContentItemData'

@Preview
@Component
export default struct ListChatContentLeftItem {
  private data?: ChatContentItemData;

  build() {
    Row() {
      Image(this.data?.headSrc)
        .width(40)
        .height(40)
        .borderRadius(20)
        .margin({ right: 10 });

      Column() { 
        if (this.data?.msgType === 0) {
          Text(this.data.msg)
            .fontSize(18)
            .padding(10)
            .backgroundColor("#FFFFFF")
            .borderRadius(10);
        } else if (this.data?.msgType === 1) {
          Text(this.data.msg)
            .fontSize(24)
            .padding(10)
            .backgroundColor("#FFFFFF")
            .borderRadius(10);
        } else if (this.data?.msgType === 2) {
          Image($r("app.media.ic_voice"))
            .width(40)
            .height(40)
            .margin({ right: 10 })
            .objectFit(ImageFit.Contain)
            .onClick(() => {
              // 点击播放录音消息
            })
        } else if (this.data?.msgType === 3) {
          Text(this.data?.msg)
            .fontSize(24)
            .padding(10)
            .backgroundColor("#a9ea7a")
            .borderRadius(10)
            .textAlign(TextAlign.End)
        }
      }
      .alignItems(HorizontalAlign.Start);
    }
    .margin({ top: 10, bottom: 10, left: 10 })
    .justifyContent(FlexAlign.Start);
  }
}

