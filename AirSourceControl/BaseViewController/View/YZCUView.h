//
//  YZCUView.h
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/15.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^changeImage)(NSInteger);
@interface YZCUView : UIView
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UILabel *settingTempertureLabel;
@property(nonatomic,strong)UILabel *roomTemPertureLabel;
@property(nonatomic,strong)UIButton *addButton;
@property(nonatomic,strong)UIButton *cutButton;

@end
