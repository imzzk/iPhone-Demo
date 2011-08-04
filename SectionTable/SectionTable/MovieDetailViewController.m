//
//  MovieDetailViewController.m
//  SectionTable
//
//  Created by 坤坤 on 11-8-4.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "MovieDetailViewController.h"

@implementation MovieDetailViewController

@synthesize selectedMovie;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{

    label.text = self.selectedMovie;
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
    self.title = @"Movie Detail";
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 260, 100)];
    label.font = [UIFont systemFontOfSize:14.0];
    label.textColor = [UIColor redColor];
    
    [self.view addSubview:label];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [label release];
    [selectedMovie release];
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
