//
//  YZDeviceCell.h
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/8.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZDeviceModel.h"
#import "YZButton.h"
@interface YZDeviceCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *deviceImage;
@property (strong, nonatomic)  UILabel *deviceName;
@property (strong, nonatomic)  UILabel *floor;
@property (strong, nonatomic)  UILabel *statuLabel;
@property (strong, nonatomic)  YZButton *statuButton;

-(void)configureCell:(YZDeviceModel *)model;
-(void)refreshDeviceData:(YZDeviceModel *)model;

@end
