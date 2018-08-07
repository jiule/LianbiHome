//
//  DwTableViewCell.h
//  DW_kuangjia
//
//  Created by Apple on 2017/10/30.
//  Copyright © 2017年 i-qlady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DwTableViewModel.h"

@class DwTableViewCell;

@protocol  DwTableViewCellDelegate <NSObject>

@optional
-(void)didsel:(DwTableViewCell *)Mycell btn:(UIButton *)btn model:(DwTableViewModel *)MyModel;

-(void)didselview:(DwTableViewCell *)Mycell data:(id)data;

@end

@interface DwTableViewCell : UITableViewCell

//子类重新这个方法
-(void)createCell;

@property(nonatomic,retain)DwTableViewModel * tableViewModel;

@property(nonatomic,assign)id <DwTableViewCellDelegate> delegate;

@property(nonatomic,retain)UIImageView *xianView;

-(void)createcell_h:(CGFloat)cellh BgColor:(UIColor *)BgColor xian_h:(CGFloat)xian_h;
@end
