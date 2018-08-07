//
//  ShufflingView.h
//  i-qlady
//
//  Created by Apple on 17/4/24.
//  Copyright © 2017年 i-qlady. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShufflingView ;

typedef void (^didShuffling)(ShufflingView * shufflingView,int index);


@interface ShufflingView : UIView

-(void)showWithImageUrlPaths:(NSArray *)urlPaths didShuffling:(didShuffling)shuffling;
-(void)showWithImageImagePaths:(NSArray *)imagePaths didShuffling:(didShuffling)shuffling;

@property(nonatomic,retain)NSArray * imageArray;

-(void)startTimer;

-(void)endTimer;

-(void)setStyle:(int)style;

@property(nonatomic,assign)float time;

@property(nonatomic,assign)int type;

@end


