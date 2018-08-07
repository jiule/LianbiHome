//---------------------------------------------
//
//
//
//   这是跟系统分类添加属性的宏
//
//
//
//----------------------------------------------

#ifndef RuntimeHelpr_h
#define RuntimeHelpr_h

/*
 *  给系统类添加一个属性 
 *  这是申明属性的
 */
#define XH_ATTRIBUTE(ATTRIBUTE,TYPE,NAME) @property(nonatomic,ATTRIBUTE)TYPE * NAME
#define XH_ATTRIBUTE_NSSTRING(NAME) XH_ATTRIBUTE(copy,NSString,NAME)      //这是添加一个nsstring类型
#define XH_ATTRIBUTE_RETURN(TYPE,NAME) XH_ATTRIBUTE(retain,TYPE,NAME)     //这是添加一个return 类型的

/*
 *  给系统类添加一个属性
 *  这是属性的实现方法
 */
#define XM_SEL(OBJC_ENUM_STR,TYPE,NAME,BIGNAME) \
-(TYPE *)NAME\
{\
return objc_getAssociatedObject(self, @#NAME);\
}\
-(void)set##BIGNAME:(TYPE *)NAME{\
objc_setAssociatedObject(self, @#NAME, NAME, OBJC_ENUM_STR);\
}

/*
 *  给系统类添加一个 block 属性
 *  这是申明属性的
 */
#define XH_ATTRIBUTE_COPY_BLOCK(TYPE,NAME) @property(nonatomic,copy)TYPE  NAME
/*
 *  给系统类添加一个 block 属性
 *  这是属性的实现方法
 */
#define XM_SEL_BLOCK(OBJC_ENUM_STR,TYPE,NAME,BIGNAME) \
-(TYPE )NAME\
{\
return objc_getAssociatedObject(self, @#NAME);\
}\
-(void)set##BIGNAME:(TYPE )NAME{\
objc_setAssociatedObject(self, @#NAME, NAME, OBJC_ENUM_STR);\
}


#endif /* RuntimeHelpr_h */
