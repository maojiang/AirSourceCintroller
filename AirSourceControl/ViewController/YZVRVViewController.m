//
//  YZVRVViewController.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/15.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZVRVViewController.h"
#import "YZNetworking.h"
#define  screenWidth  [UIScreen mainScreen].bounds.size.width
@interface YZVRVViewController ()

@end

@implementation YZVRVViewController

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.modeView!=nil) {
        [self.modeView removeFromSuperview];
    }else if (self.WinCtrolView!=nil){
        [self.WinCtrolView removeFromSuperview];
    }
}

- (IBAction)tempatureUp:(id)sender {
    __weak typeof(self) weakSelf=self;
    NSString *tempatureStr=self.settingTempetureLabel.text;
    tempatureStr=[tempatureStr substringWithRange:NSMakeRange(0, 4)];
    NSInteger tempature=[tempatureStr integerValue];
    if (tempature<=30) {
        tempature=tempature+1;
        tempatureStr=[self ToHex:tempature];
        NSString *url=@"http://emp.i-mec.cn/vrvctrl?act=SetVRVTemp&Id=1&temp=00DC";
        url=[url stringByAppendingString:self.model.buildCode];
        url=[url stringByAppendingString:@"/vrvctrl?act=SetVRVTemp&Id="];
        url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",self.model.deviceId]];
        url=[url stringByAppendingString:@"&temp="];
        url=[url stringByAppendingString:tempatureStr];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            weakSelf.settingTempetureLabel.text=[NSString stringWithFormat:@"%ld℃",(long)tempature];
            if ([responseObject objectForKey:@"flag"]) {
                //
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    
    
}

- (IBAction)tempatureDown:(id)sender {
    __weak typeof(self) weakSelf=self;
    NSString *tempatureStr=self.settingTempetureLabel.text;
    tempatureStr=[tempatureStr substringWithRange:NSMakeRange(0, 4)];
    NSInteger tempature=[tempatureStr integerValue];
    if (tempature>=18) {
        tempature=tempature-1;
        
        tempatureStr=[self ToHex:tempature];
        NSString *url=@"http://emp.i-mec.cn/vrvctrl?act=SetVRVTemp&Id=1&temp=00DC";
        url=[url stringByAppendingString:self.model.buildCode];
        url=[url stringByAppendingString:@"/vrvctrl?act=SetVRVTemp&Id="];
        url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",self.model.deviceId]];
        url=[url stringByAppendingString:@"&temp="];
        url=[url stringByAppendingString:tempatureStr];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            weakSelf.settingTempetureLabel.text=[NSString stringWithFormat:@"%ld℃",(long)tempature];
            if ([responseObject objectForKey:@"flag"]) {
                //
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }

}

//16进制转换
-(NSString *)ToHex:(long long int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    str=[@"00" stringByAppendingString:str];
    return str;
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
    //[self loadData];
    self.addButton.layer.cornerRadius=10;
    self.addButton.layer.masksToBounds=YES;
    self.cutButton.layer.cornerRadius=10;
    self.cutButton.layer.masksToBounds=YES;
    self.timerOnLabel.text=@"";
    self.timerOffLabel.text=@"";
    

    
    
    
    
}

-(void)loadData{
    NSLog(@"xxxx");
    __weak typeof(self) weakSelf=self;
    NSLog(@"%@",self.model.attStr);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 3.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

        [manager GET:weakSelf.model.attStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"vrv请求成功%@",responseObject);
            for (NSDictionary *dic in responseObject) {
                if ([[dic objectForKey:@"name"] isEqual:@"运转/停止状态"]) {
                    weakSelf.powerLabel.text=[dic objectForKey:@"value"];
                }else if ([[dic objectForKey:@"name"] isEqual:@"运转模式"]){
                    NSString *modeName=[dic objectForKey:@"value"];
                    CGFloat y=weakSelf.bottom.frame.origin.y;
                    weakSelf.iconView=[[YZIconView alloc] initWithFrame:CGRectMake(100, y-160, 70, 40)];
                    weakSelf.iconView.modeNameLabel.text=modeName;
                    [weakSelf.view addSubview:weakSelf.iconView];
                }else if ([[dic objectForKey:@"name"] isEqual:@"设定温度"]){
                    NSString *str=[[dic objectForKey:@"value"] substringWithRange:NSMakeRange(0,4)];
                    weakSelf.settingTempetureLabel.text=[str stringByAppendingString:@"℃"];
                    
                    
                }else if ([[dic objectForKey:@"name"] isEqual:@"室内温度"]){
                    
                    NSString *temp=[@"室温:"stringByAppendingString:[[dic objectForKey:@"value"] substringWithRange:NSMakeRange(0,4)]];
                    temp=[temp stringByAppendingString:@"℃"];
                    weakSelf.roomTempatureLabel.text=temp;
                }
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"vrv请求超时重新请求");
            [self loadData];
            
        }];

        
    });
    
    
    
   
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self loadData];
}




-(void)clickReturn:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setupMiddleView{
    self.verLeft.alpha=0;
    self.verRight.alpha=0;
    
    
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
    [winSpeedButton setTitle:@"刷新" forState:UIControlStateNormal];
    [winSpeedButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
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
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(clickMore:) forControlEvents:UIControlEventTouchUpInside];
    [_bottom addSubview:moreButton];

    
    

}

-(void)configWindCtrolView{
    YZModeButton *autoWindButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    autoWindButton.frame=CGRectMake(0, 40, 90, 60);
    [autoWindButton setImage:[UIImage imageNamed:@"zidongdang"] forState:UIControlStateNormal];
    [autoWindButton setTitle:@"自动风" forState:UIControlStateNormal];
    [autoWindButton addTarget:self action:@selector(windContrlEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.WinCtrolView addSubview:autoWindButton];
    
    YZModeButton *lowWindButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    lowWindButton.frame=CGRectMake(100, 40, 90, 60);
    [lowWindButton setImage:[UIImage imageNamed:@"yidang"] forState:UIControlStateNormal];
    [lowWindButton setTitle:@"低风速" forState:UIControlStateNormal];
    [lowWindButton addTarget:self action:@selector(windContrlEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.WinCtrolView addSubview:lowWindButton];
    
    YZModeButton *midWindButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    midWindButton.frame=CGRectMake(0, 110, 90, 60);
    [midWindButton setImage:[UIImage imageNamed:@"erdang"] forState:UIControlStateNormal];
    [midWindButton setTitle:@"中风速" forState:UIControlStateNormal];
    [midWindButton addTarget:self action:@selector(windContrlEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.WinCtrolView addSubview:midWindButton];
    
    YZModeButton *higWindButton=[YZModeButton buttonWithType:UIButtonTypeCustom];
    higWindButton.frame=CGRectMake(100, 110, 90, 60);
    [higWindButton setImage:[UIImage imageNamed:@"sangdang"] forState:UIControlStateNormal];
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




//button响应事件





//模式功能实现
-(void)modeEvent:(UIButton *)button{
    NSString *url=@"http://emp.i-mec.cn/";
    url=[url stringByAppendingString:[NSString stringWithFormat:@"%@",self.model.buildCode]];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    if ([button.titleLabel.text isEqualToString:@"送风"]) {
        url=[url stringByAppendingString:@"/vrvctrl?act=SetVRVModel&Id=1&model=0"];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else if ([button.titleLabel.text isEqualToString:@"制热"]){
        url=[url stringByAppendingString:@"/vrvctrl?act=SetVRVModel&Id=1&model=1"];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

    }else if ([button.titleLabel.text isEqualToString:@"制冷"]){
        url=[url stringByAppendingString:@"/vrvctrl?act=SetVRVModel&Id=1&model=2"];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }else if ([button.titleLabel.text isEqualToString:@"自动"]){
        url=[url stringByAppendingString:@"/vrvctrl?act=SetVRVModel&Id=1&model=3"];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }else if ([button.titleLabel.text isEqualToString:@"除湿"]){
        url=[url stringByAppendingString:@"/vrvctrl?act=SetVRVModel&Id=1&model=7"];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }else{}


    
    
    
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
    self.upLeft.alpha=0;
    [UIView animateWithDuration:2 animations:^{
        
        [weakSelf.iconView setFrame:CGRectMake(10 , y-50, 100, 60)];
        [weakSelf.iconView setFrame:CGRectMake(10, y-120, 70, 40)];
        
    } completion:^(BOOL finished) {
        [weakSelf.iconView setFrame:CGRectMake(100, y-120, 70, 40)];
        [weakSelf.iconView setFrame:CGRectMake(100, y-160, 70, 40)];
        weakSelf.upLeft.alpha=1;
        
    }];
    
    
    
    
    
}








-(void)clickChangeMode:(UIButton *)button{
    if ([self.powerLabel.text isEqualToString:@"停止"]) {
        //关机下模式不可用提示
        
    }
    else{
    
    
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
    [self.modeView becomeFirstResponder];
    
    }
    
    
}
-(void)clickPower:(UIButton *)button{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSString *url=@"http://emp.i-mec.cn/";
    url=[url stringByAppendingString:[NSString stringWithFormat:@"%@",self.model.buildCode]];
    if ([self.powerLabel.text isEqualToString:@"停止"]) {
        url=[url stringByAppendingString:@"/vrvctrl?act=OpenVRV&Id="];
        url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",self.model.deviceId]];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }else{
        url=[url stringByAppendingString:@"/vrvctrl?act=CloseVRV&Id="];
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
    self.upRight.alpha=0;
    [UIView animateWithDuration:2 animations:^{
        
        [weakSelf.rightIconView setFrame:CGRectMake(screenWidth-110 , y-50, 100, 60)];
        [weakSelf.rightIconView setFrame:CGRectMake(screenWidth-110, y-120, 70, 40)];
        
    } completion:^(BOOL finished) {
        [weakSelf.rightIconView setFrame:CGRectMake(screenWidth-190, y-120, 100, 40)];
        [weakSelf.rightIconView setFrame:CGRectMake(screenWidth-190, y-160, 90, 40)];
        weakSelf.upRight.alpha=1;
        
    }];
    
    
    
    
    
}





//控制风速button
-(void)winControl:(UIButton *)button{
    [self loadData];
    

    
    
}
-(void)clickTimerON:(UIButton *)button{
   NSString *url=@"http://emp.i-mec.cn/";
    url=[url stringByAppendingString:[NSString stringWithFormat:@"%@",self.model.buildCode]];
    url=[url stringByAppendingString:@"/vrvctrl?act=OpenVRV&Id="];
    url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",self.model.deviceId]];
    url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject objectForKey:@"flag"]) {
            //操作成功提示
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}
-(void)clickTimerOFF:(UIButton *)button{
    NSString *url=@"http://emp.i-mec.cn/";
    url=[url stringByAppendingString:[NSString stringWithFormat:@"%@",self.model.buildCode]];
    url=[url stringByAppendingString:@"/vrvctrl?act=CloseVRV&Id="];
    url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",self.model.deviceId]];
    url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject objectForKey:@"flag"]) {
            //操作成功提示
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
}

-(void)clickMore:(UIButton *)button{
    
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










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
