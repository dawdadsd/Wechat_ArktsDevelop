import router from '@ohos.router';
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';

// 定义明确的接口
interface ImageItem {
  id: number;
}
interface StatusItem {
  day: string;
  icon: Resource;
}

@Entry
@Component
struct mineMomentPage {
  @State currentTab: string = '朋友圈相册'
  @State imageList: ImageItem[] = [
    { id: 1 }, { id: 2 }, { id: 3 }, { id: 4 }, { id: 5 },
    { id: 6 }, { id: 7 }, { id: 8 }, { id: 9 }, { id: 10 }
  ]
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#F7F7F7', true);
  }

  build() {
    Column() {
      // 状态栏占位
      Row().height(`${this.statusBarHeight}px`).width('100%').backgroundColor('#F7F7F7')

      // 顶部栏
      Row() {
        Image($r('app.media.ic_back_black'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Blank()
        Text('朋友圈').fontSize(18).fontWeight(FontWeight.Bold)
        Blank()
        Image($r('app.media.state_threePoints')).width(24).height(24)
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F7F7F7')

      // 选项卡
      Row() {
        Text('朋友圈相册')
          .fontSize(16)
          .fontColor(this.currentTab === '朋友圈相册' ? Color.Black : Color.Gray)
          .onClick(() => this.currentTab = '朋友圈相册')
        Text('状态')
          .fontSize(16)
          .fontColor(this.currentTab === '状态' ? Color.Black : Color.Gray)
          .onClick(() => this.currentTab = '状态')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ top: 10, bottom: 10 })
      .backgroundColor(Color.White)

      if (this.currentTab === '朋友圈相册') {
        this.AlbumContent()
      } else {
        this.StatusContent()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder AlbumContent() {
    Column() {
      // 我的朋友圈
      Row() {
        Text('我的朋友圈')
          .fontSize(16)
        Image($r('app.media.ic_more'))
          .width(20)
          .height(20)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(Color.White)
      .onClick(()=>{
        router.pushUrl({
          url:"pages/Moment/MomentDataItem"
        })
      })
      // 图片网格
      Grid() {
        ForEach(this.imageList, (item: ImageItem) => {
          GridItem() {
            Image($r('app.media.xubaomei'))
              .width('100%')
              .aspectRatio(1)
              .objectFit(ImageFit.Cover)
          }
        }, (item: ImageItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsGap(4)
      .columnsGap(4)
      .padding(16)
      .backgroundColor(Color.White)
    }
  }

  @Builder StatusContent() {
    Column() {
      this.buildMonthSection('8月', [
        { day: '2', icon: $r('app.media.xiangzuo') },
        { day: '1', icon: $r('app.media.xiangzuo') }
      ])

      this.buildMonthSection('6月', [
        { day: '17', icon: $r('app.media.xiangzuo') },
        { day: '5', icon: $r('app.media.xiangzuo') },
        { day: '3', icon: $r('app.media.xiangzuo') },
        { day: '2', icon: $r('app.media.xiangzuo') }
      ])

      // 年份指示器
      Text('2023年')
        .fontSize(16)
        .fontColor(Color.Black)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(Color.White)
        .padding({ top: 16, bottom: 16 })
    }
    .width('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  buildMonthSection(month: string, days: StatusItem[]) {
    Column() {
      Text(month)
        .fontSize(18)
        .fontColor(Color.Black)
        .alignSelf(ItemAlign.Start)
        .margin({ left: 16, top: 16, bottom: 8 })

      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
        ForEach(days, (item: StatusItem) => {
          Column() {
            Text(item.day)
              .fontSize(14)
              .fontColor(Color.Gray)
            Image(item.icon)
              .width(40)
              .height(40)
              .margin({ top: 4 })
          }
          .margin({ right: 16, bottom: 16 })
        })
      }
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
  }
}
