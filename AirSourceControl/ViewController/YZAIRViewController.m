//
//  YZAIRViewController.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/15.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZAIRViewController.h"
#import "YZNetworking.h"
#import "YZHTTPRequest.h"
#import "SVProgressHUD.h"

#define  screenWidth  [UIScreen mainScreen].bounds.size.width
@interface YZAIRViewController ()

@end

@implementation YZAIRViewController

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.modeView!=nil) {
        [self.modeView removeFromSuperview];
    }else if (self.WinCtrolView!=nil){
        [self.WinCtrolView removeFromSuperview];
    }
}

- (IBAction)downTempatureAction:(id)sender {
    NSString *tempature=self.settingTempature.text;
    tempature=[tempature substringWithRange:NSMakeRange(0,4)];
    float tempa=[tempature floatValue];
    
    if (tempa>18) {
        float current=tempa-1;
        self.settingTempature.text=[NSString stringWithFormat:@"%.1f℃",current];
        BOOL flag=NO;
        YZHTTPRequest *req=[[YZHTTPRequest alloc] init];
        [req changeTempature:self.model withflag:flag andtempature:self.settingTempature.text];
    }
    
}

- (IBAction)upTempatureAction:(UIButton *)sender {
    NSString *tempature=self.settingTempature.text;
    tempature=[tempature substringWithRange:NSMakeRange(0,4)];
    float tempa=[tempature floatValue];
    
    if (tempa<30) {
        float current=tempa+1;
        self.settingTempature.text=[NSString stringWithFormat:@"%.1f℃",current];

        BOOL flag=YES;
        YZHTTPRequest *req=[[YZHTTPRequest alloc] init];
        [req changeTempature:self.model withflag:flag andtempature:self.settingTempature.text];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.barTintColor=[UIColor clearColor];
    
    [self setupBottomView];
    [self setupMiddleView];
    UIButton *returnButton=[UIButton buttonWithType:UIButtonTypeSystem];
    returnButton.frame=CGRectMake(20, 20, 40, 30);
    [returnButton setTitle:@"返回" forState:UIControlStateNormal];
    [returnButton setTintColor:[UIColor whiteColor]];
    [returnButton addTarget:self action:@selector(clickReturn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnButton];
    self.roomTempature.text=@"";
    self.timerOn.text=@"";
    self.timerOff.text=@"";
    
    
    
    
    
    
    
    
    
}

-(void)clickReturn:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setupMiddleView{
    self.rightUp.alpha=1;
    self.leftUP.alpha=1;
    
    
}

-(void)setupBottomView{
    
    
    
    self.bottom=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.75, screenWidth, self.view.frame.size.height*0.25)];
    _bottom.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_bottom];
    CGFloat width=screenWidth/3;
    CGFloat height=_bottom.bounds.size.height/2;
    _modeButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    _modeButton.frame=CGRectMake(0, 0, width, height);
    [_modeButton addTarget:self action:@selector(clickChangeMode:) forControlEvents:UIControlEventTouchUpInside];
    //modeButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [_modeButton setImage:[UIImage imageNamed:@"mode"] forState:UIControlStateNormal];
    [_modeButton setTitle:@"模式" forState:UIControlStateNormal];
    
    [_bottom addSubview:_modeButton];
    
    YZModeButton *powerButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    powerButton.frame=CGRectMake(width, 0, width, height);
    [powerButton setTitle:@"电源" forState:UIControlStateNormal];
    [powerButton setImage:[UIImage imageNamed:@"power button"] forState:UIControlStateNormal];
    [powerButton addTarget:self action:@selector(clickPower:) forControlEvents:UIControlEventTouchUpInside];
    [_bottom addSubview:powerButton];
    
    YZModeButton *winSpeedButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    winSpeedButton.frame=CGRectMake(width*2, 0, width, height);
    [winSpeedButton setTitle:@"风速" forState:UIControlStateNormal];
    [winSpeedButton setImage:[UIImage imageNamed:@"sandang"] forState:UIControlStateNormal];
    [winSpeedButton addTarget:self action:@selector(winControl:) forControlEvents:UIControlEventTouchUpInside];
    [_bottom addSubview:winSpeedButton];
    
    YZModeButton *timerOnButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    timerOnButton.frame=CGRectMake(0, height, width, height);
    [timerOnButton setTitle:@"定时开" forState:UIControlStateNormal];
    [timerOnButton setImage:[UIImage imageNamed:@"timer"] forState:UIControlStateNormal];
    [timerOnButton addTarget:self action:@selector(clickTimerON:) forControlEvents:UIControlEventTouchUpInside];
    [_bottom addSubview:timerOnButton];
    
    
    YZModeButton *timerOFFButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    timerOFFButton.frame=CGRectMake(width, height, width, height);
    [timerOFFButton setTitle:@"定时关" forState:UIControlStateNormal];
    [timerOFFButton setImage:[UIImage imageNamed:@"timer"] forState:UIControlStateNormal];
    [timerOFFButton addTarget:self action:@selector(clickTimerOFF:) forControlEvents:UIControlEventTouchUpInside];
    [_bottom addSubview:timerOFFButton];
    
    YZModeButton *moreButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame=CGRectMake(width*2, height, width, height);
    [moreButton setTitle:@"刷新" forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(clickMore:) forControlEvents:UIControlEventTouchUpInside];
    [_bottom addSubview:moreButton];
    
    
    
    
}

-(void)configWindCtrolView{
    YZModeButton *autoWindButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    autoWindButton.frame=CGRectMake(0, 40, 90, 60);
    [autoWindButton setImage:[UIImage imageNamed:@"zidongdang"] forState:UIControlStateNormal];
    [autoWindButton setTag:101];
    [autoWindButton setTitle:@"自动风" forState:UIControlStateNormal];
    [autoWindButton addTarget:self action:@selector(windContrlEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.WinCtrolView addSubview:autoWindButton];
    
    YZModeButton *lowWindButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    lowWindButton.frame=CGRectMake(100, 40, 90, 60);
    [lowWindButton setImage:[UIImage imageNamed:@"yidang"] forState:UIControlStateNormal];
    [lowWindButton setTag:102];
    [lowWindButton setTitle:@"低风速" forState:UIControlStateNormal];
    [lowWindButton addTarget:self action:@selector(windContrlEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.WinCtrolView addSubview:lowWindButton];
    
    YZModeButton *midWindButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    midWindButton.frame=CGRectMake(0, 110, 90, 60);
    [midWindButton setImage:[UIImage imageNamed:@"erdang"] forState:UIControlStateNormal];
    [midWindButton setTag:103];
    [midWindButton setTitle:@"中风速" forState:UIControlStateNormal];
    [midWindButton addTarget:self action:@selector(windContrlEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.WinCtrolView addSubview:midWindButton];
    
    YZModeButton *higWindButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    higWindButton.frame=CGRectMake(100, 110, 90, 60);
    [higWindButton setImage:[UIImage imageNamed:@"sangdang"] forState:UIControlStateNormal];
    [higWindButton setTag:104];
    [higWindButton setTitle:@"高风速" forState:UIControlStateNormal];
    [higWindButton addTarget:self action:@selector(windContrlEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.WinCtrolView addSubview:higWindButton];
    
    
    
    
}



-(void)setupModeView{
    YZModeButton *autoButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    autoButton.frame=CGRectMake(0, 40, 125, 80);
    [autoButton setImage:[UIImage imageNamed:@"auto"] forState:UIControlStateNormal];
    [autoButton setTitle:@"自动" forState:UIControlStateNormal];
    [autoButton setTag:1];
    [autoButton addTarget:self action:@selector(modeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.modeView addSubview:autoButton];
    
    //制冷button
    YZModeButton *refrigerationButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    refrigerationButton.frame=CGRectMake(125, 40, 125, 80);
    [refrigerationButton setImage:[UIImage imageNamed:@"zhileng"] forState:UIControlStateNormal];
    [refrigerationButton setTag:2];
    [refrigerationButton setTitle:@"制冷" forState:UIControlStateNormal];
    [refrigerationButton addTarget:self action:@selector(modeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.modeView addSubview:refrigerationButton];
    
    
    //制热
    YZModeButton *heatingButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    heatingButton.frame=CGRectMake(0, 105, 125, 80);
    [heatingButton setImage:[UIImage imageNamed:@"zhire"] forState:UIControlStateNormal];
    [heatingButton setTag:3];
    [heatingButton setTitle:@"制热" forState:UIControlStateNormal];
    [heatingButton addTarget:self action:@selector(modeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.modeView addSubview:heatingButton];
    
    //送风
    YZModeButton *windButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    windButton.frame=CGRectMake(125, 105, 125, 80);
    [windButton setImage:[UIImage imageNamed:@"songfeng"] forState:UIControlStateNormal];
    [windButton setTag:2];
    [windButton setTitle:@"送风" forState:UIControlStateNormal];
    [windButton addTarget:self action:@selector(modeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.modeView addSubview:windButton];
    
    
    //除湿
    YZModeButton *dehumidityButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    dehumidityButton.frame=CGRectMake(0, 170, 125, 80);
    [dehumidityButton setImage:[UIImage imageNamed:@"chushi"] forState:UIControlStateNormal];
    [dehumidityButton setTag:2];
    [dehumidityButton setTitle:@"除湿" forState:UIControlStateNormal];
    [dehumidityButton addTarget:self action:@selector(modeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.modeView addSubview:dehumidityButton];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self loadData];
}

-(void)loadData{
     __weak typeof(self) weakSelf=self;
     NSLog(@"%@",self.model.attStr);
    NSLog(@"jin ru ");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 3.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

        [manager GET:weakSelf.model.attStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"aaaAir请求成功");
            NSLog(@"aaaaa%@",responseObject);
            for (NSDictionary *dic in responseObject) {
                if ([[dic objectForKey:@"name"] isEqual:@"开关机控制"]) {
                    weakSelf.powerLabel.text=[dic objectForKey:@"value"];
                }else if ([[dic objectForKey:@"name"] isEqual:@"模式控制"]){
                    NSString *modeName=[dic objectForKey:@"value"];
                    CGFloat y=weakSelf.bottom.frame.origin.y;
                    weakSelf.iconView=[[YZIconView alloc] initWithFrame:CGRectMake(100, y-160, 70, 40)];
                    weakSelf.iconView.modeNameLabel.text=modeName;
                    [weakSelf.view addSubview:weakSelf.iconView];
                }else if ([[dic objectForKey:@"name"] isEqual:@"设置温度"]){
                    NSString *str=[dic objectForKey:@"value"];
                    weakSelf.settingTempature.text=[str stringByAppendingString:@"℃"];
                }
                
                if ([weakSelf.model.deviceType isEqualToString:@"挂式"]) {
                    if ([[dic objectForKey:@"name"] isEqualToString:@"出风温度"]) {
                        NSString *str=[dic objectForKey:@"value"];
                        float i=[str floatValue];
                        i=i/10;
                        weakSelf.roomTempature.text=[NSString stringWithFormat:@"室温:%.1f",i];
                        NSLog(@"%@",[NSString stringWithFormat:@"%.1f",i]);
                    }
                }else{
                    if ([[dic objectForKey:@"name"] isEqualToString:@"回风温度"]) {
                        NSString *str=[dic objectForKey:@"value"];
                        float i=[str floatValue];
                        i=i/10;
                        weakSelf.roomTempature.text=[NSString stringWithFormat:@"室温:%.1f",i];
                        NSLog(@"%@",[NSString stringWithFormat:@"%.1f",i]);
                        
                    }
                    
                    
                }
                
                
                
                
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self loadData];
            
        }];

        
    });
    
   
   
    
    
    
    
}


//button响应事件

//模式功能实现
-(void)modeEvent:(UIButton *)button{
    YZHTTPRequest *req=[[YZHTTPRequest alloc] init];
    [req changeModeControl:self.model withButton:button];
    
    [self.iconView removeFromSuperview];
    CGRect rect=button.bounds;
    CGPoint origin=button.bounds.origin;
    CGSize size=button.bounds.size;
    [UIView animateWithDuration:0.7 animations:^{
        button.bounds=CGRectMake(origin.x, origin.y, size.width*1.3, size.height*1.3);
        
    } completion:^(BOOL finished) {
        NSLog(@"xxxxxxxx");
        [button setBounds:rect];
        
    }];
    
    NSString *btnTitle=@"模式:";
    btnTitle=[btnTitle stringByAppendingString:button.titleLabel.text];
    
    
    [self.modeButton setTitle:btnTitle forState:UIControlStateNormal];
    [self.modeButton setImage:button.imageView.image forState:UIControlStateNormal];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(delay) userInfo:nil repeats:NO];
    [self modeMoveToRange:button];
    
    
    
    
    
}

-(void)delay{
    [self.modeView removeFromSuperview];
}


-(void)modeMoveToRange:(UIButton *)button{
    __block typeof(self) weakSelf=self;
    NSString *title=button.titleLabel.text;
    UIImage *image=button.currentImage;
    CGFloat y=self.bottom.frame.origin.y;
    NSLog(@"xxxxxxxxx%lf",self.bottom.frame.origin.y);
    self.iconView=[[YZIconView alloc] initWithFrame:CGRectMake(10, y-50, 70, 40)];
    [_iconView.modeNameLabel setText:title];
    [_iconView.iconImageView setImage:image];
    //iconView.backgroundColor=[UIColor blueColor];
    [self.view addSubview:_iconView];
    [self transitionWithType:kCATransitionReveal WithSubtype:kCATransitionFromLeft ForView:_iconView];
    self.rightUp.alpha=0;
    [UIView animateWithDuration:2 animations:^{
        
        [weakSelf.iconView setFrame:CGRectMake(10 , y-50, 100, 60)];
        [weakSelf.iconView setFrame:CGRectMake(10, y-120, 70, 40)];
        
    } completion:^(BOOL finished) {
        [weakSelf.iconView setFrame:CGRectMake(100, y-120, 70, 40)];
        [weakSelf.iconView setFrame:CGRectMake(100, y-160, 70, 40)];
        weakSelf.rightUp.alpha=1;
        
    }];
    
    
    
    
    
}






//点击模式按

-(void)clickChangeMode:(UIButton *)button{
    if ([self.powerLabel.text isEqualToString:@"关"]) {
        
    }else{
    [UIView animateWithDuration:0.4 animations:^{
        
        [self.modeButton setBounds:CGRectMake(0 , 0, screenWidth/2.5, screenWidth/2.5)];
    } completion:^(BOOL finished) {
        
        [self.modeButton setBounds:CGRectMake(0, 0, screenWidth/3, screenWidth/3)];
    }];
    
    
    
    _modeView=[[UIView alloc] initWithFrame:CGRectMake(50, button.center.y+100, 250, 350)];
    _modeView.layer.cornerRadius=30;
    _modeView.layer.masksToBounds=YES;
    UIImageView *bgImageView=[[UIImageView alloc] init];
    bgImageView.layer.cornerRadius=30;
    bgImageView.layer.masksToBounds=YES;
    [bgImageView setImage: [UIImage imageNamed:@"modeBG2.jpg"]];
    bgImageView.frame=CGRectMake(0, 0, 250, 350);
    [self transitionWithType:kCATransitionReveal WithSubtype:kCATransitionFromBottom ForView:self.modeView];
    
    [self.view addSubview:self.modeView];
    [self.modeView addSubview:bgImageView];
    [self setupModeView];
    }
    
    
    
    
}
-(void)clickPower:(UIButton *)button{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSString *url=@"http://emp.i-mec.cn/";
    url=[url stringByAppendingString:[NSString stringWithFormat:@"%@",self.model.buildCode]];
    if ([self.powerLabel.text isEqualToString:@"关"]) {
        url=[url stringByAppendingString:@"/aircer?act=open&Id="];
        url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",self.model.deviceId]];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }else{
        url=[url stringByAppendingString:@"/aircer?act=close&Id="];
        url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",self.model.deviceId]];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
        
    }
    

    
}







//执行风速事件
-(void)windContrlEvent:(UIButton *)button{
    
    if ([self.powerLabel.text isEqualToString:@"关"]) {
        
    }else{
    
    YZHTTPRequest *req=[[YZHTTPRequest alloc] init];
    [req changeWinControlwithModel:self.model withButton:button];
    
    [self.rightIconView removeFromSuperview];
    CGRect rect=button.bounds;
    CGPoint origin=button.bounds.origin;
    CGSize size=button.bounds.size;
    [UIView animateWithDuration:0.7 animations:^{
        button.bounds=CGRectMake(origin.x, origin.y, size.width*1.3, size.height*1.3);
        
    } completion:^(BOOL finished) {
        NSLog(@"xxxxxxxx");
        [button setBounds:rect];
        
    }];
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(delayRight) userInfo:nil repeats:NO];
    [self windMoveToRange:button];
    }
    
}

-(void)delayRight{
    [self.WinCtrolView removeFromSuperview];
    
}


-(void)windMoveToRange:(UIButton *)button{
    __block typeof(self) weakSelf=self;
    NSString *title=button.titleLabel.text;
    UIImage *image=button.currentImage;
    CGFloat y=self.bottom.frame.origin.y;
    NSLog(@"xxxxxxxxx%lf",self.bottom.frame.origin.y);
    self.rightIconView=[[YZIconView alloc] initWithFrame:CGRectMake(screenWidth-110, y-50, 90, 30)];
    [_rightIconView.modeNameLabel setText:title];
    [_rightIconView.modeNameLabel setFont:[UIFont systemFontOfSize:14]];
    [_rightIconView.iconImageView setImage:image];
    //    CGRect temp=_rightIconView.modeNameLabel.frame;
    //    _rightIconView.modeNameLabel.frame=_rightIconView.iconImageView.frame;
    //    _rightIconView.iconImageView.frame=temp;
    
    [self.view addSubview:_rightIconView];
    [self transitionWithType:kCATransitionReveal WithSubtype:kCATransitionFromLeft ForView:_rightIconView];
    self.leftUP.alpha=0;
    [UIView animateWithDuration:2 animations:^{
        
        [weakSelf.rightIconView setFrame:CGRectMake(screenWidth-110 , y-50, 100, 60)];
        [weakSelf.rightIconView setFrame:CGRectMake(screenWidth-110, y-120, 70, 40)];
        
    } completion:^(BOOL finished) {
        [weakSelf.rightIconView setFrame:CGRectMake(screenWidth-190, y-120, 100, 40)];
        [weakSelf.rightIconView setFrame:CGRectMake(screenWidth-190, y-160, 90, 40)];
        weakSelf.leftUP.alpha=1;
        
    }];
    
    
    
    
    
}





//控制风速button
-(void)winControl:(UIButton *)button{
    if ([self.powerLabel.text isEqualToString:@"关"]) {
        
    }else{
    
    [UIView animateWithDuration:0.4 animations:^{
        
        [button setBounds:CGRectMake(0 , 0, screenWidth/2.5, screenWidth/2.5)];
    } completion:^(BOOL finished) {
        
        [button setBounds:CGRectMake(0, 0, screenWidth/3, screenWidth/3)];
    }];
    
    NSLog(@"%lf",button.frame.size.height);
    
    self.WinCtrolView=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-220, button.frame.size.height+80, 200, 250)];
    self.WinCtrolView.layer.cornerRadius=30;
    self.WinCtrolView.layer.masksToBounds=YES;
    UIImageView *bgImageView=[[UIImageView alloc] init];
    bgImageView.layer.cornerRadius=30;
    bgImageView.layer.masksToBounds=YES;
    [bgImageView setImage: [UIImage imageNamed:@"modeBG2.jpg"]];
    bgImageView.frame=CGRectMake(0, 0, 250, 350);
    [self transitionWithType:kCATransitionReveal WithSubtype:kCATransitionFromBottom ForView:self.WinCtrolView];
    
    [self.view addSubview:self.WinCtrolView];
    [self.WinCtrolView addSubview:bgImageView];
    [self configWindCtrolView];
    
    }
    
    
    
}
-(void)clickTimerON:(UIButton *)button{
    
}
-(void)clickTimerOFF:(UIButton *)button{
    if ([self.powerLabel.text isEqualToString:@"关"]) {
        
    }else{
    }
    
}

-(void)clickMore:(UIButton *)button{
    if ([self.powerLabel.text isEqualToString:@"关"]) {
        
    }else{
    [self loadData];
    }
}







//动画封装

- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 1;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}





@end
