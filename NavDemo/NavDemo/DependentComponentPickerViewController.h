//
//  DependentComponentPickerViewController.h
//  NavDemo
//
//  Created by 坤坤 on 11-8-10.
//  Copyright 2011年 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kStateComponent 0
#define kZipComponent 1


@interface DependentComponentPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIPickerView *picker;
    NSDictionary *stateZips;
    NSArray *states;
    NSArray *zips;
}

@property(nonatomic, retain)UIPickerView *picker;
@property(nonatomic, retain)NSDictionary *stateZips;
@property(nonatomic, retain)NSArray *states;
@property(nonatomic, retain)NSArray *zips;

-(IBAction)btnPressed;
@end
