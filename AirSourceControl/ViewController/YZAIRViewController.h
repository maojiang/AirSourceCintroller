//
//  YZAIRViewController.h
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/15.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZBaseViewController.h"
#import "YZModeButton.h"
#import "YZIconView.h"
@interface YZAIRViewController : YZBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *settingTempature;
@property (weak, nonatomic) IBOutlet UILabel *roomTempature;
@property (weak, nonatomic) IBOutlet UIButton *cutButton;
@property (weak, nonatomic) IBOutlet UIImageView *rightUp;
@property (weak, nonatomic) IBOutlet UIImageView *leftUP;
@property (weak, nonatomic) IBOutlet UILabel *powerLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerOn;
@property (weak, nonatomic) IBOutlet UILabel *timerOff;
@property (nonatomic,strong) UIView *modeView;
@property (nonatomic,strong) YZModeButton *modeButton;
@property (nonatomic,strong) UIView *bottom;
@property (nonatomic,strong) YZIconView *iconView;
@property (nonatomic,strong) UIView *WinCtrolView;
@property (nonatomic,strong) YZIconView *rightIconView;
@property (weak, nonatomic) IBOutlet UIButton *upTempatureLabel;
@property (weak, nonatomic) IBOutlet UIButton *downTempatureLabel;



@end
