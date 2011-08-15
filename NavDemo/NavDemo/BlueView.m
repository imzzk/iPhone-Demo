//
//  BlueView.m
//  NavDemo
//
//  Created by 坤坤 on 11-8-10.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "BlueView.h"

@implementation BlueView

-(IBAction)blueButtonPressed{

    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Blue View Button Pressed" message:@"You have pressed the blue button" delegate:nil cancelButtonTitle:@"Yep,I did" otherButtonTitles:nil,   nil];
    [myAlertView show];
    [myAlertView release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
