//
//  SousuoViewController.m
//  LianbiHome
//
//  Created by Apple on 2018/8/8.
//  Copyright © 2018年 LianbiHome. All rights reserved.
//

#import "SousuoViewController.h"
#import "InformationView.h"
#import "InformationModel.h"
#import "DetailVC.h"
#import "MJRefresh.h"
#import "InformationCell.h"
#import "KxformationCell.h"


@interface SousuoViewController ()<InformationViewDelegate,DwTableViewCellDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

{
    NSString * text;
    InformationView * informationView;

    UISearchBar * _searchBar;
    UITextField * _textField;

    UIImageView * _imageView1;
    UIImageView * _imageView2;

}

@property(nonatomic,retain)UIView * downView1;
XH_ATTRIBUTE(strong, UITableView, leftTableView);
XH_ATTRIBUTE(strong, NSMutableArray, leftDataSource);
XH_ATTRIBUTE(strong, UITableView, rightTableView);
XH_ATTRIBUTE(strong, NSMutableArray, rightStrArr);
XH_ATTRIBUTE(strong, NSMutableArray, rightDataSource);
XH_ATTRIBUTE(copy, NSString, rightId);
XH_ATTRIBUTE(copy, NSString, leftId);
@end

@implementation SousuoViewController

-(NSMutableArray *)leftDataSource{
    if (!_leftDataSource) {
        _leftDataSource = [[NSMutableArray alloc] init];
    }
    return _leftDataSource;
}
-(NSMutableArray *)rightDataSource{
    if (!_rightDataSource) {
        _rightDataSource = [[NSMutableArray alloc] init];
    }
    return _rightDataSource;
}
-(NSMutableArray *)rightStrArr{
    if (!_rightStrArr) {
        _rightStrArr = [[NSMutableArray alloc] init];
    }
    return _rightStrArr;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshLeft];
}
-(instancetype)initWithNavTitle:(NSString *)str text:(NSString *)tex{
    text = tex;
    self = [super initWithNavTitle:str];
    if (self) {
        return self ;
    }
    return nil;
}
-(void)createNavView
{
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10,CGNavView_20h() + 7, SCREEN_WIDTH - 80, 30)];
    UIView * bgView = [[UIView alloc]initWithFrame:_searchBar.frame];
    bgView.backgroundColor = [UIColor whiteColor];
    JNViewStyle(bgView, 15, nil, 0);
    _searchBar.backgroundImage = [self makeImageWithView:bgView withSize:CGSizeMake(_searchBar.frame.size.width, _searchBar.frame.size.height)];
    _searchBar.placeholder = @"搜索关键字";
    _searchBar.text = text;
    _searchBar.delegate = self;
    _searchBar.barTintColor = COLOR_WHITE;
    [_searchBar.layer setCornerRadius:15];
    [self.view addSubview:_searchBar];

     UITextField * searchTextField = [_searchBar valueForKey:@"_searchField"];
    searchTextField.backgroundColor = COLOR_WHITE;
    searchTextField.textColor = COLOR_B2;
    //    [searchTextField becomeFirstResponder];
    _textField = searchTextField;

    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70, 7 + CGNavView_20h(), 60, 30)];
    [btn setTitle:@"取消" forState:0];
    [btn titleLabel].font = [UIFont systemFontOfSize:16.5];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:btn];
}
-(void)btnClick
{
    FANHUI_JIUSHITU;
}

-(void)createView{
    float h = self.nav_h;
    InformationView * inforMarinView = [[InformationView alloc]initWithFrame:CGRectMake(0, h, SCREEN_WIDTH, JN_HH(50))];
    inforMarinView.backgroundColor =  COLOR_WHITE;
    inforMarinView.delegate = self ;
    [self.view addSubview:inforMarinView];

    informationView = inforMarinView;

    h += JN_HH(50);
    self.downView1 = JnUIView(CGRectMake(0,h, SCREEN_WIDTH * 2, SCREEN_HEIGHT - self.nav_h - JN_HH(60)), COLOR_BLACK);
    UISwipeGestureRecognizer *swipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(left)];
    swipe.direction =UISwipeGestureRecognizerDirectionLeft;
    [self.downView1 addGestureRecognizer:swipe];
    UISwipeGestureRecognizer *swipe2 =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(right)];
    swipe2.direction =UISwipeGestureRecognizerDirectionRight;
    [self.downView1 addGestureRecognizer:swipe2];
    [self.view addSubview:self.downView1];
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.downView1.frame.size.height) style:0];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.downView1 addSubview: self.leftTableView];
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.downView1.frame.size.height) style:0];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.downView1 addSubview: self.rightTableView];
    self.view.clipsToBounds = YES;
    [self refresh];
}
-(void)InformationView:(InformationView *)informationView index:(int)index{
    [UIView animateWithDuration:0.3 animations:^{
        if (index == 0) {
            [self.downView1 setX:0];
            self.leftTableView.contentOffset = CGPointMake(0, 0);
        }
        else if(index == 1){
            [self.downView1 setX:-SCREEN_WIDTH];
            self.rightTableView.contentOffset = CGPointMake(0, 0);
        }
    }];
}
-(void)refresh{
    //默认【上拉加载】
    self.leftTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreLeft)];
    //默认【上拉加载】
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRight)];
}
-(void)change:(UITableView *)tableView  dataSource:(NSArray *)arr{
    if (arr.count) {
        [tableView reloadData];
        [tableView.mj_footer endRefreshing];
    }
    else
        [tableView.mj_footer endRefreshingWithNoMoreData];
}
-(void)refreshLeft{
    [self.leftDataSource removeAllObjects];
    [self.rightStrArr removeAllObjects];
    [self.rightDataSource removeAllObjects];
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];

    [MyNetworkingManager DDPOSTResqust:@"home/Information/search_all" withparameters:@{@"keyword":text} withVC:self progress:^(NSProgress * _Nonnull pro) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSDictionary * dict = dic[@"zx"];
        if ([dict[@"count"]intValue] == 0) {
            self->_imageView1 = JnImageView(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH), MYimageNamed(@"05_2X"));
            [self.leftTableView addSubview:self->_imageView1];
            self.leftTableView.mj_footer = nil ;
        }else {
            [self->_imageView1 removeFromSuperview];
            self.leftTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreLeft)];
            NSArray * arr = dict[@"list"];
            for (int i = 0; i < arr.count; i ++) {
                NSDictionary * dict1 = arr[i];
                InformationModel * model = [[InformationModel alloc] initWithDict:dict1];
                model.cell_id = self.leftDataSource.count + 1;
                [self.leftDataSource addObject:model];
                if (i == arr.count - 1) {
                    self.leftId = model.information_id;
                }

            }
              [self change:self.leftTableView dataSource:arr];
        }

        NSDictionary * dict2 = dic[@"kx"];
        if ([dict2[@"count"]intValue] == 0) {
            self->_imageView2 = JnImageView(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH), MYimageNamed(@"05_2X"));
            [self.rightTableView addSubview:self->_imageView2];
            self.rightTableView.mj_footer = nil ;
            return  ;
        }else {
            [self->_imageView2 removeFromSuperview];
            self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRight)];
            NSDictionary   * dict1 =  dict2[@"list"];
            for (NSString * timer in dict1.allKeys) {
                NSArray * dataArray = dict1[timer];
                for (int i = 0 ; i < dataArray.count; i++) {
                    KxModel  * model = [[KxModel alloc]initWithDict:dataArray[i]];
                    if ([self.rightStrArr containsObject:timer]) {
                        NSMutableArray * array = self.rightDataSource[[self.rightStrArr indexOfObject:timer]];
                        [array addObject:model];
                    }
                    else{
                        [self.rightStrArr addObject:timer];
                        NSMutableArray * array = [NSMutableArray array];
                        [array addObject:model];
                        [self.rightDataSource addObject:array];
                    }
                    if (i == dataArray.count - 1) {
                        self.rightId = model.kx_id;
                    }
                }
            }
        [self change:self.rightTableView dataSource:dict1.allKeys];
        }
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)analysis:(id)responseObject type:(int)type{
    NSDictionary * dic = (NSDictionary *)responseObject;
    //left
    if (type == 1) {
        NSArray * arr = dic[@"list"];
        for (int i = 0; i < arr.count; i ++) {
            NSDictionary * dict1 = arr[i];
            InformationModel * model = [[InformationModel alloc] initWithDict:dict1];
            model.cell_id = self.leftDataSource.count + 1;
            [self.leftDataSource addObject:model];
            if (i == arr.count - 1) {
                self.leftId = model.information_id;
            }
        }
        [self change:self.leftTableView dataSource:arr];
    }
    else if (type == 2){
        NSDictionary * dict1 = dic[@"list"];
        if ([dict1[@"count"]intValue] == 0) {
            return  ;
        }
        for (NSString * timer in dict1.allKeys) {
            NSArray * dataArray = dict1[timer];
            for (int i = 0 ; i < dataArray.count; i++) {
                KxModel  * model = [[KxModel alloc]initWithDict:dataArray[i]];
                if ([self.rightStrArr containsObject:timer]) {
                    NSMutableArray * array = self.rightDataSource[[self.rightStrArr indexOfObject:timer]];
                    [array addObject:model];
                }
                else{
                    [self.rightStrArr addObject:timer];
                    NSMutableArray * array = [NSMutableArray array];
                    [array addObject:model];
                    [self.rightDataSource addObject:array];
                }
                if (i == dataArray.count - 1) {
                    self.rightId = model.kx_id;
                }
            }
        }
        [self change:self.rightTableView dataSource:dict1.allKeys];
    }
}
-(void)loadMoreLeft{
    if (!self.leftId ) {
        [self.leftTableView.mj_footer endRefreshing];
        return ;
    }
    [MyNetworkingManager DDPOSTResqust:@"home/Information/search_info" withparameters:@{@"keyword":text,@"id":self.leftId,@"type":@"1"} withVC:self progress:^(NSProgress * _Nonnull pro) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self analysis:responseObject type:1];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)loadMoreRight{
    if (!self.rightId) {
        [self.rightTableView.mj_footer endRefreshing];
        return ;
    }
    [MyNetworkingManager DDPOSTResqust:@"home/Information/search_info" withparameters:@{@"keyword":text,@"id":self.rightId,@"type":@"2"} withVC:self progress:^(NSProgress * _Nonnull pro) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self analysis:responseObject type:2];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.rightTableView) {
        return self.rightStrArr.count;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.leftDataSource.count;
    }
    NSArray * arr = self.rightDataSource[section];
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        NSString * cellID = [NSString stringWithFormat:@"%zd%zd",indexPath.row,indexPath.length];
        InformationCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[InformationCell alloc] initWithStyle: 0 reuseIdentifier:cellID];
        }
        cell.tableViewModel = self.leftDataSource[indexPath.row];
        return cell;
    }
    KxformationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"right"];
    if (!cell) {
        cell = [[KxformationCell alloc] initWithStyle: 0 reuseIdentifier:@"right"];
        cell.delegate = self;
    }
    cell.tableViewModel = self.rightDataSource[indexPath.section][indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        InformationModel * model = self.leftDataSource[indexPath.row];
        DetailVC *vc = [[DetailVC alloc]init];
        vc.Id = model.information_id;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        KxModel * model = self.rightDataSource[indexPath.section][indexPath.row];
        model.is_down = !model.is_down;
        if (model.is_down) {
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
        else
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        InformationModel * model = self.leftDataSource[indexPath.row];
        return model.cell_h;
    }
    KxModel * model = self.rightDataSource[indexPath.section][indexPath.row];
    return model.cell_h;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightTableView) {
        UIView * view = JnUIView(CGRectMake(0, 0, SCREEN_WIDTH, JN_HH(40)), [UIColor groupTableViewBackgroundColor]);
        UILabel * label = JnLabel(CGRectMake(JN_HH(20), JN_HH(10), SCREEN_WIDTH - JN_HH(40), JN_HH(20)), @"", JN_HH(14.5), COLOR_RED, 0);
        if (self.rightStrArr.count > section) {
            label.text = [self  readTimerWithStr:self.rightStrArr[section]];
        }
        [view addSubview:label];
        return view;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return 0.01;
    }
    return JN_HH(40);
}
-(NSString *)readTimerWithStr:(NSString *)str{
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
-(void)left{
    [UIView animateWithDuration:0.3 animations:^{
        [self.downView1 setX:-SCREEN_WIDTH];
        [self->informationView showWithLeftBtn:YES];
    }];
}
-(void)right{
    [UIView animateWithDuration:0.3 animations:^{
        [self.downView1 setX:0];
        [self->informationView showWithLeftBtn:NO];
    }];
}
-(void)didsel:(DwTableViewCell *)Mycell btn:(UIButton *)btn model:(DwTableViewModel *)MyModel{
    if (btn.tag == 102) {
        return ;
    }


    NSArray * array = @[@"bull_vote",@"bad_vote"];
    KxModel * model = (KxModel *)MyModel;
    KxformationCell * cell = (KxformationCell *)Mycell;
    
    [MyNetworkingManager POST:@"home/Information/evaluate" parameters:@{@"sign":array[btn.tag -100],@"id":model.kx_id}  progress:^(NSProgress * _Nonnull progress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * dict  = responseDict[@"data"];
        model.bad_vote = [NSString stringWithFormat:@"%@",dict[@"bad_vote"]];
        model.bull_vote = [NSString stringWithFormat:@"%@",dict[@"bull_vote"]];
       // model.evaluate = array[btn.tag -100];
        cell.tableViewModel = model;
        if ([model.evaluate isEqualToString:array[btn.tag -100]]) {
            model.evaluate = @"";
        }else {
            model.evaluate = array[btn.tag -100];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [Listeningkeyboard endEditing];
    if (searchBar.text.length > 0) {
        NSArray * downArray = [MyUserDefaultsManager objectForKey:DWSEATCHBAR];
        NSMutableArray * array =[NSMutableArray arrayWithArray:downArray];
        [array insertObject:searchBar.text atIndex:0];
        [MyUserDefaultsManager setObject:array forkey:DWSEATCHBAR];
        text = searchBar.text;
        [self refreshLeft];

    }
}


#pragma mark 生成image
- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
