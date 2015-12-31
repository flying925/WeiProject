//
//  TweetCell.h
//  test3_图文混排
//
//  Created by weikejun on 15/12/17.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetModel.h"

@interface TweetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imgStrView;
@property (strong, nonatomic) IBOutlet UILabel *pubDateLabel;
@property(nonatomic,strong)TweetModel* model;
@end






