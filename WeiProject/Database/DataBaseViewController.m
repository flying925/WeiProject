//
//  DataBaseViewController.m
//  WeiProject
//
//  Created by weikejun on 15/12/15.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "DataBaseViewController.h"
#import "CoreDataManager.h"
@interface DataBaseViewController ()

@end

@implementation DataBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)btnAdd:(id)sender {
    [[CoreDataManager sharedManager] insertDataIntoShoppingCartDBWithDictionary:nil];
}

- (IBAction)btnView:(id)sender {
    [[CoreDataManager sharedManager]displayShoppingCart];
}

- (IBAction)btnRemove:(id)sender {
    NSString *cid=self.inputField.text;
    [[CoreDataManager sharedManager]deleteEntityByID:[cid intValue]];
}

- (IBAction)btnModify:(id)sender {
    NSDictionary *dict=@{@"customerID":[NSNumber numberWithInt:[self.inputField.text intValue]],@"customerName":@"qianfeng",@"userName":@"qianfeng",@"password":@"123456"};
    [[CoreDataManager sharedManager]modifyEntityWithDictionary:dict];
}
@end
