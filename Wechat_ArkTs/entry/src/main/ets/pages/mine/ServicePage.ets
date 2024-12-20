import router from '@ohos.router';
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';

@Entry
@Component
struct ServicePage {
  @State balance: string = '5678.2'
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#f1f1f1', false);
  }

  build() {
    Column() {
      Row().height(`${this.statusBarHeight}px`).width('100%')
      Blank()
      // 顶部导航栏
      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .onClick(() => router.back())
        Text('服务')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
        Blank()
        Image($r('app.media.ic_more'))
          .width(24)
          .height(24)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F1F3F5')

      Scroll() {
        Column({ space: 16 }) {
          Row() {
            Column() {
              Image($r('app.media.ic_card_pkg'))
                .width(40)
                .height(40)
              Text('收付款')
                .fontSize(14)
                .margin({ top: 8 })
            }
            .layoutWeight(1)

            Column() {
              Image($r('app.media.wxicon'))
                .width(40)
                .height(40)
              Text('钱包')
                .fontSize(14)
                .margin({ top: 8 })
              Text('¥' + this.balance)
                .fontSize(12)
                .fontColor('#888888')
            }
            .layoutWeight(1)
          }
          .width('100%')
          .height(100)
          .backgroundColor('#4CAF50')
          .borderRadius(8)
          .padding(16)

          this.SectionTitle('金融理财')
          Grid() {
            GridItem() {
              this.ServiceItem('信用卡还款', $r('app.media.bawang'))
            }
            GridItem() {
              this.ServiceItem('理财通', $r('app.media.baicizhan'))
            }
            GridItem() {
              this.ServiceItem('保险服务', $r('app.media.chabaidao'))
            }
          }
          .columnsTemplate('1fr 1fr 1fr')
          .rowsTemplate('1fr')
          .height(80)

          this.SectionTitle('生活服务')
          Grid() {
            GridItem() {
              this.ServiceItem('手机充值', $r('app.media.yinhang'))
            }
            GridItem() {
              this.ServiceItem('生活缴费', $r('app.media.jay'))
            }
            GridItem() {
              this.ServiceItem('Q币充值', $r('app.media.jay'))
            }
            GridItem() {
              this.ServiceItem('城市服务', $r('app.media.jay'))
            }
            GridItem() {
              this.ServiceItem('腾讯公益', $r('app.media.jay'))
            }
            GridItem() {
              this.ServiceItem('医疗健康', $r('app.media.jay'))
            }
          }
          .columnsTemplate('1fr 1fr 1fr')
          .rowsTemplate('1fr 1fr')
          .height(160)

          this.SectionTitle('交通出行')
          Grid() {
            GridItem() {
              this.ServiceItem('出行服务', $r('app.media.jay'))
            }
            GridItem() {
              this.ServiceItem('火车票机票', $r('app.media.jay'))
            }
            GridItem() {
              this.ServiceItem('滴滴出行', $r('app.media.jay'))
            }
            GridItem() {
              this.ServiceItem('酒店民宿', $r('app.media.jay'))
            }
          }
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .rowsTemplate('1fr')
          .height(80)

          this.SectionTitle('购物消费')
          Grid() {
            GridItem() {
              this.ServiceItem('品牌发现', $r('app.media.jay'))
            }
            GridItem() {
              this.ServiceItem('京东购物', $r('app.media.jay'))
            }
            GridItem() {
              this.ServiceItem('美团外卖', $r('app.media.jay'))
            }
            GridItem() {
              this.ServiceItem('电影演出玩乐', $r('app.media.jay'))
            }
            GridItem() {
              this.ServiceItem('美团特价', $r('app.media.jay'))
            }
            GridItem() {
              this.ServiceItem('拼多多', $r('app.media.jay'))
            }
            GridItem() {
              this.ServiceItem('唯品会特卖', $r('app.media.jay'))
            }
            GridItem() {
              this.ServiceItem('转转二手', $r('app.media.jay'))
            }
          }
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .rowsTemplate('1fr 1fr')
          .height(160)
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }

  @Builder
  SectionTitle(title: string) {
    Text(title)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .width('100%')
      .margin({ top: 16, bottom: 8 })
  }

  @Builder
  ServiceItem(name: string, icon: Resource) {
    Column() {
      Image(icon)
        .width(40)
        .height(40)
      Text(name)
        .fontSize(12)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}
