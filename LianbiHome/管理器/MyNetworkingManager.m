//
//  MyNetworkingManager.m
//  Q-Lady
//
//  Created by Apple on 17/2/7.
//  Copyright © 2017年 Q-Lady. All rights reserved.
//

#import "MyNetworkingManager.h"



@interface MyNetworkingManager ()

@property(nonatomic,retain)NSMutableDictionary * cacheDict;

@end

@implementation MyNetworkingManager
XMGSingletoM

-(NSMutableDictionary *)cacheDict
{
    if (!_cacheDict) {
        _cacheDict = [NSMutableDictionary dictionary];
    }
    return _cacheDict ;
}

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
 parameters:(nullable id)parameters
   progress:(void (^)(NSProgress * _Nonnull))downloadProgress
    success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
    failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (![[MyNetworkingManager sharedInstance] readWithUrl:URLString]) {
        NSURLSessionDataTask * dataTask = [manager GET:URLString parameters:parameters progress:downloadProgress success:success failure:failure];
        [[[MyNetworkingManager sharedInstance] getcacheDict]setObject:dataTask forKey:URLString];
    }
    return [[MyNetworkingManager sharedInstance] readWithUrl:URLString];
}

+(void)GETWithNOChace:(NSString *)URLString
           parameters:(nullable id)parameters
             progress:(void (^)(NSProgress * _Nonnull))downloadProgress
              success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
              failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URLString parameters:parameters progress:downloadProgress success:success failure:failure];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(nullable id )parameters
                      progress:(nullable void (^)(NSProgress * _Nonnull ))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    return [manager POST:URL(URLString) parameters:[MyNetworkingHelp addSidWithDict:parameters] progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //    id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                withparameters:(nullable nullable id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
         manager.responseSerializer = [AFHTTPResponseSerializer serializer];
      //  NSString * urlString = [URL(URLString) stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        MyLog(@"parameters=====%@",parameters);

        return [manager POST:URL(URLString) parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([MyNetworkingHelp dealWithResponseDict:responseDict]) {
                success(task,responseObject);
            }else {
                failure(task,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error====%@",error);
            failure(task,error);
        }];
}

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
               withparameters:(nullable nullable id)parameters
                     progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                      success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure type:(Encryption_TYPE)type
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  return  [manager GET:URL(URLString) parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([MyNetworkingHelp dealWithResponseDict:responseDict]) {
            success(task,responseObject);
        }else {
            failure(task,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error====%@",error);
        failure(task,error);
    }];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                withparameters:(nullable nullable id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure type:(Encryption_TYPE)type
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return [manager POST:URL(URLString) parameters:[MyNetworkingHelp addSidWithDict:parameters type:type] progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([MyNetworkingHelp dealWithResponseDict:responseDict]) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}



+(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(nullable id)parameters image:(UIImage *)image  progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure type:(nonnull NSString *)type
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    return [manager POST:URL(URLString) parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData * imageData = UIImagePNGRepresentation(image);
        if (imageData.length==0) {
                return ;
            }
         [formData appendPartWithFileData:imageData name:type fileName:[NSString stringWithFormat:@"%@.png",type] mimeType:@"image/png"];
     //   NSLog(@"%@",imageData);
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([MyNetworkingHelp dealWithResponseDict:responseDict]) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}




+(NSURLSessionDataTask *)POSTImages:(NSString *)URLString parameters:(nullable id)parameters image:(NSArray *)images  progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure 
{
    NSString * str = [NSString stringWithFormat:@"%@[]",parameters[@"img_type"]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return [manager POST:URL(URLString) parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0 ; i < images.count; i++) {
            UIImage * image = images[i];
            NSData * imageData = UIImagePNGRepresentation(image);
            if (imageData.length == 0) {
                NSLog(@"%@",image);
            }
            [formData appendPartWithFileData:imageData name:str fileName:str mimeType:@"image/png"];
        }
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([MyNetworkingHelp dealWithResponseDict:responseDict]) {
            success(task,responseObject);
        }
    } failure:[failure copy]];
}

-(NSURLSessionDataTask *)readWithUrl:(NSString *)url
{
    return self.cacheDict[url];
}
-(NSMutableDictionary *)getcacheDict
{
    return self.cacheDict;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"      //方法弃用
+(NSDictionary *)PostWithUrl:(NSString *)url httpbody:(NSString *)body
{
    NSURL *urlPath = [NSURL URLWithString:URL(url)];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlPath cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    id responseDict = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
        [self PostWithUrl:url httpbody:body];
    if ([MyNetworkingHelp dealWithResponseDict:responseDict]) {
        return responseDict;
    }
    return @{};
}


+(void)postWithUrl:(NSString *)url sid:(BOOL)sid success:(void(^)(NSDictionary * dict))success
{
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:URL(url)] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    if (sid) {
//        NSData *data = [[NSString stringWithFormat:@"sid=%@&user_id=%@",[PersonalModel sharedInstance].sid,[PersonalModel sharedInstance].userid] dataUsingEncoding:NSUTF8StringEncoding];
//        [request setHTTPBody:data];
    }
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    id responseDict = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
    if ([MyNetworkingHelp dealWithResponseDict:responseDict]) {
          success(responseDict);
    }
}
#pragma clang diagnostic pop

+(id)dispatchUrl:(NSString *)url  HTTPBody:(NSString *)Body{
    return nil;
}
+ (void)DDResqust:(NSString *)URLString
  withRequestType:(requestMode)rtype
   encryptionType:(Encryption_TYPE)etype
   withparameters:(nullable nullable id)parameters
           withVC:(UIViewController *)vc
         progress:(void (^)(NSProgress * _Nonnull))progress
          success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
          failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure{
    [MyActivityIndicatorViewManager showActivityIndicatorViewWithName:@"数据加载中...." Style:0 vc:vc];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (![[MyNetworkingManager sharedInstance] readWithUrl:URLString]) {
        if (rtype == GET) {
            [manager GET:URL(URLString) parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                progress(downloadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                [MyActivityIndicatorViewManager remove];
                if ([MyNetworkingHelp dealWithResponseDict:responseDict]) {
                    //成功
                    success(task,responseDict[@"data"]);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MyActivityIndicatorViewManager remove];
                NSLog(@"error====%@",error);
                failure(task,error);
            }];
        }
        else if (rtype == POST){
            [manager POST:URL(URLString) parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                progress(downloadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                [MyActivityIndicatorViewManager remove];
                if ([MyNetworkingHelp dealWithResponseDict:responseDict]) {
                    //成功
                    NSLog(@"*******%@",responseDict);
                    success(task,responseDict[@"data"]);
                }else
                    failure(task,[NSError new]);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MyActivityIndicatorViewManager remove];
                NSLog(@"error====%@",error);
                failure(task,error);
            }];
            
        }
        
    }
}
+ (void)DDPOSTResqust:(NSString *)URLString
       withparameters:(nullable nullable id)parameters
               withVC:(UIViewController * _Nullable)vc
             progress:(void (^)(NSProgress * _Nonnull))progress
              success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
              failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure{
    NSLog(@"parameters======%@",parameters);
    [MyNetworkingManager DDResqust:URLString withRequestType:POST encryptionType:0 withparameters:parameters withVC:vc progress:progress success:success failure:failure];
}
+(void)handleCode:(NSInteger)code{
    
}

@end
