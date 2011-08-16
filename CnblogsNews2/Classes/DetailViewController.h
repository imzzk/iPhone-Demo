//
//  DetailViewController.h
//  CnblogsNews2
//
//  Created by imzzk on 11-7-14.
//  Copyright 2011 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UIViewController {

	IBOutlet UILabel *lblTitle;
	IBOutlet UILabel *lblTime;
	IBOutlet UIWebView *webView;
	NSString *selectedTitle;
	NSString *selectedTime;
	NSString *selectedDescription;
}

@property (nonatomic, retain)NSString *selectedTitle;
@property (nonatomic, retain)NSString *selectedTime;
@property (nonatomic, retain)NSString *selectedDescription;

@end
