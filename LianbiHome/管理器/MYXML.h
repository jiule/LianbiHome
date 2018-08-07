//
//  MYXML.h
//  Q-Lady
//
//  Created by Apple on 17/3/20.
//  Copyright © 2017年 Q-Lady. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void (^ XMLString) (NSString * str,int jinbi);

@interface MYXML : NSObject 

-(instancetype)initWithXMLUrlPath:(NSString *)urlPath;

-(void)getDownsWithXMLString:(XMLString)xmlStr;

@end
