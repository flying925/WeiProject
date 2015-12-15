//
//  Customer.h
//  WeiProject
//
//  Created by weikejun on 15/12/15.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Customer : NSManagedObject

@property (nonatomic, retain) NSNumber * customerID;
@property (nonatomic, retain) NSString * customerName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSManagedObject *cart;

@end
