//
//  IconDownloader.m
//  LazyTableView
//
//  Created by 坤坤 on 11-8-15.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "IconDownloader.h"
#import "AppRecord.h"

#define kAppIconHeight 48;

@implementation IconDownloader

@synthesize imageConnection,appRecord,delegate,activeDownload,indexPathInTableRow;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)dealloc
{
    [appRecord release];
    [indexPathInTableRow release];
    
    [activeDownload release];
    [imageConnection cancel];
    [imageConnection release];
    
    [super dealloc];
}

-(void)startDownload{
    self.activeDownload = [NSMutableData data];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:appRecord.imageURLString]] delegate:self];
    self.imageConnection = conn;
    [conn release];
}

-(void)cancelDownload{
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
}

#pragma mark -
#pragma mark Download support(NSURLConnectionDelegate)

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
}


@end
