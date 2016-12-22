//
//  YZSelectView.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/13.
//  Copyright © 2016年 远正智联. All rights reserved.
//


//单击YZDeviceViewController上的导航右button弹出的view

#import "YZSelectView.h"

@implementation YZSelectView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _camoraButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _camoraButton.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/3);
        [_camoraButton setTitle:@"二维码添加" forState:UIControlStateNormal];
        [self addSubview:self.camoraButton];
        _photoButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _photoButton.frame=CGRectMake(0, self.bounds.size.height/3, self.bounds.size.width, self.bounds.size.height/3);
        [_photoButton setTitle:@"相册添加" forState:UIControlStateNormal];
        [self addSubview:self.photoButton];
        _idAddButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _idAddButton.frame=CGRectMake(0, (self.bounds.size.height)*2/3, self.bounds.size.width, self.bounds.size.height/3);
        [_idAddButton setTitle:@"id添加" forState:UIControlStateNormal];
        [self addSubview: self.idAddButton];
    }
    
    return self;
}

@end
