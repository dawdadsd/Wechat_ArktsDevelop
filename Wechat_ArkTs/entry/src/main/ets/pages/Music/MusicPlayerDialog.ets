import { audio } from '@kit.AudioKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { fileIo as fs } from '@kit.CoreFileKit';

@Entry
@Component
struct AudioPlayerDemo {
  @State isPlaying: boolean = false;
  @State currentState: string = '准备就绪'
  private audioDemo: AudioRendererDemo = new AudioRendererDemo();

  aboutToAppear() {
    this.audioDemo.init();
    // 监听状态变化
    this.audioDemo.onStateChange((state: string) => {
      this.currentState = state;
    });
  }

  build() {
    Column() {
      // 显示当前状态
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
  private file: fs.File | undefined = undefined;
  private stateChangeCallback: (state: string) => void = () => {};

  async init() {
    try {
      // 1. 配置音频流信息
      let audioStreamInfo: audio.AudioStreamInfo = {
        samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_44100,
        channels: audio.AudioChannel.CHANNEL_2,
        sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
        encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW
      };
      console.info(`${this.TAG}: 音频流配置完成`);

      // 2. 配置渲染器信息
      let audioRendererInfo: audio.AudioRendererInfo = {
        usage: audio.StreamUsage.STREAM_USAGE_MEDIA,
        rendererFlags: 0
      };
      console.info(`${this.TAG}: 渲染器配置完成`);

      // 3. 合并配置选项
      let audioRendererOptions: audio.AudioRendererOptions = {
        streamInfo: audioStreamInfo,
        rendererInfo: audioRendererInfo
      };

      // 4. 创建AudioRenderer实例
      await new Promise<void>((resolve, reject) => {
        audio.createAudioRenderer(audioRendererOptions, async (err, renderer) => {
          if (err) {
            console.error(`${this.TAG}: 创建 AudioRenderer 失败:`, JSON.stringify(err));
            reject(err);
            return;
          }

          this.renderModel = renderer;
          console.info(`${this.TAG}: 创建 AudioRenderer 成功`);

          try {
            // 5. 打开音频文件
            const context = getContext(this);
            // 修改文件路径
            const filePath = context.bundleCodeDir + '/resources/rawfile/srkl.wav';
            console.info(`${this.TAG}: 尝试打开文件: ${filePath}`);

            try {
              // 检查文件是否存在
              const stats = fs.statSync(filePath);
              console.info(`${this.TAG}: 文件大小: ${stats.size} 字节`);
              
              if (stats.size === 0) {
                console.error(`${this.TAG}: 文件大小为0`);
                reject(new Error('文件大小为0'));
                return;
              }

              this.file = fs.openSync(filePath, fs.OpenMode.READ_ONLY);
              console.info(`${this.TAG}: 文件打开成功`);

              // 6. 设置数据写入回调
              if (this.renderModel) {
                this.renderModel.on('writeData', this.writeDataCallback.bind(this));
                console.info(`${this.TAG}: 数据写入回调设置成功`);

                // 7. 监听状态变化
                this.renderModel.on('stateChange', (state) => {
                  console.info(`${this.TAG}: 播放器状态变更为: ${state}`);
                  this.stateChangeCallback(this.getStateDescription(state));
                });

                // 8. 设置音量
                await this.renderModel.setVolume(1.0);
                console.info(`${this.TAG}: 音量设置成功`);

                // 不要在这里调用 start()
                resolve();
              } else {
                reject(new Error('renderModel is undefined'));
              }
            } catch (error) {
              console.error(`${this.TAG}: 设置音频渲染器失败:`, error);
              reject(error);
            }
          } catch (error) {
            console.error(`${this.TAG}: 打开文件失败:`, error);
            reject(error);
          }
        });
      });
    } catch (error) {
      console.error(`${this.TAG}: 初始化音频渲染器失败:`, error);
    }
  }

  private writeDataCallback(buffer: ArrayBuffer): audio.AudioDataCallbackResult {
    if (!this.file) {
      console.error(`${this.TAG}: 文件未打开`);
      return audio.AudioDataCallbackResult.INVALID;
    }

    try {
      console.info(`${this.TAG}: 准备读取数据，buffer大小: ${buffer.byteLength}`);
      
      let bytesRead = fs.readSync(this.file.fd, buffer, {
        offset: this.bufferSize,  // 使用累计偏移量
        length: buffer.byteLength
      });

      console.info(`${this.TAG}: 读取了 ${bytesRead} 字节的数据，当前位置: ${this.bufferSize + bytesRead}`);

      if (bytesRead > 0) {
        this.bufferSize += bytesRead;
        return audio.AudioDataCallbackResult.VALID;
      }

      // 如果读到文件末尾，重新打开文件
      if (this.file) {
        fs.close(this.file);
        const context = getContext(this);
        const filePath = context.bundleCodeDir + '/resources/rawfile/srkl.wav';
        this.file = fs.openSync(filePath, fs.OpenMode.READ_ONLY);
        this.bufferSize = 0;
        console.info(`${this.TAG}: 重新打开文件并重置读取位置`);
      }

      return audio.AudioDataCallbackResult.INVALID;
    } catch (error) {
      console.error(`${this.TAG}: 读取文件失败:`, error);
      return audio.AudioDataCallbackResult.INVALID;
    }
  }
  onStateChange(callback: (state: string) => void) {
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

  start() {
    if (!this.renderModel) {
      console.error(`${this.TAG}: renderModel 为空`);
      return;
    }

    let state = this.renderModel.state;
    console.info(`${this.TAG}: 开始播放，当前状态: ${state}`);

    // 如果已经在播放，就先停止
    if (state === audio.AudioState.STATE_RUNNING) {
      console.info(`${this.TAG}: 播放器已在运行，先停止当前播放`);
      this.stop();
      // 重新打开文件
      if (this.file) {
        fs.close(this.file);
        const context = getContext(this);
        const filePath = context.bundleCodeDir + '/resources/rawfile/srkl.wav';
        this.file = fs.openSync(filePath, fs.OpenMode.READ_ONLY);
      }
    }

    // 重置缓冲区大小
    this.bufferSize = 0;

    this.renderModel.start((err) => {
      if (err) {
        console.error(`${this.TAG}: 开始播放失败:`, err);
      } else {
        console.info(`${this.TAG}: 开始播放成功`);
      }
    });
  }

  pause() {
    if (!this.renderModel || this.renderModel.state !== audio.AudioState.STATE_RUNNING) {
      return;
    }

    this.renderModel.pause((err) => {
      if (err) {
        console.error('暂停播放失败:', err);
      } else {
        console.info('暂停播放成功');
      }
    });
  }

  stop() {
    if (!this.renderModel ||
      (this.renderModel.state !== audio.AudioState.STATE_RUNNING &&
        this.renderModel.state !== audio.AudioState.STATE_PAUSED)) {
      return;
    }

    this.renderModel.stop((err) => {
      if (err) {
        console.error('停止播放失败:', err);
      } else {
        this.bufferSize = 0;
        console.info('停止播放成功');
      }
    });
  }

  release() {
    if (!this.renderModel || this.renderModel.state === audio.AudioState.STATE_RELEASED) {
      return;
    }

    this.renderModel.release((err) => {
      if (err) {
        console.error('释放资源失败:', err);
      } else {
        // 关闭文件
        if (this.file) {
          fs.close(this.file);
          this.file = undefined;
        }
        this.renderModel = undefined;
        this.bufferSize = 0;
        console.info('释放资源成功');
      }
    });
  }
}