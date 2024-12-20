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
        }
      }
      .alignItems(HorizontalAlign.Start);
    }
    .margin({ top: 10, bottom: 10, left: 10 })
    .justifyContent(FlexAlign.Start);
  }
}

