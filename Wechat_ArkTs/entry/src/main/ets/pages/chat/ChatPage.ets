import router from '@ohos.router';
import picker from '@ohos.file.picker';
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
  private name?: string = "";
  private headSrc?: Resource;
  private controller: TextAreaController = new TextAreaController();
  @State private chatText: string = '';
  @StorageLink(NAV_BAR_HEIGHT) navBarHeight: number = 0;
  @State private dataList: ChatContentItemData[] = [];
  private scroller: Scroller = new Scroller();
  @State private emojiPanelVisible: boolean = false;
  private emojiList: string[] = ['😀', '😃', '😄', '😁', '😆', '😅', '😂', '🤣', '😊', '😇'];
  @State private selectedImages: string[] = [];

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
        msg: "你好,有什么可以帮助你吗"
      }
    ];
  }

  private generateAutoReply(message: string): string {
    const responses = [
      "对不起,请你换个说法,我听不懂",
      "道理是这个道理,您说的很对",
      "嗯。",
      "你说得对,我完全同意。",
      "这是个很好的观点,等会再和我聊天吧。"
    ];
    return responses[Math.floor(Math.random() * responses.length)];
  }

  private sendMessage() {
    if (this.chatText.trim() === '' && this.selectedImages.length === 0) return;

    // 添加用户消息
    this.dataList.push({
      name: "我",
      headSrc: $r("app.media.jay"),
      msgType: this.selectedImages.length > 0 ? 1 : 0,
      self: true,
      msg: this.selectedImages.length > 0 ? this.selectedImages[0] : this.chatText
    });

    // 清空输入框和选中的图片
    const sentMessage = this.chatText;
    this.chatText = '';
    this.controller.caretPosition(0);
    this.selectedImages = [];

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

  private sendEmoji(emoji: string) {
    // 添加表情到聊天记录
    this.dataList.push({
      name: "我",
      headSrc: $r("app.media.jay"),
      msgType: 1,
      self: true,
      msg: emoji
    });

    this.scrollToBottom();
  }

  async selectImages() {
    try {
      let photoPicker = new picker.PhotoViewPicker();
      let result = await photoPicker.select({
        MIMEType: picker.PhotoViewMIMETypes.IMAGE_TYPE,
        maxSelectNumber: 1
      });
      if (result && result.photoUris) {
        this.selectedImages = result.photoUris;
      }
    } catch (error) {
      console.error('Failed to select images:', error);
    }
  }

  build() {
    Column() {
      Toolbar({ title: this.name });
      List({ space: 20, initialIndex: 5, scroller: this.scroller }) {
        ForEach(this.dataList, (item: ChatContentItemData) => {
          ListItem() {
            if (item.self) {
              ListChatContentRightItem({ data: item });
            } else {
              ListChatContentLeftItem({ data: item });
            }
          }
        });
        ListItem() {
          Row().height(px2vp(20));
        }
      }
      .width("100%")
      .layoutWeight(1)
      .backgroundColor("#f5f5f5");

      Row() {
        Image($r("app.media.ic_emoji_pack"))
          .width(40)
          .height(40)
          .margin({ left: 10, right: 10 })
          .objectFit(ImageFit.Contain)
          .onClick(() => {
            this.emojiPanelVisible = !this.emojiPanelVisible;
          });

        TextInput({ text: this.chatText, controller: this.controller })
          .placeholderColor(Color.Gray)
          .placeholderFont({ size: 16 })
          .textAlign(TextAlign.Start)
          .caretColor(Color.Blue)
          .height(40)
          .fontSize(16)
          .layoutWeight(1)
          .backgroundColor(Color.White)
          .borderRadius(20)
          .onChange((value: string) => {
            this.chatText = value;
          });

        Text("发送")
          .fontSize(16)
          .fontColor(Color.Blue)
          .margin({ left: 10, right: 10 })
          .onClick(() => {
            this.sendMessage();
          });
      }
      .width("100%")
      .height(60)
      .padding({ left: 10, right: 10 })
      .backgroundColor("#f5f5f5");

      if (this.emojiPanelVisible) {
        Grid() {
          ForEach(this.emojiList, (emoji: string) => {
            GridItem() {
              Text(emoji)
                .fontSize(24)
                .margin(5)
                .onClick(() => {
                  this.sendEmoji(emoji);
                  this.emojiPanelVisible = false;
                });
            }
          }, (emoji: string) => emoji)
        }
        .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
        .rowsGap(10)
        .columnsGap(10)
        .padding(10)
        .backgroundColor(Color.White)
        .height(200)
      }

      ChatFunctionBar({ onImageSelected: this.selectImages.bind(this) })
    }
    .width("100%")
    .height("100%");
  }
}

const unDevTip = () => {
  ToastUtils.show("功能正在开发中...");
}
