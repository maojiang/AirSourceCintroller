//
//  YZHTTPRequest.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/14.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZHTTPRequest.h"

@implementation YZHTTPRequest
-(void)loadDevice:(NSString *)url withModel:(YZDeviceModel *)model{
    NSString *urlMain=@"";
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    NSMutableDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    [model setDeviceId:[[dic objectForKey:@"PrimaryKey"] integerValue]];
    [model setType:[[dic objectForKey:@"Type"] integerValue]];
    [model setBuildCode:[dic objectForKey:@"BuildCode"]];
    NSLog(@"%@",model.buildCode);
    NSLog(@"%ld",(long)model.type);
    if (model.type==0) {
        urlMain=@"http://emp.i-mec.cn/";
        urlMain=[urlMain stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",model.buildCode]];
        urlMain=[urlMain stringByAppendingString:@"/vrvctrl?act=getCurrentVRVInfo&Id="];
        urlMain=[urlMain stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)model.deviceId]];
        urlMain=[urlMain stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        NSLog(@"%@",urlMain);
        NSData *devData=[NSData dataWithContentsOfURL:[NSURL URLWithString:urlMain]];
        if (data!=nil) {
            NSMutableDictionary *devDic=[NSJSONSerialization JSONObjectWithData:devData options:kNilOptions error:nil];
            NSLog(@"%@",devDic);
            
            //加载数据到model
            [model setName:[NSString stringWithFormat:@"%@",[devDic objectForKey:@"name"]]];
            [model setOnline:[[devDic objectForKey:@"online"] boolValue]];
            [model setRoomId:[[devDic objectForKey:@"roomId"] integerValue]];
            [model setBuildId:[[devDic objectForKey:@"buildId"] integerValue]];
            [model setFloorId:[[devDic objectForKey:@"floorId"] integerValue]];
        }
        
        
                
    }else{
        NSString *urlMain=@"http://emp.i-mec.cn/";
        urlMain=[urlMain stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",model.buildCode]];
        urlMain=[urlMain stringByAppendingString:@"/aircer?act=getCurrentAirerInfo&Id="];
        urlMain=[urlMain stringByAppendingString:[NSString stringWithFormat:@"%ld",model.deviceId]];
        urlMain=[urlMain stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        NSData *airData=[NSData dataWithContentsOfURL:[NSURL URLWithString:urlMain]];
        if (airData) {
            NSMutableDictionary *devDic=[NSJSONSerialization JSONObjectWithData:airData options:kNilOptions error:nil];
            NSLog(@"%@",airData);
            
            //加载数据到model
            [model setName:[devDic objectForKey:@"name"]];
            [model setOnline:[[devDic objectForKey:@"online"] boolValue]];
            [model setRoomId:[[devDic objectForKey:@"roomId"] integerValue]];
            [model setBuildId:[[devDic objectForKey:@"buildId"] integerValue]];
            [model setFloorId:[[devDic objectForKey:@"floorId"] integerValue]];
        }
        
        
        
    }
    
    if (model.buildId) {
        //获取建筑名
        NSString *urlMain=@"http://emp.i-mec.cn/";
        //先拼入bulidCode
        urlMain=[urlMain stringByAppendingString:model.buildCode];
        urlMain=[urlMain stringByAppendingString:@"/maps?act=GetBuildingInfoById&Id="];
        urlMain=[urlMain stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)model.buildId]];
        urlMain=[urlMain stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        NSData *buildData=[NSData dataWithContentsOfURL:[NSURL URLWithString:urlMain]];
        if (buildData!=nil) {
            NSMutableDictionary *buildDic=[NSJSONSerialization JSONObjectWithData:buildData options:kNilOptions error:nil];
            
            model.buildName=[buildDic objectForKey:@"name"];
        }
        
        urlMain=@"http://emp.i-mec.cn/";
        urlMain=[urlMain stringByAppendingString:model.buildCode];
        urlMain=[urlMain stringByAppendingString:@"/maps?act=GetRoomInfoById&Id="];
        urlMain=[urlMain stringByAppendingString:[NSString stringWithFormat:@"%ld",model.roomId]];
        urlMain=[urlMain stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        NSData *roomData=[NSData dataWithContentsOfURL:[NSURL URLWithString:urlMain]];
        if (roomData!=nil) {
            NSMutableDictionary *roomDic=[NSJSONSerialization JSONObjectWithData:roomData options:kNilOptions error:nil];
            model.roomName=[roomDic objectForKey:@"name"];
        }
        
        

        
    }
    
    NSString *mainUrl=@"http://emp.i-mec.cn/";
    mainUrl=[mainUrl stringByAppendingString:model.buildCode];
    if (model.type==1) {
        mainUrl=[mainUrl stringByAppendingString:@"/aircer?act=getAirerAttr&Id="];
        
    }else if(model.type==0){
        mainUrl=[mainUrl stringByAppendingString:@"/vrvctrl?act=getVRVAttr&Id="];
        
    }
    mainUrl=[mainUrl stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)model.deviceId]];
    mainUrl=[mainUrl stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
    model.attStr=mainUrl;
    NSMutableArray *attArr=[NSMutableArray array];
    NSData *attData=[NSData dataWithContentsOfURL:[NSURL URLWithString:mainUrl]];
    if (attData==nil) {
        attData=[NSData dataWithContentsOfURL:[NSURL URLWithString:mainUrl]];
    }
        
        attArr=[NSJSONSerialization JSONObjectWithData:attData options:kNilOptions error:nil];
    if (model.type==0) {
        if (attArr.count>0) {
            for (NSDictionary *dic in attArr) {
                NSString *str=[dic objectForKey:@"name"];
                if ([str isEqualToString:@"运转/停止状态"]) {
                    model.powerD=[dic objectForKey:@"value"];
                }
            }
        }

    }else{
    
    if (attArr.count>0) {
        for (NSDictionary *dic in attArr) {
            NSString *str=[dic objectForKey:@"name"];
            if ([str isEqualToString:@"开关机控制"]) {
                model.powerD=[dic objectForKey:@"value"];
            }else if ([str isEqualToString:@"设备类型"]){
                model.deviceType=[dic objectForKey:@"value"];
            }
        }
    }
    }
   
    
    
}








-(NSMutableArray *)getPowerwithModel:(YZDeviceModel *)model{
    NSString *mainUrl=@"http://emp.i-mec.cn/";
    mainUrl=[mainUrl stringByAppendingString:model.buildCode];
    if (model.type==1) {
        mainUrl=[mainUrl stringByAppendingString:@"/aircer?act=getAirerAttr&Id="];
        
    }else{
        mainUrl=[mainUrl stringByAppendingString:@"/vrvctrl?act=getVRVAttr&Id="];
        
    }
    mainUrl=[mainUrl stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)model.deviceId]];
    mainUrl=[mainUrl stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
    NSMutableArray *attArr=[NSMutableArray array];
    NSData *attData=[NSData dataWithContentsOfURL:[NSURL URLWithString:mainUrl]];
    if (attData==nil) {
        attData=[NSData dataWithContentsOfURL:[NSURL URLWithString:mainUrl]];
    }else{
        
    attArr=[NSJSONSerialization JSONObjectWithData:attData options:kNilOptions error:nil];
    NSLog(@"xxxx%@",attArr);
        
    
    }
    return attArr;
}


-(void)changeModeControl:(YZDeviceModel *)model withButton:(UIButton *)button{
    NSString *url=@"http://emp.i-mec.cn/";
    url=[url stringByAppendingString:[NSString stringWithFormat:@"%@",model.buildCode]];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    if ([button.titleLabel.text isEqualToString:@"送风"]) {
        url=[url stringByAppendingString:@"/aircer?act=WirteAirerData&Id="];
        url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",model.deviceId]];
        url=[url stringByAppendingString:@"&addr=0001&data=6"];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else if ([button.titleLabel.text isEqualToString:@"制热"]){
        url=[url stringByAppendingString:@"/aircer?act=WirteAirerData&Id="];
        url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",model.deviceId]];
        url=[url stringByAppendingString:@"&addr=0001&data=1"];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }else if ([button.titleLabel.text isEqualToString:@"制冷"]){
        url=[url stringByAppendingString:@"/aircer?act=WirteAirerData&Id="];
        url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",model.deviceId]];
        url=[url stringByAppendingString:@"&addr=0001&data=4"];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }else if ([button.titleLabel.text isEqualToString:@"自动"]){
        url=[url stringByAppendingString:@"/aircer?act=WirteAirerData&Id="];
        url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",model.deviceId]];
        url=[url stringByAppendingString:@"&addr=0001&data=0"];        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }else if ([button.titleLabel.text isEqualToString:@"除湿"]){
        url=[url stringByAppendingString:@"/aircer?act=WirteAirerData&Id="];
        url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",model.deviceId]];
        url=[url stringByAppendingString:@"&addr=0001&data=2"];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }else{}
    

}


-(void)changeWinControlwithModel:(YZDeviceModel *)model withButton:(UIButton *)button{
    NSString *url=@"http://emp.i-mec.cn/";
    url=[url stringByAppendingString:[NSString stringWithFormat:@"%@",model.buildCode]];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    if (button.tag==101) {
        url=[url stringByAppendingString:@"/aircer?act=WirteAirerData&Id="];
        url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",model.deviceId]];
        url=[url stringByAppendingString:@"&addr=0002&data=0"];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else if (button.tag==102) {
        url=[url stringByAppendingString:@"/aircer?act=WirteAirerData&Id="];
        url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",model.deviceId]];
        url=[url stringByAppendingString:@"&addr=0002&data=2"];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else if (button.tag==103) {
        url=[url stringByAppendingString:@"/aircer?act=WirteAirerData&Id="];
        url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",model.deviceId]];
        url=[url stringByAppendingString:@"&addr=0002&data=1"];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else if (button.tag==104) {
        url=[url stringByAppendingString:@"/aircer?act=WirteAirerData&Id="];
        url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",model.deviceId]];
        url=[url stringByAppendingString:@"&addr=0002&data=3"];
        url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    

    
    
}


-(void)changeTempature:(YZDeviceModel *)model withflag:(BOOL)flag andtempature:(NSString *)tempature{
    tempature=[tempature substringWithRange:NSMakeRange(0,4)];
    float tempa=[tempature floatValue];
    if (flag) {
        tempa=tempa+1;
    }else{
        tempa=tempa-1;
    }
    tempature=[NSString stringWithFormat:@"%.1f",tempa];
    NSString *url=@"http://emp.i-mec.cn/";
    url=[url stringByAppendingString:[NSString stringWithFormat:@"%@",model.buildCode]];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    url=[url stringByAppendingString:@"/aircer?act=WirteAirerData&Id="];
    url=[url stringByAppendingString:tempature];
    url=[url stringByAppendingString:[NSString stringWithFormat:@"%ld",model.deviceId]];
    url=[url stringByAppendingString:@"&addr=0003&data="];
    url=[url stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject objectForKey:@"flag"]) {
                //成功提示
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    
}







@end
