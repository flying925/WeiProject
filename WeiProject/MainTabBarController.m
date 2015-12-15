//
//  MainTabBarController.m
//  WeiProject
//
//  Created by weikejun on 15/12/15.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewControllers];
}
-(void)createViewControllers
{
    NSArray *array=@[@"DataBaseViewController",@"LocaleViewController"];
    NSMutableArray *viewControllers=[[NSMutableArray alloc]init];
    for(int i=0;i<array.count;i++){
        Class class=NSClassFromString(array[i]);
        UIViewController *vc=[[class alloc]init];
        [viewControllers addObject:vc];
    }
    self.viewControllers=viewControllers;
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

@end
