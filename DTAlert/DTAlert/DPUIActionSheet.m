//
//  DPUIActionSheet.m
//  DTAlert
//
//  Created by 宋彬彬 on 2020/7/21.
//  Copyright © 2020 宋彬彬. All rights reserved.
//



#import "DPUIActionSheet.h"


@interface DPUIActionSheet ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSArray<DPAlertAction *> *optionsArr;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic,   copy) NSString *cancelTitle;
@property (nonatomic,   copy) DPAlertActionBlock cancelBlock;
@end

@implementation DPUIActionSheet

- (instancetype)initWithTitleView:(nullable UIView*)titleView
                       optionsArr:(NSArray*)optionsArr
                      cancelTitle:(NSString*)cancelTitle
                      cancelBlock:(DPAlertActionBlock)cancelBlock {
    
    if (self = [super init]) {
        _headView = titleView;
        _optionsArr = optionsArr;
        _cancelTitle = cancelTitle;
        _cancelBlock = cancelBlock;
        [self craetUI];
    }
    return self;
}

- (void)craetUI {
    self.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.bgView];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.tableView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor whiteColor];
    button.frame = CGRectMake(0, 0, SCREEN_WIDTH,55);
    [button addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.adjustsImageWhenHighlighted = YES;
    [button setTitleColor:UIColorFromRGBA(250, 56, 79, 1) forState:UIControlStateNormal];
    [self.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-FF_VIEW_BOTTOM_MARGIN - (SPACE * 2));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(55);
    }];
    
    UIView *lineView = [[UITextView alloc]init];
    lineView.backgroundColor =UIColorFromRGBA(230, 231, 232, 1);
    [_contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-FF_VIEW_BOTTOM_MARGIN - (SPACE * 2) - 55);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(8);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)showWithView:(UIView *)view{
    
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [view addSubview:self];
    CGFloat tableViewHight = _tableView.rowHeight * _optionsArr.count + _headView.bounds.size.height;
    if(tableViewHight > (SCREEN_HEIGHT - (SPACE * 2)+ 63 - FF_VIEW_BOTTOM_MARGIN - statusBar_HEIGHT)){
        tableViewHight = SCREEN_HEIGHT - (SPACE * 2) -  63 - FF_VIEW_BOTTOM_MARGIN - statusBar_HEIGHT;
    }
    _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, tableViewHight);
    self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, tableViewHight + (SPACE * 2)+ 63 + FF_VIEW_BOTTOM_MARGIN);
    [UIView animateWithDuration:.3 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y -= rect.size.height;
        self.contentView.frame = rect;
    }];
}

- (void)dismiss:(DPAlertAction *) rightActon {
    [UIView animateWithDuration:.3 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y += rect.size.height;
        self.contentView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.cancelBlock) {
            self.cancelBlock(rightActon);
        }
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1/*延迟执行时间*/ * NSEC_PER_SEC));

        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            if(rightActon.handler){
                rightActon.handler(rightActon);
            }
        });
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss:nil];
}

#pragma mark TableViewDel

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _optionsArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Navi_Cell"];
    cell.textLabel.text = _optionsArr[indexPath.row].title;
    cell.textLabel.textColor = _optionsArr[indexPath.row].titleColor?:UIColorFromRGBA(0, 105, 252, 1);
    cell.textLabel.font=[UIFont systemFontOfSize:17];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ( _optionsArr[indexPath.row].handler) {
//        _optionsArr[indexPath.row].handler( _optionsArr[indexPath.row]);
//    }
    
    [self dismiss:_optionsArr[indexPath.row]];
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView=[UIView new];
        _bgView.frame=[UIScreen mainScreen].bounds;
        _bgView.backgroundColor=UIColorFromRGBA(0, 0, 0, 0.4);
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView=[UIView new];
        _contentView.backgroundColor= [UIColor whiteColor];
        _contentView.userInteractionEnabled = YES;
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.layer.cornerRadius = 12;
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.rowHeight = CELLHIGTH;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = self.headView;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Navi_Cell"];
    }
    return _tableView;
}
@end
