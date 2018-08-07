//
//  EncryptionManager.h
//  YB-YH
//
//  Created by Apple on 2018/6/4.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  DES_KEY   @"zcdcom@#"
#define  MD5_KEY   @"zcdcom@#"
#define  KEY_UDID  @"KEY_UDID"

typedef enum : NSUInteger
{
    Encryption_TYPE0,    //不加密
    Encryption_TYPE1,   // uuid
    Encryption_TYPE2,   // token+userid+时间戳
    Encryption_TYPE3,   // token +时间戳
} Encryption_TYPE;


@interface EncryptionManager : NSObject

//md5
+(NSString *) md5: (NSString *) inPutText;
//md5 加盐时间戳
+(NSString *) md5: (NSString *)inPutText key:(NSString *)key;
+(NSString *) md5key: (NSString *)inPutTextKey;

// DES  普通
+(NSString *) encryptUseDES2:(NSString *)plainText key:(NSString *)key;
+(NSString *) encryptUseDES2:(NSString *)plainText;

+(NSString *)decryptUseDES:(NSString *)cipherText;
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;


//获取惟一标识符  uuid
+(NSString *)readuuid;
+(void )removeuuid;

//加密 
+(NSString *)encryptionWithStr:(NSString *)str type:(Encryption_TYPE)type;

@end
