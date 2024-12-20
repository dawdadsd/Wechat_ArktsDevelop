import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
@Entry
@Component
struct LoginPage{
  @State account :string = ''
  @State password :string =''
  @State isPasswordVisible: boolean = false
  private correctPassword: string = '123456'; // 正确的密码
  @State isAccountFrozen: boolean = false;

  togglePasswordVisibility(){
    this.isPasswordVisible = !this.isPasswordVisible
  }

  // 密码识别
  verifyPassword() {
    if (this.isAccountFrozen) {
      promptAction.showToast({
        message: '账号已冻结,无法登录',
        duration: 2000,
      });
      return false;
    }
    if (this.account !== 'jay') {
      promptAction.showToast({
        message: '账号或密码错误',
        duration: 2000,
      });
      return false;
    }
    if (this.password !== this.correctPassword) {
      promptAction.showToast({
        message: '账号或密码错误',
        duration: 2000,
      });
      return false;
    }
    return true;
  }

  build() {
    Column() {
      Image($r('app.media.jay'))
        .width(120)
        .height(120)
        .margin({ top: 50, bottom: 20 })
      Text("example")
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 40 })
      Row() {
        Text("账号")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ right: 10 })
        TextInput({ placeholder: "请填写账号" })
          .width('50%')
          .height(44)
          .backgroundColor(Color.White)
          .margin({ right: 10 })
          .onChange((value: string) => {
            this.account = value
          })
      }
      .width('90%')
      .padding(10)
      .backgroundColor(Color.White)
      .borderRadius(8)
      .margin({ bottom: 10 })

      Row() {
        Text("密码")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ right: 10 })
        TextInput({ placeholder: "请填写微信密码"} )
          .width('50%')
          .height(44)
          .backgroundColor(Color.White)
          .margin({ right: 10 })
          .onChange((value: string) => {
            this.password = value
          })
      }
      .width('90%')
      .padding(10)
      .backgroundColor(Color.White)
      .borderRadius(8)
      .margin({ bottom: 10 })

      Row() {
        Text("切换验证方式")
          .fontColor("#576B95")
          .fontSize(14)
      }
      .width('80%')
      .justifyContent(FlexAlign.Start)
      .margin({ bottom: 40 })
      .onClick(() => {
        router.pushUrl({
          url: 'pages/LoginPage/LoginPage'
        })
      })

      Button("登录")
        .width('80%')
        .height(44)
        .backgroundColor("#07C160")
        .fontColor(Color.White)
        .onClick(() => {
          if (this.verifyPassword()) {
            router.pushUrl({
              url: 'pages/Index'
            });
          }
        })

      Blank()

      Row() {
        Text("找回密码")
          .fontColor("#576B95")
          .fontSize(14)
          .onClick(() => {
            promptAction.showToast({
              message: '密码已找回,密码是123456',
              duration: 2000,
            });
          })
        Text("紧急冻结")
          .fontColor("#576B95")
          .fontSize(14)
          .margin({ left: 20, right: 20 })
          .onClick(() => {
            this.isAccountFrozen = true;
            promptAction.showToast({
              message: '账号已冻结',
              duration: 2000,
            });
          })
        Text("更多")
          .fontColor("#576B95")
          .fontSize(14)
      }
      .width('90%')
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#F7F7F7")
  }
}
