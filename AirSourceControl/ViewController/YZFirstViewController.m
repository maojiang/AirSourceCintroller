//
//  YZFirstViewController.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/8.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZFirstViewController.h"
#import "YZRegisterViewController.h"
#import "YZLoginViewController.h"

@interface YZFirstViewController ()

@end

@implementation YZFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

//定制UI

-(void)setupUI{
    self.registerButton.layer.borderColor=[UIColor whiteColor].CGColor;
    self.loginButton.layer.borderColor=[UIColor whiteColor].CGColor;
    self.registerButton.layer.borderWidth=0;
    self.loginButton.layer.borderWidth=1;
    self.registerButton.layer.cornerRadius=5;
    self.loginButton.layer.cornerRadius=5;
    self.registerButton.backgroundColor=[UIColor redColor];
    
}




//登陆注册
- (IBAction)registerAction:(UIButton *)sender {
    YZRegisterViewController *vcRegister=[[YZRegisterViewController alloc] init];
    
    [self presentViewController:vcRegister animated:YES completion:nil];
    
    
}


- (IBAction)loginAction:(id)sender {
    YZLoginViewController *vcLogin=[[YZLoginViewController alloc] init];
    
    [self presentViewController:vcLogin animated:YES completion:nil];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
