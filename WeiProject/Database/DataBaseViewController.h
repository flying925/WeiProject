//
//  DataBaseViewController.h
//  WeiProject
//
//  Created by weikejun on 15/12/15.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataBaseViewController : UIViewController
- (IBAction)btnAdd:(id)sender;
- (IBAction)btnView:(id)sender;
- (IBAction)btnRemove:(id)sender;
- (IBAction)btnModify:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *inputField;

@end
