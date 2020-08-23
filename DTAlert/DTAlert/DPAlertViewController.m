//
//  DPAlertViewController.m
//  DTAlert
//
//  Created by 宋彬彬 on 2020/7/21.
//  Copyright © 2020 宋彬彬. All rights reserved.
//

#import "DPAlertViewController.h"
#import "DPUIActionSheet.h"
#import "DPUIAlertView.h"

@interface DPAlertViewController ()
@property (nonatomic, strong) NSMutableArray<DPAlertAction *> *optionsArr;
@end

@implementation DPAlertViewController

+ (instancetype)alertControllerWithTitleModel:(nullable DPAlertLableModel *)titleModel
                                 messageModel:(nullable DPAlertLableModel *)messageModel
                               preferredStyle:(DPUIAlertControllerStyle)preferredStyle {
    
    DPAlertViewController *alertVC = [[DPAlertViewController alloc]init];
    alertVC.titleModel = titleModel;
    alertVC.messageModel = messageModel;
    alertVC.preferredStyle = preferredStyle;
    alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    alertVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    return alertVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)addAction:(DPAlertAction *)action{
    [self.optionsArr addObject:action];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_preferredStyle == DPUIAlertControllerStyleActionSheet) {
        [self showActionSheet];
    }else{
        [self showAlertView];
    }
}


-(void)showAlertView{
    
    DPUIAlertView *alertView = [[DPUIAlertView alloc] initWithTitleModel:_titleModel messageModel:_messageModel optionsArr:[_optionsArr copy] cancelBlock:^(DPAlertAction * _Nonnull action) {
        NSLog(@"关闭窗口");
        [self dismiss:action];
    }];
    
    [alertView  showWithView:self.view];
}

-(void)showActionSheet{
    DPUIActionSheet *optionsView = [[DPUIActionSheet alloc]initWithTitleView:nil optionsArr:[_optionsArr copy] cancelTitle:@"取消"  cancelBlock:^(DPAlertAction * _Nonnull action) {
        NSLog(@"关闭窗口");
        [self dismiss:action];
    }];
    [optionsView  showWithView:self.view];
    
}

-(void)dismiss:(DPAlertAction *) action{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3/*延迟执行时间*/ * NSEC_PER_SEC));
//
//    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//        if(action.handler){
//            action.handler(action);
//        }
//    });
}

-(NSMutableArray<DPAlertAction *> *)optionsArr{
    if (!_optionsArr) {
        _optionsArr = [NSMutableArray<DPAlertAction *> new];
    }
    return _optionsArr;
}

@end
