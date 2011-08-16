//
//  RecommendListViewController.m
//  CnblogsNews2
//
//  Created by imzzk on 11-7-12.
//  Copyright 2011 博客园. All rights reserved.
//

#import "RecommendListViewController.h"

@implementation RecommendListViewController

@synthesize txtName;

-(IBAction)doneEditing:(id)sender{
    [sender resignFirstResponder];
}

-(IBAction)bgTouched:(id)sender{
    [myTextView resignFirstResponder];

}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.title = @"推荐新闻";
		self.navigationController.navigationBarHidden = NO;
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect viewRect = [self.view bounds];
    myScrollView = [[UIScrollView alloc] initWithFrame:viewRect];
    myScrollView.contentSize = viewRect.size;
    [self.view addSubview:myScrollView];
    
    /*CGRect lblRect = CGRectMake(10, 10, 140, 33);
    lblName = [[UILabel alloc] initWithFrame:lblRect];
    lblName.text = @"Alphanumberic Input";
    lblName.font = [UIFont systemFontOfSize:14.0];
    lblName.textColor = [UIColor blackColor];
    [myScrollView addSubview:lblName];
    
    txtName = [[UITextField alloc] initWithFrame:CGRectMake(10, 45, 200, 28)];
    txtName.borderStyle = UITextBorderStyleRoundedRect;
    txtName.adjustsFontSizeToFitWidth = YES;
    txtName.returnKeyType = UIReturnKeyDone;
    [txtName addTarget:self action:@selector(doneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [myScrollView addSubview:txtName];
    */
    
    CGRect buttonFrame = CGRectMake(10, 10, 60, 32);
    UIButton *keyboardToggle = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [keyboardToggle setTitle:@"hide" forState:UIControlStateNormal];
    [keyboardToggle addTarget:self action:@selector(bgTouched:) forControlEvents:UIControlEventTouchUpInside];
    keyboardToggle.frame = buttonFrame;
    [myScrollView addSubview:keyboardToggle];
    
    myTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 60, 300, 200)];
    myTextView.font = [UIFont systemFontOfSize:22.0];
    myTextView.keyboardType = UIKeyboardTypeDefault;
    myTextView.backgroundColor= [UIColor blueColor];
    myTextView.returnKeyType = UIReturnKeyGo;
    myTextView.delegate = self;
    [myScrollView addSubview:myTextView];
    
    [myTextView release];
    [myScrollView release];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    float keyboardHeight;
    if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait ||UIDeviceOrientationPortraitUpsideDown)
        keyboardHeight = 216.0;
    else
        keyboardHeight = 162.0;
    
    CGRect textViewRect = textView.frame;
    float textViewBottom = textViewRect.origin.y + textViewRect.size.height;
    CGRect viewRect = [myScrollView bounds];
    float keyboardTop = viewRect.size.height - keyboardHeight;
    float scrollOffSet = fabs(textViewBottom-keyboardTop);
    [myScrollView setContentOffset:CGPointMake(0, scrollOffSet) animated:YES];
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [myScrollView setContentOffset:CGPointMake(0, 0) animated:YES];

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
    [super dealloc];
}


@end
