//
//  GetWebContentAppDelegate.h
//  GetWebContent
//
//  Created by 坤坤 on 11-8-4.
//  Copyright 2011年 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GetWebContentViewController;

@class XMLExampleViewController;

@interface GetWebContentAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet GetWebContentViewController *viewController;

@property (nonatomic, retain) IBOutlet XMLExampleViewController *xmlEmpleViewController;

@end
