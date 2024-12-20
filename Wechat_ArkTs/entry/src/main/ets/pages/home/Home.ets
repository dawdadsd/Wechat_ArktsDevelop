import router from '@ohos.router'
import prompt from '@ohos.prompt'
import ListChatItem, { ChatItemData } from '../../component/ListChatItem'
import WechatToolbar from '../../component/WechatToolbar'
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../utils/StatusBarManager';

@Entry
@Component
export default struct Home {
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#F7F7F7', true);
  }

  @State chatList: ChatItemData[] = [
    {
      headSrc: $r("app.media.yutao"),
      nickname: "网友黄宇涛",
      content: "我在打黑神话",
      time: "17:21"
    },
    {
      headSrc: $r("app.media.huanghuajun"),
      nickname: "黄先生",
      content: "明天我要去北京开会",
      time: "15:38"
    },
    {
      headSrc: $r("app.media.wangtao"),
      nickname: "同事王涛",
      content: "领导，报告写好了，请过目",
      time: "14:12"
    },
    {
      headSrc: $r("app.media.xingyuan"),
      nickname: "周老板",
      content: "这个岗位还需要招两个人",
      time: "12:08"
    },
    {
      headSrc: $r("app.media.daijinbao"),
      nickname: "客户代金保",
      content: "这是我们公司的报价，希望您能考虑下",
      time: "昨天"
    },
    {
      headSrc: $r("app.media.zhaoquan"),
      nickname: "赵经理",
      content: "天凉注意填衣",
      time: "17:21"
    },
    {
      headSrc: $r("app.media.pangzhenron"),
      nickname: "pzr老弟",
      content: "好的，哥",
      time: "周一"
    }
  ]
  @State isMenuVisible: boolean = false;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Row().height(`${this.statusBarHeight}px`).width('100%')

        // 顶部栏
        Row() {
          Text('微信(5)')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
          Blank()
          Image($r('app.media.ic_add'))
            .width(24)
            .height(24)
            .margin({ right: 16 })
            .onClick(() => this.isMenuVisible = !this.isMenuVisible)
        }
        .width('100%')
        .height(50)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#EDEDED')

        // 搜索栏
        Row() {
          Image($r('app.media.ic_search'))
            .width(20)
            .height(20)
          Text('搜索')
            .fontSize(14)
            .margin({ left: 8 })
            .fontColor('#999999')
        }
        .width('92%')
        .height(36)
        .borderRadius(4)
        .backgroundColor('#E6E6E6')
        .margin({ top: 8, bottom: 8 })
        .onClick(() => {
          router.pushUrl({
            url: "pages/search/SearchPage"
          })
        })

        // 聊天列表
        List() {
          ForEach(this.chatList, (item: ChatItemData) => {
            ListItem() {
              ListChatItem({ data: item })
            }
            .onClick(() => {
              router.pushUrl({
                url: 'pages/chat/ChatPage',
                params: {
                  name: item.nickname,
                  headSrc: item.headSrc
                }
              })
            })
          })
          ListItem() {
            Divider().color(Color.Transparent).strokeWidth(0)
          }
        }
        .divider({
          strokeWidth: 0.8,
          color: '#f0f0f0',
          startMargin: 90,
          endMargin: 0
        })
        .backgroundColor(Color.White)
        .layoutWeight(1)
      }
      .width("100%")
      .height("100%")
      .backgroundColor("#EDEDED")

      // 弹出菜单
      if (this.isMenuVisible) {
        Column() {
          this.menuItem('发起群聊', $r('app.media.foreground'),'pages/contact/label/TagPage')
          this.menuItem('添加朋友', $r('app.media.ic_user_head7'),'pages/contact/NewFriendPage/NewFriendPage')
          this.menuItem('扫一扫', $r('app.media.ic_add'), 'pages/qrcode/ScanPage')
          this.menuItem('收付款', $r('app.media.ic_user_head6'), 'pages/payment/Payment')
        }
        .width(160)
        .padding({ top: 8, bottom: 8 })
        .backgroundColor(Color.White)
        .borderRadius(4)
        .position({ x: '100%', y: 50 })
        .translate({ x: -170 })
        .shadow({
          radius: 4,
          color: 'rgba(0, 0, 0, 0.1)',
          offsetX: 0,
          offsetY: 2
        })
      }
    }
  }

  @Builder
  tabItem(text: string, icon: Resource, isSelected: boolean = false) {
    Column() {
      Image(icon)
        .width(24)
        .height(24)
      Text(text)
        .fontSize(10)
        .fontColor(isSelected ? '#07C160' : '#999999')
    }
    .layoutWeight(1)
  }

  @Builder
  menuItem(text: string, icon: Resource, url: string) {
    Row() {
      Image(icon)
        .width(24)
        .height(24)
      Text(text)
        .fontSize(16)
        .margin({ left: 12 })
    }
    .width('100%')
    .height(48)
    .padding({ left: 16, right: 16 })
    .onClick(() => this.navigateTo(url))
  }

  navigateTo(url: string) {
    this.isMenuVisible = false
    switch (url) {
      case 'pages/contact/label/TagPage':
        this.navigateToCreateGroup()
        break
      case 'pages/contact/NewFriendPage/NewFriendPage':
        this.navigateToAddFriend()
        break
      case 'pages/qrcode/ScanPage':
        this.navigateToScanPage()
        break
      case 'pages/payment/Payment':
        this.navigateToPayment()
        break
      default:
        console.error(`Unknown page: ${url}`)
        prompt.showToast({ message: `未知页面: ${url}` })
    }
  }

  private navigateToCreateGroup() {
    router.pushUrl({ url: 'pages/contact/label/TagPage'})
  }

  private navigateToAddFriend() {
    router.pushUrl({ url:'pages/contact/NewFriendPage/NewFriendPage'})
  }

  private navigateToScanPage() {
    router.pushUrl({ url: 'pages/qrcode/ScanPage' })
  }

  private navigateToPayment() {
    router.pushUrl({ url: 'pages/payment/Payment' })
  }
}