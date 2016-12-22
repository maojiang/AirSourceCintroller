//
//  YZNetworking.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/13.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZNetworking.h"



@implementation YZNetworking

+(void)HTTPGET:(YZDeviceModel *)model{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:model.attStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"aaaaa%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}



@end
