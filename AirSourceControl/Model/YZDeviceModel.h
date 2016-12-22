//
//  YZDeviceModel.h
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/9.
//  Copyright © 2016年 远正智联. All rights reserved.
//



//type 1是分体空调，0是VRV
//buildCode 建筑id
//从PrimaryKey取出deviceId


#import <Foundation/Foundation.h>

@interface YZDeviceModel : NSObject<NSCoding>
@property (nonatomic,copy)NSString *buildCode;
@property (nonatomic,assign)NSInteger deviceId;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,assign)NSInteger buildId;
@property (nonatomic,assign)NSInteger floorId;
@property (nonatomic,assign)NSInteger roomId;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *buildName;
@property (nonatomic,copy)NSString *roomName;
@property (nonatomic)BOOL online;
@property (nonatomic,copy)NSString *powerD;
@property (nonatomic,copy)NSString *attStr;
@property (nonatomic,copy)NSString *deviceType;



@end
