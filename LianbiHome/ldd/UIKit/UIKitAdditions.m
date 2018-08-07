//
//  UIKitAdditions.m
//  T1
//
//  Created by simon on 6/19/14.
//  Copyright (c) 2014 simon. All rights reserved.
//

#import "UIKitAdditions.h"

@interface UIKitAdditions ()

@end

@implementation UIKitAdditions

#pragma mark -
#pragma mark UIView
/*
 * ===============================
 *  UIView
 * ===============================
 */
+ (UIImageView *)imageViewWithImageName:(NSString *)name
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:name];
    return imageView;
}

+ (UIButton *)buttonWithText:(NSString *)text backGroundColor:(UIColor*)bColor
                   textColor:(UIColor *)color
                    fontSize:(float)fontSize
                      target:(id)target
                    selector:(SEL)selector{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    if (bColor) {
        button.backgroundColor = bColor;
    }
    if (fontSize) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)buttonWithImage:(UIImage *)image
                highlightImage:(UIImage *)hiImage
                        target:(id)target
                    selector:(SEL)selector
{
    UIButton *button = [UIButton new];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:image forState:UIControlStateNormal];
//    [button setImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:hiImage forState:UIControlStateSelected];
    return button;
}
+ (UIButton *)buttonSetImage:(NSString *)imageName
                       target:(id)target
                     selector:(SEL)selector{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}

+ (UILabel*)labelWithText:(NSString*)text fontSize:(float)fontSize{
    UILabel* aLabel = [UILabel new];
    aLabel.text = text;
    if (fontSize) {
        aLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    aLabel.textColor = [UIColor whiteColor];
    return aLabel;
}
+ (UILabel*)labelWithBlackText:(NSString*)text fontSize:(float)fontSize{
    UILabel* aLabel = [self labelWithText:text fontSize:fontSize];
    aLabel.textColor = [UIColor blackColor];
    return aLabel;    
}
+ (UILabel*)labelWithText:(NSString*)text textColor:(UIColor*)textColor
                 alignment:(NSTextAlignment)alignment fontSize:(float)fontSize
{
    UILabel* aLabel = [self labelWithText:text fontSize:fontSize];
    aLabel.textColor = textColor;
    aLabel.textAlignment = alignment;
    return aLabel;
}
+ (UILabel*)labelWithText:(NSString*)text leftTextColor:(UIColor*)leftColor rightTextColor:(UIColor*)rightColor fromIndex:(NSInteger)index fontSize:(float)fontSize{
    UILabel* aLabel = [[UILabel alloc] init];
    aLabel.font = [UIFont systemFontOfSize:fontSize];
    //富文本
    NSMutableAttributedString *mutableAttriteStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString * attriteStr1 = [[NSAttributedString alloc] initWithString:[text substringWithRange:NSMakeRange(0, index)] attributes:@{NSForegroundColorAttributeName : leftColor}];
    NSAttributedString * attributeStr2 = [[NSAttributedString alloc] initWithString:[text substringWithRange:NSMakeRange(index , text.length - index)] attributes:@{NSForegroundColorAttributeName : rightColor}];
    [mutableAttriteStr appendAttributedString:attriteStr1];
    [mutableAttriteStr appendAttributedString:attributeStr2];
    aLabel.attributedText = mutableAttriteStr;
    return aLabel;
}
+ (UILabel*)mutableLabel:(UILabel *)label content:(NSString*)text leftTextColor:(UIColor*)leftColor rightTextColor:(UIColor*)rightColor fromIndex:(NSInteger)index fontSize:(float)fontSize{
    //富文本
    NSMutableAttributedString *mutableAttriteStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString * attriteStr1 = [[NSAttributedString alloc] initWithString:[text substringWithRange:NSMakeRange(0, index)] attributes:@{NSForegroundColorAttributeName : leftColor}];
    NSAttributedString * attributeStr2 = [[NSAttributedString alloc] initWithString:[text substringWithRange:NSMakeRange(index , text.length - index)] attributes:@{NSForegroundColorAttributeName : rightColor}];
    [mutableAttriteStr appendAttributedString:attriteStr1];
    [mutableAttriteStr appendAttributedString:attributeStr2];
    label.attributedText = mutableAttriteStr;
    return label;
}


/*
 * 计算文本的高度
 */
+(float)calculateTextHeightWithFont:(UIFont*)font content:(NSString*)content constraintSize:(CGSize)constraintSize
{
    ObjectForTextCalculate* obj = [ObjectForTextCalculate shared];
    float height = [obj calculateTextHeightWithFont:font content:content constraintSize:constraintSize];
    return height;
}

/*
 * 计算文本有几行文字
 */
+(int)calculateNumberOfLinesWithFont:(UIFont*)font content:(NSString*)content constraintSize:(CGSize)constraintSize
{
    CGFloat unitHeight  = [self calculateTextHeightWithFont:font content:@"A" constraintSize:constraintSize];
    CGFloat blockHeight = [self calculateTextHeightWithFont:font content:content constraintSize:constraintSize];
    int numberOfLines   =  ceilf(blockHeight / unitHeight);
    return numberOfLines;
}

/*
 * 计算单行文字的宽度
 * font:字体
 */
+(float)calculateTextWidthWithFont:(UIFont*)font content:(NSString*)content
{
    NSDictionary *dicAttr = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize textSize = [content sizeWithAttributes:dicAttr];
    return textSize.width;
}


/*
 * 计算单行文字的宽度
 * fontSize:系统字体大小
 */
+(float)calculateTextWidthWithSystemFontSize:(CGFloat)fontSize content:(NSString*)content
{
    UIFont* font = [UIFont systemFontOfSize:fontSize];
    float textWidth = [self calculateTextWidthWithFont:font content:content];
    return textWidth;
}


@end


//////////////////////////////////////////////////
//一个为了计算文本高度的对象
@implementation ObjectForTextCalculate
-(id)init
{
    if (self = [super init])
    {
        _textView = [[UITextView alloc]init];
        _textView.editable = NO;
        _textView.scrollEnabled = NO;
        _textView.textAlignment = NSTextAlignmentNatural;
    }
    return self;
}

+ (id) alloc
{
    @synchronized(self)     {
        NSAssert(shared == nil, @"Attempted to allocate a second instance of a singleton.");
        return [super alloc];
    }
    return nil;
}

static ObjectForTextCalculate* shared;
+ (ObjectForTextCalculate*) shared
{
    @synchronized(self){
        if (!shared) {
            shared = [[ObjectForTextCalculate alloc] init];
        }
    }
    return shared;
}

-(float)calculateTextHeightWithFont:(UIFont*)font content:(NSString*)content constraintSize:(CGSize)constraintSize
{
    _textView.font = font;
    _textView.text = content;
    CGSize size = [_textView sizeThatFits:constraintSize];  //内容Size大小
    return size.height;
}
@end
