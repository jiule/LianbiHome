//
//  InformationViewController.m
//  LianbiHome
//
//  Created by Apple on 2018/8/6.
//  Copyright © 2018年 LianbiHome. All rights reserved.
//

#import "InformationViewController.h"
#import "DWSearchBarView.h"
#import "ShufflingView.h"
#import "InformationView.h"
#import "DwTableView.h"
#import "InformationModel.h"
#import "DetailVC.h"



@interface InformationViewController () <DWSearchBarViewDelegate,UIScrollViewDelegate,DwTableViewDelegate,DwTableViewCellDelegate,InformationViewDelegate>
{
    ShufflingView * _ffilingView;
    InformationView * _informationView;


    int _page1;
    BOOL _is_down1;
    int _page2;
    BOOL _is_down2;
    NSString * _post_id1;  //当前下载的最后一个 订单id
    NSString * _post_id2;

    int _index;  //当前显示的 tableview


    int _is_left; //记录是左滑还是右滑动
}

@property(nonatomic,retain)NSMutableArray * arrayDatas1;

@property(nonatomic,retain)NSMutableArray * arrayDatas2;

@property(nonatomic,retain)UIScrollView * downScrollView;

@property(nonatomic,retain)UIView * downView1;

@property(nonatomic,retain)DwTableView * tableView;

@property(nonatomic,retain)DwTableView * tableView1;

@end


@implementation InformationViewController

-(void)createNavView
{
    [super createNavView];
    self.navView.backgroundColor = SXRGB16Color(0xff7147);
    UIView * bgView = JnUIView(CGRectMake(100, CGNavView_20h() + 5, SCREEN_WIDTH - 120, 34), COLOR_W(0.7));
    JNViewStyle(bgView, 17, nil, 0);
    [self.navView addSubview:bgView];

    [bgView addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
        DWSearchBarView * view1 = [[DWSearchBarView alloc]initWithFrame:self.view.bounds];
        view1.delegate = self ; 
        [view1 showWithVc:self];
    }];

//  UISearchBar * _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10,CGNavView_20h() + 7, SCREEN_WIDTH - 80, 30)];
//   // UIView * bgView = [[UIView alloc]initWithFrame:_searchBar];
//   // bgView.backgroundColor = COLOR_W(0.7);
//    [_searchBar addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
//        DWSearchBarView * view1 = [[DWSearchBarView alloc]initWithFrame:self.view.bounds];
//        [view1 showWithVc:self];
//    }];
//    _searchBar.placeholder = @"搜索";
//    _searchBar.delegate = self;
//    //   _searchBar.barTintColor = COLOR_WHITE;
//    [self.navView addSubview:_searchBar];

}


-(void)createView
{

    _page1 = 1;
    _page2 = 1;
    _index = 1;
    UIScrollView * scrollView = JnScrollView(CGRectMake(0, self.nav_h, SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h), COLOR_WHITE);
  //  scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.downScrollView = scrollView;


    UIView * hearView = JnUIView(CGRectMake(0, 0, SCREEN_WIDTH, JN_HH(170) + JN_HH(50)), COLOR_B5);
    _ffilingView = [[ShufflingView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, JN_HH(170)) BgColor:COLOR_WHITE];
    [hearView addSubview:_ffilingView];

    InformationView * inforMarinView = [[InformationView alloc]initWithFrame:CGRectMake(0, JN_HH(170), SCREEN_WIDTH, JN_HH(50))];
    inforMarinView.backgroundColor =  COLOR_WHITE;
    inforMarinView.delegate = self ;
    [hearView addSubview:inforMarinView];

    _informationView = inforMarinView;
    [self.downScrollView addSubview:hearView];

    UIView * downView1 = JnUIView(CGRectMake(0, hearView.height, SCREEN_WIDTH * 2, SCREEN_HEIGHT - self.nav_h - JN_HH(60)), COLOR_BLACK);
    [self.downScrollView addSubview:downView1];

    [downView1 addpanGestureTecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {

        UIPanGestureRecognizer * pan = (UIPanGestureRecognizer *)tap;
        CGPoint position = [pan translationInView:view];
        if (position.y > 10 && fabs(position.x) < 20 ) {
            CGPoint  pooint = self.downScrollView.contentOffset;
            pooint.y = pooint.y - position.y;
            if (pooint.y<=0) {
                pooint.y  = 0 ;
            }
            self.downScrollView.contentOffset = pooint;
            //将增量置为零
            [pan setTranslation:CGPointZero inView:view];
            return  ;
        }
        //通过stransform 进行平移交换
        view.transform = CGAffineTransformTranslate(view.transform, position.x, 0);

        if (pan.state == UIGestureRecognizerStateBegan) {
            self->_is_left = -1;
            if (position.x > 0) {
                self->_is_left = 1;
            }else if(position.x < 0){
                self->_is_left = 0;
            }
        }
        //将增量置为零
        [pan setTranslation:CGPointZero inView:view];

        if ([view getX] <= -SCREEN_WIDTH ) {
            [view setX:-SCREEN_WIDTH];
        }else if([view getX] >= 0)
        {
            [view setX:0];
        }
        if (pan.state == UIGestureRecognizerStateEnded ) {
            if ([view getX] >= -SCREEN_WIDTH / 5  * 4&& self->_is_left == 1) {
                [UIView animateWithDuration:0.3 animations:^{
                    [view setX:0];
                    [self->_informationView showWithLeftBtn:NO];
                }];
            }else if([view getX] <= -SCREEN_WIDTH / 3  && self->_is_left == 0){
                [UIView animateWithDuration:0.3 animations:^{
                    [view setX:-SCREEN_WIDTH];
                    [self->_informationView showWithLeftBtn:YES];
                }];
            }else {
                if (self->_is_left == 1) {
                    [UIView animateWithDuration:0.3 animations:^{
                        [view setX:-SCREEN_WIDTH];
                         [self->_informationView showWithLeftBtn:YES];
                    }];
                }else if(self->_is_left == 0){
                    [UIView animateWithDuration:0.3 animations:^{
                        [view setX:0];
                         [self->_informationView showWithLeftBtn:NO];
                    }];
                }else {
                    if ([view getX] >= -SCREEN_WIDTH / 2) {
                        [UIView animateWithDuration:0.3 animations:^{
                            [view setX:0];
                            [self->_informationView showWithLeftBtn:NO];
                        }];
                    }else {
                        [UIView animateWithDuration:0.3 animations:^{
                            [view setX:-SCREEN_WIDTH];
                            [self->_informationView showWithLeftBtn:YES];

                        }];
                    }
                }
            }
        }

    }];

    self.downView1 = downView1;

    self.tableView  = [DwTableView initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h - JN_HH(50)) url:URL(@"home/App/zx_list") modelName:@"InformationModel" cellName:@"InformationCell" delegate:self];
    self.tableView.is_data = YES;
    self.tableView.is_up = NO;
    [downView1 addSubview:[self.tableView readTableView]];

    self.tableView1  = [DwTableView initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h - JN_HH(50)) url:URL(@"home/Information/newsflash_list") modelName:@"KxformationModel" cellName:@"KxformationCell" delegate:self];
    self.tableView1.is_up = NO;
    self.tableView1.is_arrayDatas = YES;
    [downView1 addSubview:[self.tableView1 readTableView]];

    self.downScrollView.contentSize = CGSizeMake(0, hearView.height + downView1.height);
    self.downScrollView.bounces = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.downScrollView) {
    }else {
        if (self.downScrollView.contentOffset.y < JN_HH(169) || scrollView.contentOffset.y < 0) {
            CGPoint point = CGPointMake(0, self.downScrollView.contentOffset.y + scrollView.contentOffset.y);
            if (point.y <= 0) {
                point.y  = 0;
            }else if(point.y >= JN_HH(170))
            {
                point.y  = JN_HH(170);
            }
            self.downScrollView.contentOffset = point;
            scrollView.contentOffset = CGPointMake(0, 0);
        }else {
            if ([scrollView isEqual:[_tableView readTableView]]) {
                if (scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.height <= JN_HH(200)) {
                    if (!_is_down1 ) {
                        _page1++;
                        [self tableViewDownWithPage:_page1];
                        _is_down1 = YES;
                    }
                }
            }else {
                if (scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.height <= JN_HH(200)) {
                    if (!_is_down2) {
                        _page2++;
                        [self tableViewDownWithPage:_page2];
                        _is_down2 = YES;
                    }

                }
            }

        }
    }
    [self load];
}

-(void)load
{
    if (self.downScrollView.contentOffset.y < _ffilingView.height) {

    }else {

    }
}
-(void)downData
{
    [self.tableView downWithdict:@{} index:_page1];
    [self.tableView1 downWithdict:@{} index:_page2];
}
-(void)tableViewDownWithPage:(int)page
{
    if (_index == 1) {
        if (_page1 <= 1) {
            [self.tableView downWithdict:@{} index:_page1];
        }else {
            [self.tableView downWithdict:@{@"post_id":_post_id1} index:_page1];
        }
    }else if(_index == 2)
    {
        if (_page2 <= 1) {
            [self.tableView1 downWithdict:@{} index:_page2];
        }else {
            [self.tableView1 downWithdict:@{@"post_id":_post_id2} index:_page2];
        }
    }
}

-(void)DwtableView:(DwTableView *)tableView downDatasWithDict:(NSDictionary *)dict index:(int)index
{
    if(tableView == self.tableView){
        if (index == 1) {
            NSArray * array = dict[@"data"][@"pic"];
            NSMutableArray * ffilingArray = [NSMutableArray array];
            for ( int i = 0 ; i < array.count; i++) {
                NSDictionary * arrayDict = array[i];
                [ffilingArray addObject:TUPIANURL(arrayDict[@"image"])];
            }
            [_ffilingView showWithImageUrlPaths:ffilingArray didShuffling:^(ShufflingView *shufflingView, int index) {

            }];
        }
        [Helpr dispatch_queue_t_timer:2 send:^{
            self->_is_down1 = NO;
        }];
    }else {
        if (index <= 1) {
            [tableView.readArrays removeAllObjects];
        }
        NSDictionary   * dict1 =  [dict objectForKey:@"data"];
        for (NSString * timer in dict1.allKeys) {
            NSArray * dataArray = dict1[timer];
            for (int i = 0 ; i < dataArray.count; i++) {
                KxModel  * model2342 = [[KxModel alloc]initWithDict:dataArray[i]];
                for (int j = 0 ; j < tableView.readArrays.count; j++) {
                    KxformationModel * arrayModel = tableView.readArrays[j];
                    if ([arrayModel.kx_timer isEqualToString:timer]) {
                        [arrayModel.dataArrays addObject:model2342];
                    }else if(j == tableView.readArrays.count - 1)
                    {
                      //  NSLog(@"111111111");
                        KxformationModel * tianModel = [[KxformationModel alloc]init];
                        tianModel.kx_timer = timer;
                        [tianModel.dataArrays addObject:model2342];
                        [tableView.readArrays addObject:tianModel];
                        j = j +2;
                    }
                }
                if (tableView.readArrays.count == 0) {
                    KxformationModel * tianModel = [[KxformationModel alloc]init];
                    tianModel.kx_timer = timer;
                    [tianModel.dataArrays addObject:model2342];
                    [tableView.readArrays addObject:tianModel];
                }
                if (i == dataArray.count - 1) {
                    _post_id2 = model2342.kx_id;

                }
            }
        }
        [Helpr dispatch_queue_t_timer:2 send:^{
            self->_is_down2 = NO;
        }];
        [[tableView readTableView ]reloadData];

    }
}

-(void)dwtableView:(DwTableView *)tableView downModel:(DwTableViewModel *)myTableViewModel
{
    if (_index == 1) {
        InformationModel * model = (InformationModel *)myTableViewModel;
        _post_id1 = model.information_id;
    }else if(_index == 2){

    }

}
-(void)InformationView:(InformationView *)informationView index:(int)index
{

    [UIView animateWithDuration:0.3 animations:^{
        if (index == 0) {
            [self.downView1 setX:0];
            self->_index = 1;
            [self->_tableView readTableView].contentOffset = CGPointMake(0, 0);
        }else if(index == 1)
        {
            [self.downView1 setX:-SCREEN_WIDTH];
            self->_index = 2;
            [self->_tableView1 readTableView].contentOffset = CGPointMake(0, 0);
        }
    }];
}


-(void)DWSearchBarView:(DWSearchBarView *)seatchBarView text:(NSString *)text
{
    NSLog(@"%@",text);
    //跳转 搜索页面
}

-(void)DwtableView:(DwTableView *)tableview refresh:(int)page
{
    [self tableViewDownWithPage:page];
}
-(void)DwtableView:(DwTableView *)tableView model:(DwTableViewModel *)myTableViewModel indexPath:(NSIndexPath *)indexPath
{
    if (_index == 1) {
        InformationModel * model = (InformationModel *)myTableViewModel;
        DetailVC *vc = [[DetailVC alloc]init];
        vc.Id = model.information_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
