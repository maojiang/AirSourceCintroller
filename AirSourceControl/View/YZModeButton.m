//
//  YZModeButton.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/15.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZModeButton.h"

@implementation YZModeButton

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat midX = self.frame.size.width / 2;
    CGFloat midY = self.frame.size.height/ 2 ;
    self.titleLabel.center = CGPointMake(midX, midY + 17);
    self.imageView.center = CGPointMake(midX, midY - 10);
}

@end
