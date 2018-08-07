

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

NS_ASSUME_NONNULL_BEGIN
/**
 *  初始化BaseModel  BaseModel  是所有的数据Model的基类
 *
 *  @param dict 字典
 *
 *  @return BaseModel
 */
-(instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典
 */
@property(nonatomic,retain)NSMutableDictionary *dict;
//这个是 获取子类所有的数据的 一个字典
-(NSMutableDictionary *)jsonDict;
//清空数据
-(void)remove;

NS_ASSUME_NONNULL_END
@end
