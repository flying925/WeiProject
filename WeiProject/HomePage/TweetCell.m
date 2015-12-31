//
//  TweetCell.m
//  test3_图文混排
//
//  Created by weikejun on 15/12/17.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(TweetModel *)model
{
    _model=model;
    [self.portraitImageView setImageWithURL:[NSURL URLWithString:model.tweetPortrait]];
    self.authorLabel.text=model.tweetAuthor;
    self.bodyLabel.text=model.tweetBody;
    self.pubDateLabel.text=model.tweetPubDate;
    self.commentLabel.text=model.tweetCommentCount;
    if(model.tweetImgStr.length>0){
        [self.imgStrView setImageWithURL:[NSURL URLWithString:model.tweetImgStr]];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
