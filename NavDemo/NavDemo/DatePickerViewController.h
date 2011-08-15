//
//  DatePickerViewController.h
//  NavDemo
//
//  Created by 坤坤 on 11-8-10.
//  Copyright 2011年 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CFNetwork/CFNetwork.h>
@class ASIHTTPRequest;

@interface DatePickerViewController : UIViewController
{
    UINavigationBar *navgationBar;
    UITableView *tableView;
    ASIHTTPRequest *request;
}



-(IBAction)btnPressed;
@end
