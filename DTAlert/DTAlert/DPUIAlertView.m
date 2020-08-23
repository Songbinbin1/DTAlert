//
//  DPUIAlertView.m
//  DTAlert
//
//  Created by 宋彬彬 on 2020/7/21.
//  Copyright © 2020 宋彬彬. All rights reserved.
//

#import "DPUIAlertView.h"

#import "YYText.h"

@interface DPUIAlertView ()<UITextViewDelegate>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSArray<DPAlertAction *> *optionsArr;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic,   copy) DPAlertActionBlock cancelBlock;//void(^cancelBlock)(DPAlertAction *action);
@property (nonatomic, strong) DPAlertLableModel *titleModel;
@property (nonatomic, strong) DPAlertLableModel *messageModel;

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) YYLabel *yyMessageLabel;
@end

@implementation DPUIAlertView


- (instancetype)initWithTitleModel:(nullable DPAlertLableModel*)titleModel
                      messageModel:(nullable DPAlertLableModel*)messageModel
                        optionsArr:(NSArray*)optionsArr
                       cancelBlock:(DPAlertActionBlock )cancelBlock {
    
    if (self = [super init]) {
        _titleModel = titleModel;
        _messageModel = messageModel;
        _optionsArr = optionsArr;
        _cancelBlock = cancelBlock;
        [self craetUI];
    }
    return self;
}
- (void)craetUI {
    
    CGFloat contentViewWidth = Handle_width(285);
    
    CGFloat titleHeight = _titleModel?20:0;
    
    CGFloat titleTop = _titleModel?24:0;
    
    CGFloat messageTop = _messageModel?6:0;
    
//    CGFloat messageHeight = _messageModel?34:0;
    
    CGFloat defaultButtonH = 44;
    
    CGFloat buttonTop = 22;
    self.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.bgView];
    [self addSubview:self.contentView];
    
    self.titleLable.text = _titleModel.title;
    if(self.titleModel.title){
        self.titleLable.text = _titleModel.title;
    }else{
        self.titleLable.attributedText = _titleModel.attTitle;
    }
    self.titleLable.textColor = _titleModel.titleColor?:UIColorFromRGBA(0 , 0, 0, 1);
    
    self.titleLable.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(titleTop);
        make.height.mas_equalTo(titleHeight);
    }];
    
    if(_messageModel.title){
        self.yyMessageLabel.text = _messageModel.title;
    }else{
        self.yyMessageLabel.attributedText = _messageModel.attTitle;
    }
//    self.yyMessageLabel.textColor = _titleModel.titleColor?:UIColorFromRGBA(48, 48, 48, 1);
//    self.yyMessageLabel.font = [UIFont systemFontOfSize:16];
////    self.yyMessageLabel.delegate = self;
//    self.yyMessageLabel.userInteractionEnabled = NO;
//    self.yyMessageLabel.textAlignment = NSTextAlignmentCenter;
//    _messageTextView.editable = NO;
    [_contentView addSubview:self.yyMessageLabel];
    
    CGSize sizeToFit = [self.yyMessageLabel sizeThatFits:CGSizeMake(contentViewWidth - 28, MAXFLOAT)];
    if(!_messageModel){
        sizeToFit.height = 0;
    }
    
//    if(sizeToFit.height > SCREEN_HEIGHT - 150 - statusBar_HEIGHT){
//        sizeToFit.height = SCREEN_HEIGHT - 150 - statusBar_HEIGHT;
//        self.yyMessageLabel.userInteractionEnabled = YES;
//    }
    
    [self.yyMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(14);
        make.right.mas_equalTo(-14);
        make.top.mas_equalTo(_titleLable.mas_bottom).mas_offset(messageTop);
        make.height.mas_equalTo(sizeToFit.height);
    }];
    
    UIView *lineView = [[UITextView alloc] init];
    lineView.backgroundColor = UIColorFromRGBA(230, 231, 232, 1);
    [_contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yyMessageLabel.mas_bottom).mas_offset(21);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
  
    CGFloat contentViewHight = titleTop + titleHeight + 6 + sizeToFit.height + buttonTop;
    if (_optionsArr.count == 1) {
       
        DPAlertAction *acton = _optionsArr.firstObject;
        
        CGFloat buttonHight =  acton.size.height ?acton.size.height:defaultButtonH;
        
        contentViewHight += buttonHight;
        
        UIButton *button = [self createBtnWithAction:acton];
        button.backgroundColor = acton.bgColor;
        button.tag = 100000;
        [_contentView addSubview:button];
 
        if(acton.style == PDAlertActionStyleRadius){
           [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.yyMessageLabel.mas_bottom).mas_offset(22);
    //            make.left.mas_equalTo(0);
    //            make.right.mas_equalTo(0);
                make.centerX.mas_equalTo(self.contentView);
                make.height.mas_equalTo(buttonHight);
                make.width.mas_equalTo((acton.size.width ?acton.size.width:_contentView.frame.size.width));
            }];
            lineView.hidden = YES;
            button.layer.cornerRadius = buttonHight /2;
            contentViewHight += 10;
//            button.layer. masksToBounds = YES;
        }else{
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.yyMessageLabel.mas_bottom).mas_offset(22);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.centerX.mas_equalTo(self.contentView);
                make.height.mas_equalTo(buttonHight);
//                make.width.mas_equalTo((acton.size.width ?acton.size.width:_contentView.frame.size.width));
            }];
        }
        
    }else if (_optionsArr.count == 2){
        contentViewHight += defaultButtonH;
        DPAlertAction *leftActon = _optionsArr.firstObject;
        UIButton *leftbutton = [self createBtnWithAction:leftActon];
        leftbutton.tag = 100000;
        [_contentView addSubview:leftbutton];
        [leftbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.yyMessageLabel.mas_bottom).mas_offset(22);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(contentViewWidth/2);
            make.height.mas_equalTo(44);
        }];
        
        DPAlertAction *rightActon = _optionsArr[1];
        UIButton *rightbutton = [self createBtnWithAction:rightActon];
        rightbutton.tag = 100001;
        [_contentView addSubview:rightbutton];
        [rightbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.yyMessageLabel.mas_bottom).mas_offset(22);
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(contentViewWidth/2);
            make.height.mas_equalTo(defaultButtonH);
        }];
        
        UIView *btnLineView = [[UITextView alloc] init];
        btnLineView.backgroundColor = UIColorFromRGBA(230, 231, 232, 1);
        [_contentView addSubview:btnLineView];
        [btnLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.yyMessageLabel.mas_bottom).mas_offset(21);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(44);
        }];
    }else{
        contentViewHight += (defaultButtonH * _optionsArr.count);
        for (int i = 0 ; i<_optionsArr.count; i++) {
            DPAlertAction *acton = _optionsArr[i];
            UIButton *button = [self createBtnWithAction:acton];
            button.tag = 100000 + i;
            [_contentView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.yyMessageLabel.mas_bottom).mas_offset(22 + (44*i));
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(44);
            }];
            UIView *lineView = [[UITextView alloc] init];
            lineView.backgroundColor = UIColorFromRGBA(230, 231, 232, 1);
            [_contentView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(button.mas_bottom).mas_offset(0);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(1);
            }];
        }
    }
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(contentViewWidth);
        make.height.mas_equalTo(contentViewHight);
    }];
}

-(UIButton *)createBtnWithAction:(DPAlertAction *)acton{
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:acton.title forState:UIControlStateNormal];
    [button setTitleColor:acton.titleColor?:UIColorFromRGBA(250, 56, 79, 1) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    return button;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

-(void)buttonAction:(UIButton *)btn{
    DPAlertAction *rightActon = _optionsArr[btn.tag - 100000];
    
    [self dismiss:rightActon];
}

- (void)showWithView:(nullable UIView *)view{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [view addSubview:self];
    //    [self exChangeOut:_contentView dur:0.5];
    self.contentView.alpha = 0;
    self.contentView.transform = CGAffineTransformMakeScale(0.65, 0.65);
    [UIView animateWithDuration:0.35 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.contentView.alpha = 1;
    } completion:nil];
    
}

- (void)dismiss:(DPAlertAction *) rightActon{
    self.contentView.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.35 animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(0.65, 0.65);
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.cancelBlock) {
            self.cancelBlock(rightActon);
        }
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1/*延迟执行时间*/ * NSEC_PER_SEC));

        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            if (rightActon.handler) {
                rightActon.handler(rightActon);
              }
        });
        
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.frame = [UIScreen mainScreen].bounds;
        _bgView.backgroundColor = UIColorFromRGBA(0, 0, 0, 0.4);
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor= [UIColor whiteColor];
        _contentView.userInteractionEnabled = YES;
        _contentView.layer.cornerRadius = 12;
    }
    return _contentView;
}

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];;
    }
    return _titleLable;
}

-(YYLabel *)yyMessageLabel{
    if (!_yyMessageLabel) {
        _yyMessageLabel = [[YYLabel alloc] init];
//        _yyMessageLabel.numberOfLines = 0;
        _yyMessageLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _yyMessageLabel.textAlignment = NSTextAlignmentCenter;
        _yyMessageLabel.numberOfLines = 0;
    }
    return _yyMessageLabel;
}

@end
