//
//  DPAlertLableModel.h
//  DTAlert
//
//  Created by 宋彬彬 on 2020/7/22.
//  Copyright © 2020 宋彬彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DPAlertLableModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) UIColor  *titleColor;

@property (nonatomic, copy) NSAttributedString *attTitle;

+ (instancetype)initWithTitle:(nullable NSString *)title
                     titleColor:(nullable UIColor *)titleColor
                       attTitle:(nullable NSAttributedString *)attTitle;
@end

NS_ASSUME_NONNULL_END
