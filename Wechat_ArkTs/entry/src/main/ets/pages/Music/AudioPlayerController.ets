// import media from '@ohos.multimedia.media';
// import { BusinessError } from '@kit.BasicServicesKit';
// import prompt from '@ohos.prompt';
// import backgroundTask from './BackgroundTaskManager';
//
// const TAG = 'AudioPlayerController';
//
// enum PlayerState {
//   IDLE,
//   INITIALIZED,
//   PREPARED,
//   PLAYING,
//   PAUSED,
//   COMPLETED,
//   STOPPED,
//   RELEASED,
//   ERROR
// }
//
// export class AudioPlayerController {
//   private avPlayer: media.AVPlayer | undefined;
//   private avPlayerState: PlayerState = PlayerState.IDLE;
//   private currentTime: number = 0;
//   private duration: number = 0;
//
//   constructor() {
//     this.initAVPlayer();
//   }
//
//   private initAVPlayer() {
//     media.createAVPlayer((error, player) => {
//       if (error) {
//         console.error(`${TAG}: createAVPlayer failed, error: ${error.message}`);
//         return;
//       }
//       console.info(`${TAG}: createAVPlayer success`);
//       this.avPlayer = player;
//       this.setEventCallBack();
//     });
//   }
//
//   private setEventCallBack() {
//     if (!this.avPlayer) {
//       return;
//     }
//
//     this.avPlayer.on('stateChange', (state) => {
//       console.info(`${TAG}: AVPlayer state changed to ${state}`);
//       switch (state) {
//         case 'idle':
//           this.avPlayerState = PlayerState.IDLE;
//           break;
//         case 'initialized':
//           this.avPlayerState = PlayerState.INITIALIZED;
//           this.avPlayer?.prepare();
//           break;
//         case 'prepared':
//           this.avPlayerState = PlayerState.PREPARED;
//           this.avPlayer?.play();
//           break;
//         case 'playing':
//           this.avPlayerState = PlayerState.PLAYING;
//           break;
//         case 'paused':
//           this.avPlayerState = PlayerState.PAUSED;
//           break;
//         case 'completed':
//           this.avPlayerState = PlayerState.COMPLETED;
//           break;
//         case 'stopped':
//           this.avPlayerState = PlayerState.STOPPED;
//           break;
//         case 'released':
//           this.avPlayerState = PlayerState.RELEASED;
//           break;
//         case 'error':
//           this.avPlayerState = PlayerState.ERROR;
//           break;
//       }
//     });
//
//     this.avPlayer.on('timeUpdate', (time) => {
//       this.currentTime = time;
//     });
//
//     this.avPlayer.on('durationUpdate', (duration) => {
//       this.duration = duration;
//     });
//
//     this.avPlayer.on('error', (error) => {
//       console.error(`${TAG}: AVPlayer error: ${error}`);
//       prompt.showToast({
//         message: `播放错误: ${error}`,
//         duration: 2000
//       });
//     });
//   }
//
//   public async play(url: string) {
//     if (!this.avPlayer) {
//       console.error(`${TAG}: AVPlayer is not initialized`);
//       return;
//     }
//
//     try {
//       if (this.avPlayerState !== PlayerState.IDLE) {
//         await this.avPlayer.reset();
//       }
//
//       this.avPlayer.url = url;
//       await backgroundTask.startBackgroundTask();
//     } catch (error) {
//       console.error(`${TAG}: Failed to play: ${error}`);
//       prompt.showToast({
//         message: `播放失败: ${error}`,
//         duration: 2000
//       });
//     }
//   }
//
//   public pause() {
//     if (this.avPlayer && this.avPlayerState === PlayerState.PLAYING) {
//       this.avPlayer.pause();
//       backgroundTask.stopBackgroundTask();
//     }
//   }
//
//   public resume() {
//     if (this.avPlayer && this.avPlayerState === PlayerState.PAUSED) {
//       this.avPlayer.play();
//       backgroundTask.startBackgroundTask();
//     }
//   }
//
//   public stop() {
//     if (this.avPlayer &&
//       (this.avPlayerState === PlayerState.PLAYING ||
//        this.avPlayerState === PlayerState.PAUSED)) {
//       this.avPlayer.stop();
//       backgroundTask.stopBackgroundTask();
//     }
//   }
//
//   public release() {
//     if (this.avPlayer && this.avPlayerState !== PlayerState.RELEASED) {
//       this.avPlayer.release();
//       this.avPlayer = undefined;
//       backgroundTask.stopBackgroundTask();
//     }
//   }
//
//   public getCurrentTime(): number {
//     return this.currentTime;
//   }
//
//   public getDuration(): number {
//     return this.duration;
//   }
//
//   public isPlaying(): boolean {
//     return this.avPlayerState === PlayerState.PLAYING;
//   }
//
//   public async seek(position: number) {
//     if (this.avPlayer &&
//         (this.avPlayerState === PlayerState.PLAYING ||
//          this.avPlayerState === PlayerState.PAUSED)) {
//       try {
//         await this.avPlayer.seek(position);
//       } catch (error) {
//         console.error(`${TAG}: Failed to seek: ${error}`);
//         prompt.showToast({
//           message: `跳转失败: ${error}`,
//           duration: 2000
//         });
//       }
//     }
//   }
// }
//
// export default new AudioPlayerController();