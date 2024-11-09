import router from '@ohos.router';
import { Friend, RouterParams } from './Friend';
import { Prompt, prompt } from '@kit.ArkUI';
import StatusBarManager, { STATUS_BAR_HEIGHT } from '../../../utils/StatusBarManager';

@Entry
@Component
struct NewFriendsPage {
  @State searchText: string = ''
  @State friends: Friend[] = [
    {
      name: '不喝饮料',
      description: '我是你',
      avatar: $r('app.media.jay'),
      status: '已添加'
    },
    {
      name: '黄靖妮',
      description: '我是群聊"移动应用go! go..."',
      avatar: $r('app.media.huangjingni'),
      status: '已添加'
    },
    {
      name: '莫三妹',
      description: '我是群聊"移动应用go! go..."',
      avatar: $r('app.media.mosanmei'),
      status: '待同意'
    },
    {
      name: '许宝梅',
      description: '我是群聊"移动应用go! go..."',
      avatar: $r('app.media.xubaomei'),
      status: '已添加'
    },
    {
      name: '马菊',
      description: '我是群聊"移动应用go! go..."',
      avatar: $r('app.media.maju'),
      status: '已添加'
    }
  ]
  @State statusBarHeight: number = 0


  aboutToAppear() {
    const params = router.getParams() as RouterParams;
    if (params && params.newFriendRequest) {
      this.friends.unshift(params.newFriendRequest);
    }
    this.statusBarHeight = AppStorage.Get<number>(STATUS_BAR_HEIGHT) || 0;
    StatusBarManager.immerseColor('#F7F7F7', true);

  }

  onPageShow() {
    const params = router.getParams() as RouterParams;
    const newFriendRequest = params?.newFriendRequest;

    if (newFriendRequest) {
      const existingIndex = this.friends.findIndex(friend =>
      friend.name === newFriendRequest.name &&
        friend.description === newFriendRequest.description
      );
      if (existingIndex === -1) {
        this.friends.unshift(newFriendRequest);
      } else {
        this.friends[existingIndex] = newFriendRequest;
      }
    }
  }

  build() {
    Column() {
      Row().height(`${this.statusBarHeight}px`).width('100%')

      // Title bar
      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.pushUrl({
              url: "pages/Index"
            })
          })
        Text('新的朋友')
          .fontSize(16)
          .textAlign(TextAlign.Center)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Medium)
        Blank()
        Text('添加朋友')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .onClick(() => {
            router.pushUrl({
              url: "pages/search/SerachFriendPage"
            })
          })
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#232323')

      // Search bar
      Row() {
        Image($r('app.media.ic_search'))
          .width(20)
          .height(20)
          .margin({ right: 8 })
        TextInput({ placeholder: '账号/手机号' })
          .width('90%')
          .height(36)
          .fontColor(Color.White)
          .backgroundColor('#313131')
          .placeholderColor('#999999')
      }
      .width('100%')
      .height(40)
      .margin({ top: 8, bottom: 8 })
      .padding({ left: 12, right: 12 })
      .backgroundColor('#313131')
      .borderRadius(6)

      // Add phone contacts button
      Row() {
        Image($r('app.media.ic_group_chat'))
          .width(40)
          .height(40)
        Text('添加手机联系人')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .margin({ left: 12 })
      }
      .onClick(() => {
        router.pushUrl({
          url: "pages/contact/NewFriendPage/UploadContactPage"
        })
      })
      .width('100%')
      .height(60)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#313131')

      Text('新的朋友')
        .fontSize(14)
        .fontColor('#999999')
        .width('100%')
        .padding({ left: 16, top: 8, bottom: 8 })

      List() {
        ForEach(this.friends, (friend: Friend, index:number) => {
          ListItem() {
            Row() {
              Image(friend.avatar)
                .width(40)
                .height(40)
                .borderRadius(4)
              Column() {
                Text(friend.name)
                  .fontSize(16)
                  .fontColor('#FFFFFF')
                Text(friend.description)
                  .fontSize(14)
                  .fontColor('#999999')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              .margin({ left: 12 })
              if (friend.status === '待同意') {
                Button('同意')
                  .fontSize(14)
                  .backgroundColor('#1AAD19')
                  .height(30)
                  .width(60)
                  .onClick(() => {
                    this.friends[index].status = '已添加';
                    this.friends = [...this.friends]; // 触发更新
                    Prompt.showToast({
                      message:'已添加好友',
                      duration:2000
                    })
                  })
              } else {
                Text(friend.status)
                  .fontSize(14)
                  .fontColor('#999999')
              }
            }
            .width('100%')
            .height(60)
            .padding({ left: 16, right: 16 })
          }
        }, (friend:Friend):string=> friend.name)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#232323')
  }
}