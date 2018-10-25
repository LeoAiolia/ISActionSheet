//
//  ISActionSheet.m
//  ISActionSheet
//
//  Created by 润 on 2017/8/25.
//  Copyright © 2017年 润. All rights reserved.
//

#import "ISActionSheet.h"

#define IS_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define IS_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 带刘海的手机系列
#define IS_IPHONE_BANG \
  (IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XS || IS_IPHONE_XS_MAX)

#define IS_IPHONEX_TABBAR_ADD_HEIGHT (IS_IPHONE_BANG ? 34.0 : 0)
#define IS_COLOR_RGB(R, G, B)       \
  [UIColor colorWithRed:(R) / 255.f \
                  green:(G) / 255.f \
                   blue:(B) / 255.f \
                  alpha:1.0]

// 手机设备
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// 判断iPhoneX
#define IS_IPHONE_X                                                     \
  ([UIScreen instancesRespondToSelector:@selector(currentMode)]         \
       ? CGSizeEqualToSize(CGSizeMake(1125, 2436),                      \
                           [[UIScreen mainScreen] currentMode].size) && \
             IS_IPHONE                                                  \
       : NO)

// 判断iPHoneXr
#define IS_IPHONE_XR                                                    \
  ([UIScreen instancesRespondToSelector:@selector(currentMode)]         \
       ? CGSizeEqualToSize(CGSizeMake(828, 1792),                       \
                           [[UIScreen mainScreen] currentMode].size) && \
             IS_IPHONE                                                  \
       : NO)

// 判断iPhoneXs
#define IS_IPHONE_XS                                                    \
  ([UIScreen instancesRespondToSelector:@selector(currentMode)]         \
       ? CGSizeEqualToSize(CGSizeMake(1125, 2436),                      \
                           [[UIScreen mainScreen] currentMode].size) && \
             IS_IPHONE                                                  \
       : NO)

// 判断iPhoneXs Max
#define IS_IPHONE_XS_MAX                                                \
  ([UIScreen instancesRespondToSelector:@selector(currentMode)]         \
       ? CGSizeEqualToSize(CGSizeMake(1242, 2688),                      \
                           [[UIScreen mainScreen] currentMode].size) && \
             IS_IPHONE                                                  \
       : NO)

@interface ISActionSheet () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UIView* maskView;
@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, strong) UIView* headView;
@property(nonatomic, strong) NSArray* optionsArr;
@property(nonatomic, strong) NSMutableArray<UIColor*>* titleColorArr;
@property(nonatomic, copy) NSString* cancelTitle;

@property(nonatomic, assign) ISActionSheetStyle style;  //actionStyle类型
@property(nonatomic, assign) CGFloat marginX;  //水平方向的 空隙
@property(nonatomic, assign) CGFloat marginY;  //取消 和 上面按钮之间的空隙
@property(nonatomic, assign) CGFloat marginBottom;  //取消 距离 底部之间的空隙
@property(nonatomic, assign) CGFloat actionSheetWidth;  //弹框的宽
@property(nonatomic, assign) CGFloat cornerRadius;  //圆角

@property(nonatomic, assign) CGFloat lineWidth;  //分割线的宽
@property(nonatomic, strong) UIColor* lineColor;  //分割线的颜色
@property(nonatomic, strong) UIColor* cellTitleColor;  //item的字体颜色

@property(nonatomic, copy) SelectedBlock selectedBlock;
@property(nonatomic, copy) void (^cancelBlock)(void);

@end

@implementation ISActionSheet

+ (instancetype)actionSheetWithStyle:(ISActionSheetStyle)style
                           titleView:(nullable UIView*)titleView
                          optionsArr:(NSArray<NSString*>*)optionsArr
                         cancelTitle:(NSString*)cancelTitle
                       selectedBlock:(nullable SelectedBlock)selectedBlock
                         cancelBlock:(nullable void (^)(void))cancelBlock {
  return [[self alloc] initWithActionStyle:style
                                 titleView:titleView
                                optionsArr:optionsArr
                               cancelTitle:cancelTitle
                             selectedBlock:selectedBlock
                               cancelBlock:cancelBlock];
}

- (instancetype)initWithActionStyle:(ISActionSheetStyle)style
                          titleView:(nullable UIView*)titleView
                         optionsArr:(NSArray<NSString*>*)optionsArr
                        cancelTitle:(NSString*)cancelTitle
                      selectedBlock:(nullable SelectedBlock)selectedBlock
                        cancelBlock:(nullable void (^)(void))cancelBlock {
  if (self = [super init]) {
    [self initConfig:style];
    _headView = titleView;
    _optionsArr = optionsArr;
    _titleColorArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < optionsArr.count; i++) {
      [_titleColorArr addObject:_cellTitleColor];
    }
    _cancelTitle = cancelTitle;
    _selectedBlock = selectedBlock;
    _cancelBlock = cancelBlock;
    [self craetUI];
  }
  return self;
}

+ (instancetype)actionSheetWithStyle:(ISActionSheetStyle)style
                               title:(nullable NSString*)title
                          optionsArr:(NSArray<NSString*>*)optionsArr
                         cancelTitle:(NSString*)cancelTitle
                       selectedBlock:(nullable SelectedBlock)selectedBlock
                         cancelBlock:(nullable void (^)(void))cancelBlock {
  return [[self alloc] initWithActionStyle:style
                                     title:title
                                optionsArr:optionsArr
                               cancelTitle:cancelTitle
                             selectedBlock:selectedBlock
                               cancelBlock:cancelBlock];
}

- (instancetype)initWithActionStyle:(ISActionSheetStyle)style
                              title:(nullable NSString*)title
                         optionsArr:(NSArray<NSString*>*)optionsArr
                        cancelTitle:(NSString*)cancelTitle
                      selectedBlock:(nullable SelectedBlock)selectedBlock
                        cancelBlock:(nullable void (^)(void))cancelBlock {
  if (self = [super init]) {
    [self initConfig:style];
    _headView = [self createDefaultHeadView:title];
    _optionsArr = optionsArr;
    _titleColorArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < optionsArr.count; i++) {
      [_titleColorArr addObject:_cellTitleColor];
    }
    _cancelTitle = cancelTitle;
    _selectedBlock = selectedBlock;
    _cancelBlock = cancelBlock;
    [self craetUI];
  }
  return self;
}

- (void)initConfig:(ISActionSheetStyle)style {
  _style = style;
  switch (style) {
    case ISActionSheetStyleSystem: {
      [self configSystemStyle];
    } break;
    case ISActionSheetStyleWeChat: {
      [self configWeChatStyle];
    } break;
  }
}

- (void)configWeChatStyle {
  _marginX = 0;
  _marginY = 10;
  _marginBottom = IS_IPHONE_BANG ? IS_IPHONEX_TABBAR_ADD_HEIGHT : 0;
  _cornerRadius = 0;
  _actionSheetWidth = IS_SCREEN_WIDTH - 2 * _marginX;

  _lineWidth = 0.5;
  _cellTitleColor = [UIColor blackColor];
  _lineColor = [UIColor colorWithRed:230 / 255.0
                               green:230 / 255.0
                                blue:230 / 255.0
                               alpha:1];
}

- (void)configSystemStyle {
  _marginX = 10;
  _marginY = 10;
  _marginBottom = IS_IPHONE_BANG ? IS_IPHONEX_TABBAR_ADD_HEIGHT : 10;
  _cornerRadius = 13;
  _actionSheetWidth = IS_SCREEN_WIDTH - 2 * _marginX;

  _lineWidth = 0.5;
  _cellTitleColor = [UIColor colorWithRed:0 / 255.f
                                    green:109 / 255.f
                                     blue:251 / 255.f
                                    alpha:1];
  _lineColor = [UIColor colorWithRed:230 / 255.0
                               green:230 / 255.0
                                blue:230 / 255.0
                               alpha:1];
}

- (void)craetUI {
  self.frame = [UIScreen mainScreen].bounds;
  [self addSubview:self.maskView];
  [self addSubview:self.tableView];
}

- (UIView*)maskView {
  if (!_maskView) {
    _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0.4;
    _maskView.userInteractionEnabled = YES;
  }
  return _maskView;
}

- (UIView*)createDefaultHeadView:(NSString*)headerViewTitle {
  if (headerViewTitle == nil) {
    return nil;
  }

  UIView* view =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, _actionSheetWidth, 40)];
  view.backgroundColor = [UIColor whiteColor];

  UILabel* titleLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(0, 5, _actionSheetWidth, 30)];
  titleLabel.text = headerViewTitle;
  titleLabel.font = [UIFont systemFontOfSize:12.0];
  titleLabel.textColor = [UIColor colorWithRed:144 / 255.0
                                         green:144 / 255.0
                                          blue:144 / 255.0
                                         alpha:1];
  titleLabel.textAlignment = NSTextAlignmentCenter;
  [view addSubview:titleLabel];

  UIView* line =
      [[UIView alloc] initWithFrame:CGRectMake(0, 40 - _lineWidth,
                                               _actionSheetWidth, _lineWidth)];
  line.backgroundColor = _lineColor;
  [view addSubview:line];
  return view;
}

- (UITableView*)tableView {
  if (!_tableView) {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                              style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.layer.cornerRadius = _cornerRadius;
    _tableView.clipsToBounds = YES;
    _tableView.rowHeight = 55.0;
    _tableView.bounces = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = self.headView;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.separatorColor = _lineColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0.f;
    _tableView.estimatedSectionFooterHeight = 0.f;
    _tableView.estimatedSectionHeaderHeight = 0.f;
    if (@available(iOS 11.0, *)) {
      _tableView.contentInsetAdjustmentBehavior =
          UIScrollViewContentInsetAdjustmentNever;
    }
  }
  return _tableView;
}

#pragma mark - TableViewDelegate -

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView*)tableView
    numberOfRowsInSection:(NSInteger)section {
  return (section == 0) ? _optionsArr.count : 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  static NSString* const kCellIdentifier = @"IS_ACTIONSHEET_CELL";
  UITableViewCell* cell =
      [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:kCellIdentifier];
  }

  CGFloat defaultFont = 18;

  if (indexPath.section == 0) {
    cell.textLabel.text = _optionsArr[indexPath.row];

    if (_titleColorArr.count > indexPath.row) {
      cell.textLabel.textColor = _titleColorArr[indexPath.row];
    } else {
      cell.textLabel.textColor = _cellTitleColor;
    }
    if (indexPath.row == _optionsArr.count - 1 && _cornerRadius > 0) {
      UIBezierPath* maskPath = [UIBezierPath
          bezierPathWithRoundedRect:CGRectMake(0, 0, _actionSheetWidth,
                                               tableView.rowHeight)
                  byRoundingCorners:UIRectCornerBottomLeft |
                                    UIRectCornerBottomRight
                        cornerRadii:CGSizeMake(_cornerRadius, _cornerRadius)];
      CAShapeLayer* maskLayer = [[CAShapeLayer alloc] init];
      maskLayer.frame = cell.contentView.bounds;
      maskLayer.path = maskPath.CGPath;
      cell.layer.mask = maskLayer;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:defaultFont];

    if (indexPath.row < _optionsArr.count - 1) {
      UIView* lineView = [[UIView alloc] init];
      lineView.backgroundColor = _lineColor;
      lineView.frame = CGRectMake(0, tableView.rowHeight - _lineWidth,
                                  _actionSheetWidth, _lineWidth);
      [cell.contentView.layer addSublayer:lineView.layer];
    }
  } else {
    cell.textLabel.text = _cancelTitle;
    cell.layer.cornerRadius = _cornerRadius;
    cell.clipsToBounds = YES;

    switch (_style) {
      case ISActionSheetStyleSystem: {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:defaultFont];
      } break;
      case ISActionSheetStyleWeChat: {
        cell.textLabel.font = [UIFont systemFontOfSize:defaultFont];
      } break;
    }
    cell.textLabel.textColor = _cellTitleColor;
  }

  cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
  cell.textLabel.textAlignment = NSTextAlignmentCenter;
  return cell;
}

- (void)setTitleColor:(UIColor*)color atIndex:(NSInteger)index {
  if (index >= _titleColorArr.count) {
    return;
  }
  [_titleColorArr replaceObjectAtIndex:index withObject:color];
  [_tableView reloadData];
}

- (void)tableView:(UITableView*)tableView
    didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
  if (indexPath.section == 0) {
    if (self.selectedBlock) {
      NSString* title = _optionsArr[indexPath.row];
      self.selectedBlock(indexPath.row, title);
    }
  } else {
    if (self.cancelBlock) {
      self.cancelBlock();
    }
  }
  [self dismiss];
}

- (CGFloat)tableView:(UITableView*)tableView
    heightForFooterInSection:(NSInteger)section {
  if (section == 0) {
    return _marginY;
  } else {
    return _marginBottom;
  }
}

- (CGFloat)tableView:(UITableView*)tableView
    heightForHeaderInSection:(NSInteger)section {
  return 0.001;
}

- (UIView*)tableView:(UITableView*)tableView
    viewForHeaderInSection:(NSInteger)section {
  static NSString* const kHeaderIdentifier = @"kHeaderIdentifier";
  UITableViewHeaderFooterView* headerView = [tableView
      dequeueReusableHeaderFooterViewWithIdentifier:kHeaderIdentifier];
  if (headerView == nil) {
    headerView = [[UITableViewHeaderFooterView alloc]
        initWithReuseIdentifier:kHeaderIdentifier];
  }
  return headerView;
}

- (UIView*)tableView:(UITableView*)tableView
    viewForFooterInSection:(NSInteger)section {
  UIView* footerView = [[UIView alloc] init];
  UIColor* color = (_style == ISActionSheetStyleWeChat)
                       ? IS_COLOR_RGB(240, 240, 240)
                       : [UIColor clearColor];
  footerView.backgroundColor = color;
  return footerView;
}

- (void)showInView:(nullable UIView*)view {
  if (view == nil) {
    view = [UIApplication sharedApplication].delegate.window;
  }

  dispatch_async(dispatch_get_main_queue(), ^{
    [view addSubview:self];
    [self internal_show];
  });
}

- (void)internal_show {
  _tableView.frame =
      CGRectMake(_marginX, IS_SCREEN_HEIGHT, _actionSheetWidth,
                 _tableView.rowHeight * (_optionsArr.count + 1) +
                     _headView.bounds.size.height + (_marginY + _marginBottom));

  [UIView animateWithDuration:0.25
                   animations:^{
                     CGRect rect = self.tableView.frame;
                     rect.origin.y -= self.tableView.bounds.size.height;
                     self.tableView.frame = rect;
                   }];
}

- (void)dismiss {
  [UIView animateWithDuration:0.25
      animations:^{
        CGRect rect = self.tableView.frame;
        rect.origin.y += self.tableView.bounds.size.height;
        self.tableView.frame = rect;
      }
      completion:^(BOOL finished) {
        [self removeFromSuperview];
      }];
}

- (void)touchesEnded:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event {
  [self dismiss];
}

@end
