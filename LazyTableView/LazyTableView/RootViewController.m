//
//  RootViewController.m
//  LazyTableView
//
//  Created by 坤坤 on 11-8-15.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "RootViewController.h"
#import "AppRecord.h"

#define kCustomRowHeight 60.0
#define kCustomRowCount 7

#pragma mark -

@interface RootViewController ()

-(void)startIconDownload:(AppRecord *)appRecord forIndexPaht:(NSIndexPath *)indexPath;

@end

@implementation RootViewController

@synthesize entries,imageDownLoadsInProgress;

#pragma mark 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageDownLoadsInProgress = [NSMutableDictionary dictionary];
    self.tableView.rowHeight = kCustomRowHeight;
}

#pragma mark -
#pragma mark Table view creation (UITableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [entries count];
    if (count == 0) {
        return kCustomRowCount;
    }
    return  count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LazyTableCell";
    static NSString *PlaceholderCellIdentifier = @"PlaceholderCell";
    
    int nodeCount = [self.entries count];
    
    if (nodeCount == 0 && indexPath.row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlaceholderCellIdentifier];
        if (cell == nil) 
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                           reuseIdentifier:PlaceholderCellIdentifier] autorelease];
            cell.detailTextLabel.textAlignment = UITextAlignmentCenter;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.detailTextLabel.text = @"loading…";
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (nodeCount > 0) {
        AppRecord *appRecord = [self.entries objectAtIndex:indexPath.row];
        
        cell.textLabel.text = appRecord.appName;
        cell.detailTextLabel.text = appRecord.artist;
        
        if (!appRecord.appIcon) {
            
            if (self.tableView.dragging == NO && self.tableView.decelerating == NO) 
            {
                [self startIconDownload:appRecord forIndexPaht:indexPath];
            }
            cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        }
        else
        {
            cell.imageView.image = appRecord.appIcon;
        }
    }
    
    return cell;
}

#pragma mark -
#pragma mark Table cell image support
-(void)startIconDownload:(AppRecord *)appRecord forIndexPaht:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownLoadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil) 
    {
        iconDownloader =[[IconDownloader alloc] init];
        iconDownloader.appRecord = appRecord;
        iconDownloader.indexPathInTableRow = indexPath;
        iconDownloader.delegate = self;
        [imageDownLoadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
        [iconDownloader release];
    }
}

-(void)loadImagesForOnScreenRows{
    
    if ([self.entries count] > 0) 
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths) 
        {
            AppRecord *appRecord = [self.entries objectAtIndex:indexPath.row];
            
            if (!appRecord.appIcon)
            {
                [self startIconDownload:appRecord forIndexPaht:indexPath];
            }
        }
    }
}

- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownLoadsInProgress objectForKey:indexPath];
    if (iconDownloader != nil)
    {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:iconDownloader.indexPathInTableRow];
        
        // Display the newly loaded image
        cell.imageView.image = iconDownloader.appRecord.appIcon;
    }
}

#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnScreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnScreenRows];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
    
    NSArray *allDownloads = [self.imageDownLoadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [entries release];
    [imageDownLoadsInProgress release];
    [super dealloc];
}

@end
