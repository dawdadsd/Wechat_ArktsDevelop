import router from '@ohos.router';
import prompt from '@ohos.promptAction';
import window from '@ohos.window';
import Toolbar from '../../component/Toolbar';
import ListChatContentLeftItem from '../../component/ListChatContentLeftItem';
import ListChatContentRightItem from '../../component/ListChatContentRightItem';
import { NAV_BAR_HEIGHT } from '../../utils/StatusBarManager';
import ChatFunctionBar from './ChatFuntionBar';
import { ChatContentItemData } from './ChatContentItemData';
import ChatPageParam from './ChatPageParam';
import { ToastUtils } from '../../utils/ToastUtils';

@Entry
@Component
export default struct ChatPage {
  private name?: string = ""
  private headSrc?: Resource
  private controller: TextAreaController = new TextAreaController()
  @State private chatText: string = ''
  private keyboardHeight: number = 0
  @StorageLink(NAV_BAR_HEIGHT) navBarHeight: number = 0
  @State private funcBarHeight: number = 0;
  @State private showFuncBar: boolean = false;
  @State private dataList: ChatContentItemData[] = []
  private scroller: Scroller = new Scroller()

  aboutToAppear() {
    let params = router.getParams() as ChatPageParam;
    this.name = params.name;
    this.headSrc = params.headSrc;

    // 初始化聊天记录
    this.dataList = [
      {
        name: this.name,
        headSrc: this.headSrc,
        msgType: 0,
        self: false,
        msg: "你好，有什么可以帮到你的吗？"
      }
    ];
  }

  onBackPress() {
    return this.keyboardHeight > 0
  }
  private generateAutoReply(message: string): string {
    const responses = [
      "我明白了，请继续。",
      "这很有趣，能详细说说吗？",
      "我需要一些时间来处理这个信息。",
      "你说得对，我完全同意。",
      "这是个很好的观点，我们应该进一步讨论。"
    ];
    return responses[Math.floor(Math.random() * responses.length)];
  }
  private sendMessage() {
    if (this.chatText.trim() === '') return;
    // 添加用户消息
    this.dataList.push({
      name: "我",
      headSrc: $r("app.media.jay"),
      msgType: 0,
      self: true,
      msg: this.chatText
    });

    // 清空输入框
    const sentMessage = this.chatText;
    this.chatText = '';
    this.controller.caretPosition(0);

    // 生成自动回复
    setTimeout(() => {
      const autoReply = this.generateAutoReply(sentMessage);
      this.dataList.push({
        name: this.name,
        headSrc: this.headSrc,
        msgType: 0,
        self: false,
        msg: autoReply
      });
      this.scrollToBottom();
    }, 1000);

    this.scrollToBottom();
  }

  private scrollToBottom() {
    this.scroller.scrollToIndex(this.dataList.length - 1);
  }

  build() {
    Column() {
      Toolbar({ title: this.name })
      List({ space: 20, initialIndex: 5, scroller: this.scroller }) {
        ForEach(this.dataList, (item: ChatContentItemData) => {
          ListItem() {
            if (item.self) {
              ListChatContentRightItem({ data: item })
            } else {
              ListChatContentLeftItem({ data: item })
            }
          }
        })
        ListItem() {
          Row().height(px2vp(20))
        }
      }
      .width("100%")
      .layoutWeight(1)

      Row() {
        Image($r("app.media.ic_use_voice"))
          .width(33)
          .height(33)
          .borderRadius(4)
          .margin({ left: 15, right: 15 })
          .objectFit(ImageFit.Cover)
          .onClick(unDevTip)

        TextArea({ text: this.chatText, placeholder: '', controller: this.controller })
          .placeholderFont({ size: 20, weight: 400 })
          .caretColor(Color.Green)
          .placeholderColor(Color.Grey)
          .layoutWeight(1)
          .padding({ left: 8, right: 8 })
          .fontSize(20)
          .fontColor(Color.Black)
          .borderRadius(8)
          .stateStyles({
            normal: { .backgroundColor(Color.White) },
            pressed: { .backgroundColor(Color.White) },
            clicked: { .backgroundColor(Color.White) },
            focused: { .backgroundColor(Color.White) }
          })
          .onChange((value: string) => {
            this.chatText = value
          })

        Image($r("app.media.ic_emoji_pack"))
          .width(33)
          .height(33)
          .borderRadius(4)
          .margin({ left: 15, right: 5 })
          .objectFit(ImageFit.Cover)
          .onClick(unDevTip)

        Text("发送")
          .fontColor(Color.White)
          .width(65)
          .textAlign(TextAlign.Center)
          .height(36)
          .backgroundColor("#58BE6A")
          .fontSize(18)
          .visibility(this.chatText.length == 0 ? Visibility.None : Visibility.Visible)
          .borderRadius(6)
          .margin({ left: 10, right: 10 })
          .onClick(() => {
            this.sendMessage()
          })

        Image($r("app.media.ic_add"))
          .width(33)
          .height(33)
          .borderRadius(4)
          .visibility(this.chatText.length == 0 ? Visibility.Visible : Visibility.None)
          .margin({ left: 15, right: 8 })
          .objectFit(ImageFit.Cover)
          .onClick(() => {
            animateTo({ duration: 400, curve: Curve.Ease }, () => {
              if (this.showFuncBar) {
                this.funcBarHeight = 0;
              } else {
                this.funcBarHeight = 250;
              }
              this.showFuncBar = !this.showFuncBar;
            })
          })

      }
      .padding({ top: 10, bottom: 10 })
      .alignItems(VerticalAlign.Bottom)
      .backgroundColor("#f9f9f9")

      Divider()
        .vertical(false)
        .color("#f0f0f0")
        .strokeWidth(1)
        .lineCap(LineCapStyle.Round)

      ChatFunctionBar()
        .height(this.funcBarHeight)

      Row().height(px2vp(this.navBarHeight))

    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f1f1f1")
  }
}

const unDevTip = () => {
  ToastUtils.show("功能正在开发中...")
}
