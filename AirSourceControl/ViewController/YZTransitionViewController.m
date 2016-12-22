//
//  YZTransitionViewController.m
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/8.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import "YZTransitionViewController.h"
#import "YZDeviceViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "lhScanQCodeViewController.h"

@interface YZTransitionViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@end

@implementation YZTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureAVCapture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//开始扫描，可连接Button
- (IBAction)camora:(id)sender {
    lhScanQCodeViewController * sqVC = [[lhScanQCodeViewController alloc]init];
    UINavigationController * nVC = [[UINavigationController alloc]initWithRootViewController:sqVC];
    [self presentViewController:nVC animated:YES completion:^{
        
    }];
//    NSLog(@"xxxxxxxxx");
//    //开始扫描
//    [_session startRunning];
//    
    
//    YZDeviceViewController *vc=[[YZDeviceViewController alloc] init];
//    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:vc];
//    nav.tabBarController.tabBar.backgroundColor=[UIColor blueColor];
//    
//    [self presentViewController:nav animated:YES completion:nil];
    
    
}

//装载扫码
-(void)configureAVCapture{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    if (!_input) {
        NSLog(@"xxxxx%@",_input);
    }
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    //连接输入和输出
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    //设置条码类型
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    //添加扫描画面
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
   

    
}






//实现协议AVCaptureMetadataOutputObjectsDelegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    
    
    }





@end
