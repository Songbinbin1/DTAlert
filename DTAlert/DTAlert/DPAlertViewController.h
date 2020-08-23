//
//  DPAlertViewController.h
//  DTAlert
//
//  Created by 宋彬彬 on 2020/7/21.
//  Copyright © 2020 宋彬彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPAlertAction.h"
#import "DPAlertLableModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, DPUIAlertControllerStyle) {
    DPUIAlertControllerStyleActionSheet = 0,
    DPUIAlertControllerStyleAlert
} API_AVAILABLE(ios(8.0));

@interface DPAlertViewController : UIViewController

@property (nonatomic, strong) DPAlertLableModel *titleModel;
@property (nonatomic, strong) DPAlertLableModel *messageModel;
@property (nonatomic,   copy) NSAttributedString *messageAtt;
@property (nonatomic, assign) DPUIAlertControllerStyle preferredStyle;


+ (instancetype)alertControllerWithTitleModel:(nullable DPAlertLableModel *)titleModel
                                 messageModel:(nullable DPAlertLableModel *)messageModel
                               preferredStyle:(DPUIAlertControllerStyle)preferredStyle;

-(void)addAction:(DPAlertAction *)action;

@end

NS_ASSUME_NONNULL_END
