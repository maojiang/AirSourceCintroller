//
//  YZLoginViewController.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/8.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZLoginViewController.h"
#import "YZLineView.h"
#import "YZTransitionViewController.h"
@interface YZLoginViewController ()

@end

@implementation YZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.layer.cornerRadius=15;
    CGFloat x=self.telphoneLabel.frame.origin.x;
    CGFloat y=self.telphoneLabel.frame.origin.y;
    YZLineView *line1=[[YZLineView alloc] init];
    line1.frame=CGRectMake(x+20, (y+95), 185, 1);
    [self.view addSubview:line1];
    
    YZLineView *line=[[YZLineView alloc] init];
    line.frame=CGRectMake(x+20, (y+95)+43, 185, 1);
    [self.view addSubview:line];
    
    
    
}

- (IBAction)returnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)loginAction:(id)sender {
    YZTransitionViewController *vc=[[YZTransitionViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
