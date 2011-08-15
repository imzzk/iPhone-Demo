//
//  SwitchViewController.m
//  NavDemo
//
//  Created by 坤坤 on 11-8-9.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "SwitchViewController.h"
#import "BlueView.h"
#import "YellowView.h"

@implementation SwitchViewController

@synthesize blueController = _blueController;
@synthesize yellowController = _yellowController;
@synthesize myView = _myView;

-(IBAction)switchViews:(id)sender{
    
    /*[UIView beginAnimations:@"View Flip" context:nil]; 
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    */
    if (self.yellowController.view.superview == nil) 
    {
        if (self.yellowController == nil) {
            YellowView *yellowViewController = [[YellowView alloc] initWithNibName:@"YellowView" bundle:nil];
            self.yellowController = yellowViewController;
            [yellowViewController release];
            [_blueController.view removeFromSuperview];
            [_myView insertSubview:yellowViewController.view atIndex:0];
        }
        /*[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight
                               forView:_myView cache:YES];
        [_blueController viewWillAppear:YES]; 
        [_yellowController viewWillDisappear:YES];
        [_blueController.view removeFromSuperview];
        [_myView insertSubview:_yellowController.view atIndex:0]; 
        [_yellowController viewDidDisappear:YES];
        [_blueController viewDidAppear:YES];*/
    }
    else{
        if (self.blueController == nil) 
        {
            BlueView *blueViewController = [[BlueView alloc] initWithNibName:@"BlueView" bundle:nil]; 
            self.blueController = blueViewController;
            [blueViewController release]; 
            [_yellowController.view removeFromSuperview];
            [_myView insertSubview:blueViewController.view atIndex:0];   
        }
        /*[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft
                               forView:_myView cache:YES];
        [_yellowController viewWillAppear:YES]; 
        [_blueController viewWillDisappear:YES];
        
        [_yellowController.view removeFromSuperview];
        [_myView insertSubview:_blueController.view atIndex:0]; 
        [_blueController viewDidDisappear:YES]; 
        [_yellowController viewDidAppear:YES];*/
    }
             
    //[UIView commitAnimations];
    
    


}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    CGRect viewFrame = [self.view bounds];
    _myView = [[UIView alloc] initWithFrame:viewFrame];
    _myView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_myView];
    
    CGSize viewSize = _myView.frame.size;
    float toolBarHeight = 44.0;
    CGRect toolBarFrame = CGRectMake(0, viewSize.height - toolBarHeight, viewSize.width, toolBarHeight);
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:toolBarFrame];
    
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth
                                |
                                UIViewAutoresizingFlexibleLeftMargin
                                |
                                UIViewAutoresizingFlexibleRightMargin
                                |
                                UIViewAutoresizingFlexibleTopMargin;
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithTitle:@"Switch Views" style:UIBarButtonItemStyleBordered target:self action:@selector(switchViews:)];
        
    NSArray *buttons = [[NSArray alloc] initWithObjects:button1, nil];
    
    [toolBar setItems:buttons animated:NO];
    
    [button1 release];
    [_myView addSubview:toolBar];
    
    [toolBar release];
        
    BlueView *blueViewController = [[BlueView alloc] initWithNibName:@"BlueView" bundle:nil];
    self.blueController = blueViewController;
    [_myView insertSubview:blueViewController.view atIndex:0];
    [blueViewController release];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    
    if (self.blueController.view.superview == nil) 
        self.blueController = nil;
    else
        self.yellowController = nil;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)dealloc{

    [_myView release];
    [_blueController release];
    [_yellowController release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
