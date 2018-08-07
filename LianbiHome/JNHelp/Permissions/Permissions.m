//
//  Permissions.m
//  duwen
//
//  Created by Apple on 17/4/5.
//  Copyright © 2017年 duwen. All rights reserved.
//

#import "Permissions.h"
#import<CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>
#import <SystemConfiguration/CaptiveNetwork.h>   //网络请求wifi
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "CoreLocation/CoreLocation.h"
#import <CoreTelephony/CTCellularData.h>
#import <EventKitUI/EventKitUI.h>
#import <AddressBook/AddressBook.h>        // 通讯录权限  IOS 9.0 前
#import <Contacts/Contacts.h>              // 通讯录权限  IOS 9.0 后
#import <UserNotifications/UserNotifications.h>  
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>
#import <HealthKit/HealthKit.h>


@interface Permissions ()
@property (nonatomic, strong) AFNetworkReachabilityManager *manager;
@end

@implementation Permissions
+(void)isWiFi
{
  
}

+(BOOL)isCTCellular
{
    BOOL RequestRecord = NO;
    CTCellularData *cellularData = [[CTCellularData alloc]init];
    if (cellularData.restrictedState != kCTCellularDataNotRestricted) {
        RequestRecord = YES ;
    }
    if (!RequestRecord) {
         [Helpr addPrefsAlertControllerMessage:@"网络请求受限!去开启"];
    }
    return RequestRecord;
}

+(BOOL)isCanUsePhotos
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations" 
        ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied) {
            //无权限
            [Helpr addAlertViewMessage:@"相册权限受限"];
            return NO;
        }
        #pragma clang diagnostic pop
    }
    else {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted ||
            status == PHAuthorizationStatusDenied) {
            //无权限
             [Helpr addPrefsAlertControllerMessage:@"相册权限受限!去开启?"];
            return NO;
        }
    }
    return YES;
}

+(BOOL)isCanUseCamera
{
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        [Helpr addPrefsAlertControllerMessage:@"相机权限受限!去开启?"];
        return  NO;
    }
    return YES;
}

// 判断设备是否有摄像头
+ (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// 前面的摄像头是否可用
+ (BOOL) isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// 后面的摄像头是否可用
+ (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

+(BOOL)isLocationServicesEnabled
{
    if ([CLLocationManager locationServicesEnabled]) {
        return YES;
    }else {
         [Helpr addPrefsAlertControllerMessage:@"定位权限受限!去开启?"];
        return NO;
    }
    return YES ;
}

+ (BOOL)isRequestRecord
{
    __block BOOL RequestRecord = NO;
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        RequestRecord = granted;
        if (!RequestRecord) {
            [Helpr addPrefsAlertControllerMessage:@"麦克风!去开启?"];
        }
    }];
    return RequestRecord;
}

+(BOOL)isEKAuthorizationStatus
{
    BOOL RequestRecord = NO;
    EKAuthorizationStatus EKstatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    switch (EKstatus) {
        case EKAuthorizationStatusAuthorized:  RequestRecord = YES;  break;
        case EKAuthorizationStatusDenied:  RequestRecord = NO;  break;
        case EKAuthorizationStatusNotDetermined: RequestRecord = YES; break;
        case EKAuthorizationStatusRestricted: RequestRecord = NO; break;
        default: break;
    }
    if (!RequestRecord) {
        [Helpr addPrefsAlertControllerMessage:@"日历访问受限!去设置"];
    }
    return RequestRecord;
}

+(BOOL)isCNAuthorizationStatus
{
    BOOL RequestRecord = NO;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
   #pragma clang diagnostic push
   #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        ABAuthorizationStatus ABstatus = ABAddressBookGetAuthorizationStatus();
        switch (ABstatus) {
            case kABAuthorizationStatusAuthorized: RequestRecord = YES; break;
            case kABAuthorizationStatusDenied: RequestRecord = NO; break;
            case kABAuthorizationStatusNotDetermined: RequestRecord = YES; break;
            case kABAuthorizationStatusRestricted:  RequestRecord = NO; break; default: break;
        }
     #pragma clang diagnostic pop
    }else {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusAuthorized: RequestRecord = YES; break;
            case CNAuthorizationStatusDenied:RequestRecord = NO; break;
            case CNAuthorizationStatusRestricted: RequestRecord = YES ; break;
            case CNAuthorizationStatusNotDetermined:RequestRecord = NO; break;
        }
    }
    if (!RequestRecord) {
        [Helpr addPrefsAlertControllerMessage:@"通讯录访问受限!去设置"];
    }
    return RequestRecord;
}

+(BOOL) isUIUserNotificationSettings
{
     BOOL RequestRecord = NO;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
            switch (settings.types) {
                case UIUserNotificationTypeNone: RequestRecord = NO; break;
                case UIUserNotificationTypeAlert: RequestRecord = YES; break;
                case UIUserNotificationTypeBadge: RequestRecord = YES; break;
                case UIUserNotificationTypeSound: RequestRecord = YES; break; default: break;
#pragma clang diagnostic pop
            }
        }else {
            UNNotificationSettings * settings = [UNNotificationSettings sharedInstance];
            switch (settings.authorizationStatus) {
                case UNAuthorizationStatusNotDetermined: RequestRecord = YES;   break;
                case UNAuthorizationStatusDenied:      RequestRecord = NO;   break;
                case UNAuthorizationStatusAuthorized: RequestRecord = YES;   break;
                default:
                    break;
            }
        }
    if (!RequestRecord) {
        [Helpr addPrefsAlertControllerMessage:@"信息通知受限!去设置"];
    }
    return RequestRecord;
}

+(BOOL)isCBCentralManager
{
    BOOL RequestRecord = NO;
    CBCentralManager * manager = [CBCentralManager  sharedInstance];
    if (manager.state == CBManagerStatePoweredOn)   RequestRecord = YES;
    if (!RequestRecord) [Helpr addPrefsAlertControllerMessage:@"蓝牙受限!去设置"];
    return RequestRecord;
}

+(BOOL)isHKAuthorizationStatus
{
    BOOL RequestRecord = NO;
    HKQuantityType *stepsType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKAuthorizationStatus status = [[HKHealthStore sharedInstance] authorizationStatusForType:stepsType];
    switch (status) {
        case HKAuthorizationStatusNotDetermined: RequestRecord = YES;   break;
        case HKAuthorizationStatusSharingDenied:      RequestRecord = NO;   break;
        case HKAuthorizationStatusSharingAuthorized: RequestRecord = YES;   break;
        default:
            break;
    }
    if (!RequestRecord) {[Helpr addPrefsAlertControllerMessage:@"运动与健康权限受限!去设置"];}
    return  NO;
}




@end


