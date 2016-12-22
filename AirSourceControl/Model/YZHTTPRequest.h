//
//  YZHTTPRequest.h
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/14.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZDeviceModel.h"
#import "AFNetworking.h"
@interface YZHTTPRequest : NSObject
-(void)loadDevice:(NSString *)url withModel:(YZDeviceModel *)model;
-(NSMutableArray *)getPowerwithModel:(YZDeviceModel *)model;
-(void)changeWinControlwithModel:(YZDeviceModel *)model withButton:(UIButton *)button;
-(void)changeModeControl:(YZDeviceModel *)model withButton:(UIButton *)button;
-(void)changeTempature:(YZDeviceModel *)model withflag:(BOOL)flag andtempature:(NSString *)tempature;
@end
