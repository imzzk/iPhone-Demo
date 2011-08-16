//
//  IconDownloader.h
//  LazyTableView
//
//  Created by 坤坤 on 11-8-15.
//  Copyright 2011年 博客园. All rights reserved.
//



@class AppRecord;
@class RootViewController;

@protocol IconDownloaderDelegate; 

@interface IconDownloader : NSObject
{
    AppRecord *appRecord;
    NSIndexPath *indexPathInTableRow;
    id<IconDownloaderDelegate> delegate;
    
    NSMutableData *activeDownload;
    NSURLConnection *imageConnection;
}

@property(nonatomic, retain) AppRecord *appRecord;
@property(nonatomic, retain) NSIndexPath *indexPathInTableRow;
@property(nonatomic, assign) id<IconDownloaderDelegate> delegate;

@property(nonatomic, retain) NSMutableData *activeDownload;
@property(nonatomic, retain) NSURLConnection *imageConnection;

- (void)startDownload;
- (void)cancelDownload;

@end

@protocol IconDownloaderDelegate 

-(void)appImageDidLoad:(NSIndexPath *)indexPath;

@end
