//
//  ISActionSheet.h
//  ISActionSheet
//
//  Created by 润 on 2017/8/25.
//  Copyright © 2017年 润. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ISActionSheetStyle) {
    ISActionSheetStyleSystem,
    ISActionSheetStyleWeChat
};

@interface ISActionSheet : UIView

/**
 actionSheet
 
 @param style actionSheet的样式，微信 或 系统
 @param titleView 自定义actionSheet的头部视图View
 @param optionsArr 条目
 @param cancelTitle 取消button名字
 @param selectedBlock 选中条目的点击事件
 @param cancelBlock 取消按钮的回调
 @return ISActionSheet对象
 */
+ (instancetype)actionSheetWithStyle:(ISActionSheetStyle)style
                           titleView:(nullable UIView *)titleView
                          optionsArr:(NSArray<NSString *> *)optionsArr
                         cancelTitle:(NSString *)cancelTitle
                       selectedBlock:(nullable void(^)(NSInteger row,NSString *title))selectedBlock
                         cancelBlock:(nullable void(^)(void))cancelBlock;

- (instancetype)initWithActionStyle:(ISActionSheetStyle)style
                          titleView:(nullable UIView *)titleView
                         optionsArr:(NSArray<NSString *> *)optionsArr
                        cancelTitle:(NSString *)cancelTitle
                      selectedBlock:(nullable void(^)(NSInteger row,NSString *title))selectedBlock
                        cancelBlock:(nullable void(^)(void))cancelBlock;
/**
 actionSheet
 
 @param style actionSheet的样式，微信 或 系统
 @param title 标题
 @param optionsArr 条目数据源数组
 @param cancelTitle 取消button名字
 @param selectedBlock 选中条目的点击事件
 @param cancelBlock 取消按钮的回调
 @return ISActionSheet对象
 */
+ (instancetype)actionSheetWithStyle:(ISActionSheetStyle)style
                               title:(nullable NSString *)title
                          optionsArr:(NSArray<NSString *> *)optionsArr
                         cancelTitle:(NSString *)cancelTitle
                       selectedBlock:(nullable void(^)(NSInteger row,NSString *title))selectedBlock
                         cancelBlock:(nullable void(^)(void))cancelBlock;

- (instancetype)initWithActionStyle:(ISActionSheetStyle)style
                              title:(nullable NSString *)title
                         optionsArr:(NSArray<NSString *> *)optionsArr
                        cancelTitle:(NSString *)cancelTitle
                      selectedBlock:(nullable void(^)(NSInteger row,NSString *title))selectedBlock
                        cancelBlock:(nullable void(^)(void))cancelBlock;


/**
 设置 optionsArr内 某个标题的颜色，因此index必须小于optionsArr的count

 @param color 颜色不可为空
 @param index 设置第index个titile的颜色
 */
- (void)setTitleColor:(UIColor *)color atIndex:(NSInteger)index;
/**
 将ISActionSheet展示在view上，view为nil是，默认是window

 @param view 父view
 */
- (void)showInView:(nullable UIView *)view;
- (void)dismiss;

@end
NS_ASSUME_NONNULL_END
