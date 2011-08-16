//
//  NewsListViewController.h
//  CnblogsNews2
//
//  Created by imzzk on 11-7-12.
//  Copyright 2011 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchXML.h"
#import <QuartzCore/QuartzCore.h>



@interface NewsListViewController : UITableViewController  {

	NSMutableArray *newEntries;
	//IBOutlet UITableView *newsTable;
    
    NSDateFormatter *formatter;
	
}
//@property (nonatomic, retain) UITableView *newsTable;

-(UITableViewCell *)tableViewCellWithResusIdentifier:(NSString *)identifier;

-(void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *) indexPath;

-(NSString *)getFirstImageUrl:(NSString *)html;

@end
