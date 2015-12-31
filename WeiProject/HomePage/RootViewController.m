//
//  RootViewController.m
//  test3_图文混排
//
//  Created by weikejun on 15/12/17.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "RootViewController.h"
#import "TweetModel.h"
#import "TweetCell.h"
#import "GDataXMLNode.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"

#define kUrlString @"http://www.oschina.net/action/api/tweet_list?uid=0&pageIndex=1&pageSize=20"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    MBProgressHUD *_hud;
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self requestData];
    [self createUI];
}
-(void)requestData
{
    _dataArray=[[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:kUrlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        [self parseXMLData:responseObject];
        //刷新UI
        [_tableView reloadData];
        [_hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error.localizedDescription);
    }];
}
//解析xml数据
-(void)parseXMLData:(NSData*)data
{
    GDataXMLDocument *doc=[[GDataXMLDocument alloc]initWithData:data encoding:NSUTF8StringEncoding error:nil];
    NSArray *tweetArray=[doc nodesForXPath:@"//tweets/tweet" error:nil];
    for(GDataXMLElement *tweet in tweetArray){
        TweetModel *model=[[TweetModel alloc]init];
        GDataXMLElement *portaritEle=[tweet elementsForName:@"portrait"][0];
        model.tweetPortrait=portaritEle.stringValue;
        
        GDataXMLElement *authorEle=[tweet elementsForName:@"author"][0];
        model.tweetAuthor=authorEle.stringValue;
        
        GDataXMLElement *bodyEle=[tweet elementsForName:@"body"][0];
        model.tweetBody=bodyEle.stringValue;
        
        GDataXMLElement *commentEle=[tweet elementsForName:@"commentCount"][0];
        model.tweetCommentCount=commentEle.stringValue;
        
        GDataXMLElement *dateEle=[tweet elementsForName:@"pubDate"][0];
        model.tweetPubDate=dateEle.stringValue;
        
        GDataXMLElement *imgEle=[tweet elementsForName:@"imgSmall"][0];
        model.tweetImgStr=imgEle.stringValue;
        
        [_dataArray addObject:model];
    }
    NSLog(@"count:%ld",_dataArray.count);
}
-(void)createUI
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, 375, 600) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    _hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager=[[AFHTTPRequestOperationManager alloc]init];
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status==AFNetworkReachabilityStatusReachableViaWiFi){
            _hud.labelText=@"Loading";
            [self requestData];
        }else if (status==AFNetworkReachabilityStatusReachableViaWWAN){
            _hud.labelText=@"没有wifi";
        }else if (status==AFNetworkReachabilityStatusNotReachable){
            _hud.labelText=@"没有网络";
        }
        [_hud show:YES];
    }];
    [manager.reachabilityManager startMonitoring];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- UITableViewDataSource的协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"tweetCell";
    TweetCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell=[[NSBundle mainBundle]loadNibNamed:@"TweetCell" owner:nil options:nil][0];
    }
    TweetModel *model=_dataArray[indexPath.row];
    cell.model=model;
    //获取当前cell上显示的body需要的大小
    CGSize size=[model currentSize];
    //根据内容调整显示body内容的label的frame
    cell.bodyLabel.frame=CGRectMake(90, 40, size.width, size.height);
    //如果有图片,设置图片的frame，调整时间label的frame
    if(model.tweetImgStr.length>0){
        cell.imgStrView.frame=CGRectMake(90, 40+size.height+10, 150, 80);
        cell.imgStrView.hidden=NO;
        cell.pubDateLabel.frame=CGRectMake(90, cell.imgStrView.frame.origin.y+cell.imgStrView.frame.size.height+10, 200, 20);
    }else{
        cell.imgStrView.hidden=YES;
        cell.pubDateLabel.frame=CGRectMake(90, 40+size.height+10, 200, 20);
    }
    return cell;
}
//根据cell上显示的数据设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取该cell上显示的数据源
    TweetModel *model=_dataArray[indexPath.row];
    CGSize size=[model currentSize];
    //如果有图片
    if(model.tweetImgStr.length>0){
        return 40+size.height+10+80+10+20+10;
    }else{
        return 40+size.height+10+20+10;
    }
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
