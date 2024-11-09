import prompt from '@ohos.promptAction'
import router from '@ohos.router'
import ListContactItem from '../../component/ListContactItem'
import WechatToolbar from '../../component/WechatToolbar'
import DataItem, { ContactItem } from './DataItem'

@Preview
@Component
export default struct Contact {
  @State searchText: string = ''
  @State searchResults: ContactItem[] = []
  private scroller: Scroller = new Scroller()
  private dataList: DataItem[] = [
  // ... 保持原有的 dataList 内容不变 ...
    {
      title: '',
      contactList: [
        { name: "新的朋友", head: $r("app.media.ic_new_friend") },
        { name: "群聊", head: $r("app.media.ic_group_chat") },
        { name: "标签", head: $r("app.media.ic_tag") },
        { name: "公众号", head: $r("app.media.ic_official_account") }
      ]
    },
    {
      title: 'A',
      contactList: [
        { name: "阿", head: $r("app.media.huangjingni") },
        { name: "阿呀", head: $r("app.media.xubaomei") },
        { name: "阿呀哈哈", head: $r("app.media.maju") }
      ]
    },
    {
      title: 'B',
      contactList: [
        { name: "不", head: $r("app.media.mosanmei") },
        { name: "不喝", head: $r("app.media.jay") },
        { name: "不喝饮料", head: $r("app.media.jay") }
      ]
    },
    {
      title: 'C',
      contactList: [
        { name: "菜", head: $r("app.media.jay") },
        { name: "菜鸟", head: $r("app.media.jay") },
        { name: "菜鸟敲代码", head: $r("app.media.jay") }
      ]
    },
    {
      title: 'D',
      contactList: [
        { name: "大", head: $r("app.media.jay") },
        { name: "大哥", head: $r("app.media.jay") },
        { name: "大哥大", head: $r("app.media.jay") }
      ]
    },
    {
      title: 'S',
      contactList: [
        { name: "石破天", head: $r("app.media.jay") },
        { name: "宋浩杰", head: $r("app.media.jay") }
      ]
    },
    {
      title: 'Z',
      contactList: [
        { name: "猪八戒", head: $r("app.media.jay") },
        { name: "张宇恒", head: $r("app.media.jay") },
        { name: "周大年", head: $r("app.media.jay") }
      ]
    }
  ];
  private letterList: string[] = ['↑', '☆', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '#']

  searchContacts(keyword: string): void {
    this.searchResults = []
    if (keyword.trim() === '') {
      return
    }

    this.dataList.forEach(group => {
      group.contactList.forEach(contact => {
        if (contact.name.toLowerCase().includes(keyword.toLowerCase())) {
          this.searchResults.push(contact)
        }
      })
    })
  }

  @Builder
  itemHead(title: string): void {
    Text(title)
      .fontSize(14)
      .visibility(title === "" ? Visibility.None : Visibility.Visible)
      .backgroundColor("#EDEDED")
      .height(36)
      .width("100%")
      .padding({ left: 20 })
  }

  build() {
    Stack({ alignContent: Alignment.End }) {
      Column() {
        WechatToolbar({ title: "通讯录" })

        // 添加搜索框
        TextInput({ placeholder: '搜索' })
          .width('90%')
          .height(40)
          .backgroundColor('#F5F5F5')
          .margin({ top: 10, bottom: 10 })
          .borderRadius(6)
          .onChange((value: string) => {
            this.searchText = value
            this.searchContacts(value)
          })

        List({ scroller: this.scroller }) {
          ForEach(this.searchText ? this.searchResults : this.dataList, (item: DataItem | ContactItem) => {
            if (this.searchText) {
              ListItem() {
                Row() {
                  ListContactItem({ head: (item as ContactItem).head, name: (item as ContactItem).name })
                }
              }
            } else {
              ListItemGroup({ header: this.itemHead((item as DataItem).title) }) {
                ForEach((item as DataItem).contactList, (contact: ContactItem) => {
                  ListItem() {
                    Row() {
                      ListContactItem({ head: contact.head, name: contact.name })
                      if (contact.isStarred) {
                        Image($r('app.media.jay'))
                          .width(20)
                          .height(20)
                          .margin({ right: 10 })
                      }
                    }
                  }
                  .onClick(() => {
                    switch (contact.name) {
                      case "新的朋友":
                        router.pushUrl({ url: "pages/contact/NewFriendPage/NewFriendPage" })
                        break
                      case "群聊":
                        router.pushUrl({ url: "pages/contact/GroupChatPage" })
                        break
                      case "标签":
                        router.pushUrl({ url: "pages/contact/label/TagPage"})
                        break
                      case "公众号":
                        router.pushUrl({ url: "pages/contact/GongzhonghaoPage" })
                        break
                      default:
                      // 处理普通联系人的点击事件
                        break
                    }
                  })
                })
              }
              .divider({
                strokeWidth: 0.8,
                color: '#f0f0f0',
                startMargin: 85,
                endMargin: 0
              })
            }
          })
        }
        .width('100%')
        .height(0)
        .layoutWeight(1)
        .backgroundColor(Color.White)
      }
      .width("100%")
      .height("100%")

      AlphabetIndexer({ arrayValue: this.letterList, selected: 0 })
        .color(Color.Black)
        .font({ size: 14 })
        .selectedFont({ size: 14 })
        .selectedColor(Color.Black)
        .selectedBackgroundColor(Color.Transparent)
        .usingPopup(true)
        .popupColor(Color.Red)
        .popupBackground("#57be6a")
        .popupFont({ size: 32, weight: FontWeight.Bolder })
        .itemSize(20)
        .alignStyle(IndexerAlign.Right)
        .margin({ top: 80 })
        .onSelect((index: number) => {
          let letter = this.letterList[index]
          let target: number = 0
          for (const item of this.dataList) {
            if (letter === item.title) {
              this.scroller.scrollToIndex(target)
              prompt.showToast({ message: "" + target })
              break
            }
            target++
          }
        })
    }
    .width("100%")
    .height("100%")
  }
}
