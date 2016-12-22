//
//  YZCUView.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/15.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZCUView.h"

@implementation YZCUView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
       
        CGFloat x=frame.origin.x;
        CGFloat y=frame.origin.y;
        CGFloat w=frame.size.width;
        CGFloat h=frame.size.height;
        self.bgImageView.frame=CGRectMake(x, y, w, h-60);
        [self addSubview:self.bgImageView];
        self.settingTempertureLabel=[[UILabel alloc] init];
        self.settingTempertureLabel.textAlignment=1;
        self.settingTempertureLabel.frame=CGRectMake(x+10, y+10, w-20, 100);
        self.settingTempertureLabel.text=@"22.0℃";
        [self.settingTempertureLabel setFont:[UIFont systemFontOfSize:30]];
        [self addSubview:self.settingTempertureLabel];
        
        
    }
    return self;
}


@end
