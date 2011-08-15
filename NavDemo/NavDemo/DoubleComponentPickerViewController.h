//
//  DoubleComponentPickerViewController.h
//  NavDemo
//
//  Created by 坤坤 on 11-8-10.
//  Copyright 2011年 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kFillingComponent 0
#define kBreadComponent 1

@interface DoubleComponentPickerViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic, retain)NSArray *fillingTypes;
@property(nonatomic, retain)NSArray *breadTypes;
@property(nonatomic, retain)UIPickerView *doublePicker;

-(IBAction)btnPressed;

@end
