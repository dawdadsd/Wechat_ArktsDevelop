import router from '@ohos.router';
import {CreateMomentPage} from  './CreateMomentPage'
import { MomentDataItem, RouterParams } from './types';
interface GeneratedTypeLiteralInterface_1 {
  newMoment?: Partial<MomentDataItem>;
}

@Entry
@Component
struct MomentPage {
  @State currentIndex: number = 0;
  @State momentData: MomentDataItem[] = [
    {
      headSrc: $r('app.media.huangjingni'),
      nickName: "黄靖妮",
      content: "今天天气好好",
      time: "5分钟前",
      imageList: []
    },
    {
      headSrc: $r('app.media.maju'),
      nickName: "马菊",
      content: "开心",
      time: "16分钟前",
      imageList: []
    }
  ];

  aboutToAppear() {
    this.updateMomentData();
  }
  onPageShow() {
    console.info('MomentPage onPageShow');
    this.updateMomentData();
  }

  updateMomentData() {
    const params = router.getParams() as RouterParams;
    console.info('Received params:', JSON.stringify(params));

    if (params && params.data) {
      const content = params.data.content;
      const imageList = params.data.imageList;

      if (typeof content === 'string') {
        const newMoment: MomentDataItem = {
          headSrc: $r('app.media.jay'),
          nickName: "不喝饮料",
          content: content,
          time: "刚刚",
          imageList: imageList || []
        };
        this.momentData = [newMoment, ...this.momentData];
      }
    }
  }





  build() {
    Column() {
      Stack({ alignContent: Alignment.Top }) {
        Image($r('app.media.simple_Make'))
          .width('100%')
          .height(250)
          .objectFit(ImageFit.Cover)

        Column() {
          this.NavigationBar()
          this.UserInfo()
        }
        .width('100%')
      }
      .height(250)

      List() {
        ForEach(this.momentData, (item: MomentDataItem) => {
          ListItem() {
            this.MomentItem(item)
          }
        })
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor('#000000')

      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.ic_add'))
          .width(24)
          .height(24)
      }
      .width(56)
      .height(56)
      .position({ x: '80%', y: '90%' })
      .backgroundColor('#007DFF')
      .onClick(() => {
        router.pushUrl({ url: 'pages/Moment/CreateMomentPage' })
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder NavigationBar() {
    Row() {
      Image($r('app.media.ic_back'))
        .width(24)
        .height(24)
        .onClick(() => {
          router.back()
        })

      Blank()
      Image($r('app.media.ic_camera'))
        .width(24)
        .height(24)
    }
    .width('100%')
    .height(50)
    .padding({ left: 16, right: 16, top: 20 })
  }

  @Builder UserInfo() {
    Row() {
      Blank()
      Column() {
        Blank()
        Row() {
          Text('不喝饮料')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
          Image($r('app.media.jay'))
            .width(70)
            .height(70)
            .borderRadius(35)
            .margin({ left: 10 })
            .onClick(() => {
              router.pushUrl({
                url: "pages/Moment/ProfilePage"
              })
            })
        }
      }
      .alignItems(HorizontalAlign.End)
      .width('100%')
      .height(180)
      .padding({ right: 20, bottom: 20 })
    }
    .width('100%')
  }

  @Builder MomentItem(data: MomentDataItem) {
    Column() {
      Row() {
        Image(data.headSrc)
          .width(40)
          .height(40)
          .borderRadius(4)
          .margin({ right: 10 })

        Column() {
          Text(data.nickName)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)

          Text(data.content)
            .fontSize(14)
            .margin({ top: 5, bottom: 5 })
            .fontColor(Color.White)

          if (data.imageList && data.imageList.length > 0) {
            Grid() {
              ForEach(data.imageList, (image: string) => {
                GridItem() {
                  Image(image)
                    .width('100%')
                    .height(100)
                    .objectFit(ImageFit.Cover)
                }
              })
            }
            .columnsTemplate('1fr 1fr 1fr')
            .rowsTemplate('1fr 1fr 1fr')
            .width('100%')
            .height(300)
          }

          Text(data.time)
            .fontSize(12)
            .fontColor(Color.Gray)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .padding(10)
    .backgroundColor('transparent')
    .margin({ bottom: 10 })
  }
}
