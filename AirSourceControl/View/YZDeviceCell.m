//
//  YZDeviceCell.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/8.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZDeviceCell.h"
#import "Masonry.h"
#import "YZHTTPRequest.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
@implementation YZDeviceCell

-(UIImageView *)deviceImage{
    if (!_deviceImage) {
        _deviceImage=[[UIImageView alloc] init];
    }
    return _deviceImage;
}

-(UILabel *)deviceName{
    if (!_deviceName) {
        _deviceName=[[UILabel alloc] init];
    }
    return _deviceName;
}

-(UILabel *)floor{
    if (!_floor) {
        _floor=[[UILabel alloc] init];
    }
    return _floor;
}


-(UILabel *)statuLabel{
    if (!_statuLabel) {
        _statuLabel=[[UILabel alloc] init];
        
    }
    
    return _statuLabel;
}

-(YZButton *)statuButton{
    if (!_statuButton) {
       _statuButton=[YZButton buttonWithType:UIButtonTypeCustom];
        
    }
    return _statuButton;
    
}





- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self addSubview:self.deviceImage];
    [self addSubview:self.deviceName];
    [self addSubview:self.floor];
    [self addSubview:self.statuLabel];
    [self addSubview:self.statuButton];
    
    [self makeLayout];
    
    
}

-(void)makeLayout{
    
    //__weak typeof(self) weakSelf=self;
    [self.deviceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(60, 45));
        
    }];
    self.statuLabel.frame=CGRectMake(165, 5, 70, 30);
    self.deviceName.frame=CGRectMake(80, 5, 100, 30);
    self.statuButton.frame=CGRectMake(self.bounds.size.width-60, 20,30,30);
    _statuButton.layer.cornerRadius=self.statuButton.bounds.size.width/2;
    _statuButton.layer.masksToBounds=YES;
    _floor.frame=CGRectMake(80, 40, 200, 30);

}



-(void)configureCell:(YZDeviceModel *)model{
    
    if (model.type==0) {
        //vrv
        [self.deviceImage setImage:[UIImage imageNamed:@"vrv"]];
        
        
    }else{
        //air
        [self.deviceImage setImage:[UIImage imageNamed:@"air_condition_type"]];
    }
    
    [self.deviceName setText:model.name];
    self.statuButton.type=model.type;
    self.statuButton.buildCode=model.buildCode;
    self.statuButton.deviceId=model.deviceId;
    self.statuButton.power=model.powerD;
    [self refreshDeviceData:model];
    NSString *addr=[model.buildName stringByAppendingString:model.roomName];
    if (addr) {
        self.floor.text=addr;
        
        self.deviceName.text=model.name;
        self.floor.text=[model.buildName stringByAppendingString:model.roomName];
    }else{
        
    }
    
   
    
}


-(void)refreshDeviceData:(YZDeviceModel *)model{
    NSString *mainUrl=@"http://emp.i-mec.cn/";
    mainUrl=[mainUrl stringByAppendingString:model.buildCode];
    if (model.type==1) {
        mainUrl=[mainUrl stringByAppendingString:@"/aircer?act=getAirerAttr&Id="];
        
    }else{
        mainUrl=[mainUrl stringByAppendingString:@"/vrvctrl?act=getVRVAttr&Id="];
        
    }
    mainUrl=[mainUrl stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)model.deviceId]];
    mainUrl=[mainUrl stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 3.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager GET:mainUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"xxx请求成功");
        if (model.type==0) {
            
        for (NSDictionary *dic in responseObject) {
            NSString *str=[dic objectForKey:@"name"];
            if ([str isEqualToString:@"运转/停止状态"]) {
            model.powerD=[dic objectForKey:@"value"];
                if ([model.powerD isEqualToString:@"运转"]){
                self.statuLabel.text=@"运行中";
                self.statuButton.backgroundColor=[UIColor greenColor];
                }else if ([model.powerD isEqualToString:@"停止"]){
                    self.statuLabel.text=@"关机中";
                    self.statuButton.backgroundColor=[UIColor redColor];
                                
                }else {
                    self.statuLabel.text=@"未知状态";
                    self.statuButton.backgroundColor=[UIColor grayColor];
                                }

                        
                    }
                
            }
            
        }else{
            
           
                for (NSDictionary *dic in responseObject) {
                    NSString *str=[dic objectForKey:@"name"];
                    if ([str isEqualToString:@"开关机控制"]) {
                        model.powerD=[dic objectForKey:@"value"];
                        if ([model.powerD isEqualToString:@"开"]) {
                                self.statuLabel.text=@"运行中";
                                self.statuButton.backgroundColor=[UIColor greenColor];
                                }else if ([model.powerD isEqualToString:@"关"]){
                                self.statuLabel.text=@"关机中";
                                self.statuButton.backgroundColor=[UIColor redColor];
                                }else {
                                    self.statuLabel.text=@"未知状态";
                                    self.statuButton.backgroundColor=[UIColor grayColor];
                                }
                        
                        
                        
                    }
                }
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"xxx超时重新请求");
        [self refreshDeviceData:model];
        
    }];
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
