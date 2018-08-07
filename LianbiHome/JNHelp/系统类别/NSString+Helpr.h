//---------------------------------------------
//
//
//
//
//
//
//
//----------------------------------------------

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import<CommonCrypto/CommonDigest.h>

@interface NSString (MyHelpr)
/*
 * 判断是不是手机号码
 */
+ (BOOL) justMobile:(NSString *)mobile;
/*
 * md5 加密
 */
+(NSString *) md5: (NSString *) inPutText;
/*
 * 1970到现在的时间
 */
+(NSString *)timerWith1970;
/*
 * 判断是不是邮箱
 */
+ (BOOL) justEmail:(NSString *)email;
/**
 *  判断字符串 是否可以为用户名
 *
 *  @param name 字符串
 *
 *  @return yes  可以为用户名  no 不能为密码
 */
+ (BOOL) justUserName:(NSString *)name;
/**
 *  判断字符串 是否可以为密码
 *
 *  @param passWord 字符串
 *
 *  @return yes  可以为密码  no 不能为密码
 */
+ (BOOL) justPassword:(NSString *)passWord;
/**
 *  判断一个字符串是否包含汉字
 *
 *  @param string 字符串
 *
 *  @return  yes 不包含  no 包含
 */
+(BOOL)isChinese:(NSString * )string;

/**
 *  计算字符串的宽度
 *
 *  @param string 字符串
 *  @param font   字体大小
 *  @param height 高度
 *
 *  @return 宽度
 */
+(CGFloat)widthOfString:(NSString * )string font:(UIFont* )font height:( CGFloat )height;
-(CGFloat)widthOfFont:(UIFont * )font height:( CGFloat )height;
/**
 *  计算字符串的高度
 *
 *  @param string 字符串
 *  @param font   字体大小
 *  @param width  宽度长度
 *
 *  @return 高度
 */
+(CGFloat)heightOfString:(NSString * )string font:(UIFont* )font width:( CGFloat)width;
-(CGFloat)heightOfFont:(UIFont* )font width:( CGFloat)width;
-(CGFloat)HeightOfFont:(UIFont* )font width:( CGFloat)width;
/**
 *  字典转字符串
 */
+(NSString*)DataTOjsonString:(id)object;
/**
 *  字符串转json
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
- (NSDictionary *)dictionaryWithJson;
//判断有木有汉子 并转换
+(NSString *)isStringWithChinese:(NSString *)string;
//计算字符串的字节长度
- (int)convertToByte;
//字符串反序排列
-(NSString *)Antitone;

//把字符串 放到键盘粘贴板上
-(void)pasteboard;
+(NSString *)readpasteboard;

+(NSString *)userIphoneHaoma:(NSString *)iphone;

@end
