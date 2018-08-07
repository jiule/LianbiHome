//
//  MYXML.m
//  Q-Lady
//
//  Created by Apple on 17/3/20.
//  Copyright © 2017年 Q-Lady. All rights reserved.
//

#import "MYXML.h"

@interface MYXML () <NSXMLParserDelegate>

@property(nonatomic,copy)NSString * urlPath;

@property(nonatomic,copy)XMLString xmlStr;
@end

@implementation MYXML

-(instancetype)initWithXMLUrlPath:(NSString *)urlPath
{
    _urlPath = urlPath ;
    if (self = [super init]) {
        
    }
    return self ;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"      //方法弃用
-(void)getDownsWithXMLString:(XMLString)xmlStr
{
    _xmlStr = xmlStr;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:URL(_urlPath)] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSXMLParser *par = [[NSXMLParser alloc]initWithData:received];
    //  NSString *citystring = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    par.delegate = self ;
    [par parse];
}
#pragma clang diagnostic pop
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    int a = [string intValue];
    if (a > 0 && _xmlStr && a < 10000) {
        _xmlStr(string,a);
    }
}
@end
