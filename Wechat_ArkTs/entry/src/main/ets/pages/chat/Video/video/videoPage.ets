// VideoCreateComponent.ets
@Entry
@Component
struct VideoCreateComponent {
  @State videoSrc: Resource = $rawfile('trailer.mp4')
  @State previewUri: Resource = $r('app.media.jay')
  @State curRate: PlaybackSpeed = PlaybackSpeed.Speed_Forward_1_00_X
  @State isAutoPlay: boolean = true
  @State showControls: boolean = true
  controller: VideoController = new VideoController()
  @State muted: boolean = true
  @State loop: boolean = false

  build() {
    Column() {
      // 视频标题
      Text('Demo播放器')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })

      // 视频组件
      Video({
        src: this.videoSrc,
        previewUri: this.previewUri,
        currentProgressRate: this.curRate,
        controller: this.controller
      })
        .width('100%')
        .height(600)
        .muted(this.muted)
        .loop(this.loop)
        .autoPlay(this.isAutoPlay)
        .controls(this.showControls)
        .onStart(() => {
          console.info('onStart')
        })
        .onPause(() => {
          console.info('onPause')
        })
        .onFinish(() => {
          console.info('onFinish')
        })
        .onError(() => {
          console.info('onError')
        })
        .onStop(() => {
          console.info('onStop')
        })
        .onPrepared((e?: DurationObject) => {
          if (e != undefined) {
            console.info('onPrepared is ' + e.duration)
          }
        })
        .onSeeking((e?: TimeObject) => {
          if (e != undefined) {
            console.info('onSeeking is ' + e.time)
          }
        })
        .onSeeked((e?: TimeObject) => {
          if (e != undefined) {
            console.info('onSeeked is ' + e.time)
          }
        })
        .onUpdate((e?: TimeObject) => {
          if (e != undefined) {
            console.info('onUpdate is ' + e.time)
          }
        })


      // 视频设置
      Row() {
        Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
          Button('切换视频源')
            .onClick(() => {
              this.videoSrc = $rawfile('syz_1.mp4')
            })
            .margin(5)
            .backgroundColor('#0D9FFB')
            .fontColor('#FFFFFF')

          Button('切换预览海报')
            .onClick(() => {
              this.previewUri = $r('app.media.xiangzuo')
            })
            .margin(5)
            .backgroundColor('#0D9FFB')
            .fontColor('#FFFFFF')

          Button(this.showControls ? '隐藏控制栏' : '显示控制栏')
            .onClick(() => {
              this.showControls = !this.showControls
            })
            .margin(5)
            .backgroundColor('#0D9FFB')
            .fontColor('#FFFFFF')

          Button(this.muted ? '取消静音' : '静音')
            .onClick(() => {
              this.muted = !this.muted
            })
            .margin(5)
            .backgroundColor('#0D9FFB')
            .fontColor('#FFFFFF')

          Button(this.loop ? '取消循环' : '循环播放')
            .onClick(() => {
              this.loop = !this.loop
            })
            .margin(5)
            .backgroundColor('#0D9FFB')
            .fontColor('#FFFFFF')
        }
        .width('100%')
      }

      // 分割线

      // 视频控制
      Row() {
        Button('开始')
          .onClick(() => {
            this.controller.start()
          })
          .margin(5)
          .backgroundColor('#0D9FFB')
          .fontColor('#FFFFFF')

        Button('暂停')
          .onClick(() => {
            this.controller.pause()
          })
          .margin(5)
          .backgroundColor('#0D9FFB')
          .fontColor('#FFFFFF')

        Button('停止')
          .onClick(() => {
            this.controller.stop()
          })
          .margin(5)
          .backgroundColor('#0D9FFB')
          .fontColor('#FFFFFF')

        Button('重置')
          .onClick(() => {
            this.controller.reset()
          })
          .margin(5)
          .backgroundColor('#0D9FFB')
          .fontColor('#FFFFFF')

        Button('跳转到10s')
          .onClick(() => {
            this.controller.setCurrentTime(10, SeekMode.Accurate)
          })
          .margin(5)
          .backgroundColor('#0D9FFB')
          .fontColor('#FFFFFF')
      }

      // 播放速率
      Row() {
        Button('0.75倍速')
          .onClick(() => {
            this.curRate = PlaybackSpeed.Speed_Forward_0_75_X
          })
          .margin(5)
          .backgroundColor('#0D9FFB')
          .fontColor('#FFFFFF')

        Button('1.0倍速')
          .onClick(() => {
            this.curRate = PlaybackSpeed.Speed_Forward_1_00_X
          })
          .margin(5)
          .backgroundColor('#0D9FFB')
          .fontColor('#FFFFFF')

        Button('2.0倍速')
          .onClick(() => {
            this.curRate = PlaybackSpeed.Speed_Forward_2_00_X
          })
          .margin(5)
          .backgroundColor('#0D9FFB')
          .fontColor('#FFFFFF')
      }
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F1F3F5')
  }
}

interface DurationObject {
  duration: number; // 视频时长对象,包含duration属性表示视频时长
}

interface TimeObject {
  time: number; // 视频时间对象,包含time属性表示视频当前时间
}