//
//  NSObject+Helpr.m
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "NSObject+Helpr.h"

@implementation NSObject (Helpr)

+ (BOOL)jn_hookOrigMenthod:(SEL)origSel NewMethod:(SEL)altSel {
    Class class = self;
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method altMethod = class_getInstanceMethod(class , altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    BOOL didAddMethod = class_addMethod(class,origSel,
                                        method_getImplementation(altMethod),
                                        method_getTypeEncoding(altMethod));
    if (didAddMethod) {
        class_replaceMethod(class,altSel,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, altMethod);
    }
    return YES;
}

+ (BOOL)jn_instancehookOrigMenthod:(SEL)origSel NewMethod:(SEL)altSel
{
    Method origMethod = class_getClassMethod([self class], origSel);
    Method altMethod = class_getClassMethod([self class], altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    BOOL didAddMethod = class_addMethod(self,origSel,
                                        method_getImplementation(altMethod),
                                        method_getTypeEncoding(altMethod));

    if (didAddMethod) {
        class_replaceMethod(self,altSel,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, altMethod);
    }

    return YES;
}


+(instancetype)sharedInstance
{
    return [[self alloc]init];
}

- (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char * propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

@end
