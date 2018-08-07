//
//  DwTableView.h
//  DW_kuangjia
//
//  Created by Apple on 2017/10/30.
//  Copyright © 2017年 i-qlady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DwTableViewCell.h"
#import "DwTableViewModel.h"
#import "AFNetworking.h"
#import "MJRefresh.h"

#define DWTABLEVIEW_DATA  @"data"
#define DWTABLEVIEW_DATA1 @"list"

@class DwTableView;

@protocol DwTableViewDelegate <NSObject>
@optional
//下载好数据
-(void)DwtableView:(DwTableView *)tableView downDatasWithDict:(NSDictionary *)dict index:(int)index;
//刷新通知代理 下载新的数据
-(void)DwtableView:(DwTableView *)tableview refresh:(int)page;
//cell的点击
-(void)DwtableView:(DwTableView *)tableView model:( DwTableViewModel *)myTableViewModel indexPath:(NSIndexPath  *)indexPath;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

-(void)dwtableView:(DwTableView *)tableView  downModel:(DwTableViewModel *)myTableViewModel;
@end


@interface DwTableView : NSObject

+(DwTableView *)initWithFrame:(CGRect)frame url:(NSString *)url modelName:(NSString *)modelName cellName:(NSString *)cellName delegate:(id <DwTableViewDelegate , DwTableViewCellDelegate>)delegate;

/* index == 0  没有刷新  index==1 删除所有的数据 index >= 2 添加数据*/
-(void)downWithdict:(NSObject *)dict index:(int)index;

@property(nonatomic,assign)id < DwTableViewDelegate ,DwTableViewCellDelegate > delegate;
//设置tableview的头部view
-(void)setTableViewHearView:(UIView *)hearView;

-(void)setTableViewFooterView:(UIView *)footerView;
-(void)removeFooterView;

-(NSMutableArray *)readArrays;
-(UITableView *)readTableView;

//这是下载的数据没有数据的时候一张占位ImageView
@property(nonatomic,retain)UIImageView * emptyImageView;
//这是取2级数据的
@property(nonatomic,assign)BOOL is_data;
@property(nonatomic,copy)NSString * data1;
//这是是否添加刷新动画 默认yes
@property(nonatomic,assign)BOOL isRefreshAnimation;

@property(nonatomic,assign)int page;

@property(nonatomic,assign)BOOL is_up;  //是否支持上拉刷新

-(void)ceshiArrays:(NSArray *)arrayDatas;

@property(nonatomic,assign)BOOL is_arrayDatas;

//无数据的label
@property(nonatomic,retain)UILabel * titleLabel;

@end
