//
//  MyActivityIndicatorViewManager.h
//  Q-Lady
//
//  Created by Apple on 17/2/17.
//  Copyright © 2017年 Q-Lady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyActivityIndicatorView.h"

@interface MyActivityIndicatorViewManager : NSObject

XMGSingletoH

+(void)showActivityIndicatorViewWithName:(NSString *)name Style:(ActivityIndicatorStyle)style ;

+(void)showActivityIndicatorViewWithName:(NSString *)name Style:(ActivityIndicatorStyle)style vc:(UIViewController *)vc;

+(void)showActivityIndicatorViewWithName:(NSString *)name Style:(ActivityIndicatorStyle)style  withBlock:(void(^)(void))sendBlock;

+(void)remove;

@end
