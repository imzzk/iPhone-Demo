//
//  DoubleComponentPickerViewController.m
//  NavDemo
//
//  Created by 坤坤 on 11-8-10.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "DoubleComponentPickerViewController.h"

@implementation DoubleComponentPickerViewController

@synthesize fillingTypes,breadTypes,doublePicker;

-(IBAction)btnPressed
{
    NSInteger fillingRow = [doublePicker selectedRowInComponent:kFillingComponent];
    NSInteger breakRow = [doublePicker selectedRowInComponent:kBreadComponent];
    
    NSString *bread = [breadTypes objectAtIndex:breakRow];
    NSString *filling = [fillingTypes objectAtIndex:fillingRow];
    
    NSString *message = [[NSString alloc] initWithFormat:@"Your %@ on %@ bread will be right up.",filling,bread];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you for your order" message:message delegate:nil cancelButtonTitle:@"Great!" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [message release];
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
    doublePicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    doublePicker.dataSource = self;
    doublePicker.delegate = self;
    doublePicker.showsSelectionIndicator = YES;
    [self.view addSubview:doublePicker];
    
    CGRect buttonFrame = CGRectMake(115, 265, 100, 44);
    UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [selectedButton setFrame:buttonFrame];
    [selectedButton setTitle:@"Selected" forState:UIControlStateNormal];
    [selectedButton addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectedButton];
    
    NSArray *fillingArrays = [[NSArray alloc] initWithObjects:@"Ham",@"Turkey",@"Peanut Butter",@"Tuna Salad",@"Nutella",@"Roast Beef",@"Vegemite", nil];
    self.fillingTypes = fillingArrays;
    [fillingArrays release];
    
    NSArray *breadArrays = [[NSArray alloc] initWithObjects:@"White",@"Whole Wheat",@"Rye",@"Sourdough",@"Seven Grain", nil];
    self.breadTypes = breadArrays;
    [breadArrays release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.fillingTypes = nil;
    self.breadTypes = nil;
}

-(void)dealloc
{
    [fillingTypes release];
    [breadTypes release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma marker -
#pragma marker Picker Data Source Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == kBreadComponent) {
        return [self.breadTypes count];
    }
    else
    {
        return [self.fillingTypes count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == kBreadComponent) {
        return [self.breadTypes objectAtIndex:row];
    }
    return [self.fillingTypes objectAtIndex:row];
}
@end
