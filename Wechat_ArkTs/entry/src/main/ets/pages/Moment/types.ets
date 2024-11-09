export interface MomentDataItem {
  headSrc: Resource;
  nickName: string;
  content: string;
  time: string;
  imageList: string[];
}

export interface RouterParamsData {
  content: string;
  imageList: string[];
}

export interface RouterParams {
  data: RouterParamsData;
}
