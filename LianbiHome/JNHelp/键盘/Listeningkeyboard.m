//
//  Listeningkeyboard.m
//  框架
//
//  Created by Apple on 16/9/1.
//  Copyright © 2016年 框架. All rights reserved.
//

#import "Listeningkeyboard.h"


@interface Listeningkeyboard ()

@property(nonatomic,copy)keyboardWillShow boardWillShow;

@property(nonatomic,copy)keyboardWillHide boardWillHide;

@property(nonatomic,assign)float Keyboard_h;

@end

@implementation Listeningkeyboard
XMGSingletoM
-(void)startlistening
{
  //  [self stoplistening];
    //Increase the listening, appearing when the keyboard or change the message
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //Increase the listening, when key to exit the closed out the news
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)stoplistening{
  //  _Keyboard_h = 0;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

//When the keyboard or change calls
- (void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height=keyboardRect.size.height;
    self.Keyboard_h = height ;
    if (_boardWillShow) {
        _boardWillShow(height);
    }
    if ([_delegate respondsToSelector:@selector(keyboardWillShow:)]) {
        [_delegate keyboardWillShow:height];
    }
}
-(void)removelisteningblockcompletion
{
    _boardWillShow = nil;
    _boardWillHide = nil;

}
//When key to exit the call
- (void)keyboardWillHide:(NSNotification *)aNotification{
    JNWeakSelf(self);
    if (_boardWillHide)
    {
        _boardWillHide(weakself.Keyboard_h);
    }

    if ([_delegate respondsToSelector:@selector(keyboardWillHide:)]) {
        [_delegate keyboardWillHide:self.Keyboard_h];
    }
}

-(void)startlisteningblockcompletion:(keyboardWillShow)boardWillShow keyboard:(keyboardWillHide)boardWillHide
{
    if (boardWillHide) {
         _boardWillHide = boardWillHide;
    }
    if (boardWillShow) {
        _boardWillShow = boardWillShow;
    }
}
+(void)endEditing
{
     [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
}

@end
