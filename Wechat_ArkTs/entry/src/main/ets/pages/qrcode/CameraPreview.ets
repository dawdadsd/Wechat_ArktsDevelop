import { camera, cameraPicker as picker } from '@kit.CameraKit'
import { fileIo, fileUri } from '@kit.CoreFileKit'

@Entry
@Component
export struct CameraPreview {
  @State imgSrc: string = '';
  @State videoSrc: string = '';

  build() {
    Column() {
      Image(this.imgSrc)
        .width(200)
        .height(200)
        .backgroundColor(Color.Black)
        .margin(5)

      Video({ src: this.videoSrc })
        .width(200)
        .height(200)
        .autoPlay(true)

      Button("上面是拍照，下面是录屏")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .onClick(() => this.startCameraPicker())
        .margin(5)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  async startCameraPicker() {
    try {
      let pathDir = getContext().filesDir;
      let fileName = `${new Date().getTime()}`
      let filePath = pathDir + `/${fileName}.tmp`
      fileIo.createRandomAccessFileSync(filePath, fileIo.OpenMode.CREATE);

      let uri = fileUri.getUriFromPath(filePath);
      let pickerProfile: picker.PickerProfile = {
        cameraPosition: camera.CameraPosition.CAMERA_POSITION_BACK,
        saveUri: uri
      };

      let result: picker.PickerResult = await picker.pick(
        getContext(),
        [picker.PickerMediaType.PHOTO, picker.PickerMediaType.VIDEO],
        pickerProfile
      );

      console.info(`Picker result: Code=${result.resultCode}, URI=${result.resultUri}, Type=${result.mediaType}`);

      if (result.resultCode === 0) {
        if (result.mediaType === picker.PickerMediaType.PHOTO) {
          this.imgSrc = result.resultUri;
        } else {
          this.videoSrc = result.resultUri;
        }
      }
    } catch (error) {
      console.error('Camera picker error:', error);
    }
  }
}
