//
//  GeneralViewController.h
//  kyzx
//
//  Created by simon on 16/5/17.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeneralViewController : UIViewController

@property (nonatomic, retain) UIView* naviView;
@property (nonatomic, retain) UIView* bodyView;

-(void)setMiddleTitle:(NSString*)title;

@end



/////////////////////////////////////
@interface LeftButtonItem : UIView
@property(nonatomic,retain) UIButton* navLeftButton;
-(id)initWithStr:(NSString*)str target:(id)target action:(SEL)action;
-(id)initWithNormalImg:(NSString*)imgName selectedImg:(NSString*)selectedImgName target:(id)target action:(SEL)action;
@end


@interface RightButtonItem : UIView
@property(nonatomic,retain) UIButton* navRightButton;
-(id)initWithStr:(NSString*)str target:(id)target action:(SEL)action;
-(id)initWithNormalImg:(NSString*)imgName selectedImg:(NSString*)selectedImgName target:(id)target action:(SEL)action;
-(void)setRightButtonItemContentEdgeInsetsWith:(UIEdgeInsets)insets;
@end