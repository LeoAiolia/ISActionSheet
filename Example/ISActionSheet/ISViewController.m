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

@end

@implementation ISViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake(100, 300, 120, 50);
  button.backgroundColor = [UIColor redColor];
  [button setTitle:@"弹框" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(showActionSheet:)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}

- (void)showActionSheet:(id)sender {
  static NSInteger count = 0;
  count++;

  ISActionSheetStyle style =
      count % 2 == 1 ? ISActionSheetStyleWeChat : ISActionSheetStyleSystem;
  ISActionSheet* actionSheet = [ISActionSheet actionSheetWithStyle:style
      title:@"提示"
      optionsArr:@[ @"11", @"22" ]
      cancelTitle:@"取消"
      selectedBlock:^(NSInteger row, NSString* _Nonnull title) {
        NSLog(@"%@", title);
      }
      cancelBlock:^{
        NSLog(@"取消");
      }];
  [actionSheet showInView:self.view];
}

@end
