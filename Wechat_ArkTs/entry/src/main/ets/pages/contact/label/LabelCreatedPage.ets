import { router } from '@kit.ArkUI'
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../../utils/StatusBarManager';
import { socket } from '@kit.NetworkKit';
import { util } from '@kit.ArkTS';
import { ChatContentItemData } from '../../chat/ChatContentItemData';
import ListChatContentLeftItem from '../../../component/ListChatContentLeftItem';
import ListChatContentRightItem from '../../../component/ListChatContentRightItem';

interface LabelCreatedPageParams {
  labelName: string;
}

@Entry
@Component
struct LabelCreatedPage {
  @State labelName: string = '测试'
  @State memberCount: number = 0
  @State statusBarHeight: number = 0
  private tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
  private tcpConnect: socket.TCPSocket = socket.constructTCPSocketInstance();
  @State private chatText: string = ''; // 用户输入的聊天内容
  @State private dataList: ChatContentItemData[] = []; // 聊天记录

  aboutToAppear() {
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#f1f1f1', false);

    // 获取从TagPage传递过来的名字表示
    const params = router.getParams() as LabelCreatedPageParams;
    if (params.labelName) {
      this.labelName = params.labelName;
    }
  }

  // 启动服务器
  async startServer(serverIp: string, serverPort: number) {
    let ipAddress: socket.NetAddress = {
      address: serverIp,
      port: serverPort
    };
    try {
      await this.tcpServer.listen(ipAddress);
      console.info('服务器启动成功');
      // 服务器启动成功后的处理逻辑
      this.tcpServer.on('connect', (connection: socket.TCPSocketConnection) => {
        connection.on('message', (data: socket.SocketMessageInfo) => {
          const message = this.buf2String(data.message);
          this.dataList.push({
            name: '服务端',
            msgType: 0,
            self: false,
            msg: message
          });
        });
      });
    } catch (err) {
      console.info('服务器启动失败');
      // 服务器启动失败的处理逻辑,如显示错误提示
    }
  }

  // 连接服务器
  async connectServer(serverIp: string, serverPort: number) {
    const serverAddress: socket.NetAddress = {
      address: serverIp,
      port: serverPort,
      family: 1
    };

    try {
      await this.tcpConnect.connect({ address: serverAddress });
      console.log('连接服务器成功');

      this.tcpConnect.on('message', (value: socket.SocketMessageInfo) => {
        const msg: string = this.buf2String(value.message);
        this.dataList.push({
          name: '客户端',
          msgType: 0,
          self: true,
          msg: msg
        });
      });
    } catch (error) {
      console.error('连接服务器失败', error);
      // 连接失败的处理逻辑,如显示错误提示
    }
  }

  // 将 ArrayBuffer 转换为字符串
  private buf2String(buf: ArrayBuffer): string {
    const msgArray = new Uint8Array(buf);
    const textDecoder = new util.TextDecoder('utf-8');
    return textDecoder.decode(msgArray);
  }

  private sendMessage() {
    if (this.chatText.trim() === '') return;

    // 添加用户消息
    this.dataList.push({
      name: "我",
      msgType: 0,
      self: true,
      msg: this.chatText
    });

    // 清空输入框
    const sentMessage = this.chatText;
    this.chatText = '';

    // 发送消息到服务器
    this.tcpConnect.send({ data: `chat_${sentMessage}` });
  }

  build() {
    Column() {
      Row().height(`${this.statusBarHeight}px`).width('100%').backgroundColor('#f1f1f1')

      // 顶部导航栏
      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .onClick(()=>{
            router.back()
          })

        Text(`${this.labelName}（${this.memberCount}）`)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })

        // 创建聊天按钮
        Button('创建聊天')
          .fontSize(16)
          .fontColor(Color.White)
          .backgroundColor('#07C160')
          .margin({ left: 'auto', right: 16 })
          .onClick(() => {
            this.startServer('127.0.0.1', 8000); // 根据实际情况修改IP和端口
          })

        // 加入聊天按钮
        Button('加入聊天')
          .fontSize(16)
          .fontColor(Color.White)
          .backgroundColor('#07C160')
          .margin({ left: 16, right: 16 })
          .onClick(() => {
            this.connectServer('127.0.0.1', 8000); // 根据实际情况修改IP和端口
          })
      }
      .width('100%')
      .height(56)
      .padding({ left: 24, right: 24 })
      .backgroundColor(Color.White)

      // 聊天记录区域
      List() {
        ForEach(this.dataList, (item: ChatContentItemData) => {
          ListItem() {
            if (item.self) {
              ListChatContentRightItem({ data: item });
            } else {
              ListChatContentLeftItem({ data: item });
            }
          }
        });
      }
      .width("100%")
      .layoutWeight(1);

      // 输入框区域
      Row() {
        TextArea({ text: this.chatText, placeholder: '输入消息...', controller: new TextAreaController() })
          .layoutWeight(1)
          .onChange((value: string) => {
            this.chatText = value;
          });

        Button('发送')
          .onClick(() => {
            this.sendMessage();
          });
      }
      .padding({ left: 10, right: 10 })
      .height(50);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
