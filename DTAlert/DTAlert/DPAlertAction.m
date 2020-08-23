//
//  DPAlertAction.m
//  DTAlert
//
//  Created by 宋彬彬 on 2020/7/21.
//  Copyright © 2020 宋彬彬. All rights reserved.
//

#import "DPAlertAction.h"
@interface DPAlertAction ()
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, assign) PDAlertActionStyle style;

@end
@implementation DPAlertAction
+ (instancetype)actionWithTitle:(nullable NSString *)title
                     titleColor:(nullable UIColor *)titleColor
                          style:(PDAlertActionStyle)style
                        handler:(DPAlertActionBlock )handler{
    
    DPAlertAction *alertAction =  [DPAlertAction new];
    alertAction.title = title;
    alertAction.titleColor = titleColor;
    alertAction.style = style;
    alertAction.handler = handler;
    return alertAction;
}
@end
