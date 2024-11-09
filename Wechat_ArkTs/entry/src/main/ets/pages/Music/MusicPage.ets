import router from '@ohos.router';
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';

interface MusicItem {
  id: number;
  name: string;
  artist: string;
}

@Entry
@Component
struct MusicPage {
  @State musicList: MusicItem[] = [
    { id: 1, name: '七里香', artist: '周杰伦' },
    { id: 2, name: '青花瓷', artist: '周杰伦' },
    { id: 3, name: '稻香', artist: '周杰伦' },
    { id: 4, name: '听妈妈的话', artist: '周杰伦' },
    { id: 5, name: '菊花台', artist: '周杰伦' },
  ]

  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#F1F3F5', false);
  }

  build() {
    Column() {
      // 状态栏占位
      Row().height(`${this.statusBarHeight}px`).width('100%').backgroundColor('#F1F3F5')

      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .margin({ right: 16 })
          .onClick(() => {
            router.back()
          })
        Text('我的音乐')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding({ left: 16, top: 20, bottom: 16 })
      .alignItems(VerticalAlign.Center)

      List() {
        ForEach(this.musicList, (item: MusicItem) => {
          ListItem() {
            Row() {
              Image($r('app.media.jay'))
                .width(50)
                .height(50)
                .margin({ right: 16 })
              Column() {
                Text(item.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                Text(item.artist)
                  .fontSize(14)
                  .fontColor(Color.Gray)
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding(16)
            .onClick(() => {
              this.navigateToMusicPlayer(item)
            })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)

      Button('随机播放')
        .width('90%')
        .height(50)
        .margin({ bottom: 20 })
        .onClick(() => {
          const randomIndex = Math.floor(Math.random() * this.musicList.length)
          const randomSong = this.musicList[randomIndex]
          router.pushUrl({
            url: "pages/Music/MusicPlayerDialog",
            params: {
              songName: randomSong.name,
              artistName: randomSong.artist
            }
          })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }

  private navigateToMusicPlayer(song: MusicItem): void {
    router.pushUrl({
      url: 'pages/MusicPlayerPage',
      params: {
        songName: song.name,
        artistName: song.artist
      }
    })
  }
}
