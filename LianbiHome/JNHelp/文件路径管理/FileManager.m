//
//  FileManager.m
//  duwen
//
//  Created by Apple on 17/4/5.
//  Copyright © 2017年 duwen. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+(NSString *)imagePath
{
    return [NSString stringWithFormat:@"%@/Image", [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]];
}

+(NSString *)videoPath
{
    NSString * imagePath = [NSString stringWithFormat:@"%@/video", [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]];
    if ([self createDirectoryAtPath:imagePath]) {
        return imagePath;
    }
    return nil;
}

+(BOOL)createDirectoryAtPath:(NSString *)imagePath
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath])
    {
        NSError *error;
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        [fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error == nil) {
            return YES;
        }else {
            return NO;
        }
    }
    return YES;
}

@end
