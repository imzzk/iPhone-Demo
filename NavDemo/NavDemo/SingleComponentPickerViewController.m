//
//  SingleComponentPickerViewController.m
//  NavDemo
//
//  Created by 坤坤 on 11-8-10.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "SingleComponentPickerViewController.h"

@implementation SingleComponentPickerViewController

@synthesize singlePicker,pickerData;


-(IBAction)btnPressed{

    NSInteger row = [singlePicker selectedRowInComponent:0];
    NSString *selectedRow = [pickerData objectAtIndex:row];
    NSString *title = [[NSString alloc] initWithFormat:@"You have selected %@!",selectedRow];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"Thank you for choosing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [title release];

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    CGRect pickerFrame = CGRectMake(0, 0, 0, 0);
    singlePicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    singlePicker.dataSource = self;
    singlePicker.delegate = self;
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"Luke",@"Leia",@"Han",@"Chewbacca",@"Artoo",@"Threepio",@"Lando",nil];
    self.pickerData = array;
    singlePicker.showsSelectionIndicator = YES;
    [array release];
    
    [self.view addSubview:singlePicker];
    CGRect buttonFrame = CGRectMake(115, 265, 100, 44);
    UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [selectedButton setFrame:buttonFrame];
    [selectedButton setTitle:@"Selected" forState:UIControlStateNormal];
    [selectedButton addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:selectedButton];
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.pickerData = nil;
    self.singlePicker = nil;
    
}

-(void)dealloc
{
    [singlePicker release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark Pick Data Source Methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerData count];
}

#pragma mark Picker Delegate Methods
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerData objectAtIndex:row];
}


@end
