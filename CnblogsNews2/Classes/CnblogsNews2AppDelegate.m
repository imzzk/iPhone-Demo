//
//  CnblogsNews2AppDelegate.m
//  CnblogsNews2
//
//  Created by imzzk on 11-7-12.
//  Copyright 2011 博客园. All rights reserved.
//

#import "CnblogsNews2AppDelegate.h"
#import "NewsListViewController.h"
#import "RecommendListViewController.h"
#import "CommentListViewController.h"
#import "AppSettingViewController.h"
#import "DetailViewController.h"

@implementation CnblogsNews2AppDelegate

@synthesize window,rootController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	rootController = [[UITabBarController alloc] init];
	
	NewsListViewController *newsListViewController = [[NewsListViewController alloc] initWithNibName:@"NewsListViewController" bundle:nil];
	UINavigationController *newsListNavigationController = [[UINavigationController alloc] initWithRootViewController:newsListViewController];
	newsListNavigationController.tabBarItem.image = [UIImage imageNamed:@"singleicon.png"];
	[newsListViewController release];
	
	RecommendListViewController *recommendListViewController = [[RecommendListViewController alloc] initWithNibName:@"RecommendListViewController" bundle:nil];
	UINavigationController *recommendNavigationController = [[UINavigationController alloc] initWithRootViewController:recommendListViewController];
	recommendNavigationController.tabBarItem.image = [UIImage imageNamed:@"doubleicon.png"];
	[recommendListViewController release];
	
	CommentListViewController *commentListViewController = [[CommentListViewController alloc] initWithNibName:@"CommentListViewController" bundle:nil];
	UINavigationController *commentNavigationController = [[UINavigationController alloc] initWithRootViewController:commentListViewController];
	commentNavigationController.tabBarItem.image = [UIImage imageNamed:@"clockicon.png"];
	[commentListViewController release];
	
	AppSettingViewController *appSetViewController = [[AppSettingViewController alloc] initWithNibName:@"AppSettingViewController" bundle:nil];
	UINavigationController *appNavigationController = [[UINavigationController alloc] initWithRootViewController:appSetViewController];
	appNavigationController.tabBarItem.image = [UIImage imageNamed:@"toolicon.png"];
	[appSetViewController release];
	
	rootController.viewControllers = [NSArray arrayWithObjects:newsListNavigationController,recommendNavigationController,commentNavigationController,appNavigationController,nil];
	
	
    [self.window addSubview:rootController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}


#pragma mark -
#pragma mark Memory management


- (void)dealloc {
	[rootController release];
   
	[window release];
    [super dealloc];
}


@end
