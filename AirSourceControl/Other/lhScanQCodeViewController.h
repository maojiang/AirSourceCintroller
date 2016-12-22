//
//  YZTransitionViewController.h
//  AirSourceControl
//
//  Created by 邓茂江 on 2016/12/8.
//  Copyright © 2016年 远正智联. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UrlReturnBlock)(NSString *url);


@interface lhScanQCodeViewController : UIViewController
@property (nonatomic,copy)UrlReturnBlock urlBlock;
- (instancetype)initWithPhoto;
- (void)alumbBtnEvent;
@end
