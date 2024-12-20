import { audio } from '@kit.AudioKit';
import { BusinessError } from '@kit.BasicServicesKit';
import resourceManager from '@ohos.resourceManager';
import fileio from '@ohos.fileio';

@Entry
@Component
struct AudioPlayerDemo {
  @State isPlaying: boolean = false;
  @State currentState: string = '准备就绪'
  private audioDemo: AudioRendererDemo = new AudioRendererDemo();

  aboutToAppear() {
    this.audioDemo.init();
    this.audioDemo.onStateChange((state: string) => {
      this.currentState = state;
    });
  }

  build() {
    Column() {
      Text(this.currentState)
        .fontSize(20)
        .margin({ bottom: 20 })

      Row() {
        Button('播放')
          .onClick(() => {
            this.audioDemo.start();
          })
          .width(100)
          .margin({ right: 20 })

        Button('暂停')
          .onClick(() => {
            this.audioDemo.pause();
          })
          .width(100)
          .margin({ right: 20 })

        Button('停止')
          .onClick(() => {
            this.audioDemo.stop();
          })
          .width(100)
      }
      .margin({ bottom: 20 })

      Button('释放资源')
        .onClick(() => {
          this.audioDemo.release();
        })
        .width(200)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  aboutToDisappear() {
    this.audioDemo.release();
  }
}

class AudioRendererDemo {
  private readonly TAG: string = 'AudioRendererDemo';
  private renderModel: audio.AudioRenderer | undefined = undefined;
  private bufferSize: number = 0;
  private fileHandle: number = -1;
  private fileLength: number = 0;
  private stateChangeCallback: (state: string) => void = () => {};

  async init(): Promise<void> {
    try {
      // 音频流配置
      const audioStreamInfo: audio.AudioStreamInfo = {
        samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_44100,
        channels: audio.AudioChannel.CHANNEL_2,
        sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
        encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW
      };

      // 渲染器配置
      const audioRendererInfo: audio.AudioRendererInfo = {
        usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
        rendererFlags: 0
      };

      const audioRendererOptions: audio.AudioRendererOptions = {
        streamInfo: audioStreamInfo,
        rendererInfo: audioRendererInfo
      };

      // 创建音频渲染器
      this.renderModel = await new Promise<audio.AudioRenderer>((resolve, reject) => {
        audio.createAudioRenderer(audioRendererOptions, (err, renderer) => {
          if (err) {
            console.error(`${this.TAG}: 创建音频渲染器失败:`, err.message);
            reject(err);
            return;
          }
          resolve(renderer);
        });
      });

      console.info(`${this.TAG}: 创建音频渲染器成功`);

      // 获取资源管理器
      const context = getContext(this);
      const resourceMgr = await context.resourceManager;

      // 获取音频文件
      const rawFd = await resourceMgr.getRawFd('srkl.wav');
      this.fileHandle = rawFd.fd;
      this.fileLength = rawFd.length;

      console.info(`${this.TAG}: 打开音频文件成功, 文件长度: ${this.fileLength}`);

      // 设置回调
      if (this.renderModel) {
        // 数据写入回调
        this.renderModel.on('writeData', (buffer: ArrayBuffer) => {
          return this.writeDataCallback(buffer);
        });

        // 状态变化回调
        this.renderModel.on('stateChange', (state: audio.AudioState) => {
          console.info(`${this.TAG}: 播放器状态变更为: ${state}`);
          this.stateChangeCallback(this.getStateDescription(state));
        });

        // 设置音量
        await this.renderModel.setVolume(1.0);
        console.info(`${this.TAG}: 音量设置成功`);
      }
    } catch (error) {
      console.error(`${this.TAG}: 初始化失败:`, error instanceof Error ? error.message : String(error));
    }
  }

  private writeDataCallback(buffer: ArrayBuffer): audio.AudioDataCallbackResult {
    if (this.fileHandle < 0) {
      console.error(`${this.TAG}: 文件未打开`);
      return audio.AudioDataCallbackResult.INVALID;
    }

    try {
      // 读取音频数据
      const bytesRead = fileio.readSync(this.fileHandle, buffer, {
        offset: this.bufferSize,
        length: buffer.byteLength
      });

      console.info(`${this.TAG}: 读取了 ${bytesRead} 字节的数据，总位置: ${this.bufferSize}`);

      if (bytesRead > 0) {
        this.bufferSize += bytesRead;
        return audio.AudioDataCallbackResult.VALID;
      }

      // 如果读到文件末尾，重新开始播放
      this.bufferSize = 0;
      const newBytesRead = fileio.readSync(this.fileHandle, buffer, {
        offset: 0,
        length: buffer.byteLength
      });

      if (newBytesRead > 0) {
        this.bufferSize = newBytesRead;
        return audio.AudioDataCallbackResult.VALID;
      }

      console.info(`${this.TAG}: 没有更多数据可读`);
      return audio.AudioDataCallbackResult.INVALID;
    } catch (error) {
      console.error(`${this.TAG}: 读取文件失败:`, error instanceof Error ? error.message : String(error));
      return audio.AudioDataCallbackResult.INVALID;
    }
  }

  onStateChange(callback: (state: string) => void): void {
    this.stateChangeCallback = callback;
  }

  private getStateDescription(state: audio.AudioState): string {
    switch (state) {
      case audio.AudioState.STATE_PREPARED:
        return '准备就绪';
      case audio.AudioState.STATE_RUNNING:
        return '正在播放';
      case audio.AudioState.STATE_PAUSED:
        return '已暂停';
      case audio.AudioState.STATE_STOPPED:
        return '已停止';
      case audio.AudioState.STATE_RELEASED:
        return '已释放资源';
      default:
        return '未知状态';
    }
  }

  start(): void {
    if (!this.renderModel) {
      console.error(`${this.TAG}: 渲染器未初始化`);
      return;
    }

    const state = this.renderModel.state;
    const validStates = [
      audio.AudioState.STATE_PREPARED,
      audio.AudioState.STATE_PAUSED,
      audio.AudioState.STATE_STOPPED
    ];

    if (!validStates.includes(state)) {
      console.error(`${this.TAG}: 无法开始播放：当前状态 ${state} 不正确`);
      return;
    }

    this.renderModel.start((err: BusinessError) => {
      if (err) {
        console.error(`${this.TAG}: 开始播放失败:`, err.message);
      } else {
        console.info(`${this.TAG}: 开始播放成功`);
      }
    });
  }

  pause(): void {
    if (!this.renderModel || this.renderModel.state !== audio.AudioState.STATE_RUNNING) {
      return;
    }

    this.renderModel.pause((err: BusinessError) => {
      if (err) {
        console.error(`${this.TAG}: 暂停失败:`, err.message);
      } else {
        console.info(`${this.TAG}: 暂停成功`);
      }
    });
  }

  stop(): void {
    if (!this.renderModel ||
      (this.renderModel.state !== audio.AudioState.STATE_RUNNING &&
        this.renderModel.state !== audio.AudioState.STATE_PAUSED)) {
      return;
    }

    this.renderModel.stop((err: BusinessError) => {
      if (err) {
        console.error(`${this.TAG}: 停止失败:`, err.message);
      } else {
        this.bufferSize = 0;
        console.info(`${this.TAG}: 停止成功`);
      }
    });
  }

  release(): void {
    if (!this.renderModel || this.renderModel.state === audio.AudioState.STATE_RELEASED) {
      return;
    }

    this.renderModel.release((err: BusinessError) => {
      if (err) {
        console.error(`${this.TAG}: 释放资源失败:`, err.message);
      } else {
        // 关闭文件
        if (this.fileHandle >= 0) {
          fileio.closeSync(this.fileHandle);
          this.fileHandle = -1;
        }
        this.renderModel = undefined;
        this.bufferSize = 0;
        console.info(`${this.TAG}: 释放资源成功`);
      }
    });
  }
}