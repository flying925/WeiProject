//
//  MQLResumeManager.h
//  URLSessionTest
//
//  Created by weikejun on 15/12/27.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFResumeManager : NSObject

/**
 *  创建断点续传管理对象，启动下载请求
 *
 *  @param url          文件资源地址
 *  @param targetPath   文件存放路径
 *  @param success      文件下载成功的回调块
 *  @param failure      文件下载失败的回调块
 *  @param progress     文件下载进度的回调块
 *
 *  @return 断点续传管理对象
 *
 */
+(QFResumeManager*)resumeManagerWithURL:(NSURL*)url
                                targetPath:(NSString*)targetPath
                                success:(void (^)())success
                                failure:(void (^)(NSError *error))failure
                               progress:(void (^)(long long totalReceivedContentLength, long long totalContentLength))progress;

/**
 *  启动断点续传下载请求
 */
-(void)start;

/**
 *  取消断点续传下载请求
 */
-(void)cancel;


@end
