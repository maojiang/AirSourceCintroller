//
//  YZDeviceModel.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/9.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZDeviceModel.h"



@implementation YZDeviceModel

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.buildCode forKey:@"buildCode"];
    [coder encodeInteger:self.deviceId forKey:@"deviceId"];
    [coder encodeInteger:self.type  forKey:@"type"];
    [coder encodeInteger:self.buildId  forKey:@"buildId"];
    [coder encodeInteger:self.floorId forKey:@"floorId"];
    [coder encodeInteger:self.roomId forKey:@"roomId"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.buildName forKey:@"buildName"];
    [coder encodeObject:self.roomName forKey:@"roomName"];
    [coder encodeBool:self.online forKey:@"online"];
    [coder encodeObject:self.powerD forKey:@"powerD"];
    [coder encodeObject:self.attStr forKey:@"attStr"];
    [coder encodeObject:self.deviceType forKey:@"deviceType"];
    
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self=[super init];
    if (self) {
        self.name=[coder decodeObjectForKey:@"name"];
        self.buildCode=[coder decodeObjectForKey:@"buildCode"];
        self.deviceId=[coder decodeIntegerForKey:@"deviceId"];
        self.type=[coder decodeIntegerForKey:@"type"];
        self.buildId=[coder decodeIntegerForKey:@"buildId"];
        self.floorId=[coder decodeIntegerForKey:@"floorId"];
        self.roomId=[coder decodeIntegerForKey:@"roomId"];
        self.buildName=[coder decodeObjectForKey:@"buildName"];
        self.roomName=[coder decodeObjectForKey:@"roomName"];
        self.online=[coder decodeBoolForKey:@"online"];
        self.powerD=[coder decodeObjectForKey:@"powerD"];
        self.attStr=[coder decodeObjectForKey:@"attStr"];
        self.deviceType=[coder decodeObjectForKey:@"deviceType"];
    }
    return self;
}



@end
