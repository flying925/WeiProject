//
//  ShoppingCartMaster.h
//  WeiProject
//
//  Created by weikejun on 15/12/15.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Customer, ShoppingCartDetail;

@interface ShoppingCartMaster : NSManagedObject

@property (nonatomic, retain) NSNumber * cartID;
@property (nonatomic, retain) NSNumber * customerID;
@property (nonatomic, retain) NSSet *detail;
@property (nonatomic, retain) Customer *customer;
@end

@interface ShoppingCartMaster (CoreDataGeneratedAccessors)

- (void)addDetailObject:(ShoppingCartDetail *)value;
- (void)removeDetailObject:(ShoppingCartDetail *)value;
- (void)addDetail:(NSSet *)values;
- (void)removeDetail:(NSSet *)values;

@end
