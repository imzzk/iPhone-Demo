//
//  SingleComponentPickerViewController.h
//  NavDemo
//
//  Created by 坤坤 on 11-8-10.
//  Copyright 2011年 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleComponentPickerViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *singlePicker;
    NSArray *pickerData;
    
}

@property(nonatomic, retain)UIPickerView *singlePicker;
@property(nonatomic, retain)NSArray *pickerData;

-(IBAction)btnPressed;

@end
