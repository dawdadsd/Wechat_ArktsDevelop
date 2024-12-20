import {speechRecognizer} from '@kit.CoreSpeechKit'
import {BusinessError} from '@kit.BasicServicesKit'
import {fileIo} from '@kit.CoreFileKit'
let asrEngine:speechRecognizer.SpeechRecognitionEngine
class SpeechManager{
  private sessionId: string = "123456"
  // 创建引擎，通过callback形式返回
  private createByCallback() {
    // 设置创建引擎参数
    let extraParam: Record<string, Object> = { "locate": "CN", "recognizerMode": "short" };
    let initParamsInfo: speechRecognizer.CreateEngineParams = {
      language: 'zh-CN',
      online: 1,
      extraParams: extraParam
    }

    // 调用createEngine方法
    speechRecognizer.createEngine(initParamsInfo, (err: BusinessError, speechRecognitionEngine:
      speechRecognizer.SpeechRecognitionEngine) => {
      if (!err) {
        console.info('createEngine is succeeded');
        // 接收创建引擎的实例
        asrEngine = speechRecognitionEngine;
      } else {
        // 无法创建引擎时返回错误码1002200001，原因：语种不支持、模式不支持、初始化超时、资源不存在等导致创建引擎失败
        // 无法创建引擎时返回错误码1002200006，原因：引擎正在忙碌中，一般多个应用同时调用语音识别引擎时触发
        // 无法创建引擎时返回错误码1002200008，原因：引擎正在销毁中
        console.error("errCode: " + err.code + " errMessage: " + JSON.stringify(err.message));
      }
    })
  }

  // 设置回调
  private setListener(cb:(result:speechRecognizer.SpeechRecognitionResult)=>void) {
    // 创建回调对象
    let setListener: speechRecognizer.RecognitionListener = {
      // 开始识别成功回调
      onStart(sessionId: string, eventMessage: string) {
        console.info("onStart sessionId: " + sessionId + "eventMessage: " + eventMessage);
      },
      // 事件回调
      onEvent(sessionId: string, eventCode: number, eventMessage: string) {
        console.info("onEvent sessionId: " + sessionId + "eventCode: " + eventCode + "eventMessage: " + eventMessage);
      },
      // 识别结果回调，包括中间结果和最终结果
      onResult(sessionId: string, result: speechRecognizer.SpeechRecognitionResult) {
        console.info("onResult sessionId: " + sessionId + "sessionId: " + JSON.stringify(result))
        // that.keyword = result.result
        // that.pressState = 1
        cb && cb(result)
      },
      //识别完成回调
      onComplete(sessionId: string, eventMessage: string) {
        console.info("onComplete sessionId: " + sessionId + "eventMessage: " + eventMessage);
      },
      // 错误回调，错误码通过本方法返回
      // 如：返回错误码1002200006，识别引擎正忙，引擎正在识别中
      // 更多错误码请参考错误码参考
      onError(sessionId: string, errorCode: number, errorMessage: string) {
        console.error("onError sessionId: " + sessionId + "errorCode: " + errorCode + "errorMessage: " + errorMessage);
      },
    }
    // 设置回调
    asrEngine.setListener(setListener)
  }

  // 开始识别
  private startListening() {
    // 设置开始识别的相关参数
    let recognizerParams: speechRecognizer.StartParams = {
      sessionId: this.sessionId,
      audioInfo: { audioType: 'pcm', sampleRate: 16000, soundChannel: 1, sampleBit: 16 }
    }
    // 调用开始识别方法
    asrEngine.startListening(recognizerParams)
  }

  // 计时
  private async countDownLatch(count: number) {
    while (count > 0) {
      await this.sleep(40)
      count--
    }
  }

  // 睡眠
  private sleep(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms))
  }

  // 写音频流
  private async writeAudio(filePath:string) {
    let ctx = getContext(this)
    let filenames: string[] = fileIo.listFileSync(ctx.filesDir)
    if (filenames.length <= 0) {
      return
    }
    // 根据路径地址把录音阶段的存入的音频文件取到
    let file = fileIo.openSync(filePath, fileIo.OpenMode.READ_WRITE)
    try {
      let buf: ArrayBuffer = new ArrayBuffer(1280);
      let offset: number = 0;
      while (1280 == fileIo.readSync(file.fd, buf, {
        offset: offset
      })) {
        let unit8Array: Uint8Array = new Uint8Array(buf)
        asrEngine.writeAudio(this.sessionId, unit8Array)
        await this.countDownLatch(1)
        offset = offset + 1280
      }
    } catch (e) {
      console.error("read file error " + e);
    } finally {
      if (null != file) {
        fileIo.closeSync(file)
      }
    }
  }

  // 开始函数
  start(filePath:string, cb:(result:speechRecognizer.SpeechRecognitionResult)=>void){
    this.createByCallback()
    setTimeout(()=>{
      this.setListener(cb)
      this.startListening()
      this.writeAudio(filePath)
    },1000)
  }
}
export {SpeechManager}