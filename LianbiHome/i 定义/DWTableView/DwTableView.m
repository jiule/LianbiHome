//
//  DwTableView.m
//  DW_kuangjia
//
//  Created by Apple on 2017/10/30.
//  Copyright © 2017年 i-qlady. All rights reserved.
//

#import "DwTableView.h"


@interface DwTableView() <UITableViewDelegate , UITableViewDataSource>

@property(nonatomic,copy)NSString * url;

@property(nonatomic,copy)NSString * modelName;

@property(nonatomic,copy)NSString * cellName;

@property(nonatomic,retain)UITableView * tableView;
//这是保存的请求数据
@property(nonatomic,retain)NSMutableArray * dataArrays;

@property(nonatomic,retain)UIView * footerView;
//计算保存cell 一共有多少个
@property(nonatomic,assign)int count;

@property(nonatomic,copy)NSString * data;
//记录是不是正在下载  YES是正在下载
@property(nonatomic,assign)BOOL is_down;

@property(nonatomic,retain)UIActivityIndicatorView *activ;

@property(nonatomic,assign)int cur;

@end

@implementation DwTableView

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = JnLabelType(CGRectMake(0, JN_HH(10), self.tableView.width, JN_HH(30)), UILABEL_6, @"暂无数据", 1);
        [self.tableView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(NSMutableArray *)dataArrays
{
    if (!_dataArrays) {
        _dataArrays = [NSMutableArray array];
    }
    return _dataArrays ;
}

-(UIImageView *)emptyImageView
{
    if (!_emptyImageView) {
        _emptyImageView = [[UIImageView alloc] initWithFrame:CGRectMake([self.tableView getW] * 0.5 - 25, [self.tableView getH] * 0.5 - 25, 50, 50)];
        _emptyImageView.alpha = 0 ;
        [self.tableView addSubview:_emptyImageView];
    }
    return _emptyImageView;
}

+(DwTableView *)initWithFrame:(CGRect)frame url:(NSString *)url modelName:(NSString *)modelName cellName:(NSString *)cellName delegate:(id <DwTableViewDelegate , DwTableViewCellDelegate>)delegate
{
    DwTableView * view = [[DwTableView alloc]init];
    view.tableView = [[UITableView alloc]initWithFrame:frame style:0];
    view.tableView.delegate = view;
    view.tableView.dataSource = view;
    view.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    view.tableView.bounces = YES;
    view.is_up = YES;
    view.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    view.tableView.backgroundColor = COLOR_B6;
    view.url = url;
    view.modelName = modelName;
    view.cellName = cellName;
    view.delegate = delegate;
    view.page = -1;
    view.data = DWTABLEVIEW_DATA ;
    view.data1 = DWTABLEVIEW_DATA1;
    view.is_data = NO;
    view.is_down = NO;
    view.isRefreshAnimation = YES;
    return view;
}

/* index == 0  没有刷新  index==1 删除所有的数据 index >= 2 添加数据*/
-(void)downWithdict:(NSObject *)dict index:(int)index
{
    if (!_url && self.is_down) {
        NSLog(@"URL 不存在===%@",_url);
        return ;
    }
    //保存 我要下载数据了
    self.is_down = YES;
    //是否添加下载的小圈圈
    if (self.isRefreshAnimation) {
        [_activ removeFromSuperview];
        _activ = [UIImage downloadingImageActivityIndicatorView:CGRectMake(self.tableView.bounds.size.width / 2 - 5,self.tableView.bounds.size.height/2-5 , 10, 10)];
        [self.tableView addSubview:_activ];
    }
    _page = index ;
    //index 大于0 添加上拉刷新  下拉加载刷新效果
    if (index > 0) {
        if (_is_up) {
            self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
                self->_page = 1;
                [self->_tableView.mj_header endRefreshing];
                if ([self->_delegate respondsToSelector:@selector(DwtableView:refresh:)]) {
                    [self->_delegate DwtableView:self refresh:self->_page];
                }
            }];
        }
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self->_page ++;
            [self->_tableView.mj_footer endRefreshing];
            if ([self->_delegate respondsToSelector:@selector(DwtableView:refresh:)]) {
                [self->_delegate DwtableView:self refresh:self->_page];
            }
         //  [_tableView.mj_footer endRefreshingWithNoMoreData];
        }];
    }else {
        self.tableView.mj_header = nil ;
        self.tableView.mj_footer = nil ;
    }
    //请求数据
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:_url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //通知代理下载好数据了
        if([self->_delegate respondsToSelector:@selector(DwtableView:downDatasWithDict:index:)])        {
            [self->_delegate DwtableView:self downDatasWithDict:responseDict index:index];
        }
        if (_is_arrayDatas) {

        }else {
             [self responseDict:responseDict index:index];
        }
        //判断是不是没有更多的数据了
  //      [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [self->_activ removeFromSuperview];
        self.is_down = NO;
        [self->_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.is_down = NO;
        [self->_activ removeFromSuperview];
    }];
}

#pragma mark-----解析数据
-(void)responseDict:(NSDictionary *)dict index:(int)index
{
    if (self.page <= 1) {
        [self.dataArrays removeAllObjects];
    }
    Class cls = NSClassFromString(_modelName);
    NSDictionary   * dict1 = dict;
    NSArray * array ;
    if (self.is_data) {
        dict1 = [dict objectForKey:_data];
        array = [dict1 objectForKey:_data1];
    }else {
        array = [dict1 objectForKeyedSubscript:_data];
    }
  
    for (int i = 0; i < array.count; i++) {
        DwTableViewModel  * model2342 = [[cls alloc]initWithDict:array[i]];
        model2342.cell_id = (int)self.dataArrays.count + 1;
        if (model2342) {
            [self.dataArrays addObject:model2342];
            if (i == array.count-1) {
                if ([_delegate respondsToSelector:@selector(dwtableView:downModel:)]) {
                    [_delegate dwtableView:self downModel:model2342];
                }
            }
        }else {
            NSLog(@"没有添加成功的model====%@，%@",_modelName,array[i]);
        }
    }
    if (_dataArrays.count == 0) {
        self.titleLabel.alpha = 1;
    }else {
        self.titleLabel.alpha = 0 ;
    }
}




#pragma mark----设置tableview 的tableHeaderView
-(void)setTableViewHearView:(UIView *)hearView
{
    self.tableView.tableHeaderView = hearView;
    [self.tableView reloadData];
}
#pragma mark----设置tableview 的tableFooterView
-(void)setTableViewFooterView:(UIView *)footerView
{
    _footerView = footerView;
    self.tableView.tableFooterView = footerView;
   [self.tableView reloadData];
}
-(void)removeFooterView
{
    [self.tableView.tableFooterView removeFromSuperview];
    [self.tableView reloadData];
}
-(NSMutableArray *)readArrays
{
    return self.dataArrays;
}

-(UITableView *)readTableView
{
    return self.tableView;
}
#pragma mark----cell的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArrays.count ;
}
#pragma mark----创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = [NSString stringWithFormat:@"cell%ld%lu",(long)indexPath.row,(unsigned long)indexPath.length];
    DwTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        if (!_cellName) {
            NSLog(@"CELLName 不存在");
            return [[UITableViewCell alloc]init] ;  
        }
         Class cls = NSClassFromString(_cellName);
        if (cls) {
            cell = [[cls alloc]initWithStyle:0 reuseIdentifier:cellID];
            cell.delegate = self.delegate;
        }else
            NSLog(@"CELL创建失败");
    }
    cell.tableViewModel = [self getIndexPath:indexPath];
    if (cell)   return cell ;
    return [[UITableViewCell alloc]init] ;
}

#pragma mark----设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DwTableViewModel * model = [self getIndexPath:indexPath];
    return model.cell_h;
}

#pragma mark----选中点击一个cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_delegate respondsToSelector:@selector(DwtableView:model:indexPath:)]) {
        [_delegate DwtableView:self model:[self getIndexPath:indexPath] indexPath:indexPath];
    }
}
#pragma mark---获取MODEL
-(DwTableViewModel *)getIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArrays.count <= indexPath.row) {
        return  nil;
    }
    DwTableViewModel * model = self.dataArrays[indexPath.row];
    return model;
}

-(void)ceshiArrays:(NSArray *)arrayDatas
{
    self.dataArrays = [NSMutableArray arrayWithArray:arrayDatas];
    [self.tableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([_delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_delegate scrollViewDidScroll:scrollView];
    }
}

@end
