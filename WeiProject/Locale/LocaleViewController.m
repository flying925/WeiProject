//
//  LocaleViewController.m
//  WeiProject
//
//  Created by weikejun on 15/12/15.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "LocaleViewController.h"

@interface LocaleViewController ()

@end

@implementation LocaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //对时间变量的本地化
    NSDate *nowDate=[NSDate date];
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateStyle:NSDateFormatterFullStyle];
    [format setTimeStyle:NSDateFormatterFullStyle];
    //实例化NSLocale对象
    NSLocale *locale=[NSLocale currentLocale];
    [format setLocale:locale];
    self.dateLabel.text=[format stringFromDate:nowDate];
    //对国家货币符号的本地化
    self.curSymbolLabel.text=[locale objectForKey:NSLocaleCurrencySymbol];
    //对国家代码的本地化
    self.countryCodeLabel.text=[locale objectForKey:NSLocaleCountryCode];
    
    //对资源进行本地化
    //使用NSLocalizedStringFromTable方法取出设置好的多语言内容，第一个参数为对应的key，第二参数是多语言文件名，第三个参数是对这个内容的注释，可以为nil
    self.strLabel.text=NSLocalizedStringFromTable(@"labelKey", @"Localizable", nil);
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
