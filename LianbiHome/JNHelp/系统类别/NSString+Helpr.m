

#import "NSString+Helpr.h"

@implementation NSString (MyHelpr)

+ (BOOL) justMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


+(NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+(NSString *)timerWith1970
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970] ;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

+ (BOOL) justEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//用户名
+ (BOOL) justUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{4,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
//密码
+ (BOOL) justPassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9\x21-\x7e]{6,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
//判断是不是汉字
+(BOOL)isChinese:(NSString *)string{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ matches %@",string, match];
    return [predicate evaluateWithObject:self];
}

//字符串文字的长度
+(CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height
{
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width;
}
-(CGFloat)widthOfFont:(UIFont* )font height:( CGFloat )height{
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect=[self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width;
}

//字符串的宽度
+(CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    CGRect bounds1 = [@"我" boundingRectWithSize:CGSizeMake(width - 5, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height + bounds.size.height / bounds1.size.height;
}
-(CGFloat)heightOfFont:(UIFont* )font width:( CGFloat)width
{
    CGRect bounds;
    NSDictionary * parameterDict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds = [self boundingRectWithSize:CGSizeMake(width - 5, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
         CGRect bounds1 = [@"1" boundingRectWithSize:CGSizeMake(width - 5, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
       return bounds.size.height + bounds.size.height /   bounds1.size.height;
}

-(CGFloat)HeightOfFont:(UIFont* )font width:( CGFloat)width
{
    CGRect bounds;
    NSDictionary * parameterDict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds = [self boundingRectWithSize:CGSizeMake(width - 5, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height;
}

+(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        //  MyLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }    
    return jsonString;
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
-(NSDictionary *)dictionaryWithJson
{
    return [NSString dictionaryWithJsonString:self];
}

+(NSString *)isStringWithChinese:(NSString *)string{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ matches %@",string, match];
    if ([predicate evaluateWithObject:string]) {
        return string ;
    }

    NSLog(@"%@", [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);

    return  [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (int)convertToByte {
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength + 1)/2;
}

-(NSString *)Antitone
{
    NSString * rerurnStr = @"";
    for (int i = 0 ; i < self.length; i++) {
        rerurnStr = [NSString stringWithFormat:@"%@%@",rerurnStr,[self substringWithRange:NSMakeRange(self.length - 1-i, 1)]];
    }
    return rerurnStr;
}


-(void)pasteboard
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self;
}

+(NSString *)readpasteboard
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    return    pasteboard.string ;
}

+(NSString *)userIphoneHaoma:(NSString *)iphone
{
    if (iphone.length != 11) {
        return iphone;
    }
    return [NSString stringWithFormat:@"%@****%@",[iphone substringToIndex:3],[iphone substringFromIndex:8]];
}
@end
