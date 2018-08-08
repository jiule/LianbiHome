//
//  KXTableView.h
//  LianbiHome
//
//  Created by Apple on 2018/8/7.
//  Copyright © 2018年 LianbiHome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DwTableView.h"

@interface KXTableView : DwTableView

@property(nonatomic,assign)id < DwTableViewDelegate ,DwTableViewCellDelegate > delegate;

+(KXTableView *)initWithFrame:(CGRect)frame url:(NSString *)url modelName:(NSString *)modelName cellName:(NSString *)cellName delegate:(id <DwTableViewDelegate , DwTableViewCellDelegate>)delegate;

@property(nonatomic,retain)UITableView * tableView;

-(void)downWithdict:(NSObject *)dict index:(int)index;

@end
