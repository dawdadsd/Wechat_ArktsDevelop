import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import text from '@ohos.graphics.text';

@Extend(Text) function ButtonTextStyle () {
  .fontColor(Color.Red)
  .fontSize("#07C160")
}
@Extend(Button) function commonButtonStyle (){
  .width('80%')
  .height(44)
  .backgroundColor("#07C160")
  .fontColor(Color.White)
}

@Entry
@Component
struct LoginPage{
  @State verificationCode: string = "获取验证码"
  @State account :string = ''
  @State password :string =''
  @State isCountingDown:boolean = false
  @State Countdown:number=60
  private intervalID:number = 0
  private correctVerificationCode: string = '';
  @State showVerificationCodeDialog: boolean = false;
  @State isAccountFrozen: boolean = false;

  //倒计时开始函数
  startCountDown(){
    if (this.isCountingDown){
      // 重复提交时弹出
      promptAction.showToast({
        message:'提交过于频繁',
        duration: 2000,
      })
      return
    }
    //准备开始阶段，把倒计时开关打开
    this.isCountingDown = true
    this.Countdown = 60;
    //开始倒计时
    this.intervalID = setInterval(() => {
      if (this.Countdown > 0) {
        this.Countdown--;
        this.verificationCode = `${this.Countdown}s后重新获取`;
      } else {

      }
    }, 1000);
    //强制倒计时结束，当超过60s时自动停止
    setTimeout(()=>{
      this.stopCountdown()
    },60000)

    // 生成随机的5位验证码
    this.correctVerificationCode = Math.floor(Math.random() * 90000 + 10000).toString();
    // 3秒后弹出验证码弹窗
    setTimeout(() => {
      this.showVerificationCodeDialog = true;
    }, 3000);
  }
  //倒计时停止函数
  stopCountdown(){
    if(this.intervalID){
      clearInterval(this.intervalID)
    }
    //把倒计时重置
    this.isCountingDown = false
    this.verificationCode = "获取验证码"
  }

  // 验证码识别
  verifyCode() {
    if (this.isAccountFrozen) {
      promptAction.showToast({
        message: '账号已冻结,无法登录',
        duration: 2000,
      });
      return false;
    }
    if (this.account !== 'jay') {
      promptAction.showToast({
        message: '账号错误',
        duration: 2000,
      });
      return false;
    }
    if (this.password !== this.correctVerificationCode) {
      promptAction.showToast({
        message: '验证码错误',
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
        Text("验证码")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ right: 10 })
        TextInput({ placeholder: "请填写验证码" })
          .width('50%')
          .height(44)
          .backgroundColor(Color.White)
          .margin({ right: 10 })
          .onChange((value: string) => {
            this.password = value
          })
        Button(this.verificationCode)
          .width('30%')
          .height(44)
          .backgroundColor(Color.White)
          .fontColor("#07C160")
          .borderRadius(0)
          .onClick(()=>this.startCountDown())
      }
      .width('90%')
      .padding(10)
      .backgroundColor(Color.White)
      .borderRadius(8)
      .margin({ bottom: 10 })

      Row() {
        Text("切换验证方式")
          .ButtonTextStyle()
      }
      .width('80%')
      .justifyContent(FlexAlign.Start)
      .margin({ bottom: 40 })
      .onClick(() => {
        router.pushUrl({
          url: 'pages/LoginPage/PasswordLogin'
        })
      })
      Button("登录")
        .commonButtonStyle()
        .onClick(() => {
          if (this.verifyCode()) {
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
              message: '密码已找回,密码是654321',
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

      if (this.showVerificationCodeDialog) {
        Column() {
          Text(`你的验证码是: ${this.correctVerificationCode}`)
            .fontSize(18)
            .margin({ bottom: 20 })
          Row() {
            Button("确认")
              .onClick(() => {
                this.password = this.correctVerificationCode;
                this.showVerificationCodeDialog = false;
              })
            Button("x")
              .onClick(() => {
                this.showVerificationCodeDialog = false;
              })
          }
        }
        .width(200)
        .height(100)
        .backgroundColor(Color.White)
        .border({ color: Color.Black, width: 1 })
        .padding(10)
        .position({ x: 20, y: 20 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#F7F7F7")
  }
}
