import { CameraPreview } from './CameraPreview';
import abilityAccessCtrl from '@ohos.abilityAccessCtrl';
import common from '@ohos.app.ability.common';
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';

@Entry
@Component
struct ScanPage {
  @State isScanning: boolean = false;
  @State imgSrc: string = '';
  @State videoSrc: string = '';
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#F7F7F7', true);
  }
  build() {

    Column() {
      Row().height(`${this.statusBarHeight}px`).width('100%').backgroundColor('#F7F7F7')

      if (this.isScanning) {
        CameraPreview({
          imgSrc: this.imgSrc,
          videoSrc: this.videoSrc
        })
        Button('停止扫描')
          .onClick(() => this.stopScan())
      } else {
        Button('开始扫描')
          .onClick(() => this.startScan())
      }
    }
  }

  async startScan() {
    try {
      const context = getContext(this) as common.UIAbilityContext;
      const atManager = abilityAccessCtrl.createAtManager();
      const result = await atManager.requestPermissionsFromUser(context, ['ohos.permission.CAMERA']);
      if (result.authResults[0] === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
        this.isScanning = true;
        // 在这里启动相机预览和扫描逻辑
        // 例如：
        // this.imgSrc = '某个图片源URL';
        // this.videoSrc = '某个视频源URL';
      } else {
        console.error('Camera permission denied');
      }
    } catch (error) {
      console.error(`Failed to request permission: ${error.message}`);
    }
  }

  stopScan() {
    this.isScanning = false;
    this.imgSrc = '';
    this.videoSrc = '';
    // 在这里处理扫描结果或清理工作
  }
}
