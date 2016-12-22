//
//  YZRegisterViewController.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/8.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZRegisterViewController.h"
#import "YZLineView.h"

@interface YZRegisterViewController ()<UITextFieldDelegate>

@end

@implementation YZRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.telphoneNumber.clearsOnBeginEditing=YES;
    self.passwordNumber.clearsOnBeginEditing=YES;
    self.entrueNumber.clearsOnBeginEditing=YES;
}




-(void)setupUI{
    self.registerButton.layer.cornerRadius=15;

    CGFloat x=self.telphoneLabel.frame.origin.x;
    CGFloat y=self.telphoneLabel.frame.origin.y;
    //画三条白线
    for (NSInteger i=0; i<3; i++) {
        YZLineView *line1=[[YZLineView alloc] init];
        line1.frame=CGRectMake(x, (y+95)+(47*i), 200, 1);
        [self.view addSubview:line1];

        
    }
    
    
        
    
    
    
    
}






-(void)viewWillLayoutSubviews{
    //[self drawLine];
    
    
    
}

//画线

-(void)drawLine{
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
    
    
    
    [self.view addSubview:imageView];
    
    
    
    
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    
    
    
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
    
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0);  //线宽
    
    
    
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    
    
    
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 1.0, 1.0);  //颜色
    
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.telphoneLabel.frame.origin.x, self.telphoneLabel.frame.origin.y+40);  //起点坐标
    
    
    
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.telphoneLabel.frame.origin.x+200, self.telphoneLabel.frame.origin.y+40);
    //终点坐标
    
    
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    
    
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    UIGraphicsEndImageContext();
    
    
}



- (IBAction)returnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)registerAction:(id)sender {
}





@end
