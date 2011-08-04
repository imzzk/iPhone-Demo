//
//  RootViewController.h
//  SectionTable
//
//  Created by 坤坤 on 11-8-3.
//  Copyright 2011年 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetailViewController.h"

@interface RootViewController : UITableViewController <UISearchBarDelegate>
{
    MovieDetailViewController *detailViewController;
    NSDictionary *movieTitles;
    NSArray *years;
    
    IBOutlet UISearchBar *searchBar;
    
    BOOL isSearchOn;
    BOOL canSelectRow;
    
    NSMutableArray *listOfMovies;
    NSMutableArray *searchResult;
    
}

@property(nonatomic, retain)NSDictionary *moiveTitles;

@property(nonatomic, retain)NSArray *years;

@property(nonatomic, retain)UISearchBar *searchBar; 

@property(nonatomic, retain)MovieDetailViewController *detailViewController;

-(void) doneSearch:(id)sender;
-(void) searchMoviesTableView;

@end
