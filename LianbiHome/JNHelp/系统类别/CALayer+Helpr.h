//
//  CALayer+Helpr.h
//  i-qlady
//
//  Created by Apple on 2018/1/19.
//  Copyright © 2018年 i-qlady. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


#define DEGREES_TO_RADIANS(degrees) ((degrees)*M_PI)/180

@interface CALayer (Helpr)


//弧度的 CAShapeLayer  默认圆角  颜色 green 宽度 6
+(CAShapeLayer *)dw_radianBottomLayerWithFrame:(CGRect)frame;

+(CAShapeLayer *)dw_radianBottomLayerWithFrame:(CGRect)frame strokeColor:(UIColor *)strokeColor capRound:(BOOL)isRound lineWidth:(float)width;

//光标进度
+(CAShapeLayer *)dw_radianProgressLayerWithFrame:(CGRect)frame strokeColor:(UIColor *)strokeColor capRound:(BOOL)isRound lineWidth:(float)width;
//光标
+(UIImageView *)dw_radianCursorImageViewWithFrame:(CGRect)frame image:(UIImage *)image dotDiameter:(float)dotDiameter;
@end
