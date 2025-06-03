// 定义活动列表项数据模型
interface ActivityListItem {
  title: string;
  time: string;
  location: string;
  detailId: string; // 用于跳转详情页
}

// 定义活动列表数据模型
export interface ActivitiesData {
  hot: ActivityListItem[];
  new: ActivityListItem[];
  explore: ActivityListItem[];
  more: ActivityListItem[];
}

// 定义活动详情数据模型
interface ActivityDetailData {
  activityId: string;
  title: string;
  carouselImages: string[];
  sections: Section[];
  enrollmentAvailable: boolean;
  enrollmentText?: string;
  enrollmentLink?: string;
}

// 为 items 数组的元素定义一个接口
interface SectionItem {
  label: string;
  value: string | string[];
}

// Section 的通用接口
interface Section {
  type: 'text' | 'rich_text_list' | 'image_gallery' | 'contact_info';
  title: string;
  content?: string;
  items?: SectionItem[];
  images?: string[];
  phone?: string;
  email?: string;
  website?: string;
}