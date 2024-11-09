import { router } from '@kit.ArkUI'
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';

@Entry
@Component
struct PersonalCenterPage {
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#F7F7F7', true);
  }
  build() {
    Column() {
      Row().height(`${this.statusBarHeight}px`).width('100%')

      // 顶部导航栏
      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .onClick(()=>{
            router.back()
          })
        Text('个人中心')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({left: 16})
      }
      .width('100%')
      .height(56)
      .padding({left: 16, right: 16})
      .backgroundColor(Color.White)

      // 主体内容
      Scroll() {
        Column() {
          this.ListItem('我的手机号码')
          this.ListItem('我的评价')

          // 分割线
          Divider().color('#F0F0F0').height(8)

          this.ToggleItem('我的常用小程序', '开启后,将在「我的常用小程序」基于你的小程序使用记录展示常用的小程序。')
          this.ToggleItem('小程序个性化推荐', '开启后,将基于你的小程序使用记录推荐你可能感兴趣的小程序。')
          this.ListItem('小程序中的个人信息与权限')
          this.ListItem('第三方应用运行小程序授权')
        }
        .backgroundColor(Color.White)
      }
      .backgroundColor('#F7F7F7')
    }
  }

  @Builder ListItem(title: string, description?: string) {
    Row() {
      Text(title)
        .fontSize(16)
        .fontColor('#333333')
      Blank()
      if (description) {
        Text(description)
          .fontSize(14)
          .fontColor('#999999')
          .layoutWeight(1)
          .textAlign(TextAlign.End)
          .margin({right: 4})
      }
      Image($r('app.media.ic_next'))
        .width(16).height(16)
    }
    .width('100%')
    .height(56)
    .padding({left: 16, right: 16})
    .backgroundColor(Color.White)
  }

  @Builder ToggleItem(title: string, description: string) {
    Column() {
      Row() {
        Text(title)
          .fontSize(16)
          .fontColor('#333333')
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: true })
          .selectedColor('#07C160')
          .switchPointColor(0xe5ffffff)
          .width(51)
          .height(31)
      }
      .width('100%')
      .height(56)
      .padding({left: 16, right: 16})

      Text(description)
        .fontSize(12)
        .fontColor('#999999')
        .width('100%')
        .padding({left: 16, right: 16, bottom: 16})
    }
    .backgroundColor(Color.White)
  }
}
