//
//  KXTableView.m
//  LianbiHome
//
//  Created by Apple on 2018/8/7.
//  Copyright © 2018年 LianbiHome. All rights reserved.
//

#import "KXTableView.h"
#import "InformationModel.h"

@interface KXTableView()<UITableViewDelegate,UITableViewDataSource>
{
    int _page;
    BOOL _isDown;
}

@property(nonatomic,copy)NSString * url;

@property(nonatomic,copy)NSString * modelName;

@property(nonatomic,copy)NSString * cellName;

//这是保存的请求数据
@property(nonatomic,retain)NSMutableArray * dataArrays;

@property(nonatomic,retain)NSMutableArray * hearArrays;
//记录是不是正在下载  YES是正在下载
@property(nonatomic,assign)BOOL is_down;

@end

@implementation KXTableView

-(NSMutableArray *)hearArrays
{
    if (!_hearArrays) {
        _hearArrays = [NSMutableArray array];
    }
    return _hearArrays;
}

-(NSMutableArray *)dataArrays
{
    if (!_dataArrays) {
        _dataArrays = [NSMutableArray array];
    }
    return _dataArrays;
}

+(KXTableView *)initWithFrame:(CGRect)frame url:(NSString *)url modelName:(NSString *)modelName cellName:(NSString *)cellName delegate:(id <DwTableViewDelegate , DwTableViewCellDelegate>)delegate
{
    KXTableView * tableview = [[KXTableView alloc]init];
    tableview.url = url;
    tableview.modelName = modelName;
    tableview.cellName = cellName;
    tableview.delegate = delegate;
    tableview.tableView = [[UITableView alloc]initWithFrame:frame];
    tableview.tableView.dataSource = tableview;
    tableview.tableView.delegate = tableview;
    tableview.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableview;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArrays.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSArray * array = self.dataArrays[section];
    return array.count;
}


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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = JnUIView(CGRectMake(0, 0, SCREEN_WIDTH, JN_HH(40)), [UIColor groupTableViewBackgroundColor]);
    UILabel * label = JnLabel(CGRectMake(JN_HH(20), JN_HH(5), SCREEN_WIDTH - JN_HH(40), JN_HH(20)), @"", JN_HH(14.5), SXRGB16Color(0xff7147), 0);
    if (self.hearArrays.count > section) {
            label.text = [self  readTimerWithStr:self.hearArrays[section]];
    }
    [view addSubview:label];
    return view;
}

-(DwTableViewModel *)getIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArrays.count <= indexPath.section) {
        return  nil;
    }
    NSArray * array = self.dataArrays[indexPath.section];

    DwTableViewModel * model = array[indexPath.row];
    return model;
}


-(void)downWithdict:(NSObject *)dict index:(int)index
{
    if (!_url && _isDown) {
        NSLog(@"URL 不存在===%@",_url);
        return ;
    }
    //保存 我要下载数据了
    _isDown = YES;
    _page = index ;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->_page ++;
        [self->_tableView.mj_footer endRefreshing];
        if ([self.delegate respondsToSelector:@selector(DwtableView:refresh:)]) {
            [self.delegate DwtableView:self refresh:self->_page];
        }
    }];

    //请求数据
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:_url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //通知代理下载好数据了
        if([self.delegate respondsToSelector:@selector(DwtableView:downDatasWithDict:index:)])        {
            [self.delegate DwtableView:self downDatasWithDict:responseDict index:index];
        }
        [self arrayDatasDict:responseDict index:index];
        //判断是不是没有更多的数据了
        //      [self.tableView.mj_footer endRefreshingWithNoMoreData];
        self.is_down = NO;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.is_down = NO;
    }];
}

-(void)arrayDatasDict:(NSDictionary *)dict index:(int)index
{
//    NSLog(@"%@",dict);
//    return ;
    NSDictionary   * dict1 =  [dict objectForKey:@"data"];
    for (NSString * timer in dict1.allKeys) {
        NSArray * dataArray = dict1[timer];
        for (int i = 0 ; i < dataArray.count; i++) {
            KxModel  * model2342 = [[KxModel alloc]initWithDict:dataArray[i]];
            for (int j = 0 ; j < self.hearArrays.count; j++) {
                NSString * str = self.hearArrays[j];
                if ([str isEqualToString:timer]) {
                     NSMutableArray * array = self.dataArrays[j];
                     [array addObject:model2342];
                }else if(j == self.hearArrays.count - 1)
                {
                    [self.hearArrays addObject:str];
                    NSMutableArray * array = [NSMutableArray array];
                    [array addObject:model2342];
                    [self.dataArrays addObject:array];
                    j = j +2;
                }
            }
            if (self.hearArrays.count == 0) {
                [self.hearArrays addObject:timer];
                NSMutableArray * array = [NSMutableArray array];
                [array addObject:model2342];
                [self.dataArrays addObject:array];
            }
            if (i == dataArray.count - 1) {
                if ([self.delegate respondsToSelector:@selector(dwtableView:downModel:)]) {
                    [self.delegate dwtableView:self downModel:model2342];
                }
            }
        }
    }

}

-(NSString *)readTimerWithStr:(NSString *)str
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[str integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    date = [formatter  dateFromString:str];
    NSString * dateTime = [formatter stringFromDate:date];  //显示时间
    NSString * week = [Helpr weekdayStringFromDate:date];   //显示星期
    NSString * str1 = @"";
    NSString * timerDate = [formatter stringFromDate:[NSDate date]];
    if ([timerDate isEqualToString:dateTime]) {
        str1 = @"今天  ";
    }
    NSString * ztimerDate = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:3600 * 24]];
    if ([ztimerDate isEqualToString:dateTime]) {
        str1 = @"昨天  ";
    }
    return  [NSString stringWithFormat:@"%@%@  %@ ",str1,dateTime,week];
}
@end
