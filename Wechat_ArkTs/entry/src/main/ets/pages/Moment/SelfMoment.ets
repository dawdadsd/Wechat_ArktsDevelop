import router from '@ohos.router'
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';

@Entry
@Component
struct DiaryPage {
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#F7F7F7', true);
  }
  build() {
    Column() {
      Row().height(`${this.statusBarHeight}px`).width('100%').backgroundColor('#F7F7F7')
      Stack({ alignContent: Alignment.TopStart }) {
        Image($r('app.media.jay'))
          .width('100%')
          .height(240)
          .objectFit(ImageFit.Cover)

        Button({ type: ButtonType.Circle, stateEffect: true }) {
          Image($r('app.media.ic_back'))
            .width(24)
            .height(24)
        }
        .width(40)
        .height(40)
        .position({ x: 20, y: 20 })
        .backgroundColor('#80FFFFFF')
        .onClick(() => {
          router.back()
        })

        Row() {
          Column({ space: 4 }) {
            Text('不喝饮料')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
            Text('知南北行，徐北游')
              .fontSize(12)
              .fontColor(Color.White)
          }.alignItems(HorizontalAlign.End)

          Image($r('app.media.jay'))
            .width(40)
            .height(40)
            .borderRadius(20)
            .margin({ left: 10 })
        }
        .position({ x: '100%', y: '100%' })
        .translate({ x: -160, y: -50 })
        .width(150)
      }
      .height(240)
      .width('100%')

      Column({ space: 20 }) {
        Text('寻找诗和远方')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        Text('徐霞客游记')
          .fontSize(16)
          .fontColor('#999999')

        Text('江南多佳木，锦绣不可名。草木之盛，宜其土地之腴美也。秦岭以北，不见异木，古松乔柏，栎棫槠柞而已。及至江淮，渐闻有香樟、杜仲、楠木、梓桐诸名。至闽至粤，始见繁茂，亦自然之理也。')
          .fontSize(16)
          .fontColor('#666666')
      }
      .width('100%')
      .padding(20)
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 20, topRight: 20 })
      .margin({ top: -20 })

      List() {
        ListItem() {
          Column({ space: 8 }) {
            Text('今天').fontSize(16).fontWeight(FontWeight.Bold)
            Text('南宁市 · 老口渡口').fontSize(14).fontColor(Color.Gray)
            Text('Today go where?').fontSize(14)
            Grid() {
              GridItem() {
                Image($r('app.media.today_1'))
                  .width('100%')
                  .height('100%')
                  .borderRadius(8)
              }.rowStart(1).rowEnd(1).columnStart(2).columnEnd(2)

              GridItem() {
                Image($r('app.media.today_2'))
                  .width('100%')
                  .height('100%')
                  .borderRadius(8)
              }.rowStart(1).rowEnd(1).columnStart(2).columnEnd(2)

              GridItem() {
                Image($r('app.media.today_3'))
                  .width('100%')
                  .height('100%')
                  .borderRadius(8)
              }.rowStart(1).rowEnd(2).columnStart(2).columnEnd(2)

              GridItem() {
                Image($r('app.media.today_4'))
                  .width('100%')
                  .height('100%')
                  .borderRadius(8)
              }.rowStart(1).rowEnd(2).columnStart(2).columnEnd(2)

              GridItem() {
                Image($r('app.media.today_1'))
                  .width('100%')
                  .height('100%')
                  .borderRadius(8)
              }.rowStart(1).rowEnd(2).columnStart(2).columnEnd(2)
            }
            .width('60%')
            .height('60%')
            .columnsTemplate('1fr 1fr 1fr')
            .rowsTemplate('1fr 1fr 1fr')
            .margin({ top: 8 })


          }.alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ top: 16, bottom: 16 })
        }

        ListItem() {
          Column({ space: 8 }) {
            Text('昨天').fontSize(16).fontWeight(FontWeight.Bold)
            Text('适合睡觉啊').fontSize(14)
            Grid() {
              GridItem() {
                Image($r('app.media.today_1'))
                  .width('100%')
                  .height('100%')
                  .borderRadius(8)
              }.rowStart(1).rowEnd(1).columnStart(2).columnEnd(2)

              GridItem() {
                Image($r('app.media.today_2'))
                  .width('100%')
                  .height('100%')
                  .borderRadius(8)
              }.rowStart(1).rowEnd(1).columnStart(2).columnEnd(2)

              GridItem() {
                Image($r('app.media.today_3'))
                  .width('100%')
                  .height('100%')
                  .borderRadius(8)
              }.rowStart(1).rowEnd(2).columnStart(2).columnEnd(2)

              GridItem() {
                Image($r('app.media.today_4'))
                  .width('100%')
                  .height('100%')
                  .borderRadius(8)
              }.rowStart(1).rowEnd(2).columnStart(2).columnEnd(2)

              GridItem() {
                Image($r('app.media.today_1'))
                  .width('100%')
                  .height('100%')
                  .borderRadius(8)
              }.rowStart(1).rowEnd(2).columnStart(2).columnEnd(2)
            }
            .width('60%')
            .height('60%')
            .columnsTemplate('1fr 1fr 1fr')
            .rowsTemplate('1fr 1fr 1fr')
            .margin({ top: 8 })


          }.alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ top: 16, bottom: 16 })
        }
        ListItem() {
          Column({ space: 8 }) {
            Text('29 10月').fontSize(16).fontWeight(FontWeight.Bold)
            Row({ space: 8 }) {
              ForEach([1, 2, 3], (item:number) => {
                Image($r(`app.media.day29_${item}`))
                  .width(105)
                  .height(80)
                  .borderRadius(8)
              })
            }
            Text('今天骑去哪').fontSize(14)
          }.alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ top: 16, bottom: 16 })
        }
      }
      .width('100%')
      .margin({ top: 16 })
      .divider({ strokeWidth: 0.5, color: '#E0E0E0' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
