//
//  SwitchViewController.h
//  NavDemo
//
//  Created by 坤坤 on 11-8-9.
//  Copyright 2011年 博客园. All rights reserved.
//


#import <UIKit/UIKit.h>
@class BlueView;
@class YellowView;

@interface SwitchViewController : UIViewController

@property (nonatomic, retain)IBOutlet BlueView *blueController;
@property (nonatomic, retain)IBOutlet YellowView *yellowController;
@property (nonatomic, retain)IBOutlet UIView *myView;

-(IBAction)switchViews:(id)sender;
@end
