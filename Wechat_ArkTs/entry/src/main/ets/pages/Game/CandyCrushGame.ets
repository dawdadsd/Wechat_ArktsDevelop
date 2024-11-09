import router from '@ohos.router';

@Entry
@Component
struct YouAskIAnswerGame {
  @State question: string = ''
  @State answer: string = ''

  build() {
    Column() {
      Row() {
        Button() {
          Image($r('app.media.ic_back'))
            .width(24)
            .height(24)
        }
        .width(40)
        .height(40)
        .type(ButtonType.Circle)
        .backgroundColor('transparent')
        .onClick(() => {
          router.back()
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .padding({ left: 16, top: 16 })

      Text('你问我答游戏')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20, top: 40 }) // 增加顶部边距

      TextInput({ placeholder: '无论你输入什么都是周杰伦很帅' })
        .width('80%')
        .height(40)
        .margin({ bottom: 20 })
        .onChange((value: string) => {
          this.question = value
        })

      Button('提交问题')
        .width('40%')
        .height(40)
        .onClick(() => {
          if (this.question.trim() !== '') {
            this.answer = '周杰伦很帅'
          } else {
            this.answer = '请先输入问题'
          }
        })

      Text('回答：' + this.answer)
        .fontSize(20)
        .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start) // 改为顶部对齐
  }
}
