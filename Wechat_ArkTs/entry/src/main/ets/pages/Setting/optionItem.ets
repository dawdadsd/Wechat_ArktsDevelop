/**
 * 该组件为设置和其他类似UI的选项布局。
 * 主要内容为图片+文字+导航箭头
 * powered by yiyefangzhou24
 * 2022/5/15
 */

@Component
export struct optionItem {
  @State bgColor: Resource = $r("app.color.white")
  //private  img: Resource       //图标资源
  @State img: string= ''
 // private context: string     //文字内容
  @State context: string='';
  @State isNext: boolean = false;
  //private marginTop: number   //组件上边距
  @State  marginTop: number=1;

  private itemOnClick = (event: ClickEvent) =>{}  //item的单击事件（可选）

  build(){
    Row(){
      if(this.img != null){
        Flex({direction: FlexDirection.Row , alignItems:ItemAlign.Center , justifyContent:FlexAlign.Center}){
          Image(this.img)
            .width(30).height(30)
        }.width(50).height(60)
      }
      Column(){
        Row(){
          Text(this.context)
            .fontSize(19)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(1)
            .layoutWeight(1)
            //.margin({left: 10})
          if(this.isNext == true){
            Image($r('app.media.ic_next'))
              .width(18)
              .height(18)
              .margin(10)
          }
        }.height(59)
        Divider().color($r('app.color.grey2')).strokeWidth(0.8)
      }
      .padding({left: 10 , right:4})
      .height(60)
      .layoutWeight(1)
    }.width('100%').height(60)
    .margin({top: this.marginTop})
    .backgroundColor(this.bgColor)
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.bgColor = $r('app.color.grey2')
      }
      if (event.type === TouchType.Up) {
        this.bgColor = $r('app.color.white')
      }
    })
    .onClick((event: ClickEvent) => {
      this.itemOnClick(event)
    })
  }
}