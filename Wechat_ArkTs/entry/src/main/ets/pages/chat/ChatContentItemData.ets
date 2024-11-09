//聊天内容接口


export interface ChatContentItemData {
  name?: string
  headSrc?: Resource
  msg?: string
  img?: Resource
  msgType?: number
  self?: Boolean
}