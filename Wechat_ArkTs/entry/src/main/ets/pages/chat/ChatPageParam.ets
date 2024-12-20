//聊天界面，用户名字强制类型转换接口，别删

import { ChatContentItemData } from './ChatContentItemData'

export default interface ChatPageParam {
  name: string;
  headSrc:Resource;
  dataList: ChatContentItemData[];//数据传递用的不能删
}