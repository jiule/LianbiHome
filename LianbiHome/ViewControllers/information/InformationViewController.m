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



@interface InformationViewController () <DWSearchBarViewDelegate,UIScrollViewDelegate,DwTableViewDelegate,DwTableViewCellDelegate,InformationViewDelegate>
{
    ShufflingView * _ffilingView;
    InformationView * _informationView;


    int _page;
    NSString * _post_id;
    float _down1_swipe;

    int _index;


    int _is_left;
}

@property(nonatomic,retain)NSMutableArray * arrayDatas1;

@property(nonatomic,retain)NSMutableArray * arrayDatas2;

@property(nonatomic,retain)UIScrollView * downScrollView;

@property(nonatomic,retain)UIView * downView1;

@property(nonatomic,retain)DwTableView * tableView;

@property(nonatomic,retain)DwTableView * tableView1;

@end


@implementation InformationViewController




-(void)createView
{

    _page = 1;
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
    [self.downScrollView addSubview:hearView];

    UIView * downView1 = JnUIView(CGRectMake(0, hearView.height, SCREEN_WIDTH * 2, SCREEN_HEIGHT - self.nav_h - JN_HH(60)), COLOR_BLACK);
    [self.downScrollView addSubview:downView1];

    [downView1 addpanGestureTecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {

        UIPanGestureRecognizer * pan = (UIPanGestureRecognizer *)tap;
        CGPoint position =[pan translationInView:view];


        //通过stransform 进行平移交换
        view.transform = CGAffineTransformTranslate(view.transform, position.x, 0);

        if (pan.state == UIGestureRecognizerStateBegan) {
            self->_is_left = 1;
            NSLog(@"%f",position.x);
            if (position.x > 0) {
                self->_is_left = 1;
                NSLog(@"555555");
            }else if(position.x < 0){
                self->_is_left = 0;
                NSLog(@"666666");
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
        NSLog(@"%f",[view getX]);
        if (pan.state == UIGestureRecognizerStateEnded ) {
            if ([view getX] <= -SCREEN_WIDTH / 3 && self->_is_left == 1) {
                [UIView animateWithDuration:0.3 animations:^{
                    [view setX:0];
                    [self->_informationView showWithLeftBtn:NO];
                }];
                NSLog(@"111111");
            }else if([view getX] <= -SCREEN_WIDTH / 3  && self->_is_left == 0){
                [UIView animateWithDuration:0.3 animations:^{
                    [view setX:-SCREEN_WIDTH];
                     [self->_informationView showWithLeftBtn:YES];
                }];
                NSLog(@"2222222");
            }else {
                if (self->_is_left == 1) {
                    [UIView animateWithDuration:0.3 animations:^{
                        [view setX:-SCREEN_WIDTH];
                         [self->_informationView showWithLeftBtn:YES];
                    }];
                    NSLog(@"333333");
                }else if(self->_is_left == 0){
                    [UIView animateWithDuration:0.3 animations:^{
                        [view setX:0];
                         [self->_informationView showWithLeftBtn:NO];
                    }];
                    NSLog(@"44444");
                }
            }
        }

    }];

    self.downView1 = downView1;

    self.tableView  = [DwTableView initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h - JN_HH(60)) url:URL(@"home/App/zx_list") modelName:@"InformationModel" cellName:@"InformationCell" delegate:self];
    self.tableView.is_data = YES;
    self.tableView.is_up = NO;
    [downView1 addSubview:[self.tableView readTableView]];

    self.tableView1  = [DwTableView initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h - JN_HH(60)) url:URL(@"home/Information/newsflash_list") modelName:@"InformationModel" cellName:@"InformationCell" delegate:self];
    self.tableView1.is_data = YES;
    self.tableView1.is_up = NO;
    [downView1 addSubview:[self.tableView readTableView]];

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
            if (scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.height <= JN_HH(200)) {
                _page++;
                [self tableViewDownWithPage:_page];
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
    [self.tableView downWithdict:@{} index:_page];
   // [self.tableView1 downWithdict:@{} index:_page];
  //  [self postdownDatas:@"home/Information/newsflash_list" withdict:@{} index:501];
}



-(void)tableViewDownWithPage:(int)page
{
    if (_index == 1) {
        if (_page <= 1) {
            [self.tableView downWithdict:@{} index:_page];
        }else {
            [self.tableView downWithdict:@{@"post_id":_post_id} index:_page];
        }
    }else if(_index == 2)
    {
        if (_page <= 1) {
            [self.tableView1 downWithdict:@{} index:_page];
        }else {
            [self.tableView1 downWithdict:@{@"post_id":_post_id} index:_page];
        }
    }


}

-(void)DwtableView:(DwTableView *)tableView downDatasWithDict:(NSDictionary *)dict index:(int)index
{
    if (index == 1) {
         NSArray * array = dict[@"data"][@"pic"];
        NSMutableArray * ffilingArray = [NSMutableArray array];
        for ( int i = 0 ; i < array.count; i++) {
            NSDictionary * arrayDict = array[i];
            [ffilingArray addObject:TUPIANURL(arrayDict[@"image"])];
        }
        [_ffilingView showWithImageUrlPaths:ffilingArray didShuffling:^(ShufflingView *shufflingView, int index) {

        }];
        NSLog(@"%@",dict);
    }
}



-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if (index == 1) {
        NSArray * array = responseDict[@"pic"];
        NSMutableArray * ffilingArray = [NSMutableArray array];
        for ( int i = 0 ; i < array.count; i++) {
            NSDictionary * arrayDict = array[i];
            [ffilingArray addObject:TUPIANURL(arrayDict[@"image"])];
        }
        [_ffilingView showWithImageUrlPaths:ffilingArray didShuffling:^(ShufflingView *shufflingView, int index) {

        }];
        NSLog(@"%@",responseDict);
       
    }else     if (index == 501) {
        NSLog(@"%@",responseDict);
    }
}

-(void)dwtableView:(DwTableView *)tableView downModel:(DwTableViewModel *)myTableViewModel
{
    InformationModel * model = (InformationModel *)myTableViewModel;
    _post_id = model.information_id;
}


-(void)swipeAction:(UISwipeGestureRecognizer *)swipe
{

    if ( swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self.downView1 setX:SCREEN_WIDTH];
    }else if(swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self.downView1 setX:0];
    }
}

-(void)InformationView:(InformationView *)informationView index:(int)index
{

}

@end
