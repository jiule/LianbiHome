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

@interface FileManager : NSObject
/**
 *  图片保存的沙盒地址
 */
+(NSString *)imagePath;
/**
 *  视频的地址
 */
+(NSString *)videoPath;
/**
 *  判断是否有文件路径
 */
+(BOOL)createDirectoryAtPath:(NSString *)imagePath;
@end
