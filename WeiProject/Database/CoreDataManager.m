//
//  CoreDataManager.m
//  WeiProject
//
//  Created by weikejun on 15/12/15.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "CoreDataManager.h"
#import "Customer.h"
#import "ShoppingCartDetail.h"
#import "ShoppingCartMaster.h"
@implementation CoreDataManager
@synthesize managedObjectContext=_managedObjectContext;
+(CoreDataManager*)sharedManager
{
    static CoreDataManager *manager=nil;
    @synchronized(self){
        if(manager==nil){
            manager=[[CoreDataManager alloc]init];
        }
    }
    return manager;
}
-(NSManagedObjectContext *)managedObjectContext
{
    if(_managedObjectContext==nil){
        //(1)指定存储数据文件路径
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory=[paths lastObject];
        NSString *storePath=[documentsDirectory stringByAppendingPathComponent:@"ShoppingCart.sqlite"];
        NSLog(@"file is %@",storePath);
        NSURL *storeURL=[NSURL fileURLWithPath:storePath];
        NSError *error=nil;
        //2创建被管理对象模型
        NSURL *url=[[NSBundle mainBundle]URLForResource:@"ShoppingCart" withExtension:@"momd"];
        NSManagedObjectModel *managedObjectModel=[[NSManagedObjectModel alloc]initWithContentsOfURL:url];
        //3使用被管理对象模型创建持久化存储协调器NSPersistentStoreCoordinator，
        NSPersistentStoreCoordinator *persistentStoreCoordinator=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:managedObjectModel];
        //4 （创建持久化存储,）并使用SQLite数据库做持久化存储
        NSPersistentStore *persistentStore=[persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        if(!persistentStore)
            NSLog(@"Error while loading persistent store :%@",error);
        //5创建被管理对象上下文
        _managedObjectContext=[[NSManagedObjectContext alloc]init];
        //6设置当前被管理对象上下文的持久化存储协调器
        [_managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    }
    return _managedObjectContext;
}
-(void)insertDataIntoShoppingCartDBWithDictionary:(NSDictionary*)dict
{
    //创建Customer被管理对象实例
    Customer* customer1=(Customer*)[NSEntityDescription insertNewObjectForEntityForName:@"Customer" inManagedObjectContext:self.managedObjectContext];
    customer1.customerID=[NSNumber numberWithInt:1];
    customer1.customerName=@"lisi";
    customer1.password=@"lisi";
    customer1.userName=@"lisi";
    
    //创建ShoppingCartMaster被管理对象实例
    ShoppingCartMaster *shoppingCartMaster1=(ShoppingCartMaster *)[NSEntityDescription insertNewObjectForEntityForName:@"ShoppingCartMaster" inManagedObjectContext:self.managedObjectContext];
    shoppingCartMaster1.customerID=[NSNumber numberWithInt:2];
    shoppingCartMaster1.cartID=[NSNumber numberWithInt:200];
    
    //创建ShoppingCartDetail被管理对象实例
    ShoppingCartDetail *shoppingCartDetail1=(ShoppingCartDetail *)[NSEntityDescription insertNewObjectForEntityForName:@"ShoppingCartDetail" inManagedObjectContext:self.managedObjectContext];
    shoppingCartDetail1.cartID=[NSNumber numberWithInt:200];
    shoppingCartDetail1.productID=[NSNumber numberWithInt:30];
    shoppingCartDetail1.productName=@"iphone 5";
    shoppingCartDetail1.currentPrice=[[NSDecimalNumber alloc]initWithDouble:5000.0 ];
    
    ShoppingCartDetail *shoppingCartDetail2=(ShoppingCartDetail *)[NSEntityDescription insertNewObjectForEntityForName:@"ShoppingCartDetail" inManagedObjectContext:self.managedObjectContext];
    shoppingCartDetail2.cartID=[NSNumber numberWithInt:200];
    shoppingCartDetail2.productID=[NSNumber numberWithInt:40];
    shoppingCartDetail2.productName=@"ipad 2";
    shoppingCartDetail2.currentPrice=[NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:3000] decimalValue]];
    
    customer1.cart=shoppingCartMaster1;
    [shoppingCartMaster1 addDetailObject:shoppingCartDetail1];
    [shoppingCartMaster1 addDetailObject:shoppingCartDetail2];
    
    if([self.managedObjectContext hasChanges])
        if([self.managedObjectContext save:nil])
            NSLog(@"insert successfully");

}
//显示数据
-(void)displayShoppingCart
{
    //NSFetchRequest对象用来检索数据
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    NSEntityDescription *myEntityQuery=[NSEntityDescription entityForName:@"Customer" inManagedObjectContext:self.managedObjectContext];
    //int customerID=1;
    //设置查询条件
    //NSPredicate *predicate=[NSPredicate predicateWithFormat:@"customerID=%d",customerID];
    
    //指定实体
    [request setEntity:myEntityQuery];
    //[request setPredicate:predicate];
    NSError *error=nil;
    //返回符合查询条件NSFetchRequest的记录数组
    NSArray *customerArr=[self.managedObjectContext executeFetchRequest:request error:&error];
    NSInteger recordCount=[customerArr count];
    NSLog(@"Record Count: %ld",recordCount);
    for(int i=0;i<recordCount;i++)
    {
        //数组中元素为Customer被管理对象
        Customer *customer=(Customer *)[customerArr objectAtIndex:i];
        NSLog(@"CustomerID:%@,CustomerName:%@,userName:%@",customer.customerID,customer.customerName,customer.userName);
        //获取Customer对应关系的ShoppingCartMaster对象,一对一关系
        ShoppingCartMaster *cart=(ShoppingCartMaster *)customer.cart;
        NSLog(@"我的购物车:%@",cart.cartID);
        
        //获取ShoppingCartMaster对象中所有的detail对象数组,一对多关系
        NSArray *productList=[cart.detail allObjects];
        NSInteger numberOfProducts=[productList count];
        NSLog(@"购物车商品数:%ld",numberOfProducts);
        
        //遍历ShoppingCartDetail数组
        for(int j=0;j<numberOfProducts;j++){
            ShoppingCartDetail *detail=[productList objectAtIndex:j];
            NSLog(@"购物车商品:名称：%@，价格：%@",detail.productName,detail.currentPrice);
        }
    }
}
-(void)deleteEntityByID:(int) customerID
{
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Customer" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"customerID=%d",customerID];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *result=[[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if(result==nil){
        NSLog(@"Error:%@,%@",error,[error userInfo]);
        return;
    }
    if(result==0){
        NSLog(@"No Data");
        return;
    }
    for(Customer *customer in result){
        NSLog(@"delete succesfully,user, customerID:%@,name:%@,pass:%@",customer.customerID,customer.customerName,customer.password);
        [self.managedObjectContext deleteObject:customer];
    }
    if(![self.managedObjectContext save:&error]){
        NSLog(@"Error:%@,%@",error,[error userInfo]);
    }
}
//修改记录
-(void)modifyEntityWithDictionary:(NSDictionary*)dict
{
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Customer" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"customerID=%d",[dict[@"customerID"] intValue]];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError *error=nil;
    NSArray *result=[self.managedObjectContext executeFetchRequest:request error:&error];
    if([result count]>0){
        Customer *data=[result lastObject];
        data.customerName=dict[@"customerName"];
        data.password=dict[@"password"];
        data.userName=dict[@"userName"];
        if([self.managedObjectContext save:&error]){
            NSLog(@"修改成功！");
        }else{
            NSLog(@"修改失败！");
        }
    }
}
@end
