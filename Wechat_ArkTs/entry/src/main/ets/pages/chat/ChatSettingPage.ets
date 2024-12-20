import { router } from '@kit.ArkUI'
import {ChatContentItemData} from '../chat/ChatContentItemData'
import ChatPageParam from './ChatPageParam'
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';
import { PhotoPickerUtils } from '../../utils/PhotoPickerUtils'
import { ToastUtils } from '../../utils/ToastUtils'
@Entry
@Component
struct ChatDetailPage {
  @State isDisturb: boolean = false
  @State isTop: boolean = false
  private name: string = ''
  @State private dataList: ChatContentItemData[] = []
  @StorageLink(STATUS_BAR_HEIGHT) statusBarHeight: number = 0
  @State imgPath: string = ""
  aboutToAppear() {
    let params = router.getParams() as ChatPageParam//一定要声明类型不然会报错ps12/20
    this.name = params.name
    this.dataList = params.dataList
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#f1f1f1', false);
  }

  build() {
    Column() {
      Row().height(`${this.statusBarHeight}px`).width('100%').backgroundColor('#f1f1f1')

      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .margin({ left: 16 })
          .onClick(() => {
            router.back()
          })
        Text('聊天详情')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 12 })
        Blank()
        Image($r('app.media.ic_more'))
          .width(24)
          .height(24)
          .margin({ right: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFFFFF')

      Column() {
        Row() {
          Image($r('app.media.jay'))
            .width(64)
            .height(64)
            .borderRadius(4)
            .margin({ left: 16, right: 16 })
            .onClick(() => {
              PhotoPickerUtils.openGallery(
                uri => {
                  this.imgPath = uri;
                }, errMsg => {
                ToastUtils.show(errMsg)
              })
            })
          /*
           可以恶搞一下换头像哈哈哈哈哈
           */
          Text(this.name)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .onClick(() => {
          // 点击头像和昵称区域的事件处理
        })

        Divider()
          .color('#EEEEEE')
          .strokeWidth(0.5)
          .margin({ left: 16, right: 16 })

        Row() {
          Text('查找聊天内容')
            .fontSize(16)
            .flexGrow(1)
          Image($r('app.media.ic_next'))
            .width(16)
            .height(16)
            .margin({ right: 16 })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .onClick(() => {
          //12/20新增查询聊天记录，传递Chat的数据
          router.pushUrl({
            url: 'pages/chat/ChatSearchPage',
            params: { dataList: this.dataList }
          })
        })

        Row() {
          Text('消息免打扰')
            .fontSize(16)
            .flexGrow(1)
          Toggle({ type: ToggleType.Switch, isOn: this.isDisturb })
            .selectedColor('#07C160')
            .width(51)
            .height(31)
            .onChange((isOn: boolean) => {
              this.isDisturb = isOn
            })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })

        Row() {
          Text('置顶聊天')
            .fontSize(16)
            .flexGrow(1)
          Toggle({ type: ToggleType.Switch, isOn: this.isTop })
            .selectedColor('#07C160')
            .width(51)
            .height(31)
            .onChange((isOn: boolean) => {
              this.isTop = isOn
            })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })

        Divider()
          .color('#EEEEEE')
          .strokeWidth(0.5)
          .margin({ left: 16, right: 16 })

        Row() {
          Text('设置当前聊天背景')
            .fontSize(16)
            .flexGrow(1)
          Image($r('app.media.ic_next'))
            .width(16)
            .height(16)
            .margin({ right: 16 })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .onClick(() => {
          // 点击"设置当前聊天背景"的事件处理
        })

        Text('清空聊天记录')
          .fontSize(16)
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          .onClick(() => {
            this.dataList = []
            router.back()
          })

        Divider()
          .color('#EEEEEE')
          .strokeWidth(0.5)
          .margin({ left: 16, right: 16 })

        Text('投诉')
          .fontSize(16)
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          .onClick(() => {
            // 点击"投诉"的事件处理
          })
      }
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}