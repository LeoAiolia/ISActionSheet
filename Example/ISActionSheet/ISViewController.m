//
//  ISViewController.m
//  ISActionSheet
//
//  Created by LeoAiolia on 01/30/2018.
//  Copyright (c) 2018 LeoAiolia. All rights reserved.
//

#import "ISViewController.h"
#import "ISActionSheet.h"

@interface ISViewController ()

@property(nonatomic, strong) UIScrollView* scrollView;
@property(nonatomic, strong) UIView* weChatheadView;
@property(nonatomic, strong) UIView* headView;
@property(nonatomic, strong) ISActionSheet* actionSheet;
@end

@implementation ISViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  _scrollView = [[UIScrollView alloc] init];
  _scrollView.frame = self.view.bounds;
  _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
  [self.view addSubview:_scrollView];
  [self creatButtonWithTitle:@"系统"
                    origionY:150
                      action:@selector(buttonClick1:)];
  [self creatButtonWithTitle:@"仿系统"
                    origionY:250
                      action:@selector(buttonClick2:)];
  [self creatButtonWithTitle:@"仿微信"
                    origionY:350
                      action:@selector(buttonClick3:)];
  [self creatButtonWithTitle:@"自定义head仿系统"
                    origionY:450
                      action:@selector(buttonClick4:)];
  [self creatButtonWithTitle:@"自定义head仿微信"
                    origionY:550
                      action:@selector(buttonClick5:)];
}

- (void)creatButtonWithTitle:(NSString*)title
                    origionY:(CGFloat)origionY
                      action:(SEL)selector {
  UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
  CGFloat origionX = (self.view.frame.size.width - 160) / 2.f;
  button.frame = CGRectMake(origionX, origionY, 160, 50);
  button.backgroundColor = [UIColor redColor];
  [button setTitle:title forState:UIControlStateNormal];
  [button addTarget:self
                action:selector
      forControlEvents:UIControlEventTouchUpInside];
  [_scrollView addSubview:button];
}

- (void)buttonClick1:(id)sender {
  UIAlertController* alerController = [UIAlertController
      alertControllerWithTitle:@"提示"
                       message:nil
                preferredStyle:UIAlertControllerStyleActionSheet];
  [alerController
      addAction:[UIAlertAction
                    actionWithTitle:@"11"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction* _Nonnull action) {
                              NSLog(@"11");
                            }]];
  [alerController
      addAction:[UIAlertAction
                    actionWithTitle:@"22"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction* _Nonnull action) {
                              NSLog(@"22");
                            }]];
  [alerController
      addAction:[UIAlertAction
                    actionWithTitle:@"取消"
                              style:UIAlertActionStyleCancel
                            handler:^(UIAlertAction* _Nonnull action) {
                              NSLog(@"取消");
                            }]];
  [self presentViewController:alerController
                     animated:YES
                   completion:^{
                     NSLog(@"弹出了");
                   }];
}

- (void)buttonClick2:(id)sender {
  ISActionSheetStyle style = ISActionSheetStyleSystem;
  NSArray* options = @[ @"11", @"22" ];
  ISActionSheet* actionSheet = [ISActionSheet actionSheetWithStyle:style
      title:@"提示"
      optionsArr:options
      cancelTitle:@"取消"
      selectedBlock:^(NSInteger row) {
        NSString* title = options[row];
        NSLog(@"%@", title);
      }
      cancelBlock:^{
        NSLog(@"取消");
      }];
  [actionSheet showInView:self.view];
}

- (void)buttonClick3:(id)sender {
  ISActionSheetStyle style = ISActionSheetStyleWeChat;
  NSArray* options = @[ @"11", @"22" ];
  ISActionSheet* actionSheet = [ISActionSheet actionSheetWithStyle:style
      title:@"提示"
      optionsArr:@[ @"11", @"22" ]
      cancelTitle:@"取消"
      selectedBlock:^(NSInteger row) {
        NSString* title = options[row];
        NSLog(@"%@", title);
      }
      cancelBlock:^{
        NSLog(@"取消");
      }];
  [actionSheet showInView:self.view];
}

- (void)buttonClick4:(id)sender {
  ISActionSheetStyle style = ISActionSheetStyleSystem;
  NSArray* options = @[ @"百度地图", @"高德地图", @"苹果地图" ];
  ISActionSheet* actionSheet = [ISActionSheet actionSheetWithStyle:style
      titleView:[self headView]
      optionsArr:options
      cancelTitle:@"取消"
      selectedBlock:^(NSInteger row) {
        NSString* title = options[row];
        NSLog(@"%@", title);
      }
      cancelBlock:^{
        NSLog(@"取消");
      }];
  [actionSheet showInView:self.view];
}

- (void)buttonClick5:(id)sender {
  ISActionSheetStyle style = ISActionSheetStyleWeChat;
  NSDictionary* dic1 = @{
    NSFontAttributeName : [UIFont systemFontOfSize:18],
    NSForegroundColorAttributeName : [UIColor blackColor]
  };
  NSDictionary* dic2 = @{
    NSFontAttributeName : [UIFont systemFontOfSize:14],
    NSForegroundColorAttributeName : [UIColor colorWithRed:173 / 255.0
                                                     green:175 / 255.0
                                                      blue:190 / 255.0
                                                     alpha:1]
  };
  NSMutableAttributedString* attStr =
      [[NSMutableAttributedString alloc] initWithString:@"用微视拍摄\n"
                                             attributes:dic1];
  NSAttributedString* attStr2 =
      [[NSAttributedString alloc] initWithString:@"推广" attributes:dic2];
  [attStr appendAttributedString:attStr2];
  NSArray* optionsArr = @[ @"从手机相册选择", attStr ];
  _actionSheet = [ISActionSheet actionSheetWithStyle:style
      titleView:[self weChatheadView]
      optionsArr:optionsArr
      cancelTitle:@"取消"
      selectedBlock:^(NSInteger row) {
        NSLog(@"%@", @(row));
      }
      cancelBlock:^{
        NSLog(@"取消");
      }];
  [_actionSheet showInView:self.view];
}

- (UIView*)weChatheadView {
  if (!_weChatheadView) {
    _weChatheadView = [[UIView alloc]
        initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    _weChatheadView.backgroundColor = [UIColor whiteColor];

    NSDictionary* dic1 = @{
      NSFontAttributeName : [UIFont systemFontOfSize:18],
      NSForegroundColorAttributeName : [UIColor blackColor]
    };
    NSDictionary* dic2 = @{
      NSFontAttributeName : [UIFont systemFontOfSize:16],
      NSForegroundColorAttributeName : [UIColor colorWithRed:73 / 255.0
                                                       green:75 / 255.0
                                                        blue:90 / 255.0
                                                       alpha:1]
    };
    NSMutableAttributedString* attStr =
        [[NSMutableAttributedString alloc] initWithString:@"拍摄\n"
                                               attributes:dic1];
    NSAttributedString* attStr2 =
        [[NSAttributedString alloc] initWithString:@"照片或视频"
                                        attributes:dic2];
    [attStr appendAttributedString:attStr2];

    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    btn.showsTouchWhenHighlighted = YES;
    [btn addTarget:self
                  action:@selector(buttonTouchUpInsideClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self
                  action:@selector(buttonHeightClick:)
        forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self
                  action:@selector(buttonDragInClick:)
        forControlEvents:UIControlEventTouchDragInside];
    [btn addTarget:self
                  action:@selector(buttonDragoutSideClick:)
        forControlEvents:UIControlEventTouchDragOutside];
    [btn setAttributedTitle:attStr forState:UIControlStateNormal];
    btn.titleLabel.numberOfLines = 2;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.frame = _weChatheadView.frame;
    [_weChatheadView addSubview:btn];

    UIView* line = [[UIView alloc]
        initWithFrame:CGRectMake(0, 79.5, self.view.bounds.size.width, .5)];
    line.backgroundColor = [UIColor colorWithRed:220 / 255.0
                                           green:220 / 255.0
                                            blue:220 / 255.0
                                           alpha:1];
    [_weChatheadView addSubview:line];
  }
  return _weChatheadView;
}

- (UIView*)headView {
  if (!_headView) {
    _headView = [[UIView alloc]
        initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 80)];
    _headView.backgroundColor = [UIColor whiteColor];

    UILabel* titleLabel = [[UILabel alloc]
        initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width - 20, 30)];
    titleLabel.text = @"请选择导航";
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.textColor = [UIColor colorWithRed:73 / 255.0
                                           green:75 / 255.0
                                            blue:90 / 255.0
                                           alpha:1];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_headView addSubview:titleLabel];

    UILabel* descLabel =
        [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    descLabel.text = @"记住我的选择，不再提示";
    descLabel.font = [UIFont systemFontOfSize:16];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.center = CGPointMake(_headView.center.x, 55);
    [_headView addSubview:descLabel];

    UIButton* selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectedButton.frame =
        CGRectMake(CGRectGetMinX(descLabel.frame) - 25, 40, 30, 30);
    [selectedButton setImage:[UIImage imageNamed:@"unselected"]
                    forState:UIControlStateNormal];
    [selectedButton setImage:[UIImage imageNamed:@"selected"]
                    forState:UIControlStateSelected];
    [selectedButton addTarget:self
                       action:@selector(selectedClick:)
             forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:selectedButton];

    UIView* line = [[UIView alloc]
        initWithFrame:CGRectMake(0, 79.5, self.view.bounds.size.width - 20,
                                 .5)];
    line.backgroundColor = [UIColor colorWithRed:220 / 255.0
                                           green:220 / 255.0
                                            blue:220 / 255.0
                                           alpha:1];
    [_headView addSubview:line];
  }
  return _headView;
}

- (void)selectedClick:(UIButton*)button {
  button.selected = !button.selected;
}

- (void)buttonTouchUpInsideClick:(UIButton*)sender {
  sender.backgroundColor = [UIColor whiteColor];
  if (_actionSheet) {
    [_actionSheet dismiss];
  }
}

- (void)buttonDragInClick:(UIButton*)sender {
  sender.backgroundColor = [UIColor colorWithRed:240 / 255.f
                                           green:240 / 255.f
                                            blue:240 / 255.f
                                           alpha:1];
}

- (void)buttonDragoutSideClick:(UIButton*)sender {
  sender.backgroundColor = [UIColor whiteColor];
}

- (void)buttonHeightClick:(UIButton*)sender {
  sender.backgroundColor = [UIColor colorWithRed:240 / 255.f
                                           green:240 / 255.f
                                            blue:240 / 255.f
                                           alpha:1];
}
@end
