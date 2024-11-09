import router from '@ohos.router';
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';

@Entry
@Component
struct FavoritesPage {
  @State searchText: string = ''
  @State categories: string[] = ['最近使用', '语音', '图片与视频', '文件', '聊天记录', '小程序', '链接']
  @State selectedCategory: number = 0
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#F7F7F7', true);
  }
  @Builder
  FavoriteItem(image: Resource | null, text: string, author: string, date: string) {
    Column() {
      if (image) {
        Image(image)
          .width('100%')
          .height(200)
          .objectFit(ImageFit.Cover)
      } else {
        Text(text)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      Row() {
        Text(author)
          .fontSize(14)
          .fontColor('#888888')
        Blank()
        Text(date)
          .fontSize(14)
          .fontColor('#888888')
      }
      .width('100%')
      .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 8 })
  }

  build() {
    Column() {
      // Title bar
      Row().height(`${this.statusBarHeight}px`).width('100%')
      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Text('收藏')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
        Blank()
        Image($r('app.media.ic_add'))
          .width(24)
          .height(24)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })

      // Search bar
      TextInput({ placeholder: '搜索' })
        .width('90%')
        .height(40)
        .backgroundColor('#F5F5F5')
        .margin({ top: 8, bottom: 16 })

      // Categories
      Scroll() {
        Row() {
          ForEach(this.categories, (category: string, index: number) => {
            Text(category)
              .fontSize(16)
              .fontColor(this.selectedCategory === index ? '#07C160' : '#000000')
              .padding({ left: 16, right: 16 })
              .onClick(() => {
                this.selectedCategory = index
              })
          })
        }
      }
      .width('100%')
      .height(40)

      // Favorites list
      Scroll() {
        Column() {
          this.FavoriteItem($r('app.media.simple_Make'), '一个慢头变到60万马克币你拉铆钉的声音比维鲁都响', '王涛', '2月18日')
          this.FavoriteItem($r('app.media.simple_pig'), '', '王涛', '2月18日')
          this.FavoriteItem($r('app.media.simple_Sikele'), '', '王涛', '2月18日')
          this.FavoriteItem(null, '06"', '王涛', '2023年8月5日')
          this.FavoriteItem(null, '10"', '彭总（表弟）', '2023年2月6日')
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}
