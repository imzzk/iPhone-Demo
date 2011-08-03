//
//  TableViewDemoAppDelegate.h
//  TableViewDemo
//
//  Created by 坤坤 on 11-8-3.
//  Copyright 2011年 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableViewDemoViewController;

@interface TableViewDemoAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TableViewDemoViewController *viewController;

@end
