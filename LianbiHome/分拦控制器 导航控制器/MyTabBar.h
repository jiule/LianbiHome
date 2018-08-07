//
//  MyTabBar.h
//  XM
//
//  Created by Macintosh HD on 16/4/16.
//  Copyright © 2016年 XM. All rights reserved.
//

#define label_color         COLOR_B3
#define label_sel_color     COLOR_B2

#import <UIKit/UIKit.h>



@class MyTabBar;

@protocol MyTabBarDelegate <NSObject>

@optional
- (void)tabBar:(MyTabBar *)tabBar didSelectItemWithIndex:(NSUInteger)toIndex;

- (void)tabBar:(MyTabBar *)tabBar didSelectItemWithIndex:(NSUInteger)toIndex fromIndex:(NSUInteger)fromIndex;

@end

@interface MyTabBar : UIImageView

@property(nonatomic,assign)int index1;

@property (nonatomic, assign) id <MyTabBarDelegate> delegate;

/**
 *  创建分栏按钮，用参数1和参数2指定的图片
 *
 *  @param imageName    普通状态下的显示图片
 *  @param selImageName 选中状态下的显示图片
 */
- (void)addItemWithImageName:(NSString *)imageName selImageName:(NSString *)selImageName name:(NSString *)name;


@end
