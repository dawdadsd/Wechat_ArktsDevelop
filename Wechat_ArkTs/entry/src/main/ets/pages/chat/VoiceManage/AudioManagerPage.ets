//感谢贴吧大哥分享的干货，论坛链接https://developer.huawei.com/consumer/cn/forum/topic/0208152916313499731
import audio from '@ohos.multimedia.audio';
import fs from '@ohos.file.fs';
import {abilityAccessCtrl,common} from '@kit.AbilityKit'
class AudioManagerPage{
  private audioCapturer: audio.AudioCapturer | undefined = undefined

  // 存储录音的地址路径
  private filePath:string = ''

  private init() {
    let audioStreamInfo: audio.AudioStreamInfo = {
      samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_16000,
      channels: audio.AudioChannel.CHANNEL_1,
      sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
      encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW
    }
    let audioCapturerInfo: audio.AudioCapturerInfo = {
      source: audio.SourceType.SOURCE_TYPE_MIC, // 音源类型
      capturerFlags: 0 // 音频采集器标志
    }
    let audioCapturerOptions: audio.AudioCapturerOptions = {
      streamInfo: audioStreamInfo,
      capturerInfo: audioCapturerInfo
    }
    audio.createAudioCapturer(audioCapturerOptions, (err, capturer) => { // 创建AudioCapturer实例
      if (err) {
        console.error(`Invoke createAudioCapturer failed, code is ${err.code}, message is ${err.message}`);
        return;
      }
      console.info(` create AudioCapturer success`);
      this.audioCapturer = capturer;
      if (this.audioCapturer !== undefined) {
        (this.audioCapturer as audio.AudioCapturer).on('markReach', 1000, (position: number) => { // 订阅markReach事件，当采集的帧数达到1000时触发回调
          if (position === 1000) {
            console.info('ON Triggered successfully')
          }
        });
        (this.audioCapturer as audio.AudioCapturer).on('periodReach', 2000, (position: number) => { // 订阅periodReach事件，当采集的帧数达到2000时触发回调
          if (position === 2000) {
            console.info('ON Triggered successfully')
          }
        })
      }
    })
  }

  // 开始录音
  async start() {
    if (this.audioCapturer !== undefined) {
      let stateGroup = [audio.AudioState.STATE_PREPARED, audio.AudioState.STATE_PAUSED, audio.AudioState.STATE_STOPPED]
      if (stateGroup.indexOf((this.audioCapturer as audio.AudioCapturer).state.valueOf()) === -1) { // 当且仅当状态为STATE_PREPARED、STATE_PAUSED和STATE_STOPPED之一时才能启动采集
        console.error(`: start failed`);
        return;
      }
      await (this.audioCapturer as audio.AudioCapturer).start(); // 启动采集
      let currentWavName = `${Date.now()}.wav`
      this.filePath = getContext(this).filesDir + `/${currentWavName}`; // 采集到的音频文件存储路径
      let file: fs.File = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE); // 如果文件不存在则创建文件
      let fd = file.fd;

      let numBuffersToCapture = 150; // 循环写入150次
      let count = 0;

      class Options {
        offset: number = 0;
        length: number = 0
      }
      while (numBuffersToCapture) {
        let bufferSize = await (this.audioCapturer as audio.AudioCapturer).getBufferSize();
        let buffer = await (this.audioCapturer as audio.AudioCapturer).read(bufferSize, true);
        let options: Options = {
          offset: count * bufferSize,
          length: bufferSize
        };
        if (buffer === undefined) {
          console.error(`read buffer failed`);
        } else {
          let number = fs.writeSync(fd, buffer, options);
          console.info(`write date: ${number}`, buffer.byteLength.toString());
        }
        numBuffersToCapture--;
        count++;
      }
      fs.closeSync(file)
    }
  }

  // 停止录音
  async stop():Promise<string | void> {
    if (this.audioCapturer !== undefined) {
      // 只有采集器状态为STATE_RUNNING或STATE_PAUSED的时候才可以停止
      if ((this.audioCapturer as audio.AudioCapturer).state.valueOf() !== audio.AudioState.STATE_RUNNING && (this.audioCapturer as audio.AudioCapturer).state.valueOf() !== audio.AudioState.STATE_PAUSED) {
        return
      }
      try {
        await (this.audioCapturer as audio.AudioCapturer).stop() // 停止采集
      } catch (e) {

      }
      if ((this.audioCapturer as audio.AudioCapturer).state.valueOf() === audio.AudioState.STATE_STOPPED) {
        console.info('Capturer stopped')

      } else {
        console.error('Capturer stop failed')
      }
      return this.filePath
    }
  }

  // 销毁实例，释放资源
  async release() {
    if (this.audioCapturer !== undefined) {
      // 采集器状态不是STATE_RELEASED或STATE_NEW状态，才能release
      if ((this.audioCapturer as audio.AudioCapturer).state.valueOf() === audio.AudioState.STATE_RELEASED || (this.audioCapturer as audio.AudioCapturer).state.valueOf() === audio.AudioState.STATE_NEW) {
        console.info('Capturer already released')
        return
      }
      await (this.audioCapturer as audio.AudioCapturer).release() // 释放资源
      if ((this.audioCapturer as audio.AudioCapturer).state.valueOf() === audio.AudioState.STATE_RELEASED) {
        console.info('Capturer released')
      } else {
        console.error('Capturer release failed')
      }
    }
  }

  // 请求录音权限
  requestPermission(){
    let atManager = abilityAccessCtrl.createAtManager()
    let context: Context = getContext(this) as common.UIAbilityContext
    atManager.requestPermissionsFromUser(context, [
      "ohos.permission.MICROPHONE",
    ]).then(() => {
      this.init()
    })
  }
}
export {AudioManagerPage}