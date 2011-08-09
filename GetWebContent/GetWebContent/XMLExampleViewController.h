//
//  XMLExampleViewController.h
//  GetWebContent
//
//  Created by 坤坤 on 11-8-8.
//  Copyright 2011年 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMLExampleViewController : UIViewController <NSXMLParserDelegate>
{
    //XML 解析器
    NSXMLParser *parser;
    
    //保存解析得到的数据
    NSMutableArray *articles;
    
    
    NSString *currentElement;
    NSMutableString *currentTitle;
    NSMutableString *currentGuid;
    NSMutableString *pudDate;
    
    BOOL itemActive;
    
}

@end
