//
//  YZButton.h
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/15.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZButton : UIButton
@property(nonatomic,assign)NSInteger deviceId;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,copy)NSString *buildCode;
@property(nonatomic,copy)NSString *power;
@end
