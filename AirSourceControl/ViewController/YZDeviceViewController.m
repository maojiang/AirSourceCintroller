//
//  YZDeviceViewController.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/8.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZDeviceViewController.h"
#import "YZSelectView.h"   //右button弹出view
#import "lhScanQCodeViewController.h"
#import "YZNetworking.h"
#import "YZHTTPRequest.h"
#import "YZButton.h"
#import "YZAIRViewController.h"
#import "YZVRVViewController.h"

static NSString *identifier=@"deviceCell";

@interface YZDeviceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSString *urlValue;
@property (nonatomic,strong)YZSelectView *selView;
@property (nonatomic,strong)NSMutableArray *dataSources;
@property(nonatomic)dispatch_queue_t firstQueue;

@end

@implementation YZDeviceViewController

//初始化
- (instancetype)initWithString:(NSString *)value
{
    self = [super init];
    if (self) {
        self.title=@"设备列表";
        
        self.urlValue=value;
        
    }
    return self;
}




#pragma 懒加载

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 49, self.view.bounds.size.width, self.view.bounds.size.height-49) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}






- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.dataSources=[NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[YZDeviceCell class] forCellReuseIdentifier:identifier];
    
    [self configureNav];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//加载Nav
-(void)configureNav{
    self.title=@"设备列表";
    //导航条透明
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.4 green:0.76 blue:0.5 alpha:1];
    //NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,[UIFont systemFontOfSize:24],UITextAttributeFont, nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    //左button
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setFrame:CGRectMake(0, -10, 60, 60)];
    [self.navigationController.navigationBar addSubview:leftButton];
    [leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    //右button
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"添加" forState:UIControlStateNormal];
    [rightButton setFrame:CGRectMake(self.view.bounds.size.width-60, -10, 60, 60)];
    [self.navigationController.navigationBar addSubview:rightButton];
    [rightButton addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSData *data=[def objectForKey:@"data"];
    if (data!=nil) {
        [self.dataSources removeAllObjects];
        NSArray *dataArray=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self.dataSources addObjectsFromArray:dataArray];
        [self.tableView reloadData];

    }
    

}



-(void)viewWillDisappear:(BOOL)animated{
  
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSArray *dataArray=[NSArray arrayWithArray:self.dataSources];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:dataArray];
    [def setObject:data forKey:@"data"];

}






//button事件
-(void)clickLeftButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickRightButton:(UIButton *)button{
    NSLog(@"xxxxxxxxx");
    _selView=[[YZSelectView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-100, 64, 100, 120)];
    _selView.backgroundColor=[UIColor colorWithRed:0.4 green:0.76 blue:0.5 alpha:1];
    [self.view addSubview:self.selView];
    [_selView.camoraButton addTarget:self action:@selector(actionCamora:) forControlEvents:UIControlEventTouchUpInside];
    [_selView.photoButton addTarget:self action:@selector(actionPhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}


-(void)actionCamora:(UIButton *)button{
    [self.selView removeFromSuperview];
    lhScanQCodeViewController *QcodeVC=[[lhScanQCodeViewController alloc] init];
    __weak typeof(self) weakSelf=self;
    QcodeVC.urlBlock=^(NSString *url){
        YZDeviceModel *myModel=[[YZDeviceModel alloc] init];
        NSLog(@"%@",url);
        YZHTTPRequest *net=[[YZHTTPRequest alloc] init];
        [net loadDevice:url withModel:myModel];
        [weakSelf.dataSources addObject:myModel];
        [weakSelf.tableView reloadData];
        
    };
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:QcodeVC];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)actionPhoto:(UIButton *)button{
    lhScanQCodeViewController *qcodeVC=[[lhScanQCodeViewController alloc] initWithPhoto];
    [qcodeVC alumbBtnEvent];
}

-(void)power:(YZButton *)sender{
    NSString *uStr=@"http://emp.i-mec.cn/";
    uStr=[uStr stringByAppendingString:sender.buildCode];
    if (sender.type==0) {
        if ([sender.power isEqualToString:@"运转"]) {
            
            uStr=[uStr stringByAppendingString:@"/vrvctrl?act=CloseVRV&Id="];
            uStr=[uStr stringByAppendingString:[NSString stringWithFormat:@"%ld",sender.deviceId]];
            uStr=[uStr stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:uStr]];
            
            NSLog(@"%@",data);
            
        }else{
            uStr=[uStr stringByAppendingString:@"/vrvctrl?act=OpenVRV&Id="];
            uStr=[uStr stringByAppendingString:[NSString stringWithFormat:@"%ld",sender.deviceId]];
            uStr=[uStr stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:uStr]];
            NSLog(@"%@",data);
        }
        
    }else{
        if ([sender.power isEqualToString:@"开"]) {
            uStr=[uStr stringByAppendingString:@"/aircer?act=close&Id="];
            uStr=[uStr stringByAppendingString:[NSString stringWithFormat:@"%ld",sender.deviceId]];
            uStr=[uStr stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:uStr]];
            NSLog(@"%@",data);
                    }
        else{
            uStr=[uStr stringByAppendingString:@"/aircer?act=open&Id="];
            uStr=[uStr stringByAppendingString:[NSString stringWithFormat:@"%ld",sender.deviceId]];
            uStr=[uStr stringByAppendingString:@"&----user_login_i----=efe10872-6adb-46ef-be40-2ac598a94345"];
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:uStr]];
            NSLog(@"%@",data);

        }
        
    }
}







#pragma tableView协议
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZDeviceCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell=[[YZDeviceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    [cell.statuButton addTarget:self action:@selector(power:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.dataSources.count>0) {
        YZDeviceModel *model=self.dataSources[indexPath.row];
         [cell configureCell:model];
    }
    

    
   
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YZDeviceModel *model=self.dataSources[indexPath.row];
    if (model.type==0) {
        //vrv
        YZVRVViewController *vrvVC=[[YZVRVViewController alloc] initWith:model];
        [self presentViewController:vrvVC animated:YES completion:nil];
        
    }else{
        YZAIRViewController *airVC=[[YZAIRViewController alloc] initWith:model];
        [self presentViewController:airVC animated:YES completion:nil];
    }
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  @"删除";
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (tableView == self.tableView) {
            [self.dataSources removeObjectAtIndex:indexPath.row];
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView endUpdates];
        }
    }
}


@end
