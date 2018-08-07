
//---------------------------------------------
//
//
//
//
//
//
//
//----------------------------------------------
#ifndef Danli_h
#define Danli_h

//单例宏
#define XMGSingletonH(name) +(instancetype)shared##name;

#define XMGSingletonM(name)  \
static id _instace;   \
+(instancetype)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t  onceToken;\
dispatch_once(&onceToken, ^{\
_instace=[super allocWithZone: zone];\
});\
return   _instace;\
}\
+(instancetype)shared##name{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instace=[[self alloc]init];\
});\
return _instace;\
}\
-(id)copyWithZone:(NSZone *)zone{\
return _instace;\
}

#define XMGSingletoH  XMGSingletonH(Instance)
#define XMGSingletoM  XMGSingletonM(Instance)

//归档 解档
#define MY_NSCODING \
- (void)encodeWithCoder:(NSCoder *)aCoder\
{\
    unsigned  int count = 0;\
    Ivar * ivars = class_copyIvarList([self class], &count);\
    for (int i = 0; i < count; i++) {\
        Ivar ivar = ivars[i];\
        const char * name = ivar_getName(ivar);\
        NSString * key = [NSString stringWithUTF8String:name];\
        [aCoder encodeObject:[self valueForKey:key] forKey:key];\
    }\
    free(ivars);\
}\
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder\
{\
    if (self = [super init]) {\
        unsigned  int count = 0;\
        Ivar * ivars = class_copyIvarList([self class], &count);\
        for (int i = 0; i < count; i++) {\
            NSString * key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];\
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];\
        }\
        free(ivars);\
    }\
    return self ;\
}

#endif /* Danli_h */
