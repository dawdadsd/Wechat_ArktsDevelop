import router from '@ohos.router'

@Entry
@Component
struct Shouye {

  build() {
    // 使用 Stack 组件来重叠背景图和内容
    Stack() {
      // 背景图片填充
      Image($r('app.media.splash'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)

      // 内容区域
      Column() {
        // 添加一个占位元素，推送按钮到底部
        Column() {
          // 这个内部 Column 充当占位符，用于推挤下方的内容
          // 可以只设置高度，保证它们占用剩余空间
          // 如果存在 UI 库支持的设置高度方式可替代这段代码

          // 例如，假设使用的高度为 `flexGrow(1)`
        }
        .flexGrow(1) // 占用剩余空间以推动到下方

        Row({ space: 20 }) {
          Button("登录", { type: ButtonType.Normal })
            .width(150)
            .height(50)
            .backgroundColor($r("app.color.green0"))
            .fontSize(18)
            .fontColor($r("app.color.white"))
            .borderRadius(8)
            .onClick(() => {
              router.pushUrl({
                url: "pages/LoginPage/LoginPage"
              })
            })

          Button("注册", { type: ButtonType.Normal })
            .width(150)
            .height(50)
            .backgroundColor($r("app.color.white"))
            .fontSize(18)
            .fontColor($r("app.color.black"))
            .borderRadius(8)
            .shadow({ radius: 10, offsetX: 5, offsetY: 5 })
            .onClick(() => {
              router.pushUrl({
                url: "pages/LoginPage/LoginPage"
              })
            })
        }
        .justifyContent(FlexAlign.Center) // 水平居中按钮
        .margin({ bottom: 20 }) // 确保底部有些间隔
      }
      .width('100%')
      .height('100%')
    }
    .width('100vw') // 确保全屏宽度
    .height('100vh') // 确保全屏高度
    .padding(0) // 移除默认的外边距
  }
}
