//
//  LUNetHelp.m
//
//  Created by nansen on 16/2/20.
//  Copyright © 2016年 NansenLu. All rights reserved.
//

#import "LUNetHelp.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#import <CommonCrypto/CommonDigest.h>

#import <sys/utsname.h>

#import "NetworkReachabilityTool.h"


//使用单例来处理
static LUNetHelp *_shareManager = nil;

@interface LUNetHelp ()

@property (nonatomic, weak) MBProgressHUD *hud;

@end

@implementation LUNetHelp
- (MBProgressHUD *)hud
{
    if (!_hud) {
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:window];
        hud.removeFromSuperViewOnHide = YES;
        [window addSubview:hud];
        _hud = hud;
    }
    return _hud;
}


+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获得管理者
        _shareManager = [super manager];
        
        _shareManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _shareManager.requestSerializer.timeoutInterval = 30;
        //设置客户端支持的数据类型(响应者的MIMEType)
        _shareManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return _shareManager;
}


//封装Post请求,成功和失败在一个block里面处理
+ (void)lu_postWithPath:(NSString *)path andParams:(NSDictionary *)params andProgress:(void (^)(NSProgress *))progress andComplete:(void(^)(BOOL success, id result))complete
{
    if ([NetworkReachabilityTool defaultTool].isConnectNet == NO) {
        if (complete) {
            complete(NO, @"网络被断开");
        }
        return;
    }
    
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    
    //encryptRequestDic
    [[self shareManager] POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
    {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BOOL success = YES;
        
        if (complete) {
            complete(success, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        BOOL success = NO;
        id result = error.localizedDescription;
        
        if (complete) {
            complete(success, result);
        }
    }];
}


+ (void)cancelAll
{
    [[LUNetHelp shareManager].operationQueue cancelAllOperations];
}


/**
 上传图片
 */
+ (void)uploadImage:(UIImage *)image
       successBlock:(void (^)(NSString *imageURL))successBlock
         errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
       failureBlock:(void (^)(NSString *failure))failureBlock
{
    if ([NetworkReachabilityTool defaultTool].isConnectNet == NO) {
        if (failureBlock) {
            failureBlock(@"当前无网络");
        }
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    //设置客户端支持的数据类型(响应者的MIMEType)
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    
    
    NSData *imageData = UIImageJPEGRepresentation(image,0.5);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"nanjing" forKey:@"areaversioncode"];
    [params setObject:[self imgNameString] forKey:@"imgname"];
    
    [manager POST:@"http://www.zrodo.com:8080/njsyDetectList/uploadPic.do" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString *fileName = [self imgNameString];
        [formData appendPartWithFileData:imageData name:@"img" fileName:fileName mimeType:@"image/jpeg"];

    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 1000000) {
            NSString *imageURL = [responseObject objectForKey:@"result"];
            if (successBlock) {
                successBlock(imageURL);
            }
        }
        else {
            if (errorBlock) {
                errorBlock(responseObject[@"code"], responseObject[@"message"]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error.localizedDescription);
        }
    }];
    
    
}

//获取当前时间戳
+ (NSString *)imgNameString{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *imgNameString = [NSString stringWithFormat:@"%.0fiosspsz.jpg", time];
    return imgNameString;
}


@end
