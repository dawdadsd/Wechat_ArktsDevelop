import router from '@ohos.router';
import { STATUS_BAR_HEIGHT } from '../../../utils/StatusBarManager';

@Entry
@Component
struct ContactLabelPage {
  @State isPopupVisible: boolean = false;
  @StorageLink(STATUS_BAR_HEIGHT) statusBarHeight: number = 0

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Flex({ direction: FlexDirection.Column }) {
        // 状态栏占位符
        Flex().height(this.statusBarHeight + 10)

        // 标题栏
        Flex({
          justifyContent: FlexAlign.Start,
          alignItems: ItemAlign.Center
        }) {
          Image($r('app.media.ic_back'))
            .width(24)
            .height(24)
            .margin({ left: 16 })
            .onClick(() => {
              router.back()
            })
          Text('通讯录标签')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .margin({ left: 16 })
        }
        .width('100%')
        .height(56)
        .backgroundColor('#F7F7F7')

        // 主要内容
        Flex({
          direction: FlexDirection.Column,
          justifyContent: FlexAlign.Start,
          alignItems: ItemAlign.Center
        }) {
          Text('你可以通过标签更方便地查找和管理联系人')
            .fontSize(16)
            .fontColor('#888888')
            .textAlign(TextAlign.Center)
            .margin({ top: 100, bottom: 20 })
            .padding({ left: 32, right: 32 })

          Button('添加')
            .width(200)
            .height(40)
            .fontSize(18)
            .fontColor(Color.Black)
            .backgroundColor('#ffefefef')
            .borderRadius(20)
            .onClick(() => {
              this.isPopupVisible = true
            })
        }
        .width('100%')
        .flexGrow(1)

        // 底部填充（为带有导航栏的设备预留空间）
        Flex().height(20)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      NewLabelPopup({
        isVisible: $isPopupVisible,
        onClose: () => {
          this.isPopupVisible = false
        },
        onComplete: (labelName: string) => {
          this.isPopupVisible = false
          router.pushUrl({
            url: 'pages/contact/label/LabelCreatedPage',
            params: {
              labelName: labelName
            }
          })
        }
      })
    }
    .width('100%')
    .height('100%')
  }
}

// NewLabelPopup 组件保持不��

// NewLabelPopup 组件保持不变
@Component
struct NewLabelPopup {
  @Link isVisible: boolean
  @State labelName: string = ''
  onClose?: () => void
  onComplete?: (labelName: string) => void

  build() {
    Panel(this.isVisible) {
      Column() {
        // 标题栏
        Row() {
          Text('新建标签')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('×')
            .fontSize(24)
            .fontColor(Color.Gray)
            .onClick(() => {
              if (this.onClose) {
                this.onClose()
              }
            })
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })

        TextInput({ placeholder: '标签名称' })
          .width('90%')
          .height(50)
          .margin({ top: 20 })
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .padding(10)
          .onChange((value: string) => {
            this.labelName = value
          })

        Button('完成')
          .width('90%')
          .height(50)
          .margin({ top: 20 })
          .backgroundColor('#EFEFEF')
          .fontColor(Color.Black)
          .borderRadius(8)
          .onClick(() => {
            if (this.onComplete) {
              this.onComplete(this.labelName)
            }
          })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 20, topRight: 20 })
      .padding({ top: 20, bottom: 20 })
    }
    .mode(PanelMode.Half)
    .dragBar(false)
    .backgroundColor('rgba(0,0,0,0.6)')
  }
}
