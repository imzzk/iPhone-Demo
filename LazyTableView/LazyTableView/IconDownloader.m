//
//  IconDownloader.m
//  LazyTableView
//
//  Created by 坤坤 on 11-8-15.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "IconDownloader.h"
#import "AppRecord.h"

#define kAppIconHeight 48

@implementation IconDownloader

@synthesize imageConnection,appRecord,delegate,activeDownload,indexPathInTableRow;

#pragma mark

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
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:
                             [NSURLRequest requestWithURL:
                              [NSURL URLWithString:appRecord.imageURLString]] delegate:self];
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
    [self.activeDownload appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.activeDownload = nil;
    
    self.imageConnection = nil;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
    
    if (image.size.width != kAppIconHeight && image.size.height != kAppIconHeight) 
    {
        CGSize itemSize = CGSizeMake(kAppIconHeight, kAppIconHeight);
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
        [image drawInRect:imageRect];
        self.appRecord.appIcon = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else
    {
        self.appRecord.appIcon = image;
    }
    self.activeDownload = nil;
    [image release];
    self.imageConnection = nil;
    
    [delegate appImageDidLoad:self.indexPathInTableRow];
}

@end
