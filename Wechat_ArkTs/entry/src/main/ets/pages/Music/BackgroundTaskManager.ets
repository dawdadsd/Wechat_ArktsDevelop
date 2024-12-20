// import backgroundTaskManager from '@ohos.resourceschedule.backgroundTaskManager';
// import wantAgent from '@ohos.app.ability.wantAgent';
// import common from '@ohos.app.ability.common';
// import prompt from '@ohos.prompt';
//
// const TAG = 'BackgroundTaskManager';
//
// export class BackgroundTaskManager {
//   private static instance: BackgroundTaskManager;
//   private context: common.UIAbilityContext | null = null;
//
//   private constructor() {}
//
//   public static getInstance(): BackgroundTaskManager {
//     if (!BackgroundTaskManager.instance) {
//       BackgroundTaskManager.instance = new BackgroundTaskManager();
//     }
//     return BackgroundTaskManager.instance;
//   }
//
//   public setContext(context: common.UIAbilityContext) {
//     this.context = context;
//   }
//
//   public async startBackgroundTask() {
//     if (!this.context) {
//       console.error(`${TAG}: Context is not set`);
//       return;
//     }
//
//     try {
//       const wantAgentInfo = {
//         wants: [
//           {
//             bundleName: this.context.bundleName,
//             abilityName: 'EntryAbility'
//           }
//         ],
//         operationType: wantAgent.OperationType.START_ABILITY,
//         requestCode: 1
//       } as wantAgent.WantAgentInfo;
//
//       const wantAgentObj = await wantAgent.getWantAgent(wantAgentInfo);
//
//       await backgroundTaskManager.startBackgroundRunning(
//         this.context,
//         backgroundTaskManager.BackgroundMode.AUDIO_PLAYBACK,
//         wantAgentObj
//       );
//
//       console.info(`${TAG}: Background task started successfully`);
//     } catch (error) {
//       console.error(`${TAG}: Failed to start background task:`, error);
//       prompt.showToast({
//         message: '启动后台任务失败',
//         duration: 2000
//       });
//     }
//   }
//
//   public async stopBackgroundTask() {
//     if (!this.context) {
//       console.error(`${TAG}: Context is not set`);
//       return;
//     }
//
//     try {
//       await backgroundTaskManager.stopBackgroundRunning(this.context);
//       console.info(`${TAG}: Background task stopped successfully`);
//     } catch (error) {
//       console.error(`${TAG}: Failed to stop background task:`, error);
//       prompt.showToast({
//         message: '停止后台任务失败',
//         duration: 2000
//       });
//     }
//   }
// }
//
// export default BackgroundTaskManager.getInstance();