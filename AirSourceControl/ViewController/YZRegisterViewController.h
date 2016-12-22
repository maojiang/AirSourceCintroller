//
//  YZRegisterViewController.h
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/8.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZRegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *telphoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *passwordNumber;
@property (weak, nonatomic) IBOutlet UITextField *entrueNumber;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *telphoneLabel;


@end
