//
//  RecommendListViewController.h
//  CnblogsNews2
//
//  Created by imzzk on 11-7-12.
//  Copyright 2011 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecommendListViewController : UIViewController <UITextViewDelegate>{

    UILabel *lblName;
    IBOutlet UITextField *txtName;
    
    UIScrollView *myScrollView;
    
    UITextView *myTextView;
}
@property(nonatomic, retain)UITextField *txtName;

-(IBAction)doneEditing:(id)sender;

-(IBAction)bgTouched:(id)sender;

@end
