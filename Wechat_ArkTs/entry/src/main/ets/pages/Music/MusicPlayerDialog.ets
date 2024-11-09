import router from '@ohos.router';
import audio from '@ohos.multimedia.audio';
import fs from '@ohos.file.fs';

interface RouteParams {
  songName?: string;
  artistName?: string;
}

@Entry
@Component
struct MusicPlayerPage {
  private audioPlayer: audio.AudioRenderer | null = null;
  @State currentTime: number = 0;
  @State duration: number = 180;
  @State songName: string = '未知歌曲';
  @State artistName: string = '未知艺术家';
  @State isPlaying: boolean = false;

  aboutToAppear() {
    const params = router.getParams() as RouteParams;
    if (params) {
      this.songName = params.songName || '未知歌曲';
      this.artistName = params.artistName || '未知艺术家';
    }
    this.createAudioPlayer();
  }

  aboutToDisappear() {
    this.releaseAudioPlayer();
  }

  async createAudioPlayer() {
    try {
      const audioStreamInfo: audio.AudioStreamInfo = {
        samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_44100,
        channels: audio.AudioChannel.CHANNEL_2,
        sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
        encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW
      };

      const audioRendererOptions: audio.AudioRendererOptions = {
        streamInfo: audioStreamInfo,
        rendererInfo: {
          content: audio.ContentType.CONTENT_TYPE_MUSIC,
          usage: audio.StreamUsage.STREAM_USAGE_MEDIA,
          rendererFlags: 0
        }
      };

      this.audioPlayer = await audio.createAudioRenderer(audioRendererOptions);
    } catch (err) {
      console.error(`Failed to create AudioRenderer: ${err instanceof Error ? err.message : String(err)}`);
    }
  }

  releaseAudioPlayer() {
    if (this.audioPlayer) {
      this.audioPlayer.stop();
      this.audioPlayer.release();
      this.audioPlayer = null;
    }
  }

  async playMusic() {
    if (this.audioPlayer) {
      try {
        const filePath: string = '/data/storage/el2/base/files/Jay_geqian.mp3';
        await this.audioPlayer.start();

        const file = await fs.open(filePath, fs.OpenMode.READ_ONLY);
        const stat = await fs.stat(filePath);
        const fileContent = new Uint8Array(stat.size);
        await fs.read(file.fd, fileContent);
        await fs.close(file);

        await this.audioPlayer.write(fileContent.buffer);
        this.isPlaying = true;
      } catch (err) {
        console.error(`Failed to play music: ${err instanceof Error ? err.message : String(err)}`);
      }
    }
  }

  pauseMusic() {
    if (this.audioPlayer) {
      this.audioPlayer.pause();
      this.isPlaying = false;
    }
  }

  formatTime(seconds: number): string {
    const minutes: number = Math.floor(seconds / 60);
    const remainingSeconds: number = Math.floor(seconds % 60);
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
  }





build() {
    Column() {
      Button() {
        Image($r('app.media.ic_close'))
          .width(24)
          .height(24)
      }
      .type(ButtonType.Circle)
      .backgroundColor('rgba(0,0,0,0.5)')
      .width(36)
      .height(36)
      .margin({ top: 20, right: 20 })
      .alignSelf(ItemAlign.End)
      .onClick(() => {
        router.back()
      })

      Image($r('app.media.jay'))
        .width('80%')
        .aspectRatio(1)
        .borderRadius(8)
        .margin({ top: 40 })

      Text(this.songName)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20 })
      Text(this.artistName)
        .fontSize(16)
        .fontColor(Color.Gray)
        .margin({ top: 8 })

      Slider({
        value: this.currentTime,
        min: 0,
        max: this.duration,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('90%')
        .margin({ top: 40 })
        .onChange((value: number) => {
          this.currentTime = value
        })

      Row() {
        Text(this.formatTime(this.currentTime))
          .fontSize(12)
          .fontColor(Color.Gray)
        Text(this.formatTime(this.duration))
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 8 })

      Row() {
        Button() {
          Image($r('app.media.jay'))
            .width(24)
            .height(24)
        }.type(ButtonType.Circle)
        .backgroundColor(Color.Transparent)

        Button() {
          Image(this.isPlaying ? $r('app.media.jay') : $r('app.media.jay'))
            .width(48)
            .height(48)
        }.type(ButtonType.Circle)
        .backgroundColor('#007DFF')
        .width(64)
        .height(64)
        .onClick(() => {
          if (this.isPlaying) {
            this.pauseMusic();
          } else {
            this.playMusic();
          }
        })

        Button() {
          Image($r('app.media.jay'))
            .width(24)
            .height(24)
        }.type(ButtonType.Circle)
        .backgroundColor(Color.Transparent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
