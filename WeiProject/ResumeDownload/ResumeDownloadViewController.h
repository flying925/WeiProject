//
//  ResumeDownloadViewController.h
//  WeiProject
//
//  Created by weikejun on 15/12/27.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResumeDownloadViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UILabel *showLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)btnDownload:(id)sender;
- (IBAction)btnPause:(id)sender;

@end
