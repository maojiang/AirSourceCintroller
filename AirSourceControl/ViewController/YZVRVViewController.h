//
//  YZVRVViewController.h
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/15.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZBaseViewController.h"
#import "YZModeButton.h"
#import "YZIconView.h"
@interface YZVRVViewController : YZBaseViewController
//@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *upRight;
@property (weak, nonatomic) IBOutlet UIImageView *upLeft;
@property (weak, nonatomic) IBOutlet UIImageView *verRight;
@property (weak, nonatomic) IBOutlet UIImageView *verLeft;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *cutButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *statuButton;
@property (nonatomic,strong) UIView *modeView;
@property (nonatomic,strong) YZModeButton *modeButton;
@property (nonatomic,strong) UIView *bottom;
@property (nonatomic,strong) YZIconView *iconView;
@property (nonatomic,strong) UIView *WinCtrolView;
@property (nonatomic,strong) YZIconView *rightIconView;
@property (weak, nonatomic) IBOutlet UILabel *powerLabel;

@property (weak, nonatomic) IBOutlet UILabel *timerOnLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerOffLabel;
@property (weak, nonatomic) IBOutlet UILabel *settingTempetureLabel;

@property (weak, nonatomic) IBOutlet UILabel *roomTempatureLabel;

@end
