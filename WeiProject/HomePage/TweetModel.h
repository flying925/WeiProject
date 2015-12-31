//
//  TweetModel.h
//  test3_图文混排
//
//  Created by weikejun on 15/12/17.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TweetModel : NSObject
@property(nonatomic,copy)NSString *tweetPortrait;
@property(nonatomic,copy)NSString *tweetAuthor;
@property(nonatomic,copy)NSString *tweetBody;
@property(nonatomic,copy)NSString *tweetCommentCount;
@property(nonatomic,copy)NSString *tweetPubDate;
@property(nonatomic,copy)NSString *tweetImgStr;
//获取显示body内容需要的大小
-(CGSize)currentSize;
@end













