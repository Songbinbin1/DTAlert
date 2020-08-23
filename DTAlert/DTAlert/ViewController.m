//
//  ViewController.m
//  DTAlert
//
//  Created by 宋彬彬 on 2020/7/21.
//  Copyright © 2020 宋彬彬. All rights reserved.
//

#import "ViewController.h"
#import "DPAlertViewController.h"
#import "YYText.h"
#import "DPUIAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (IBAction)alertMore:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题标题标题标题标" message:@"这个是UIAlertController的默认样式" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController *alertController1 = [UIAlertController alertControllerWithTitle:@"标题" message:@"这个是UIAlertController的默认样式" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
          [alertController1 addAction:cancelAction];
         [self presentViewController:alertController1 animated:YES completion:nil];
        
//        [self alert:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
     [self presentViewController:alertController animated:YES completion:nil];
    
         
    
//    DPAlertAction *action2 = [DPAlertAction actionWithTitle:@"确定"
//                                                 titleColor:[UIColor redColor]
//                                                      style:(PDAlertActionStyleAlertActionStyleCancel)
//                                                    handler:^(DPAlertAction * _Nonnull action) {
//        NSLog(@"确定");
//
//
//    }];
//
//    DPAlertAction *action1 = [DPAlertAction actionWithTitle:@"取消" titleColor:[UIColor blueColor] style:(PDAlertActionStyleAlertActionStyleCancel) handler:^(DPAlertAction * _Nonnull action) {
//        NSLog(@"取消");
//    }];
//
//    DPAlertLableModel *titleModel = [DPAlertLableModel initWithTitle:@"标题标题标题标题标题标题" titleColor:[UIColor redColor] attTitle:nil];
//
//    DPAlertLableModel *messageModel = [[DPAlertLableModel alloc] init];
//    messageModel.title = @"135352526666";
//    DPAlertViewController *alert = [DPAlertViewController alertControllerWithTitleModel:titleModel messageModel:messageModel preferredStyle:DPUIAlertControllerStyleAlert];
//
//    [alert addAction:action1];
//    [alert addAction:action2];
//    [alert addAction:action2];
//    [self presentViewController:alert animated:NO completion:nil];
    
//    [self alert:nil];
}


- (IBAction)alert:(id)sender {
    
    DPAlertAction *action2 = [DPAlertAction actionWithTitle:@"确定"
                                                 titleColor:[UIColor redColor]
                                                      style: PDAlertActionStyleRadius
                                                    handler:^(DPAlertAction * _Nonnull action) {
        NSLog(@"确定");
    }];
    action2.size = CGSizeMake(88, 30);
    action2.bgColor = [UIColor yellowColor];
//    DPAlertAction *action1 = [DPAlertAction actionWithTitle:@"取消" titleColor:[UIColor blueColor] style:(PDAlertActionStyleAlertActionStyleCancel) handler:^(DPAlertAction * _Nonnull action) {
//        NSLog(@"取消");
//    }];
    
   //设置整段字符串的颜色
//    UIColor *color = self.isSelect ? [UIColor blackColor] : [UIColor lightGrayColor];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:16], NSForegroundColorAttributeName:  [UIColor lightGrayColor]};
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"  注册即表示同意注册即表示同意注册即表示同意注册即表示同意注册即表示同意《用户协议》和《隐私政策》" attributes:attributes];
    //设置高亮色和点击事件
    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"《用户协议》"] color:[UIColor orangeColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了《用户协议》");
    }];
    //设置高亮色和点击事件
    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"《隐私政策》"] color:[UIColor orangeColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了《隐私政策》");
        UIAlertController *alertController1 = [UIAlertController alertControllerWithTitle:@"标题" message:@"这个是UIAlertController的默认样式" preferredStyle:UIAlertControllerStyleAlert];
               UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alertController1 addAction:cancelAction];
        
               [self presentViewController:alertController1 animated:YES completion:nil];

    }];
    
    DPAlertLableModel *messageModel = [DPAlertLableModel initWithTitle:nil titleColor:[UIColor redColor] attTitle:text];
    
    DPAlertLableModel *titleModel = [[DPAlertLableModel alloc] init];
    titleModel.title = @"确定确定确定确定确定确定确定确定确定";
//    DPAlertViewController *alert = [DPAlertViewController alertControllerWithTitleModel:titleModel messageModel:messageModel preferredStyle:DPUIAlertControllerStyleAlert];
    
    DPUIAlertView *alertView = [[DPUIAlertView alloc] initWithTitleModel:titleModel messageModel:messageModel optionsArr:@[action2] cancelBlock:^(DPAlertAction * _Nonnull action) {
           NSLog(@"关闭窗口");
//           [self dismiss:action];
       
       }];
       
       [alertView  showWithView:self.navigationController.view];
    //    DPAlertViewController *alert = [DPAlertViewController alertControllerWithTitle:@"确定确定确定确定确定确定确定" message:nil preferredStyle:DPUIAlertControllerStyleAlert];
//    [alert addAction:action1];
//    [alert addAction:action2];
    
//    [self presentViewController:alert animated:NO completion:nil];
}

- (IBAction)sheet:(id)sender {
    DPAlertAction *action2 = [DPAlertAction actionWithTitle:@"标题1"
                                                 titleColor:[UIColor redColor]
                                                      style:PDAlertActionStyleDefault
                                                    handler:^(DPAlertAction * _Nonnull action) {
        NSLog(@"标题1");
    }];
    DPAlertAction *action1 = [DPAlertAction actionWithTitle:@"标题2"
                                                 titleColor:[UIColor blueColor]
                                                      style:PDAlertActionStyleDefault
                                                    handler:^(DPAlertAction * _Nonnull action) {
        NSLog(@"标题2");
        [self alert:nil];
    }];
    
    DPAlertViewController *alert = [DPAlertViewController alertControllerWithTitleModel:nil messageModel:nil preferredStyle:DPUIAlertControllerStyleActionSheet];
    [alert addAction:action1];
    [alert addAction:action2];
    
    
    [self presentViewController:alert animated:NO completion:nil];
}


@end
