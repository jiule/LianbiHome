//
//  EncryptionManager.m
//  YB-YH
//
//  Created by Apple on 2018/6/4.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "EncryptionManager.h"
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>

@implementation EncryptionManager

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
+(NSString *) md5: (NSString *)inPutText key:(NSString *)key
{
    return  [[self class]md5:[NSString stringWithFormat:@"%@%@%@",[[self class]timer],inPutText,key]];
}

+(NSString *) md5key: (NSString *)inPutTextKey
{
    return  [self md5:inPutTextKey key:MD5_KEY];
}

+(NSString *)timer
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970] ;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

+(NSString *) encryptUseDES2:(NSString *)plainText
{
    return [self encryptUseDES2:plainText key:DES_KEY];
}

+(NSString *) encryptUseDES2:(NSString *)plainText key:(NSString *)key{
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    size_t dataLength = [plainText length];

    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;

    bufferPtrSize = (dataLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);

    NSString *testString = key;
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    Byte *iv = (Byte *)[testData bytes];

    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          (void *)bufferPtr, bufferPtrSize,
                                          &movedBytes);
    if (cryptStatus == kCCSuccess) {

        ciphertext= [[self class] parseByte2HexString:bufferPtr :(int)movedBytes];

    }
    ciphertext=[ciphertext uppercaseString];//字符变大写
    return ciphertext ;
}

+(NSString *) parseByte2HexString:(Byte *) bytes  :(int)len{
    NSString *hexStr = @"";
    if(bytes)
    {
        for(int i=0;i<len;i++)
        {
            NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff]; ///16进制数
            if([newHexStr length]==1)
                hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
            else
            {
                hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
            }
        }
    }
    return hexStr;
}

+(NSString *)decryptUseDES:(NSString *)cipherText
{
    return  [self decryptUseDES:cipherText key:DES_KEY];
}

+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key
{
    NSData* cipherData = [[self class] convertHexStrToData:[cipherText lowercaseString]];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    NSString *testString = key;
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    Byte *iv = (Byte *)[testData bytes];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}

+ (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }

    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];

        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];

        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

//----------------------------------------uuid----------------------------------------

+(NSString *)readuuid
{
    NSString * uuid = [self readKeychainValue:KEY_UDID];
//    NSLog(@"%@",uuid);
    if (!uuid) {
        uuid = [self uuid];
        [self saveKeychainValue:[self encryptUseDES2: uuid key:KEY_UDID] key:KEY_UDID];
    }else {
        uuid = [self decryptUseDES:uuid key:KEY_UDID];
    }
    return uuid;
}
+(void)removeuuid
{
    [self deleteKeychainValue:KEY_UDID];
}
//生成一个uuid
+(NSString *)uuid
{
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    return identifierForVendor;
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,
            (__bridge_transfer id)kSecClass,service,
            (__bridge_transfer id)kSecAttrService,service,
            (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,
            (__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey{
    NSMutableDictionary * keychainQuery = [self getKeychainQuery:sKey];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:sValue] forKey:(__bridge_transfer id)kSecValueData];
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}

+ (NSString *)readKeychainValue:(NSString *)sKey
{
    NSString *ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:sKey];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = (NSString *)[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", sKey, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)deleteKeychainValue:(NSString *)sKey
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:sKey];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

//对于des加密过后的一种排序 得到一个新的字符串
/*
 *  前40位字符串 反序排序   后40位 根据  01234ABCDEFGHIJKLMNOPQRSTUVWXYZ56789  交换   在后20位反序
 */
+(NSString *)DES2WithDesStr:(NSString *)Str
{
    if (Str.length != 80) {
        NSLog(@"输入的字符串长度不对====%@",Str);
        return  nil;
    }
    NSString * str40 = [Str substringToIndex:40];
    str40 = [str40 Antitone];
    NSString * str80 = [Str substringFromIndex:40];
    str80 = [self des80WithStr:str80];
    NSString *  str20 = [str80 substringFromIndex:20];
    str20 = [str20 Antitone];
    str80 = [str80 substringToIndex:20];
    return [NSString stringWithFormat:@"%@%@%@",str40,str80,str20];
}

+(NSString *)des80WithStr:(NSString *)str80
{
    NSString * str40 = @"";
    for (int i =  0;  i < str80.length; i++) {
        NSString * str = [str80 substringWithRange:NSMakeRange(i, 1)];
        str40 = [NSString stringWithFormat:@"%@%@",str40,[self charWithStr:str]];
    }
    return  str40;
}

+(NSString *)charWithStr:(NSString *)str
{
    if (str.length != 1) {
        return @"0";
    }
    NSString * retureStr = @"01234ABCDEFGHIJKLMNOPQRSTUVWXYZ56789";
    NSRange index = [retureStr rangeOfString:str];
    if ( index.location <= retureStr.length) {
        return [retureStr substringWithRange:NSMakeRange(retureStr.length - index.location-1, 1)];
    }
    return @"0";
}

+(NSString *)encryptionWithStr:(NSString *)str type:(Encryption_TYPE)type
{
    if (type == Encryption_TYPE1) {
        return [self encryptUseDES2:str];
    }else if(type == Encryption_TYPE2)
    {
        return [self md5:str];
    }else if(type == Encryption_TYPE3)
    {
        NSString * edcStrkey = [EncryptionManager encryptUseDES2:str];
        NSString * dec11 = [EncryptionManager DES2WithDesStr:edcStrkey];
        return  [EncryptionManager md5:dec11];
    }
    return str;
}

@end
