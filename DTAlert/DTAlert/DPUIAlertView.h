//
//  DPUIAlertView.h
//  DTAlert
//
//  Created by 宋彬彬 on 2020/7/21.
//  Copyright © 2020 宋彬彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPAlertAction.h"
#import "Masonry.h"
#import "DPAlertLableModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DPUIAlertView : UIView

- (instancetype)initWithTitleModel:(nullable DPAlertLableModel*)titleModel
                      messageModel:(nullable DPAlertLableModel*)messageModel
                        optionsArr:(NSArray*)optionsArr
                       cancelBlock:(DPAlertActionBlock )cancelBlock;
 
- (void)showWithView:(nullable UIView *)view;
@end

NS_ASSUME_NONNULL_END
