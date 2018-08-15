//---------------------------------------------
//
//  Permissions :  判断系统的一些权限申请 是否打开
//  MIPickerimage :  调用系统的 UIImagePickerController 返回图片
//
//
//
//
//----------------------------------------------

#import <UIKit/UIKit.h>
#import "NSObject+Helpr.h"
#import "Helpr.h"

NS_ASSUME_NONNULL_BEGIN
@interface Permissions : NSObject

+(void)isWiFi;

/*
 * 判断联网权限
 */
+(BOOL)isCTCellular;
/* 
 * 判断相册功能是否开启
 */
+(BOOL)isCanUsePhotos;

/*
 * 判断相机功能是否开启
 */
+(BOOL)isCanUseCamera;

/*
 * 判断设备是否有摄像头
 */
+ (BOOL) isCameraAvailable;

/*
 * 前面的摄像头是否可用
 */
+ (BOOL) isFrontCameraAvailable;

/*
 * 后面的摄像头是否可用
 */
+ (BOOL) isRearCameraAvailable;

///*
// * 判断定位有木有打开
// */
//+ (BOOL)isLocationServicesEnabled;
/*
 * 判断麦克风权限
 */
+ (BOOL)isRequestRecord;
///*
// * 判断日历权限
// */
//+ (BOOL)isEKAuthorizationStatus;
///*
// * 判断通讯录权限
// */
//+ (BOOL)isCNAuthorizationStatus;
///*
// * 判断推送权限
// */
//+ (BOOL)isUIUserNotificationSettings;
///*
// * 判断蓝牙权限
// */
//+ (BOOL)isCBCentralManager;
///*
// * 判断运动与健康权限
// */
//+(BOOL)isHKAuthorizationStatus;

@end


NS_ASSUME_NONNULL_END
