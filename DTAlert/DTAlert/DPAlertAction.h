//
//  DPAlertAction.h
//  DTAlert
//
//  Created by 宋彬彬 on 2020/7/21.
//  Copyright © 2020 宋彬彬. All rights reserved.
//
#define KEY_WINDOW    ([[[UIApplication sharedApplication] delegate] window])
#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define navigation_HEIGHT  self.navigationController.navigationBar.frame.size.height
#define statusBar_HEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height
//iPhoneX / iPhoneXS
#define   HN_isIphoneX_XS     (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define   HN_isIphoneXR_XSMax    (SCREEN_WIDTH == 414.f && SCREEN_HEIGHT == 896.f ? YES : NO)
//异性全面屏
#define   HN_isFullScreen    (HN_isIphoneX_XS || HN_isIphoneXR_XSMax)

#define FF_IS_IPHONE_X_P (SCREEN_WIDTH == 414)
#define FF_IS_IPHONEX (SCREEN_HEIGHT == 812)

#define FF_IPHONEX_HOME_INDICATOR_PORTRAIT 34
#define FF_IPHONEX_HOME_INDICATOR_LANDSCAPE 21

#define FF_VIEW_BOTTOM_MARGIN (HN_isFullScreen ? FF_IPHONEX_HOME_INDICATOR_PORTRAIT : 0)
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height

#define SCREEN_SCALE  ((SCREEN_WIDTH > 414) ? (SCREEN_HEIGHT/375.0) : (SCREEN_WIDTH/375.0))
#define Handle(x)        ((x)*SCREEN_SCALE)
#define Handle_width(w)  ((w)*SCREEN_SCALE)
#define Handle_height(h) ((h)*SCREEN_SCALE)

#define SPACE 8
// 颜色
#define UIColorFromHEXA(hex,a) [UIColor colorWithRed:((hex & 0xFF0000) >> 16) / 255.0f green:((hex & 0xFF00) >> 8) / 255.0f blue:(hex & 0xFF) / 255.0f alpha:a]
#define UIColorFromRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PDAlertActionStyle) {
    PDAlertActionStyleDefault = 0,
    PDAlertActionStyleCancel,
    PDAlertActionStyleRadius,
    PDAlertActionStyleDestructive
} API_AVAILABLE(ios(8.0));
NS_ASSUME_NONNULL_BEGIN


@interface DPAlertAction : NSObject

typedef void(^DPAlertActionBlock)(DPAlertAction * _Nonnull action);

+ (instancetype)actionWithTitle:(nullable NSString *)title
                     titleColor:(nullable UIColor *)titleColor
                          style:(PDAlertActionStyle)style
                        handler:(DPAlertActionBlock )handler;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) UIColor  *titleColor;
@property (nonatomic, copy) UIColor  *bgColor;
@property (nonatomic, copy) NSAttributedString *attTitle;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) PDAlertActionStyle style;
@property (nonatomic, copy) DPAlertActionBlock handler;
@end

NS_ASSUME_NONNULL_END
