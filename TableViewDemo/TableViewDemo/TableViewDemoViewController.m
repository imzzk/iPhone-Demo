//
//  TableViewDemoViewController.m
//  TableViewDemo
//
//  Created by 坤坤 on 11-8-3.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "TableViewDemoViewController.h"


@implementation TableViewDemoViewController
NSMutableArray *listOfMovies;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    CGRect tableFrame = [self.view bounds];
    simpleTableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    simpleTableView.contentSize = tableFrame.size;
    simpleTableView.delegate = self;
    simpleTableView.dataSource = self;
    [self.view addSubview:simpleTableView];
    
    listOfMovies = [[NSMutableArray alloc]init ];
    [listOfMovies addObject:@"变形金刚3"];
    [listOfMovies addObject:@"变形金刚3"];
    [listOfMovies addObject:@"变形金刚3"];
    [listOfMovies addObject:@"变形金刚3"];
    [listOfMovies addObject:@"变形金刚3"];
    [listOfMovies addObject:@"变形金刚3"];
    [listOfMovies addObject:@"变形金刚3"];
    [listOfMovies addObject:@"变形金刚3"];
    [listOfMovies addObject:@"变形金刚3"];
    [listOfMovies addObject:@"变形金刚3"];
    [listOfMovies addObject:@"变形金刚3"];
    [listOfMovies addObject:@"变形金刚3"];
    
    
    [super viewDidLoad];
    
}


- (void)viewDidUnload
{
    [listOfMovies release];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return  listOfMovies.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }
    
    NSString *cellValue = [listOfMovies objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    
    
    return  cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return @"电影列表";
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{

    return @"Product by imzzk";
}



@end
