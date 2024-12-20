// import router from '@ohos.router';
// import promptAction from '@ohos.promptAction';
// @Entry
// @Component
// struct LoginPage{
//   //@State verificationCode: string = "获取验证码"
//   @State account :string = ''
//   @State password :string =''
//   @State isCountingDown:boolean = false
//   @State Countdown:number=60
//   private intervalID:number = 0
//   //倒计时开始函数
//   /*startCountDown(){
//     if (this.isCountingDown){
//       // 重复提交时弹出
//       promptAction.showToast({
//         message:'提交过于频繁',
//         duration: 2000,
//       })
//       return
//     }
//     //准备开始阶段，把倒计时开关打开
//     this.isCountingDown = true
//     this.Countdown = 60;
//     //开始倒计时
//     this.intervalID = setInterval(() => {
//       if (this.Countdown > 0) {
//         this.Countdown--;
//         this.verificationCode = `${this.Countdown}s后重新获取`;
//       } else {
//
//       }
//     }, 1000);
//     //强制倒计时结束，当超过60s时自动停止
//     setTimeout(()=>{
//       this.stopCountdown()
//     },60000)
//   }
//   //倒计时停止函数
//   stopCountdown(){
//     if(this.intervalID){
//       clearInterval(this.intervalID)
//     }
//     //把倒计时重置
//     this.isCountingDown = false
//     this.verificationCode = "获取验证码"
//   }*/
//
//   build() {
//     Column() {
//       Image($r('app.media.huangjingni'))
//         .width(120)
//         .height(120)
//         .margin({ top: 50, bottom: 20 })
//       Text("17750888778")
//         .fontSize(24)
//         .fontWeight(FontWeight.Bold)
//         .margin({ bottom: 40 })
//       Row() {
//         Text("密码")
//           .fontSize(16)
//           .fontWeight(FontWeight.Bold)
//           .margin({ right: 10 })
//         TextInput({ placeholder: "请填写微信密码" })
//           .width('50%')
//           .height(44)
//           .backgroundColor(Color.White)
//           .margin({ right: 10 })
//           .onChange((value: string) => {
//             this.account = value})
//         /*Button(this.verificationCode)
//           .width('30%')
//           .height(44)
//           .backgroundColor(Color.White)
//           .fontColor("#07C160")
//           .borderRadius(0)
//           .onClick(()=>this.startCountDown())*/
//       }
//       .width('90%')
//       .padding(10)
//       .backgroundColor(Color.White)
//       .borderRadius(8)
//       .margin({ bottom: 10 })
//
//       Row() {
//         Text("切换验证方式")
//           .fontColor("#576B95")
//           .fontSize(14)
//       }
//       .width('80%')
//       .justifyContent(FlexAlign.Start)
//       .margin({ bottom: 40 })
//       .onClick(() => {
//         router.pushUrl({
//           url: 'pages/LoginPage/LoginPage'
//         })
//       })
//
//       Button("登录")
//         .width('80%')
//         .height(44)
//         .backgroundColor("#07C160")
//         .fontColor(Color.White)
//           // 在Login页面中
//         .onClick(() => {
//           router.pushUrl({
//             url: 'pages/Index'
//           })
//         })
//
//       Blank()
//
//       Row() {
//         Text("找回密码")
//           .fontColor("#576B95")
//           .fontSize(14)
//         Text("紧急冻结")
//           .fontColor("#576B95")
//           .fontSize(14)
//           .margin({ left: 20, right: 20 })
//         Text("更多")
//           .fontColor("#576B95")
//           .fontSize(14)
//       }
//       .width('90%')
//       .justifyContent(FlexAlign.Center)
//       .margin({ bottom: 20 })
//     }
//     .width('100%')
//     .height('100%')
//     .backgroundColor("#F7F7F7")
//   }
// }
