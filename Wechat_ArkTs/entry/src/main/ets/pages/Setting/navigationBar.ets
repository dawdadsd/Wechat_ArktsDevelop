/**
 * 该组件为导航栏，除了特定页面如闪屏页面，都应该有导航栏。
 * 导航栏固定高度60vp，宽度为100%
 */

import router from '@ohos.router'

@Component
export struct navigationBar{
  @State title: string = '';
  @State isBack: boolean = true;
  @State isMenu: boolean = true;
  @State isSearch: boolean = true;
  @State isMore: boolean = false;
  @State isClose: boolean = false;
  @State bgColor: Resource = $r('app.color.grey0')

  build(){
   Row(){
     /**
      * 左侧的 后退/关闭 按钮
      * isBack和isClose变量为互斥关系，不能共存
      */
      Column(){
        if(this.isBack == true){
          Image($r('app.media.ic_back'))
            .width(26)
            .height(26)
            .onClick(() => {
              router.back()
            })
        }
        if(this.isClose == true){
          Image($r('app.media.ic_close'))
            .width(26)
            .height(26)
            .onClick(() => {
              router.back()
            })
        }
      }.width(50)
      /**
       * 中间标题栏
       */
      Column(){
        Text(this.title )
          .fontSize(20)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }.layoutWeight(1).padding({left: 20})
      /**
       * 右侧搜索按钮
       */
      Column(){
        if(this.isSearch == true){
          Image($r('app.media.ic_search'))
            .width(26)
            .height(26)
        }
      }.width(30)
      /**
       * 右侧菜单按钮
       * isMenu和isMore变量为互斥关系，不能共存
       */
      Column(){
        if(this.isMenu == true){
          Image($r('app.media.ic_add'))
            .width(26)
            .height(26)
        }
        if(this.isMore == true){
          Image($r('app.media.ic_more'))
            .width(26)
            .height(26)
        }
      }.width(50)
    }
    .height(60)
    .width('100%')
    .backgroundColor(this.bgColor)
  }
}

@Component
export struct isback {
  myUrl: string = ''

  build() {
    Image($r('app.media.ic_back'))
      .width(25)
      .height(25)
      .margin({ right: '280' })
      .onClick(( ) => {
        router.pushUrl({ url: this.myUrl })

      })
  }
}

@Component
export struct isnext {
  myUrl: string = ''

  build() {
    Image($r('app.media.ic_next'))
      .width(25)
      .height(25)
      .margin({ right: '280' })
      .onClick(( ) => {
        router.pushUrl({ url: this.myUrl })

      })
  }
}
