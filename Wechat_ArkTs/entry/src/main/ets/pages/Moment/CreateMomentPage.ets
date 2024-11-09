import router from '@ohos.router';
import picker from '@ohos.file.picker';
import { MomentDataItem } from './types';
import { RouterParams, RouterParamsData } from './types';
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';

@Entry
@Component
export struct CreateMomentPage {
  @State content: string = '';
  @State selectedImages: string[] = [];
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#F7F7F7', true);
  }
  build() {
    Column() {
      Row().height(`${this.statusBarHeight}px`).width('100%').backgroundColor('#F7F7F7')
      // 导航栏
      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .onClick(() => router.back())
        Text('发布朋友圈')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Blank()
        Button('发布')
          .onClick(() => this.publishMoment())
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })

      // 内容输入框
      TextArea({ placeholder: '这一刻的想法...' })
        .height(200)
        .onChange((value: string) => {
          this.content = value;
        })

      // 图片选择器
      Grid() {
        ForEach(this.selectedImages, (image:Resource, index) => {
          GridItem() {
            Image(image)
              .width('100%')
              .height(100)
              .objectFit(ImageFit.Cover)
          }
        })
        GridItem() {
          Button({ type: ButtonType.Circle }) {
            Image($r('app.media.ic_add'))
              .width(24)
              .height(24)
          }
          .width(100)
          .height(100)
          .backgroundColor('#F0F0F0')
          .onClick(() => this.selectImages())
        }
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr')
      .width('100%')
      .height(300)
    }
    .width('100%')
    .height('100%')
  }

  async selectImages() {
    try {
      let photoPicker = new picker.PhotoViewPicker();
      let result = await photoPicker.select({
        MIMEType: picker.PhotoViewMIMETypes.IMAGE_TYPE,
        maxSelectNumber: 9
      });
      if (result && result.photoUris) {
        this.selectedImages = result.photoUris;
      }
    } catch (error) {
      console.error('Failed to select images:', error);
    }
  }
  publishMoment() {
    console.info('Publishing moment:', this.content, this.selectedImages);
    const paramsData: RouterParamsData = {
      content: this.content,
      imageList: this.selectedImages
    };
    const params: RouterParams = {
      data: paramsData
    };
    router.back({
      url: 'pages/Moment/MomentPage',
      params: params
    });
  }
}