//
//  MYRuntime.m
//  runtime
//
//  Created by Apple on 17/2/10.
//  Copyright © 2017年 runtime. All rights reserved.
//

#import "MYRuntime.h"

@implementation MYRuntime

+(NSString *)Myclass_getClassName:(Class)myclass
{
    return [NSString stringWithUTF8String:class_getName([myclass class])];
}

+(NSString *)Myclass_getSuperClass:(Class)myclass
{
    return [NSString stringWithUTF8String:class_getName(class_getSuperclass([myclass class]))];
}

+ (int)Myclass_getInstanceSize:(Class)myclass
{
  return  (int)class_getInstanceSize([myclass class]);
}

+(NSString *)Myclass_getInstanceVariable:(Class)myclass name:(const char *)name
{
    return [NSString stringWithUTF8String:ivar_getName(class_getInstanceVariable(myclass,name))] ;
}

+ (id)Myclass_getProperty:(id)myclass name:(const char *)name {
   NSString * key = [NSString stringWithUTF8String:name];
    return [myclass valueForKey:key];
}

+ (Method)Myclass_getInstanceMethod:(Class)myclass selector:(SEL)selector
{
    Method method = class_getInstanceMethod(myclass, selector);
    return method;
}

+ (Method)Myclass_getClassMethod:(Class)myclass selector:(SEL)selector {
    Method method = class_getClassMethod(myclass, selector);
    return method;
}

+ (NSArray <NSString *> * )Myclass_getClassMethodString:(Class)myclass
{
    unsigned  int count = 0;
    NSMutableArray * MethodArray = [NSMutableArray array];
    Method * method = class_copyMethodList([myclass class], &count);
    for (int i = 0; i <  count; i++) {
        [MethodArray addObject:NSStringFromSelector(method_getName(method[i]))];
    }
    free(method);
    return [NSArray arrayWithArray:MethodArray];
}

//+ (IMP)Myclass_getMethodImplementation_stret:(Class)myclass selector:(SEL)selector
//{
//    IMP imp = class_getMethodImplementation_stret(myclass, selector);
//    return imp;
//}
//
//+ (IMP)Myclass_getMethodImplementation_stret:(Class)myclass selectorString:(NSString *)selectorString
//{
//    return [self Myclass_getMethodImplementation_stret:myclass selector:NSSelectorFromString(selectorString)];
//}

+ (NSArray *)Myclass_copyIvarList:(Class)myclass
{
    unsigned int count;
    Ivar *ivarList = class_copyIvarList(myclass, &count);
   NSMutableArray * IvarListArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        [IvarListArray addObject:[NSString stringWithUTF8String:ivar_getName(ivarList[i])]];
    }
    free(ivarList);
    return [NSArray arrayWithArray:IvarListArray];
}

+ (NSArray *)Myclass_copyPropertyList:(Class)myclass
{
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList(myclass,&count);
    NSMutableArray * propertyListArray = [NSMutableArray array];
    for (int i = 0; i < count; i++)
    {
        [propertyListArray addObject:[NSString stringWithUTF8String:property_getName(propertyList[i])]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:propertyListArray];
}

+ (NSArray *)Myclass_copyMethodList:(Class)myclass
{
    unsigned int count;
    Method * methodList = class_copyMethodList(myclass,&count);
    NSMutableArray * methodListArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        [methodListArray addObject:NSStringFromSelector(method_getName(methodList[i]))];
    }
    free(methodList);
    return [NSArray arrayWithArray:methodListArray];
}

+ (NSArray *)Myclass_copyProtocolList:(Class)myclass {
    unsigned int count;
    Protocol *__unsafe_unretained *protocolList = class_copyProtocolList(myclass,&count);
    NSMutableArray * protocolListArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Protocol * protocol = protocolList[i];
        [protocolListArray addObject:protocol];
    }
    return [NSArray arrayWithArray:protocolListArray];
}


+ (BOOL)Myclass_addIvar:(Class)myclass name:(const char *)name size:(size_t)size alignment:(uint8_t)alignment types:(const char *)types
{
//        if (class_addIvar([HKPerson class], "country", 24, 1, "NSString")) {
    if (class_addIvar(myclass, name, size, alignment, types)) {
        return YES;
    }else{
        return NO;
    }
}
+ (BOOL)Myclass_addProperty:(Class)myclass name:(const char *)name attributes:(const objc_property_attribute_t *)attributes attributeCount:(unsigned int)attributeCount {
    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t ownership = { "&", "N" };
    objc_property_attribute_t backingivar  = { "V", "" };
    objc_property_attribute_t attrs[] = { type, ownership, backingivar };
    if (class_addProperty(myclass, name, attrs, attributeCount)) {
        return YES;
    }else{
        return NO ;
    }
}

+ (BOOL)Myclass_addMethod:(Class)myclass selector:(SEL)selector imp:(IMP)imp types:(const char *)types
{
    if (class_addMethod(myclass,selector,class_getMethodImplementation(myclass, selector),types)) {
        return YES;
    }else{
        return NO ;
    }
}

+ (BOOL)Myclass_addProtocol:(Class)myclass protocol:(Protocol *)protocol {
    if (class_addProtocol(myclass, protocol)) {
        return YES ;
    }else{
        return  NO;
    }
}

+ (BOOL)Myclass_respondsToSelector:(Class)myclass selector:(SEL)sel;
{
    if (class_respondsToSelector(myclass,sel)) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)Myclass_isMetaClass:(Class)myclass {
    if (class_isMetaClass(myclass)) {
        return YES;
    }else{
        return NO;
    }
}

/**
 *  查看类是否遵循指定协议
 *
 *  @param myclass    类
 *  @param protocol 协议
 */
- (BOOL)Myclass_conformsToProtocol:(Class)myclass protocol:(Protocol *)protocol {
    if (class_conformsToProtocol(myclass, protocol)) {
        return YES;
    }else{
        return NO;
    }
}

+ (void)addAssociatedWithtarget:(id)target withPropertyName:(NSString *)propertyName withValue:(id)value {
    id property = objc_getAssociatedObject(target, &propertyName);
    
    if(property == nil)
    {
        property = value;
        objc_setAssociatedObject(target, &propertyName, property, OBJC_ASSOCIATION_RETAIN);
    }
}

//获取目标target的指定关联对象值
+ (id)getAssociatedValueWithTarget:(id)target withPropertyName:(NSString *)propertyName {
    id property = objc_getAssociatedObject(target, &propertyName);
    return property;
}

@end
