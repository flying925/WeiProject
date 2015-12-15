//
//  ShoppingCartDetail.h
//  WeiProject
//
//  Created by weikejun on 15/12/15.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface ShoppingCartDetail : NSManagedObject

@property (nonatomic, retain) NSNumber * cartID;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSNumber * productID;
@property (nonatomic, retain) NSDecimalNumber * currentPrice;
@property (nonatomic, retain) NSManagedObject *master;

@end
