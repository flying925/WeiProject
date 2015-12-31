//
//  ResumeDownloadViewController.m
//  WeiProject
//
//  Created by weikejun on 15/12/27.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "ResumeDownloadViewController.h"
#import "QFResumeManager.h"

@interface ResumeDownloadViewController ()
{
    QFResumeManager *_manager;
    NSString *_targetPath;
}
@end

@implementation ResumeDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnDownload:(id)sender {
    if(_manager){
        [self btnPause:nil];
    }
    NSString *docDir=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    _targetPath=[docDir stringByAppendingPathComponent:@"myPic"];
    NSString *path=@"http://p1.pichost.me/i/40/1639665.png";
    _manager=[QFResumeManager resumeManagerWithURL:[NSURL URLWithString:path] targetPath:_targetPath success:^{
        NSLog(@"success");
        self.imageView.image=[UIImage imageWithContentsOfFile:_targetPath];
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error.localizedDescription);
    } progress:^(long long totalReceivedContentLength, long long totalContentLength) {
        float percent=1.0*totalReceivedContentLength/totalContentLength;
        NSString *str=[NSString stringWithFormat:@"%.f",percent*100];
        self.progressView.progress=percent;
        self.showLabel.text=[NSString stringWithFormat:@"已下载%@%%",str];
    }];
    [_manager start];
}

- (IBAction)btnPause:(id)sender {
    [_manager cancel];
    _manager=nil;
}
@end
