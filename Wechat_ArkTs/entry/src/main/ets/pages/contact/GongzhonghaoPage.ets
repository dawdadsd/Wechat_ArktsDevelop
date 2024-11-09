import prompt from '@ohos.promptAction'
import router from '@ohos.router'
import ListContactItem from '../../component/ListContactItem'
import WechatToolbar from '../../component/WechatToolbar'
import DataItem, { ContactItem } from './DataItem'

@Entry
@Preview
@Component
export default struct GongzhonghaoContact {
  private scroller: Scroller = new Scroller()
  private dataList: DataItem[] = [
    {
      title: 'A',
      contactList: [
        { name: "AIPPT", head: $r("app.media.aippt") },
        { name: "安全教育平台", head: $r("app.media.anquanjiaoyu") },
        { name: "安热沙", head: $r("app.media.Yanzhengma") },
        { name: "A咱厝人外卖", head: $r("app.media.zancuren") }
      ]
    },
    {
      title: 'B',
      contactList: [
        { name: "百词斩", head: $r("app.media.baicizhan") },
        {name: "霸王茶姬", head: $r("app.media.bawang") }
      ]
    },
    {
      title: 'C',
      contactList: [
        { name: "创新创业大事记", head: $r("app.media.chuangxin") },
        { name: "词达人", head: $r("app.media.cidaren") },
        { name: "茶百道chapanda", head: $r("app.media.chabaidao") },
        { name: "COTTI COFFEE", head: $r("app.media.cotti") }
      ]
    },
    {
      title: 'D',
      contactList: [
        { name: "达达快送", head: $r("app.media.dadakuaisong") },
        { name: "大众点评", head: $r("app.media.dazhongdianping") },
        { name: "滴滴出行", head: $r("app.media.didichuxing") },
        { name: "电信宽带办理服务", head: $r("app.media.dianxinkuandai") }
      ]
    },
    {
      title: 'X',
      contactList: [
        { name: "洗烘服务中心", head: $r("app.media.xihong") },
        { name: "西西打车", head: $r("app.media.xixi") }
      ]
    },
    {
      title: 'Z',
      contactList: [
        { name: "中国国际航空", head: $r("app.media.hangkong") },
        { name: "中国青年志愿者", head: $r("app.media.zhiyuanzhe") },
        { name: "中国银行福建省分行", head: $r("app.media.yinhang") }
      ]
    }
  ];
  private letterList: string[] =
    ['↑', '☆', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
      'V', 'W', 'X', 'Y', 'Z', '#']

  @Builder
  itemHead(title: string) {
    Text(title)
      .fontSize(14)
      .visibility("" === title ? Visibility.None : Visibility.Visible)
      .backgroundColor("#EDEDED")
      .height(36)
      .width("100%")
      .padding({ left: 20 })
  }

  build() {
    Stack({ alignContent: Alignment.End }) {
      Column() {
        // 修改后的WechatToolbar组件
        WechatToolbar({
          titleS: "公众号",
          showBack: true,
          showAdd:false,
          onBackClick: () => {
            router.back()
          }
        })

        // 通讯录列表
        List({ scroller: this.scroller }) {
          ForEach(this.dataList, (item: DataItem) => {
            ListItemGroup({ header: this.itemHead(item.title) }) {
              ForEach(item.contactList, (contact: ContactItem) => {
                ListItem() {
                  ListContactItem({ head: contact.head, name: contact.name })
                }
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/chat/ChatPage',
                    params: { name: contact.name }
                  })
                })
              })
            }
            .divider({
              strokeWidth: 0.8,
              color: '#f0f0f0',
              startMargin: 85,
              endMargin: 0
            })
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
    }.width("100%")
    .height("100%")
  }
}
