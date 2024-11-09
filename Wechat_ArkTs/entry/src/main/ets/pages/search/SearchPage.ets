import prompt from '@ohos.promptAction';
import router from '@ohos.router';
import common from '@ohos.app.ability.common';
import window from '@ohos.window';
import { NAV_BAR_HEIGHT, STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';
import { ToastUtils } from '../../utils/ToastUtils';
import { ContactItem } from '../contact/DataItem';
import DataItem from '../contact/DataItem';

@Entry
@Component
struct SearchPage {
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  private controller: TextInputController = new TextInputController()
  private keyboardHeight: number = 0
  @State private searchText: string = ''
  @State private searchResults: ContactItem[] = []
  @StorageLink(STATUS_BAR_HEIGHT) statusBarHeight: number = 0
  @StorageLink(NAV_BAR_HEIGHT) navBarHeight: number = 0
  private dataList: DataItem[] = []
  @State private recentSearches: string[] = ['张三', '李四', '王五'] // 添加类型定义
  @State private hotSearches: string[] = ['热门1', '热门2', '热门3'] // 添加类型定义

  aboutToAppear() {
    window.getLastWindow(this.context).then((currentWindow) => {
      currentWindow.on('keyboardHeightChange', (height: number) => {
        this.keyboardHeight = height;
      })
    })
    // 获取联系人数据
    const params = router.getParams() as Record<string, DataItem[]>;
    this.dataList = params?.['dataList'] || [];
  }

  onBackPress(): boolean {
    return this.keyboardHeight > 0
  }

  searchContacts(text: string): void {
    this.searchResults = []
    if (text.trim() === '' || !this.dataList.length) {
      return
    }

    this.dataList.forEach(group => {
      if (group.contactList) {  // 添加此检查
        group.contactList.forEach(contact => {
          if (contact.name.toLowerCase().includes(text.toLowerCase())) {
            this.searchResults.push(contact)
          }
        })
      }
    })
  }


  build() {
    Column() {
      // 状态栏占位
      Row().height(px2vp(this.statusBarHeight))

      // 搜索栏
      Row() {
        Stack() {
          TextInput({ text: this.searchText, placeholder: '搜索', controller: this.controller })
            .width('100%')
            .height(40)
            .backgroundColor('#e6e6e6')
            .borderRadius(6)
            .fontSize(16)
            .padding({ left: 40, right: 40 })
            .onChange((value: string) => {
              this.searchText = value
              this.searchContacts(value)
            })

          Image($r('app.media.ic_search'))
            .width(20)
            .height(20)
            .margin({ left: 12 })
            .position({ x: 0, y: '50%' })
            .translate({ y: -10 })

          if (this.searchText) {
            Image($r("app.media.ic_close"))
              .width(20)
              .height(20)
              .margin({ right: 12 })
              .position({ x: '100%', y: '50%' })
              .translate({ x: -25, y: -10 })
              .onClick(() => {
                this.searchText = ''
                this.controller.caretPosition(0)
                this.searchResults = []
              })
          }
        }
        .margin({ left: 20 })
        .layoutWeight(1)

        Text("取消")
          .fontColor(Color.Blue)
          .fontSize(17)
          .margin({ left: 10, right: 20 })
          .onClick(() => {
            router.back()
          })
      }
      .width("100%")
      .height(40)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 10 })

      // 搜索结果列表
      if (this.searchResults.length > 0) {
        List() {
          ForEach(this.searchResults, (contact: ContactItem) => {
            ListItem() {
              Row() {
                Image(contact.head)
                  .width(40)
                  .height(40)
                  .borderRadius(20)
                Text(contact.name)
                  .fontSize(16)
                  .margin({ left: 10 })
              }
              .width('100%')
              .padding(10)
              .backgroundColor('#FFFFFF')
              .onClick(() => {
                // 处理联系人点击事件，可以跳转到联系人详情页
                router.pushUrl({
                  url: 'pages/search/JayProfilePage',
                  params: { contact: contact }
                })
              })
            }
          }, (item: ContactItem) => item.name)
        }
        .width('100%')
        .layoutWeight(1)
      } else if (this.searchText) {
        Text('没有找到匹配的联系人')
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ top: 20 })
      } else {
        this.DefaultSearchView()
      }

      // 导航栏占位
      Row().height(px2vp(this.navBarHeight))
    }
    .width("100%")
    .height("100%")
    .alignItems(HorizontalAlign.Start)
    .backgroundColor("#f3f3f3")
  }
@Builder
  DefaultSearchView() {
    Column() {
      // 最近搜索
      Text('最近搜索')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .alignSelf(ItemAlign.Start)
        .margin({ top: 20, left: 16 })

      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
        ForEach(this.recentSearches, (item:string) => {
          this.SearchItem(item)
        })
      }.padding({ left: 16, right: 16, top: 10 })

      // 热门搜索
      Text('热门搜索')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .alignSelf(ItemAlign.Start)
        .margin({ top: 20, left: 16 })

      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
        ForEach(this.hotSearches, (item:string) => {
          this.SearchItem(item)
        })
      }.padding({ left: 16, right: 16, top: 10 })
    }
    .width('100%')
  }

  @Builder
  SearchItem(title: string) {
    Text(title)
      .fontSize(14)
      .backgroundColor('#f0f0f0')
      .borderRadius(16)
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .margin({ right: 8, bottom: 8 })
      .onClick(() => {
        this.searchText = title
        this.searchContacts(title)
      })
  }
}
interface Contact {
  name: string;
  // 其他联系人属性...
}