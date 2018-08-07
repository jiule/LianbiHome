//
//  MyNetworkingManager.h
//  Q-Lady
//
//  Created by Apple on 17/2/7.
//  Copyright © 2017年 Q-Lady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "EncryptionManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger{
    GET,
    POST,
} requestMode;

@interface MyNetworkingManager : NSObject

XMGSingletoH

// post request
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(nullable id )parameters
                      progress:(nullable void (^)(NSProgress * _Nonnull ))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                withparameters:(nullable nullable id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                withparameters:(nullable nullable id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure type:(Encryption_TYPE)type;

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                withparameters:(nullable nullable id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure type:(Encryption_TYPE)type;
// up image
+(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(nullable id )parameters image:(UIImage *)image  progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure type:(NSString *)type;
+(NSURLSessionDataTask *)POSTImages:(NSString *)URLString parameters:(nullable id)parameters image:(NSArray *)images  progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+(nullable id)dispatchUrl:(NSString *)url  HTTPBody:(NSString *)Body;
/**
 LDD 网络请求
 
 @param URLString 方法名
 @param rtype 请求方式 GET OR POST
 @param etype 加密方式
 @param parameters 参数
 @param vc 当前VC
 @param progress 下载进度
 @param success 成功block
 @param failure 失败block
 */
+ (void)DDResqust:(NSString *)URLString
  withRequestType:(requestMode)rtype
   encryptionType:(Encryption_TYPE)etype
   withparameters:(nullable nullable id)parameters
           withVC:(UIViewController *)vc
         progress:(void (^)(NSProgress * _Nonnull))progress
          success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
          failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

/**
 LDD POST请求
 
 @param URLString 方法名
 @param parameters 参数
 @param vc 当前控制器
 @param progress 进度
 @param success 成功
 @param failure 失败
 */
+ (void)DDPOSTResqust:(NSString *)URLString
       withparameters:(nullable nullable id)parameters
               withVC:(UIViewController * _Nullable)vc
             progress:(void (^)(NSProgress * _Nonnull))progress
              success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
              failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

NS_ASSUME_NONNULL_END
@end
