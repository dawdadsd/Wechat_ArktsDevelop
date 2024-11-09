import router from '@ohos.router';

@Entry
@Component
struct UploadContactsPage {
  @State phoneNumber: string = '166*****97'

  build() {
    Column() {
      // Title bar
      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Blank()
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })

      // Main content
      Column() {
        Text(`已绑定手机号: ${this.phoneNumber}`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 40, bottom: 16 })

        Text('上传你的手机通讯录后，可了解通讯录中哪些朋友注册了账号。')
          .fontSize(16)
          .textAlign(TextAlign.Center)
          .margin({ bottom: 40 })
          .padding({ left: 32, right: 32 })

        Blank()

        Button('上传通讯录找朋友')
          .width('90%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#07C160')
          .margin({ bottom: 16 })

        Button('更换手机号')
          .width('90%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#F2F2F2')
          .fontColor('#000000')
          .margin({ bottom: 32 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
