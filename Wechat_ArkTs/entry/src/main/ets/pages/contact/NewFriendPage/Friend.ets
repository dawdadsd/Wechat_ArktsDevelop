export interface Friend {
  name: string;
  description: string;
  avatar: Resource;
  status: string;
}

export interface RouterParams {
  newFriendRequest?: Friend;
}
