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

#import "KXTableView.h"
#import "DetailVC.h"
#import "SousuoViewController.h"
#import "KxformationCell.h"
#import <UIImage+GIF.h>


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

    BOOL _isgif;
}

@property(nonatomic,retain)NSMutableArray * arrayDatas1;

@property(nonatomic,retain)NSMutableArray * arrayDatas2;

@property(nonatomic,retain)UIScrollView * downScrollView;

@property(nonatomic,retain)UIView * downView1;

@property(nonatomic,retain)DwTableView * tableView;

@property(nonatomic,retain)KXTableView * tableView1;



@end


@implementation InformationViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_isgif) {
        UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"qidong02" ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        UIImage *image = [UIImage sd_animatedGIFWithData:data];
        gifImageView.image = image;
        [self.view addSubview:gifImageView];
        [Helpr dispatch_queue_t_timer:3 send:^{
            [gifImageView removeFromSuperview];
            self-> _isgif = YES;
        }];
    }
}




-(void)createNavView
{
    [super createNavView];

    self.navView.backgroundColor = SXRGB16Color(0xff7147);

    [self.navView addSubview:JnImageView(CGRectMake(10, CGNavView_20h() +14 , 78, 16), MYimageNamed(@"logo"))];


    UIView * bgView = JnUIView(CGRectMake(100, CGNavView_20h() + 5, SCREEN_WIDTH - 120, 34), COLOR_W(0.7));
    JNViewStyle(bgView, 17, nil, 0);
    [self.navView addSubview:bgView];
    [bgView addSubview:JnImageView(CGRectMake(bgView.width / 2 - 45, 10 , 15, 15), MYimageNamed(@"01_search_pre"))];
    [bgView addSubview:JnLabel(CGRectMake(bgView.width / 2 - 20, 7 , 60, 20), @"搜索", JN_HH(13.5), COLOR_B3, 0)];

    [bgView addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
        DWSearchBarView * view1 = [[DWSearchBarView alloc]initWithFrame:self.view.bounds];
        view1.delegate = self ;
        [view1 showWithVc:self];
    }];
}


-(void)createView
{

    _page1 = 1;
    _page2 = 1;
    _index = 1;
    UIScrollView * scrollView = JnScrollView(CGRectMake(0, self.nav_h, self.view.width, SCREEN_HEIGHT - self.nav_h), COLOR_WHITE);
    //  scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.downScrollView = scrollView;

    UIView * hearView = JnUIView(CGRectMake(0, 0, SCREEN_WIDTH, JN_HH(170) + JN_HH(50)), COLOR_B5);
    _ffilingView = [[ShufflingView alloc]initWithFrame:CGRectMake(0, 0, scrollView.width, JN_HH(170)) BgColor:COLOR_WHITE];

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

    self.tableView1  = [KXTableView initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h - JN_HH(50)) url:URL(@"home/Information/newsflash_list") modelName:@"KxModel" cellName:@"KxformationCell" delegate:self];
    self.tableView1.is_up = NO;
    self.tableView1.is_arrayDatas = YES;
    [downView1 addSubview:self.tableView1.tableView];

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
    }
}

-(void)dwtableView:(DwTableView *)tableView downModel:(DwTableViewModel *)myTableViewModel
{
    if ([myTableViewModel class] ==[InformationModel class]) {
        InformationModel * model = (InformationModel *)myTableViewModel;
        _post_id1 = model.information_id;
    }else if([myTableViewModel class] ==[KxModel class]) {
        KxModel * model = (KxModel *)myTableViewModel;
        _post_id2 = model.kx_id ;
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
    SousuoViewController * vc = [[SousuoViewController alloc]initWithNavTitle:@"" text:text];
    [self.navigationController pushViewController:vc animated:YES];
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
    }else {
        KxModel * model = (KxModel * )myTableViewModel;
        model.is_down = !model.is_down;
        KXTableView * table = (KXTableView *)tableView;
        if (model.is_down) {
             [table.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }else {
            [table.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}



-(void)didsel:(DwTableViewCell *)Mycell btn:(UIButton *)btn model:(DwTableViewModel *)MyModel
{
    NSArray * array = @[@"bull_vote",@"bad_vote"];
    KxModel * model = (KxModel *)MyModel;
    KxformationCell * cell = (KxformationCell *)Mycell;

    [MyNetworkingManager POST:@"home/Information/evaluate" parameters:@{@"sign":array[btn.tag -100],@"id":model.kx_id}  progress:^(NSProgress * _Nonnull progress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * dict  = responseDict[@"data"];
        model.bad_vote = [NSString stringWithFormat:@"%@",dict[@"bad_vote"]];
        model.bull_vote = [NSString stringWithFormat:@"%@",dict[@"bull_vote"]];
        model.evaluate = array[btn.tag -100];
        cell.tableViewModel = model;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];


}



@end
