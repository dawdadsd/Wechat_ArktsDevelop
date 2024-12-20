import { BusinessError } from '@kit.BasicServicesKit';
import { camera } from '@kit.CameraKit';
import { media } from '@kit.MediaKit';
import prompt from '@ohos.prompt';
import common from '@ohos.app.ability.common';
import { geoLocationManager } from '@kit.LocationKit';
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
@Component
@Preview
export default struct ChatFunctionBar {
  private onImageSelected?:(images: string[]) => void
  private onLocationSend?:(locationMsg: string) => void
  private onCameraSelected?:()=>void
  @State isCapturing: boolean = false;
  @State imgSrc: string = '';
  @State currentLocation: geoLocationManager.Location | undefined = undefined
  @State private hasLocationPermission: boolean = false
  @State private hasReadMediaPermission: boolean = false

  aboutToAppear() {
    this.requestLocationPermission();
    this.requestReadMediaPermission();
  }

  private requestLocationPermission() {
    const permissions: Array<Permissions> = ['ohos.permission.APPROXIMATELY_LOCATION', 'ohos.permission.LOCATION'];
    const context = getContext(this) as common.UIAbilityContext;
    const atManager = abilityAccessCtrl.createAtManager();
    atManager.requestPermissionsFromUser(context, permissions).then((data) => {
      console.log(JSON.stringify(data));
      this.hasLocationPermission = data.authResults.every(result => result === 0);
      if (!this.hasLocationPermission) {
        prompt.showToast({
          message: '没有位置权限,某些功能可能无法使用',
          duration: 3000,
        });
      } else {
        console.log('位置权限已获取');
      }
    });
  }

  private requestReadMediaPermission() {
    const permissions: Array<Permissions> = ['ohos.permission.READ_MEDIA'];
    const context = getContext(this) as common.UIAbilityContext;
    const atManager = abilityAccessCtrl.createAtManager();
    atManager.requestPermissionsFromUser(context, permissions).then((data) => {
      console.log(JSON.stringify(data));
      this.hasReadMediaPermission = data.authResults.every(result => result === 0);
      if (!this.hasReadMediaPermission) {
        prompt.showToast({
          message: '没有读取媒体文件权限,无法访问相册',
          duration: 3000,
        });
      } else {
        console.log('读取媒体文件权限已获取');
      }
    });
  }

  private async getCurrentLocation() {
    try {
      if (geoLocationManager.isLocationEnabled()) {
        let request: geoLocationManager.SingleLocationRequest = {
          'locatingPriority': geoLocationManager.LocatingPriority.PRIORITY_LOCATING_SPEED,
          'locatingTimeoutMs': 10000
        };
        let location = await geoLocationManager.getCurrentLocation(request);
        console.log('current location: ' + JSON.stringify(location));
        this.currentLocation = location;
        this.onLocationSend?.(JSON.stringify(this.currentLocation));
      } else {
        console.log("位置服务不可用");
        prompt.showToast({
          message: '请在系统设置中开启位置服务',
          duration: 3000,
        });
      }
    } catch (err) {
      console.error("errCode:" + JSON.stringify(err));
    }
  }

  private async takePhoto() {
    const context = getContext(this) as common.UIAbilityContext;
    const atManager = abilityAccessCtrl.createAtManager();
    const result = await atManager.requestPermissionsFromUser(context, ['ohos.permission.CAMERA']);
    if (result.authResults[0] === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      this.isCapturing = true;
      this.onImageSelected?.([this.imgSrc]);
    } else {
      console.error('Camera permission denied');
    }
  }

  private stopCapture() {
    this.isCapturing = false;
    this.imgSrc = '';
  }

  build() {
    Grid() {//网格布局,最多放4个图标，布局方向一行一列
      GridItem() {
        this.createMenu($r("app.media.ic_camera"), "相册")
      }
      .onClick(()=>{
        if (this.hasReadMediaPermission) {
          this.onImageSelected?.([]);
        } else {
          console.log("没有读取媒体文件权限");
          prompt.showToast({
            message: '请在系统设置中开启读取媒体文件权限',
            duration: 3000,
          });
        }
      })

      GridItem() {
        this.createMenu($r("app.media.ic_shoot"), "拍摄")
      }
      .onClick(()=>{
        if (this.isCapturing) {
          this.stopCapture();
        } else {
          this.takePhoto();
        }
      })

      GridItem() {
        this.createMenu($r("app.media.ic_voice_call"), "语音通话")
      }

      GridItem() {
        this.createMenu($r("app.media.ic_location"), "位置")
      }
      .onClick(async () => {
        if (this.hasLocationPermission) {
          this.getCurrentLocation();
        } else {
          console.log("没有位置权限");
          prompt.showToast({
            message: '请在系统设置中开启位置权限',
            duration: 3000,
          });
        }
      })

      GridItem() {
        this.createMenu($r("app.media.ic_red_pkg"), "红包")
      }
      GridItem() {
        this.createMenu($r("app.media.ic_translation"), "转账")
      }

      GridItem() {
        Text('位置').fontSize(16)
        this.createMenu($r("app.media.ic_voice_input"), "语音输入")
      }

      GridItem() {
        this.createMenu($r("app.media.ic_my_collection"), "我的收藏")
      }

      GridItem() {
        this.createMenu($r("app.media.ic_voice"), "群工具")
      }

    }
    .maxCount(4)
    .layoutDirection(GridDirection.Row)
    .rowsTemplate('1fr 1fr')
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .height(250)
    .backgroundColor("#f9f9f9")
    .padding({ top: 20, bottom: 20 })
  }

  @Builder
  //封装
  createMenu(iconSrc: Resource, menuName: string) {
    Column() {
      Image(iconSrc)
        .width(60)
        .height(60)
        .objectFit(ImageFit.Fill)
        .margin({ bottom: 5 })
        .padding(13)
        .borderRadius(15)
        .backgroundColor(Color.White)
      // 文本
      Text(menuName)
        .fontColor(Color.Gray)
        .fontSize(14)
    }
    .borderRadius(20)
    .justifyContent(FlexAlign.Center)
    .width(70)
    .height(70)
  }
}