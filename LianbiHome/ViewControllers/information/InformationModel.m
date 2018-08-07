//
//  InformationModel.m
//  LianbiHome
//
//  Created by Apple on 2018/8/6.
//  Copyright © 2018年 LianbiHome. All rights reserved.
//

#import "InformationModel.h"

@implementation InformationModel

-(void)setDict:(NSMutableDictionary *)dict
{
    [super setDict:dict];
    self.information_id = dict[@"id"];
    NSDictionary * dict1 = [dict[@"more"] dictionaryWithJson];
    self.moreModel = [[InformationImageModel alloc]initWithDict:dict1];
}

@end

@implementation InformationImageModel

@end

@implementation KxformationModel

-(NSMutableArray *)dataArrays
{
    if (!_dataArrays) {
        _dataArrays = [NSMutableArray array];
    }
    return _dataArrays;
}


@end

@implementation  KxModel
-(void)setDict:(NSMutableDictionary *)dict
{
    [super setDict:dict];
    self.kx_id = dict[@"id"];
}
@end
