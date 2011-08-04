//
//  RootViewController.m
//  SectionTable
//
//  Created by 坤坤 on 11-8-3.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize moiveTitles,years,searchBar;

- (void)viewDidLoad
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Movies" ofType:@"plist"];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    self.moiveTitles = dic;
    
    NSArray *array = [[self.moiveTitles allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    self.years = array;
    
    listOfMovies = [[NSMutableArray alloc] init];
    for (NSString *year in array) 
    {
        NSArray *movies = [moiveTitles objectForKey:year];
        
        for (NSString *title in movies) {
            [listOfMovies addObject:title];
        }
    }
    
    searchResult = [[NSMutableArray alloc] init];
    isSearchOn = NO;
    canSelectRow = YES;

    
    CGRect tableFrame  = [self.tableView frame];
    CGRect searchRect = tableFrame;
    searchRect.size.height = 40;
    searchBar = [[UISearchBar alloc] initWithFrame:searchRect];
    searchBar.delegate = self;
    self.tableView.tableHeaderView = searchBar;
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeYes;
    
    [dic release];
    [super viewDidLoad];
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (isSearchOn) {
        return 1;
    }
    else
    {
        return [self.years count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearchOn) {
        return [searchResult count];
    }
    else
    {
        NSString *year = [years objectAtIndex:section];
    
        NSArray *movieArray = [self.moiveTitles objectForKey:year];
    
        return [movieArray count];
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
    if (isSearchOn) {
        NSString *cellValue = [searchResult objectAtIndex:indexPath.row];
        cell.textLabel.text = cellValue;
    }
    else
    {
    
        NSString *year = [self.years objectAtIndex:[indexPath section]];
    
        NSArray *movieSection = [self.moiveTitles objectForKey:year];
    
        cell.textLabel.text = [movieSection objectAtIndex:[indexPath row]];
        
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    NSString *year = [self.years objectAtIndex:section];
    
    if (isSearchOn) {
        return nil;
    }
    else{
        return  year;
    }
    
}

//searchBar delegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    isSearchOn = YES;
    canSelectRow = NO;
    
    self.tableView.scrollEnabled = NO;
    
    //加入search的按钮
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneSearch:)] autorelease];
    
}

-(void)doneSearch:(id)sender
{
    isSearchOn = NO;
    canSelectRow = YES;
    self.tableView.scrollEnabled = YES;
    
    self.navigationItem.rightBarButtonItem = nil;
    
    [searchBar resignFirstResponder];
    
    [self.tableView reloadData];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText length] > 0) {
        isSearchOn = YES;
        canSelectRow = YES;
        self.tableView.scrollEnabled = YES;
        [self searchMoviesTableView];
    }
    else
    {
        isSearchOn = NO;
        canSelectRow = NO;
        self.tableView.scrollEnabled = NO;
    }
    [self.tableView reloadData];
}

-(void)searchMoviesTableView{

    [searchResult removeAllObjects];
    
    for (NSString *str in listOfMovies) {
        NSRange titleResultRange = [str rangeOfString:searchBar.text 
                                              options:NSCaseInsensitiveSearch];
    
        if(titleResultRange.length > 0)
        {
            [searchResult addObject:str];
        }
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    [self searchMoviesTableView];
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (canSelectRow) {
        return  indexPath;
    }
    else{
        return  nil;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	*/
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [searchResult release];
    [listOfMovies release];
    [searchBar release];
    [moiveTitles release];
    [years release];
    [super dealloc];
}

@end
