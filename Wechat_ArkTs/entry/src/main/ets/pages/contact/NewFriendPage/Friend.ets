export interface Friend {
  name: string;
  description: string;
  avatar: Resource;
  status: string;
  isAdded : boolean;
}

export interface RouterParams {
  newFriendRequest?: Friend;
}
