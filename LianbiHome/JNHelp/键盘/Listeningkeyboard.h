//
//   必须要先初始化  startlistening
//
//
//
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Danli.h"
/**
 *  键盘出来
 */
typedef void (^keyboardWillShow)(CGFloat h);
/**
 *  键盘下去
 */
typedef void (^keyboardWillHide)(CGFloat h);

@protocol ListeningkeyboardDelegate <NSObject>
/**
 *  出来
 */
-(void)keyboardWillShow:(CGFloat)h;
/**
 *  键盘下去
 */
-(void)keyboardWillHide:(CGFloat)h;

@end

NS_ASSUME_NONNULL_BEGIN
@interface Listeningkeyboard : NSObject
XMGSingletoH
/**
 *  初始化
 */
-(void)startlistening;
/**
 *  移除监听键盘
 */
-(void)stoplistening;
/**
 *
 *
 *  @param boardWillShow 键盘起来
 *  @param boardWillHide 键盘下去
 */
-(void)startlisteningblockcompletion:( keyboardWillShow)boardWillShow keyboard:(keyboardWillHide)boardWillHide;
-(void)removelisteningblockcompletion;
/**
 *  代理
 */
@property(nonatomic,assign)id<ListeningkeyboardDelegate>delegate;

+(void)endEditing;

@end
NS_ASSUME_NONNULL_END
