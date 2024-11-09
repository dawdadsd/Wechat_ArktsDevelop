import router from '@ohos.router'
import prompt from '@ohos.promptAction'
import { STATUS_BAR_HEIGHT } from '../utils/StatusBarManager'
@Preview
@Component
export default struct WechatToolbar {
  private title: string = "发现"
  @StorageLink(STATUS_BAR_HEIGHT) statusBarHeight: number = 0
  onRightClick?: () => void
  titleS?: string
  showBack: boolean = false
  showAdd: boolean = true  // 新增属性，控制是否显示添加按钮
  onBackClick?: () => void

  build() {
    Column() {
      // 状态栏占位
      Row()
        .height(px2vp(this.statusBarHeight))

      Stack() {
        Row() {
          if (this.showBack) {
            Image($r('app.media.ic_back'))
              .width(24)
              .height(24)
              .margin({ left: 16 })
              .onClick(() => {
                if (this.onBackClick) {
                  this.onBackClick()
                } else {
                  router.back()
                }
              })
          }

          Text(this.titleS || this.title)
            .fontColor(Color.Black)
            .fontSize(19)
            .fontWeight(500)
            .margin({ left: this.showBack ? 16 : 0 })
        }
        .height("100%")
        .alignItems(VerticalAlign.Center)

        Row() {
          if (this.onRightClick) {
            Image($r('app.media.ic_search'))
              .width(22)
              .height(22)
              .margin({ right: 20 })
              .onClick(() => {
                router.pushUrl({ url: 'pages/search/SearchPage' })
              })
          }
          if (this.showAdd) {  // 只有当 showAdd 为 true 时才显示添加按钮
            Image($r('app.media.ic_add'))
              .width(25)
              .height(25)
              .margin({ right: 18 })
              .onClick(() => {
                router.pushUrl({
                  url: "pages/search/SerachFriendPage"
                })
              })
          }
        }
        .height("100%")
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.End)
      }
      .width("100%")
      .height(53)
    }
    .backgroundColor("#f0f0f0")
    .width("100%")
  }
}
