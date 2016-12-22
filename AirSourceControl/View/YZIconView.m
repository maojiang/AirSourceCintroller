//
//  YZIconView.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/16.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZIconView.h"

@implementation YZIconView

-(UILabel *)modeNameLabel{
    if (!_modeNameLabel) {
        _modeNameLabel=[[UILabel alloc] init];
    }
    return _modeNameLabel;
}

-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView=[[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.modeNameLabel.frame=CGRectMake(0, 0, frame.size.width/2, frame.size.height);
        self.iconImageView.frame=CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height);
        [self.modeNameLabel setTextColor:[UIColor whiteColor]];
        
        [self addSubview:self.modeNameLabel];
        [self addSubview:self.iconImageView];
        
    }
    return self;
}


@end
