//
//  CALayer+Helpr.m
//  i-qlady
//
//  Created by Apple on 2018/1/19.
//  Copyright © 2018年 i-qlady. All rights reserved.
//

#import "CALayer+Helpr.h"

@implementation CALayer (Helpr)

+(CAShapeLayer *)dw_radianBottomLayerWithFrame:(CGRect)frame
{
    return [self dw_radianBottomLayerWithFrame:frame strokeColor:[UIColor greenColor] capRound:YES lineWidth:5];
}

+(CAShapeLayer *)dw_radianBottomLayerWithFrame:(CGRect)frame strokeColor:(UIColor *)strokeColor capRound:(BOOL)isRound lineWidth:(float)width
{
    UIBezierPath *bottomPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2, frame.size.height/2)
                                                              radius:frame.size.width * 0.5
                                                          startAngle:DEGREES_TO_RADIANS(-90)
                                                            endAngle:DEGREES_TO_RADIANS(270)
                                                           clockwise:YES];
    CAShapeLayer * bottomLayer = [CAShapeLayer layer];
    bottomLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    bottomLayer.fillColor = [UIColor clearColor].CGColor;
    bottomLayer.strokeColor = strokeColor.CGColor;
    if (isRound) {
        bottomLayer.lineCap = kCALineCapRound;
    }
    bottomLayer.lineWidth = width;
    bottomLayer.path = [bottomPath CGPath];
    return bottomLayer;

}

+(CAShapeLayer *)dw_radianProgressLayerWithFrame:(CGRect)frame strokeColor:(UIColor *)strokeColor capRound:(BOOL)isRound lineWidth:(float)width
{
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2, frame.size.height/2)
                                                                radius:frame.size.width * 0.5
                                                            startAngle:DEGREES_TO_RADIANS(-90)
                                                              endAngle:DEGREES_TO_RADIANS(270)
                                                             clockwise:YES];
    CAShapeLayer * progressLayer = [CAShapeLayer layer];
    progressLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    progressLayer.fillColor =  [UIColor clearColor].CGColor;
    progressLayer.strokeColor  = strokeColor.CGColor;
    if (isRound) {
        progressLayer.lineCap = kCALineCapRound;
    }
    progressLayer.lineWidth = width;
    progressLayer.path = [progressPath CGPath];
    progressLayer.strokeEnd = 0;
    return progressLayer;
}

+(UIImageView *)dw_radianCursorImageViewWithFrame:(CGRect)frame image:(UIImage *)image dotDiameter:(float)dotDiameter
{
    UIImageView * curImageView = [[UIImageView alloc]init];
    curImageView.frame = CGRectMake(0, 0, dotDiameter, dotDiameter);
    CGFloat centerX = frame.size.width/2 + dotDiameter * 0.5 * cosf(DEGREES_TO_RADIANS(-90));
    CGFloat centerY = frame.size.width/2 + dotDiameter * 0.5 * sinf(DEGREES_TO_RADIANS(270));
    curImageView.center = CGPointMake(centerX, centerY);
    curImageView.layer.cornerRadius = dotDiameter/2;
    [curImageView setImage:image];
    return curImageView;
}
@end
