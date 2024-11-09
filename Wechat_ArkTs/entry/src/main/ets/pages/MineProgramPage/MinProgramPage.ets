import { router } from '@kit.ArkUI'
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';

@Entry
@Component
struct MiniProgramPage {
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#F7F7F7', true);
  }
  build() {
    Column() {
      // 顶部导航栏
      Row().height(`${this.statusBarHeight}px`).width('100%')
      Row() {
        Image($r('app.media.ic_back'))
          .width(24).height(24)
          .onClick(()=>{
            router.back()
          })
        Text('小程序')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({left: 16})
        Blank()
        Image($r('app.media.ic_search'))
          .width(24).height(24)
        Image($r('app.media.ic_group_chat'))
          .width(24).height(24)
          .margin({left: 16})
          .onClick(()=>{
            router.pushUrl({
              url:"pages/MineProgramPage/PersonalCenterPage"
            })
          })
      }
      .width('100%')
      .height(56)
      .padding({left: 16, right: 16})
      .backgroundColor('#F7F7F7')

      // 主体内容
      Scroll() {
        Column() {
          // 交易评价邀请
          this.TradeReviewInvitation()

          // 最近使用
          this.RecentlyUsed()

          // 我的常用
          this.MyFrequentlyUsed()

          // 附近的小程序
          this.NearbyMiniPrograms()

          // 小游戏
          this.MiniGames()

          // 政务民生
          this.GovernmentServices()
        }
        .padding({left: 16, right: 16})
      }
      .backgroundColor('#F7F7F7')
    }
  }

  @Builder TradeReviewInvitation() {
    Row() {
      Row() {
        Image($r('app.media.jay'))
          .width(40).height(40)
        Column() {
          Text('柳盘外卖')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          Text('10月23日消费¥150.00')
            .fontSize(14)
            .fontColor('#999999')
        }.margin({left: 12})
      }
      Button('去评价')
        .fontSize(14)
        .fontColor(Color.White)
        .backgroundColor('#4CAF50')
        .width(80)
        .height(32)
        .borderRadius(16)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({top: 12, bottom: 12})
  }

  @Builder RecentlyUsed() {
    Column() {
      Row() {
        Text('最近使用')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        Image($r('app.media.ic_next'))
          .width(16).height(16)
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)

      Flex({ justifyContent: FlexAlign.SpaceBetween, wrap: FlexWrap.Wrap }) {
        this.MiniProgramIcon('Ai', $r('app.media.aippt'))
        this.MiniProgramIcon('安全教育平台', $r('app.media.anquanjiaoyu'))
        this.MiniProgramIcon('百词斩', $r('app.media.baicizhan'))
        this.MiniProgramIcon('霸王茶姬', $r('app.media.bawang'))
      }.margin({top: 12})
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({bottom: 12})
  }

  @Builder MyFrequentlyUsed() {
    Column() {
      Text('我的常用')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Flex({ justifyContent: FlexAlign.SpaceBetween, wrap: FlexWrap.Wrap }) {
        this.MiniProgramIcon('Ai', $r('app.media.aippt'))
        this.MiniProgramIcon('安全教育平台', $r('app.media.anquanjiaoyu'))
        this.MiniProgramIcon('百词斩', $r('app.media.baicizhan'))
        this.MiniProgramIcon('霸王茶姬', $r('app.media.bawang'))
        this.MiniProgramIcon('茶百道', $r('app.media.chabaidao'))
        this.MiniProgramIcon('创新教育平台', $r('app.media.chuangxin'))
        this.MiniProgramIcon('词', $r('app.media.cidaren'))
        this.MiniProgramIcon('cotti', $r('app.media.cotti'))
      }.margin({top: 12})
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({bottom: 12})
  }

  @Builder NearbyMiniPrograms() {
    Column() {
      Row() {
        Text('附近的小程序')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        Image($r('app.media.ic_next'))
          .width(16).height(16)
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)

      Column() {
        this.NearbyMiniProgramItem('luckincoffee瑞幸咖啡', '瑞幸咖啡，新鲜现制业咖啡', $r('app.media.chabaidao'))
        this.NearbyMiniProgramItem('霸王茶姬', '东方新茶铺，原叶鲜奶茶，传承茶事文化', $r('app.media.bawang'))
        this.NearbyMiniProgramItem('茶百道', '南宁学院店 54m', $r('app.media.chabaidao'))
      }.margin({top: 12})
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({bottom: 12})
  }

  @Builder MiniGames() {
    Column() {
      Row() {
        Text('小游戏')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        Text('更多新游戏')
          .fontSize(14)
          .fontColor('#999999')
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)

      Column() {
        this.MiniGameItem('没事找事干', '嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻', $r('app.media.jay'))
        this.MiniGameItem('干了就没事', '哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈', $r('app.media.jay'))
        this.MiniGameItem('没事就要干', '啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦', $r('app.media.jay'))
      }.margin({top: 12})
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({bottom: 12})
  }

  @Builder GovernmentServices() {
    Row() {
      Text('政务民生')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
      Image($r('app.media.ic_next'))
        .width(16).height(16)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({bottom: 12})
  }

  @Builder MiniProgramIcon(name: string, icon: Resource) {
    Column() {
      Image(icon)
        .width(48).height(48)
        .borderRadius(8)
      Text(name)
        .fontSize(12)
        .margin({top: 8})
    }.width('25%').alignItems(HorizontalAlign.Center)
  }

  @Builder NearbyMiniProgramItem(name: string, description: string, icon: Resource) {
    Row() {
      Image(icon)
        .width(40).height(40)
        .borderRadius(8)
      Column() {
        Text(name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        Text(description)
          .fontSize(14)
          .fontColor('#999999')
      }.margin({left: 12})
    }
    .width('100%')
    .padding({top: 8, bottom: 8})
  }

  @Builder MiniGameItem(name: string, description: string, icon: Resource) {
    Row() {
      Image(icon)
        .width(60).height(60)
        .borderRadius(8)
      Column() {
        Text(name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        Text(description)
          .fontSize(14)
          .fontColor('#999999')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }.margin({left: 12}).layoutWeight(1)
    }
    .width('100%')
    .padding({top: 8, bottom: 8})
  }
}
