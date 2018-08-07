//
//  BaseModel.m
//  框架
//
//  Created by Apple on 16/8/15.
//  Copyright © 2016年 框架. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

//-(void)setValue:(id)value forKey:(NSString *)key
//{
//    if ([value class] == [NSNull class]) {
//        value = @"";
//    }
//}
//
//-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    if ([key isEqualToString:@"id"]) {
//      //  _Id = value;
//    }
//}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"未定义%@属性",key);
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [self init]) {
        self.dict = [NSMutableDictionary dictionaryWithDictionary:dict];
    }
    return self;
}
-(void)setDict:(NSMutableDictionary *)dict{
    _dict = dict;
    
    NSArray * array = [self getAllProperties];
    for (NSString *str in array) {
        if ([self judgewithStr:str]) {
            //KVC
            [self setValue:[dict objectForKey:str] forKey:str];
        }else {
        }
    }
}

-(void)remove
{
    NSArray *array=[self getAllProperties];
    for (NSString *str in array) {
        [self setValue:nil forKey:str];
    }
}

-(BOOL)judgewithStr:(NSString *)str{
    for (NSString *str1 in self.dict.allKeys) {
        if ([str isEqualToString:str1]) {
            if ([self.dict[str1] class] == [NSNull class]) {
                [self.dict setValue:@"" forKey:str1 ];
            }
            return  YES;
        }
    }
    return NO;
}

-(NSMutableDictionary *)jsonDict
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSArray * array = [self getAllProperties];
    for (NSString *str in array) {
        [dict setObject:[self valueForKey:str] forKey:str];
    }
    return dict;
}

@end
