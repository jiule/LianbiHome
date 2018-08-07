//
//  InformationModel.h
//  LianbiHome
//
//  Created by Apple on 2018/8/6.
//  Copyright © 2018年 LianbiHome. All rights reserved.
//

#import "DwTableViewModel.h"

@class InformationImageModel;

@interface InformationModel : DwTableViewModel

@property(nonatomic,copy)NSString * add_hits;

@property(nonatomic,copy)NSString * add_like;

@property(nonatomic,copy)NSString * comment_count;

@property(nonatomic,copy)NSString * information_id;

@property(nonatomic,retain)InformationImageModel * moreModel;

@property(nonatomic,copy)NSString * post_excerpt;

@property(nonatomic,copy)NSString * post_hits;

@property(nonatomic,copy)NSString * post_like;

@property(nonatomic,copy)NSString * post_source;

@property(nonatomic,copy)NSString * post_title;

@property(nonatomic,copy)NSString * published_time;

@end

@interface InformationImageModel : DwTableViewModel


@property(nonatomic,copy)NSString * thumbnail;

//@property(nonatomic,copy)NSString * template1;

@end
