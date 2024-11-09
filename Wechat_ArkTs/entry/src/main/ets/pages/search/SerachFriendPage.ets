import router from '@ohos.router';

@Entry
@Component
struct AddFriendPage2 {
  @State searchText: string = ''

  build() {
    Column() {
      Row() {
        Text('取消')
          .fontSize(16)
          .fontColor('#007AFF')
          .onClick(() => {
            router.back()
          })
        Blank()
        Text('添加朋友')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
        Blank()
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F7F7F7')
      TextInput({ placeholder: '账号/手机号', text: this.searchText })
        .width('100%')
        .height(36)
        .backgroundColor(Color.White)
        .margin({ top: 10, bottom: 10 })
        .textAlign(TextAlign.Center)
        .onChange((value: string) => {
          this.searchText = value
          this.checkAndNavigate()
        })

      Row() {
        Text('我的微信号：qq1399092218')
          .fontSize(14)
          .fontColor('#888888')
        Image($r('app.media.ic_qrcode'))
          .width(20)
          .height(20)
          .margin({ left: 5 })
      }
      .width('100%')
      .padding(16)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.White)
      .borderRadius(6)
      Column() {
        this.AddFriendOption($r('app.media.ic_miniprogram'), '雷达加朋友', '添加身边的朋友')
        Divider().color('#EEEEEE').height(1).margin({ left: 56 })
        this.AddFriendOption($r('app.media.ic_group_chat'), '面对面建群', '与身边的朋友进入同一个群聊')
        Divider().color('#EEEEEE').height(1).margin({ left: 56 })
        this.AddFriendOption($r('app.media.ic_scan'), '扫一扫', '扫描二维码名片')
        Divider().color('#EEEEEE').height(1).margin({ left: 56 })
        this.AddFriendOption($r('app.media.ic_official_account'), '手机联系人', '添加通讯录中的朋友')
        Divider().color('#EEEEEE').height(1).margin({ left: 56 })
        this.AddFriendOption($r('app.media.jay'), '公众号', '获取更多资讯和服务')
        Divider().color('#EEEEEE').height(1).margin({ left: 56 })
        this.AddFriendOption($r('app.media.ic_group_chat'), '企业微信联系人', '通过手机号搜索企业微信用户')
      }
      .backgroundColor(Color.White)
      .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F7F7')
  }
  checkAndNavigate() {
    if (this.searchText.toLowerCase() === 'jay') {
      router.pushUrl({
        url:  "pages/search/JayProfilePage",
        params: {
          name: 'Jay'
        }
      })
    }
  }

  @Builder
  AddFriendOption(icon: Resource, title: string, subtitle: string) {
    Row() {
      Image(icon)
        .width(40)
        .height(40)
      Column() {
        Text(title)
          .fontSize(16)
          .fontColor('#333333')
        Text(subtitle)
          .fontSize(14)
          .fontColor('#888888')
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })
      Blank()
      Image($r('app.media.ic_next'))
        .width(16)
        .height(16)
    }
    .width('100%')
    .height(70)
    .padding({ left: 16, right: 16 })
  }
}
