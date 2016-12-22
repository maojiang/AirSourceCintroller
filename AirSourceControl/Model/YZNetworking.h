//
//  YZNetworking.h
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/13.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "YZDeviceModel.h"

@interface YZNetworking : NSObject
+(void)HTTPGET:(YZDeviceModel *)model;

@end
