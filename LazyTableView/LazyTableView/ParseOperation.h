//
//  ParseOperation.h
//  LazyTableView
//
//  Created by 坤坤 on 11-8-15.
//  Copyright 2011年 博客园. All rights reserved.
//

@class AppRecord;

@protocol ParseOperationDelegate;

@interface ParseOperation : NSOperation <NSXMLParserDelegate>
{
@private
    id<ParseOperationDelegate>  delegate;
    
    NSData *dataToParse;
    
    NSMutableArray *workingArray;
    
    AppRecord *workingEntry;
    
    NSMutableString *workingPropertyString;
    
    NSArray *elementsToParse;
    
    BOOL storingCharacterData;
}

-(id)initWithData:(NSData *)data delegate:(id<ParseOperationDelegate>)theDelegate;

@end

@protocol ParseOperationDelegate

-(void)didFinishParsing:(NSArray *)appList;
-(void)parseErrorOccurred:(NSError *)error;

@end

