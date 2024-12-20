//聊天内容接口


export interface ChatContentItemData {
  name?: string
  headSrc?: Resource
  msg?: string
  img?: Resource
  msgType?: 0 | 1 | 2 | 3//0:文本 1:图片 2:语音 3:位置
  self?: Boolean
}