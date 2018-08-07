//
//  MyNetworkingHelp.h
//  JNTest
//
//  Created by Apple on 2018/4/13.
//  Copyright © 2018年 YHCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EncryptionManager.h"

@interface MyNetworkingHelp : NSObject

/*
 * 处理请求到的数据  一般处理 格式是否正确 什么的 token 是否需要重新申请 修改MyNetworkingModel的值
 */
+(BOOL)dealWithResponseDict:(NSDictionary *)responseDict;

/*
 * 请求数据的json  是否需要添加什么token 健的  在 getSidDict方法 设置添加的健
 */
+(NSDictionary *)addSidWithDict:(NSDictionary *)dict;
+(NSString *)addSidStringWithDict:(NSDictionary *)dict;
+(NSDictionary *)addSidWithDict:(NSDictionary *)dict type:(Encryption_TYPE)type;

/*
 *  设置每次请求必须添加的键 或者更新的值  具体更新的值 在MyNetworkingModel 定义
 */
+(NSDictionary *)getSidDict;

@end
