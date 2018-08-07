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
#import <objc/message.h>

@interface MYRuntime : NSObject
/**
 *  获取实类的名称
 */
+(NSString *)Myclass_getClassName:(Class)myclass;

/**
 *  获取实类的父类名称
 */
+(NSString *)Myclass_getSuperClass:(Class)myclass;

/**
 *  获取实例大小
 */
+ (int)Myclass_getInstanceSize:(Class)myclass;

/**
 *  获取类中指定名称实例成员变量的类型
 *
 *  @param myclass 类
 *  @param name  成员变量名
 */
+(NSString *)Myclass_getInstanceVariable:(Class)myclass name:(const char *)name;

/**
 *  获取属性的信息的值
 *
 *  @param myclass 类
 *  @param name  成员变量名
 */
+(id)Myclass_getProperty:(id)myclass name:(const char *)name ;

/**
 *  获取类制定方法的信息
 *
 *  @param myclass    类
 *  @param selector 方法
 */
+ (Method)Myclass_getInstanceMethod:(Class)myclass selector:(SEL)selector;

/**
 *  获取类方法的信息
 *
 *  @param myclass    类
 *  @param selector 方法
 */
+ (Method)Myclass_getClassMethod:(Class)myclass selector:(SEL)selector;

/**
 *  获取实类所有方法的信息
 *
 *  @param myclass    类
 */
+ (NSArray <NSString *> * )Myclass_getClassMethodString:(Class)myclass;

/**
 *  获取类中的方法的实现,该方法的返回值类型为struct
 *
 *  @param myclass    类
 *  @param selector 方法
 *  @return IMP
 */
//+ (IMP)Myclass_getMethodImplementation_stret:(Class)myclass selector:(SEL)selector;
//+ (IMP)Myclass_getMethodImplementation_stret:(Class)myclass selectorString:(NSString *)selectorString;

/**
 *  获取成员变量列表
 *
 *  @param myclass 类
 */
+ (NSArray *)Myclass_copyIvarList:(Class)myclass;

/**
 *  获取成员属性变量列表
 *
 *  @param myclass 类
 */
+ (NSArray *)Myclass_copyPropertyList:(Class)myclass;

/**
 *  获取方法列表
 *
 *  @param myclass 类
 */
+ (NSArray *)Myclass_copyMethodList:(Class)myclass;

/**
 *  获取协议列表
 *
 *  @param myclass 类
 */
+ (NSArray *)Myclass_copyProtocolList:(Class)myclass;

/**
 *  添加成员变量(添加成员变量只能在运行时创建的类，且不能为元类)
 *
 *  @param myclass     类
 *  @param name      成员变量名字
 *  @param size      大小
 *  @param alignment 对其方式
 *  @param types     参数类型
 */
+ (BOOL)Myclass_addIvar:(Class)myclass name:(const char *)name size:(size_t)size alignment:(uint8_t)alignment types:(const char *)types;

/**
 *  添加属性
 *
 *  @param myclass          类
 *  @param name           属性名
 *  @param attributes     参数
 *  @param attributeCount 参数数量
 */
+ (BOOL)Myclass_addProperty:(Class)myclass name:(const char *)name attributes:(const objc_property_attribute_t *)attributes attributeCount:(unsigned int)attributeCount;

/**
 *  添加方法
 *
 *  @param myclass    类
 *  @param selector 方法
 *  @param imp      方法实现
 *  @param types    类型
 */
+ (BOOL)Myclass_addMethod:(Class)myclass selector:(SEL)selector imp:(IMP)imp types:(const char *)types;

/**
 *  添加协议
 *
 *  @param myclass    类
 *  @param protocol 协议
 */
+ (BOOL)Myclass_addProtocol:(Class)myclass protocol:(Protocol *)protocol;

/**
 *  查看类是否相应指定方法
 *
 *  @param myclass    类
 *  @param sel 方法
 */
+ (BOOL)Myclass_respondsToSelector:(Class)myclass selector:(SEL)sel;

/**
 *  查看类是否为元类
 *
 *  @param myclass 类
 */
+ (BOOL)Myclass_isMetaClass:(Class)myclass;

/**
 *  查看类是否遵循指定协议
 *
 *  @param myclass   类
 *  @param protocol 协议
 */
- (BOOL)Myclass_conformsToProtocol:(Class)myclass protocol:(Protocol *)protocol;

+ (void)addAssociatedWithtarget:(id)target withPropertyName:(NSString *)propertyName withValue:(id)value;

//获取目标target的指定关联对象值
+ (id)getAssociatedValueWithTarget:(id)target withPropertyName:(NSString *)propertyName;

@end
