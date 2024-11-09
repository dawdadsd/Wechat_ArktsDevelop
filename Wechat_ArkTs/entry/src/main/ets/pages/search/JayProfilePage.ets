import router from '@ohos.router';

@Entry
@Component
struct JayProfilePage {
  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Blank()
        Image($r('app.media.ic_more'))
          .width(24)
          .height(24)
      }
      .width('100%')
      .height(50)
      .padding({left: 16, right: 16})
      Row() {
        Image($r('app.media.jay'))
          .width(60)
          .height(60)
          .borderRadius(30)
        Column() {
          Text('不喝饮料')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
        }
        .alignItems(HorizontalAlign.Start)
        .margin({left: 16})
      }
      .width('100%')
      .padding({left: 16, right: 16, top: 20, bottom: 20})
      List() {
        ListItem() {
          Row() {
            Text('备注和标签')
              .fontSize(16)
            Blank()
            Image($r('app.media.ic_next'))
              .width(16)
              .height(16)
          }
          .width('100%')
        }
        .height(50)
        .backgroundColor(Color.White)

        ListItem() {
          Row() {
            Text('来源')
              .fontSize(16)
            Blank()
            Text('来自手机号搜索')
              .fontSize(14)
              .fontColor(Color.Gray)
          }
          .width('100%')
        }
        .height(50)
        .backgroundColor(Color.White)

        ListItem() {
          Row() {
            Text('更多信息')
              .fontSize(16)
            Blank()
            Image($r('app.media.ic_new_friend'))
              .width(16)
              .height(16)
            Image($r('app.media.ic_next'))
              .width(16)
              .height(16)
              .margin({ left: 8 })
          }
          .width('100%')
        }
        .height(50)
        .backgroundColor(Color.White)
      }
      Button('添加到通讯录')
        .width('90%')
        .height(45)
        .margin({top: 20})
        .backgroundColor('#1AAD19')
        .fontColor(Color.White)
        .onClick(()=>{
          router.pushUrl({
            url:"pages/search/AddFriden/AddFriendRequestPage"
          })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F7F7')
  }
}
