//
//  DPUIActionSheet.h
//  DTAlert
//
//  Created by 宋彬彬 on 2020/7/21.
//  Copyright © 2020 宋彬彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "DPAlertAction.h"
#define CELLHIGTH 55
NS_ASSUME_NONNULL_BEGIN
//typedef void(^DPCancelBlockBlock)(void);

@interface DPUIActionSheet : UIView

- (instancetype)initWithTitleView:(nullable UIView*)titleView
                       optionsArr:(NSArray*)optionsArr
                      cancelTitle:(NSString*)cancelTitle
                      cancelBlock:(DPAlertActionBlock)cancelBlock;

- (void)showWithView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
