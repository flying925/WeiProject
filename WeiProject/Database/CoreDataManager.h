//
//  CoreDataManager.h
//  WeiProject
//
//  Created by weikejun on 15/12/15.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataManager : NSObject
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
+(CoreDataManager*)sharedManager;
-(void)insertDataIntoShoppingCartDBWithDictionary:(NSDictionary*)dict;
-(void)displayShoppingCart;
//删除记录,根据ID
-(void)deleteEntityByID:(int) customerID ;
//修改记录
-(void)modifyEntityWithDictionary:(NSDictionary*)dict;
@end
