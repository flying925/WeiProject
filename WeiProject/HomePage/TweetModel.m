//
//  TweetModel.m
//  test3_图文混排
//
//  Created by weikejun on 15/12/17.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "TweetModel.h"

@implementation TweetModel
-(CGSize)currentSize
{
    CGSize size;
    //获取当前系统的版本号
    float version=[[UIDevice currentDevice].systemVersion floatValue];
    UIFont *font=[UIFont systemFontOfSize:15];
    if(version>=7.0){
        //计算显示文本内容需要的大小
        //第1个参数是大小，主要指定宽度
        //第2个参数是计算大小的参照，主要参照字体和换行样式
        //第3个参数是字典，封装字体
        //第4个参数可选的，一般为nil
        size=[self.tweetBody boundingRectWithSize:CGSizeMake(270, 999) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
    }else{
        size=[self.tweetBody sizeWithFont:font constrainedToSize:CGSizeMake(270, 999) lineBreakMode:NSLineBreakByCharWrapping];
    }
    return size;
}
@end
