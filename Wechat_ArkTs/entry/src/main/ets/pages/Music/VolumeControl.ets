// import audio from '@ohos.multimedia.audio';
//
// @Component
// export struct VolumeControl {
//   @State volume: number = 0.5;
//   private audioManager: audio.AudioManager | undefined;
//
//   aboutToAppear() {
//     this.initAudioManager();
//   }
//
//   async initAudioManager() {
//     try {
//       this.audioManager = audio.getAudioManager();
//       const volumeManager = this.audioManager.getVolumeManager();
//       const stream = audio.AudioVolumeType.MEDIA;
//       const vol = await volumeManager.getVolume(stream);
//       const maxVol = await volumeManager.getMaxVolume(stream);
//       this.volume = vol / maxVol;
//     } catch (error) {
//       console.error('Failed to initialize audio manager:', error);
//     }
//   }
//
//   async setVolume(value: number) {
//     try {
//       if (this.audioManager) {
//         const volumeManager = this.audioManager.getVolumeManager();
//         const stream = audio.AudioVolumeType.MEDIA;
//         const maxVol = await volumeManager.getMaxVolume(stream);
//         await volumeManager.setVolume(stream, Math.round(value * maxVol));
//       }
//     } catch (error) {
//       console.error('Failed to set volume:', error);
//     }
//   }
//
//   build() {
//     Row() {
//       Image($r('app.media.ic_volume_down'))
//         .width(24)
//         .height(24)
//         .margin({ right: 8 })
//
//       Slider({
//         value: this.volume * 100,
//         min: 0,
//         max: 100,
//         step: 1,
//         style: SliderStyle.OutSet
//       })
//         .layoutWeight(1)
//         .selectedColor('#0D9FFB')
//         .onChange((value: number) => {
//           this.volume = value / 100;
//           this.setVolume(this.volume);
//         })
//
//       Image($r('app.media.ic_volume_up'))
//         .width(24)
//         .height(24)
//         .margin({ left: 8 })
//     }
//     .width('100%')
//     .padding({ left: 16, right: 16 })
//   }
// }