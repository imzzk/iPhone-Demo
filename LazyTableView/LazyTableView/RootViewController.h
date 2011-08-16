//
//  RootViewController.h
//  LazyTableView
//
//  Created by 坤坤 on 11-8-15.
//  Copyright 2011年 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDownloader.h"

@interface RootViewController : UITableViewController<UIScrollViewDelegate, IconDownloaderDelegate>
{
    NSArray *entries;
    NSMutableDictionary *imageDownLoadsInProgress;

}

@property(nonatomic, retain) NSArray *entries;
@property(nonatomic, retain) NSMutableDictionary *imageDownLoadsInProgress;

-(void)appImageDidLoad:(NSIndexPath *)indexPath;

@end
