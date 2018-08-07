//
//  BaseViewController.h
//  XM
//
//  Created by Macintosh HD on 16/4/16.
//  Copyright © 2016年 XM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EncryptionManager.h"
#import "NavView.h"



NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController <NavViewDelegate>

@property (nonatomic, retain, readonly) NSDictionary *dict;

/**
 *  A custom navigation bar
 */
@property(nonatomic,readonly)NavView * navView;
/**
 *  跟控制器创建的方法
 *
 *  @param dict json
 *
 *  @return self
 */
- (instancetype)initWithDict:(NSDictionary *)dict ;
/**
 *  带返回的创建
 *
 *  @param str 自定义导航栏的文字
 *
 *  @return self
 */
-(instancetype)initWithNavTitle:(nullable NSString *)str;


-(instancetype)initWithNavTitle:(nullable NSString *)str data:(id)data;

@property(nonatomic,copy)NSString * titlestr;

/**
 *  post 下载数据  不保存缓存
 *
 *  @param str   str   下载地址
 *  @param dict  上传的josn
 *  @param index index  index < 0  下载的地址不拼接  index > 0 拼接地址   index>100  数据解析出来是数组  <100是josn >50 打印数据
 */
-(void)postdownDatas:(NSString *)str adddict:(nullable NSDictionary *)dict index:(int)index ;

-(void)postdownDatas:(NSString *)str withdict:(NSDictionary *)dict index:(int)index;

-(void)postdownDatas:(NSString *)str withdict:(NSDictionary *)dict index:(int)index type:(Encryption_TYPE)type;

-(void)getDownDatas:(NSString *)str withdict:(NSDictionary *)dict index:(int)index type:(Encryption_TYPE)type;
/**
 *  解析数据  子类要重写
 *  非正常的数据解析
 *  @param responseDict 下载的数据
 *  @param index        标示
 */
-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index;
/**
 *  解析数据 子类要重写
 *  index>100  解析出来的是数组
 *  @param dataArray 下载的数据
 *  @param index     标示
 */
-(void)readDowndatawithArray:(NSArray *)dataArray index:(int)index;
/**
 *  错误数据的解析
 *
 *  @param error 错误信息
 *  @param index 标示
 */
-(void)duxucuowu:(NSError *)error index:(int)index;
-(void)readcuowu:(NSString *)cuowu index:(int)index;
/**
 *  下载数据 刷新小圈
 */
-(void)createShuaxin;
/**
 *  刷新小圈
 */
@property(nonatomic,retain)UIActivityIndicatorView   *actView;

-(void)popControllerwithstr:(NSString *)str title:(NSString *)title;

-(void)shuaxinView;
//默认页面进来下载数据的方法
-(void)downDatas;
//这是初始化下载数据的方法
-(void)downData;
//创建导航栏  子类必要调用父类的方法
-(void)createNavView;
//创建view
-(void)createView;
//初始化一些数据  子类必要调用父类的方法
-(void)Initialize;

//导航栏的高度
@property (nonatomic,assign,readonly)float nav_h ;
//适配x的下方空白高度
@property (nonatomic,assign,readonly)float tab_h ;
//监听app从后台进入前台
-(void)addUIApplicationDidBecomeActiveNotification ;
-(void)removeUIApplicationDidBecomeActiveNotification ;
//挂在后台进入前台
-(void)Fromthebackground;

@property(nonatomic,assign)BOOL isRootViewController;

-(void)addListeningkeyboard;

-(void)stopListeningkeyboard;
@end


NS_ASSUME_NONNULL_END

