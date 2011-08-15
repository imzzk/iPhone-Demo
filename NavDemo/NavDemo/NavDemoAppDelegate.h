//
//  NavDemoAppDelegate.h
//  NavDemo
//
//  Created by 坤坤 on 11-8-9.
//  Copyright 2011年 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SwitchViewController;

@interface NavDemoAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
    //SwitchViewController *switchViewController;
    UITabBarController *rootController;

}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;

//@property (nonatomic, retain) IBOutlet SwitchViewController *switchViewController;


@end
