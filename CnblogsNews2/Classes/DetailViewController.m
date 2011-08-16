//
//  DetailViewController.m
//  CnblogsNews2
//
//  Created by imzzk on 11-7-14.
//  Copyright 2011 博客园. All rights reserved.
//

#import "DetailViewController.h"


@implementation DetailViewController

@synthesize selectedTitle,selectedTime,selectedDescription;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	lblTitle.text = selectedTitle;
	lblTime.text = selectedTime;
	webView.backgroundColor = [UIColor whiteColor];
	[webView loadHTMLString:selectedDescription baseURL:nil];
	self.navigationItem.title = @"博客园新闻";
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[lblTitle release];
	[lblTime release];
	[webView release];
	[selectedTitle release];
	[selectedTime release];
	[selectedDescription release];
    [super dealloc];
}


@end
