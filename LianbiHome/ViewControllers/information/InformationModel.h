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
@property(nonatomic,copy)NSString * post_content;
@end

@interface InformationImageModel : DwTableViewModel


@property(nonatomic,copy)NSString * thumbnail;

@end

@interface  KxformationModel : DwTableViewModel

@property(nonatomic,copy)NSString * kx_timer;

@property(nonatomic,retain)NSMutableArray * dataArrays;
@end

@interface  KxModel : BaseModel

@property(nonatomic,copy)NSString * bad_add;

@property(nonatomic,copy)NSString * bad_vote;

@property(nonatomic,copy)NSString * bull_add;

@property(nonatomic,copy)NSString * bull_vote;

@property(nonatomic,copy)NSString * content;

@property(nonatomic,copy)NSString * evaluate;

@property(nonatomic,copy)NSString * kx_id;

@property(nonatomic,copy)NSString * issue_time;

@property(nonatomic,copy)NSString * newsflash_id;

@property(nonatomic,copy)NSString * pic_build;

@property(nonatomic,copy)NSString * source;

@property(nonatomic,copy)NSString * title;
@end
