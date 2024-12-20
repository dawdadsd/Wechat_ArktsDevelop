import { router } from '@kit.ArkUI'
import { ChatContentItemData } from './ChatContentItemData'
import ChatPageParm from './ChatPageParam'
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';
@Entry
@Component
struct ChatSearchPage {
  @State private searchText: string = ''
  @State private dataList: ChatContentItemData[] = []
  @StorageLink(STATUS_BAR_HEIGHT) statusBarHeight: number = 0
  aboutToAppear() {
    let params = router.getParams() as ChatPageParm
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
        Text('搜索')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 12 })
        Blank()
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFFFFF')

      TextInput({ placeholder: '搜索', text: this.searchText })
        .placeholderColor(Color.Gray)
        .placeholderFont({ size: 16 })
        .textAlign(TextAlign.Start)
        .caretColor(Color.Blue)
        .height(40)
        .fontSize(16)
        .margin({
          left: 16,
          right: 16,
          top: 8,
          bottom: 8
        })
        .backgroundColor('#F5F5F5')
        .borderRadius(20)
        .onChange((value: string) => {
          this.searchText = value
        })

      List() {
        ForEach(this.dataList, (item: ChatContentItemData) => {
          ListItem() {
            /*
            因为在ChatContentItemData接口里面msg是可选属性，所以要进行类型守卫，使用了可选连和空值合并控制符就行，不然会undefine。
             */
            if (item.msg?.includes(this.searchText) ?? false) {
              Text(item.msg)
                .fontSize(16)
                .padding(12)
            }
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
} 