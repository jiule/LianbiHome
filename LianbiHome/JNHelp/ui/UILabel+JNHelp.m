//
//  UILabel+JNHelp.m
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "UILabel+JNHelp.h"
#import "NSString+Helpr.h"

@implementation UILabel (JNHelp)

-(instancetype)initWithFrame:(CGRect)frame text:(nullable NSString *)text
{
    return [self initWithFrame:frame text:text textColor:nil];
}

-(instancetype)initWithFrame:(CGRect)frame text:(nullable NSString *)text textColor:(nullable UIColor *)textColor
{
    return  [self initWithFrame:frame text:text textColor:textColor textSize:JN_HH(18) index:0];
}

-(instancetype)initWithFrame:(CGRect)frame text:(nullable NSString *)text textColor:(nullable UIColor *)textColor textSize:(float)textSize index:(int)index
{
   // self = [super initWithFrame:frame];
    if (self == [self initWithFrame:frame]) {
        self.text = text;
        self.font = [UIFont systemFontOfSize:textSize];
        if (textColor) {
            self.textColor = textColor;
        }else {
            self.textColor = COLOR_WHITE;
        }
        if (index == 0) {
            self.textAlignment = NSTextAlignmentLeft;
        }else if(index == 2)
        {
            self.textAlignment = NSTextAlignmentRight;
        }else {
            self.textAlignment  = NSTextAlignmentCenter;
        }
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text type:(JNLabel_TYPE)type index:(int)index
{
    if (type == UILABEL_0 || type == UILABEL_1) {
        return  [self initWithFrame:frame text:text textColor:COLOR_BL_1 textSize:UILABEL_BZ_1 index:index];
    }else if(type == UILABEL_2)
    {
        return  [self initWithFrame:frame text:text textColor:COLOR_BL_2 textSize:UILABEL_BZ_2 index:index];
    }else if(type == UILABEL_3)
    {
        return  [self initWithFrame:frame text:text textColor:COLOR_BL_3 textSize:UILABEL_BZ_3 index:index];
    }else if(type == UILABEL_4)
    {
        return  [self initWithFrame:frame text:text textColor:COLOR_BL_4 textSize:UILABEL_BZ_4 index:index];
    }else if(type == UILABEL_5)
    {
        return  [self initWithFrame:frame text:text textColor:COLOR_BL_5 textSize:UILABEL_BZ_5 index:index];
    }else if (type == UILABEL_6)
    {
        return  [self initWithFrame:frame text:text textColor:COLOR_BL_6 textSize:UILABEL_BZ_6 index:index];
    }
    return  nil;
}

-(instancetype)initWithJNFrame:(CGRect)JnFrame text:(NSString *)text type:(JNLabel_TYPE)type index:(int)index;
{
    return [self initWithFrame:CGFrameWithJNFrame(JnFrame) text:text type:type index:index];
}

-(instancetype)initWithJNFrame:(CGRect)JnFrame text:(NSString *)text
{
    return  [self initWithJNFrame:JnFrame text:text type:0 index:0];
}

+ (UILabel *)labelWithtext:(NSString *)text width:(float)width x:(float)x y:(float)y
{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(x, 0, width, 100) text:text];
    int i = 1;  float size = JN_HH(2);
    do {
        UIFont * font = [UIFont systemFontOfSize:size];
        float w = [NSString widthOfString:text font:font height:100];
        if (w > width) {
            label.font = [UIFont systemFontOfSize:size - 0.5];
            i = 0;
        }else if (w == width){
            label.font = [UIFont systemFontOfSize:size ];
            i = 0;
        }else {
            size += 0.5;
        }
    } while (i == 1);

//    [label setY:y];
//    [label setH:[NSString heightOfString:label.text font:label.font width:label.bounds.size.width]];
    return label;
}

//改变行间距
+(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font  Line:(float)line para:(float)para
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = line; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(para)
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

-(void)setSpaceLine:(float)line para:(float)para{
    [UILabel setLabelSpace:self withValue:self.text withFont:self.font Line:line para:para];
}

+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width Line:(float)line para:(float)para
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = line;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(para)
                          };
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

-(void)addTextArrays:(NSArray <NSString *>*)textArrays colorArrays:(NSArray <UIColor *>*)colorArrays numArrays:(NSArray <NSNumber * >*)numArrays up:(BOOL)up
{
    if (textArrays.count != colorArrays.count ||  colorArrays.count != numArrays.count) {
        return ;
    }
    NSString * str = @"";  float h = 0;
    for (int i = 0 ; i < textArrays.count; i++) {
        str = [NSString stringWithFormat:@"%@%@",str,textArrays[i]];
    }
    NSMutableAttributedString  * str1 = [[NSMutableAttributedString alloc]initWithString:str];
    for (int i = 0; i < colorArrays.count; i++) {
        [str1 addAttribute:NSForegroundColorAttributeName value:[[UIColor alloc]initWithCGColor:colorArrays[colorArrays.count - i - 1].CGColor] range:NSMakeRange(0, str.length - h)];
        [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[numArrays[numArrays.count -i -1]floatValue]] range:NSMakeRange(0, str.length - h)];
        h += textArrays[textArrays.count -i -1].length;
    }

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentJustified];
    [str1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];

    self.text = nil ;
    self.attributedText = str1;
    
}

- (void)adjusts
{
    int i = 1;  float size = JN_HH(2);
    do {
        UIFont * font = [UIFont systemFontOfSize:size];
        float w = [NSString widthOfString:self.text font:font height:100];
        if (w > self.width) {
            self.font = [UIFont systemFontOfSize:size - 0.5];
            i = 0;
        }else if (w == self.width){
            self.font = [UIFont systemFontOfSize:size ];
            i = 0;
        }else {
            size += 0.5;
        }
    } while (i == 1);
 //   [self setH:[NSString heightOfString:self.text font:self.font width:self.bounds.size.width]];
}
@end
