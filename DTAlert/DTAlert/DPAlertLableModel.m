//
//  DPAlertLableModel.m
//  DTAlert
//
//  Created by 宋彬彬 on 2020/7/22.
//  Copyright © 2020 宋彬彬. All rights reserved.
//

#import "DPAlertLableModel.h"

@implementation DPAlertLableModel

+ (instancetype)initWithTitle:(nullable NSString *)title
                     titleColor:(nullable UIColor *)titleColor
                       attTitle:(nullable NSAttributedString *)attTitle{
    
    DPAlertLableModel *alertAction =  [DPAlertLableModel new];
    alertAction.title = title;
    alertAction.titleColor = titleColor;
    alertAction.attTitle = attTitle;
    return alertAction;
}
@end
