//
//  LazyTableViewAppDelegate.m
//  LazyTableView
//
//  Created by 坤坤 on 11-8-15.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "LazyTableViewAppDelegate.h"
#import "RootViewController.h"
#import "ParseOperation.h"

#import <CFNetwork/CFNetwork.h>

static NSString *const TopPaidAppsFeed =
    @"http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=75/xml";

@implementation LazyTableViewAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize rootViewController;
@synthesize appRecords;
@synthesize queue;
@synthesize appListFeedConnection;
@synthesize appListData;

#pragma mark -

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    //self.window.rootViewController = self.navigationController;
    
    [window addSubview:[self.navigationController view]];

    [window makeKeyAndVisible];
    
    self.appRecords = [NSMutableArray array];
    
    rootViewController.entries = self.appRecords;
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:TopPaidAppsFeed]];
    self.appListFeedConnection = [[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self] autorelease];
    
    
    NSAssert(self.appListFeedConnection != nil, @"Failure to create URL connection.");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}


-(void)handleLoadedApps:(NSArray *)loadedApps
{
    [self.appRecords addObjectsFromArray:loadedApps];
    
    [rootViewController.tableView reloadData];
}

-(void)didFinishParsing:(NSArray *)appList
{
    [self performSelectorOnMainThread:@selector(handleLoadedApps:) withObject:appList waitUntilDone:NO];
    
    self.queue = nil;
}

-(void)parseErrorOccurred:(NSError *)error
{
    [self performSelectorOnMainThread:@selector(handleError:) withObject:error waitUntilDone:NO];
}


#pragma mark -
#pragma mark NSURLConnection delegate methods   


-(void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot Show Top Paid Apps" 
                                                    message:errorMessage 
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.appListData = [NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [appListData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([error code] == kCFURLErrorNotConnectedToInternet) 
    {
        NSDictionary *userInfo =[NSDictionary dictionaryWithObject:@"NO Connection Error" 
                                                            forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain 
                                                         code:kCFURLErrorNotConnectedToInternet 
                                                     userInfo:userInfo];
        
        [self handleError:noConnectionError];
    }
    else
    {
        [self handleError:error];
    }
    self.appListFeedConnection = nil;
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.appListFeedConnection = nil;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    self.queue = [[NSOperationQueue alloc] init];
    
    ParseOperation *parser = [[ParseOperation alloc] initWithData:appListData delegate:self];
    
    [queue addOperation:parser];
    
    [parser release];
    
    self.appListData = nil;
}




- (void)dealloc
{
    [navigationController release];
    [appRecords release];
    [rootViewController release];
    [appListData release];
    [appListFeedConnection release];
    [window release];

    [super dealloc];
}

@end
