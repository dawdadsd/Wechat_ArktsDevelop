//循环数组接口，后续更新：自动分类，自动根据名字的第一个首字母分类（纯字母） -- 自动根据中文名字的首个字母拼音来分类




export interface ContactItem {
  name: string;
  head: string| Resource;
  isStarred?:boolean
}

export default  interface DataItem {
  title: string;
  contactList: ContactItem[];
}

class YourClass {
  private dataList: DataItem[] = [
    {
      title: '',
      contactList: [
        { name: "新的朋友", head: $r("app.media.ic_new_friend") },
        { name: "群聊", head: $r("app.media.ic_group_chat") },
        { name: "标签", head: $r("app.media.ic_tag") },
        { name: "公众号", head: $r("app.media.ic_official_account") }
      ]
    },
    {
      title: 'A',
      contactList: [
        { name: "黄靖妮", head: $r("app.media.huangjingni") },
        { name: "许宝梅", head: $r("app.media.xubaomei") },
        { name: "马菊", head: $r("app.media.maju") }
      ]
    },
    {
      title: 'B',
      contactList: [
        { name: "莫三妹", head: $r("app.media.mosanmei") },
        { name: "博士伦", head: $r("app.media.jay") },
        { name: "白雪公主", head: $r("app.media.jay") }
      ]
    },
    {
      title: 'C',
      contactList: [
        { name: "陈先进", head: $r("app.media.jay") },
        { name: "蔡伦", head: $r("app.media.jay") },
        { name: "褚卫娟", head: $r("app.media.jay") }
      ]
    },
    {
      title: 'D',
      contactList: [
        { name: "达芬奇", head: $r("app.media.jay") },
        { name: "丁春秋", head: $r("app.media.jay") },
        { name: "邓浩", head: $r("app.media.jay") }
      ]
    },
    {
      title: 'S',
      contactList: [
        { name: "石破天", head: $r("app.media.jay") },
        { name: "宋浩杰", head: $r("app.media.jay") }
      ]
    },
    {
      title: 'Z',
      contactList: [
        { name: "猪八戒", head: $r("app.media.jay") },
        { name: "张宇恒", head: $r("app.media.jay") },
        { name: "周大年", head: $r("app.media.jay") }
      ]
    }
  ];
}