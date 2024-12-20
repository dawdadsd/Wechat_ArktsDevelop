import router from '@ohos.router';
import { Friend, RouterParams } from '../../contact/NewFriendPage/Friend';
@Entry
@Component
struct AddFriendRequestPage {
  @State message: string = '我是不喝饮料'
  @State remark: string = '只喝饮料'
  @State friendPermission: number = 0
  @State hideFromFriend: boolean = false
  @State hideFromMe: boolean = false

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Text('申请添加朋友')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })

      Scroll() {
        Column() {
          this.SectionTitle('发送添加朋友申请')
          this.InputArea(this.message, '我是不喝饮料')

          this.SectionTitle('设置备注')
          this.InputArea(this.remark, '爱你永不变')

          this.SectionTitle('添加标签与描述')
          this.SettingItem('标签')
          this.SettingItem('描述')

          this.SectionTitle('设置朋友权限')
          this.PermissionSetting()

          this.SectionTitle('朋友圈和状态')
          this.ToggleSetting('不让他(她)看', this.hideFromFriend)
          this.ToggleSetting('不看他(她)', this.hideFromMe)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
      }
      .layoutWeight(1)

      Button('发送')
        .width('90%')
        .height(45)
        .backgroundColor('#1AAD19')
        .fontColor(Color.White)
        .margin({ bottom: 20 })
        .onClick(() => {
          const newFriendRequest: Friend = {
            name: '不喝饮料', // 使用输入的备注或默认名称
            description: this.message, // 使用输入的申请消息
            avatar: $r('app.media.jay'), // 使用默认头像或其他适当的头像
            status: '待同意',
            isAdded:false
          }

          const params: RouterParams = {
            newFriendRequest: newFriendRequest
          };

          router.pushUrl({
            url: "pages/contact/NewFriendPage/NewFriendPage",
            params: params
          })

        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F7F7')
  }

  @Builder SectionTitle(title: string) {
    Text(title)
      .fontSize(14)
      .fontColor(Color.Gray)
      .margin({ top: 20, bottom: 10 })
      .alignSelf(ItemAlign.Start)
  }

  @Builder InputArea(content: string, placeholder: string) {
    TextArea({ text: content, placeholder: placeholder })
      .width('100%')
      .backgroundColor(Color.White)
      .height(100)
      .margin({ bottom: 10 })
  }

  @Builder SettingItem(title: string) {
    Row() {
      Text(title)
        .fontSize(16)
      Blank()
      Image($r('app.media.ic_next'))
        .width(16)
        .height(16)
    }
    .width('100%')
    .height(50)
    .backgroundColor(Color.White)
    .padding({ left: 16, right: 16 })
  }

  @Builder PermissionSetting() {
    Column() {
      Row() {
        Text('聊天、朋友圈、微信运动等')
          .fontSize(16)
        Blank()
        Image($r('app.media.ic_add'))
          .width(16)
          .height(16)
          .visibility(this.friendPermission === 0 ? Visibility.Visible : Visibility.Hidden)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.White)
      .padding({ left: 16, right: 16 })

      Row() {
        Text('仅聊天')
          .fontSize(16)
        Blank()
        Image($r('app.media.ic_add'))
          .width(16)
          .height(16)
          .visibility(this.friendPermission === 1 ? Visibility.Visible : Visibility.Hidden)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.White)
      .padding({ left: 16, right: 16 })
    }
  }

  @Builder ToggleSetting(title: string, isOn: boolean) {
    Row() {
      Text(title)
        .fontSize(16)
      Blank()
      Toggle({ type: ToggleType.Switch, isOn: isOn })
    }
    .width('100%')
    .height(50)
    .backgroundColor(Color.White)
    .padding({ left: 16, right: 16 })
  }
}
