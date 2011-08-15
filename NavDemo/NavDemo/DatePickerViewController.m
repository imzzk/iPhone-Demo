//
//  DatePickerViewController.m
//  NavDemo
//
//  Created by 坤坤 on 11-8-10.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "DatePickerViewController.h"
#import "ASIHTTPRequest.h"


@implementation DatePickerViewController


-(IBAction)btnPressed{
    NSURL *url = [NSURL URLWithString:@"http://wcf.open.cnblogs.com/NewsWcf.svc/GetRecentNews"];
    request =  [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response =[request responseString];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Json" message:response delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
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
    /*NSDate *maxDate,*minDate;
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    maxDate = [formatter dateFromString:@"2020-12-31 23:59:00"];
    minDate = [formatter dateFromString:@"1970-01-01 00:00:00"];
    
    CGRect pickerFrame = CGRectMake(0, 0, 320, 260);
    myDatePicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    myDatePicker.minimumDate=minDate;
    myDatePicker.maximumDate=maxDate;
    [self.view addSubview:myDatePicker];*/
    
    navgationBar= [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"最新新闻"];
    [navgationBar pushNavigationItem:item animated:YES];
    
    [self.view addSubview:navgationBar];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, 300, 385) style:UITableViewStylePlain];
    //tableView.dataSource = self;
    //tableView.delegate = self;
    //[self.view addSubview:tableView];
    
    UIButton *btnTest = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnTest setFrame:CGRectMake(110, 310, 110, 44)];
    [btnTest setTitle:@"Invoke WCF" forState:UIControlStateNormal];
    //[btnTest setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnTest addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTest];
    
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)dealloc
{
    [navgationBar release];
    [request cancel];
    [request release];
    [tableView release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*
#pragma mark -
#pragma mark TableView Data Source Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease]; 
	}
    
    // Configure the cell.
    return cell;
    
}
*/

@end
