import router from '@ohos.router';
import home from './home/Home'
import contact from './contact/Contact'
import discovery from './discovery/Discovery'
import mine from './mine/Mine'
import { NAV_BAR_HEIGHT } from '../utils/StatusBarManager'

interface RouteParams {
  activeTab?: number;
}

@Entry
@Component
struct Index {
  @State private currentIndex: number = 0
  private tabController: TabsController = new TabsController()
  private tabTitles: string[] = ["微信", "通信录", "发现", "我"]
  private tabTextColors: string[] = ["#040404", "#57be6a"]
  private tabTipCounts: number[] = [5, 0, 8, 0]
  @StorageLink(NAV_BAR_HEIGHT) navBarHeight: number = 0


  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, controller: this.tabController }) {
        TabContent() {
          home()
        }
        .tabBar(this.createTabMenu(0))
        TabContent() {
          contact()
        }
        .tabBar(this.createTabMenu(1))
        TabContent() {
          discovery()
        }
        .tabBar(this.createTabMenu(2))
        TabContent() {
          mine()
        }
        .tabBar(this.createTabMenu(3))
      }
      .width("100%")
      .height("100%")
      .barHeight(65)
      .backgroundColor("#f4f4f4")
      .vertical(false)
      .layoutWeight(1)

      Row().height(px2vp(this.navBarHeight))
    }
    .width('100%')
    .height('100%')
  }

  @Builder createTabMenu(index: number) {
    Stack({ alignContent: Alignment.Center }) {
      Badge({
        count: this.tabTipCounts[index],
        maxCount: 99,
        position: BadgePosition.RightTop,
        style: { color: 0xFFFFFF, fontSize: 13, badgeSize: 20, badgeColor: Color.Red }
      }) {
        Column() {
          Image(this.currentIndex === index ? `/images/main_page_index${index}_pre.png` : `/images/main_page_index${index}_nor.png`)
            .width(29.714)
            .height(26)
            .objectFit(ImageFit.Fill)
            .margin({ bottom: 3 })
          Text(this.tabTitles[index])
            .fontColor(this.tabTextColors[this.currentIndex === index?1:0])
            .fontSize(14)
        }
        .backgroundColor(Color.Transparent)
        .justifyContent(FlexAlign.Center)
      }
      .width(42)
      .height(40)
    }
    .width("100%")
    .height("100%")
  }
}