//
//  NewsListViewController.m
//  CnblogsNews2
//
//  Created by imzzk on 11-7-12.
//  Copyright 2011 博客园. All rights reserved.
//

#import "NewsListViewController.h"
#import "DetailViewController.h"
#import "CnblogsNews2AppDelegate.h"
#import "NSString+HTML.h"
#import "NSDate+InternetDateTime.h"

#define ROW_HEIGHT 120

@implementation NewsListViewController

-(void) grabRSSFeed:(NSString *)newsAddress{
	newEntries = [[NSMutableArray alloc] init];
	
	//将指定的url字符串转换城可用的url对象
	NSURL *url = [NSURL URLWithString:newsAddress];
	
	//创建一个新的rssParser对象基于TouchXML类，这个对象实际的作用收集处理rss数据
	CXMLDocument *rssParser = [[[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil] autorelease];
	
	NSArray *resultNodes = NULL;
	
	resultNodes = [rssParser nodesForXPath:@"//item" error:nil];
	
	for (CXMLElement *resultElement in resultNodes) {
		NSMutableDictionary *newsItem = [[NSMutableDictionary alloc] init];
		
		int counter;
		
		for (counter = 0; counter < [resultElement childCount]; counter++) {
			[newsItem setObject:[[resultElement childAtIndex:counter] stringValue] forKey:[[resultElement childAtIndex:counter] name]];
		}
		[newEntries addObject:[newsItem copy]];
	}
	
}

-(NSString *)getFirstImageUrl:(NSString *)html{

	NSScanner *theScanner;
	NSString *text = nil;
	
	theScanner = [NSScanner scannerWithString: html];
	
    // find start of tag
    [theScanner scanUpToString: @"<img src=\"" intoString: NULL];
    if ([theScanner isAtEnd] == NO) {
        NSInteger newLoc = [theScanner scanLocation] + 10;
        [theScanner setScanLocation: newLoc];
		
        // find end of tag
        [theScanner scanUpToString: @"\"" intoString: &text];
    }
	
    return text;

}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
	if ([newEntries count] == 0) {
		NSString *newAddress = @"http://news.cnblogs.com/rss/";
		
		[self grabRSSFeed:newAddress];
		
		[self.tableView reloadData];
	}

}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.title = @"最新新闻";
		self.navigationController.navigationBarHidden = NO;
		
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
		
	[super viewDidLoad];
	self.tableView.rowHeight = ROW_HEIGHT;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [formatter release];
    [super dealloc];
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [newEntries count];
} 

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil) {
		cell = [self tableViewCellWithResusIdentifier:CellIdentifier];
	}
	
	/*if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.textLabel.opaque = NO;
		cell.textLabel.textColor = [UIColor colorWithRed:7/255 green:93/255 blue:179/255 alpha:1.0];
		//cell.textLabel.highlightedTextColor = [UIColor whiteColor];
	
		cell.textLabel.font = [UIFont fontWithName:@"verdana" size:15];
		cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:11];
		
	}
    
	// Configure the cell.
	UIImage *image = [UIImage imageNamed:@"dotted.gif"];
	
	cell.imageView.image = image;
	
	int newEntryIndex = [indexPath indexAtPosition:[indexPath length] -1];
	[cell.textLabel setText:[[newEntries objectAtIndex:newEntryIndex] objectForKey:@"title"]];
	[cell.detailTextLabel setText:[[newEntries objectAtIndex:newEntryIndex] objectForKey:@"pubDate"]];
	*/
	
	[self configureCell:cell forIndexPath:indexPath];
	
	return cell;
	
	/*NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
	*/
	//[dateFormatter release];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

	return ROW_HEIGHT;
}
/*
-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{

	return UITableViewCellAccessoryDisclosureIndicator;
}
 */

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
		
	NSString *selectedTitle = [[newEntries objectAtIndex:indexPath.row] objectForKey:@"title"];
	NSString *selectedTime = [[newEntries objectAtIndex:indexPath.row] objectForKey:@"pubDate"];
	NSString *selectedDescription = [[newEntries objectAtIndex:indexPath.row] objectForKey:@"description"];
	DetailViewController *dvController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
	dvController.selectedTitle = selectedTitle;
	dvController.selectedTime = selectedTime;
	dvController.selectedDescription = selectedDescription;
	self.hidesBottomBarWhenPushed = YES;
	[[self navigationController] pushViewController:dvController animated:YES];
	self.hidesBottomBarWhenPushed = NO;
	[dvController release];
	
	
}

#pragma mark -
#pragma mark Configuring table view cell

#define TITLE_TAG 1
#define TIME_TAG 2
#define DESCRIPTION_TAG 3
#define IMAGE_TAG 4

#define LEFT_COLUMN_OFFSET	20.0
#define LEFT_COLUMN_WIDTH	300.0

#define LABEL_HEIGHT 26.0
#define IMAGE_SIDE 48.0


-(UITableViewCell *)tableViewCellWithResusIdentifier:(NSString *)identifier{
	
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
	
	UILabel *label;
	CGRect rect;
	
	rect = CGRectMake(LEFT_COLUMN_OFFSET, 10, 280, 46.0);
	label = [[UILabel alloc] initWithFrame:rect];
	label.tag = TITLE_TAG;
	label.font = [UIFont boldSystemFontOfSize:16.0];
	label.textAlignment = UITextAlignmentLeft;
	label.lineBreakMode = UILineBreakModeWordWrap;
	label.numberOfLines = 0;
	[cell.contentView addSubview:label];
	
	
	rect = CGRectMake(LEFT_COLUMN_OFFSET, 50, 120, 22.0);
	label = [[UILabel alloc] initWithFrame:rect];
	label.tag = TIME_TAG;
	label.font = [UIFont systemFontOfSize:12.0];
	label.textColor = [UIColor grayColor];
	[cell.contentView addSubview:label];
	
	
	rect = CGRectMake(20 , 72, 220, 36.0);
	label = [[UILabel alloc] initWithFrame:rect];
	label.tag = DESCRIPTION_TAG;
	label.font = [UIFont systemFontOfSize:12.0];
	label.textAlignment = UITextAlignmentLeft;
	label.lineBreakMode = UILineBreakModeWordWrap;
	label.numberOfLines = 0;
	label.textColor = [UIColor colorWithRed:152/255 green:152/255 blue:159/255 alpha:1.0];
	[cell.contentView addSubview:label];
	[label release];
	
	rect = CGRectMake(260, 55, IMAGE_SIDE, IMAGE_SIDE);
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
	imageView.tag = IMAGE_TAG;
	CALayer *layer = [imageView layer];
	[layer setMasksToBounds:YES];
	[layer setCornerRadius:8.0];
	[layer setBorderWidth:2.0];
	[layer setBorderColor:[[UIColor whiteColor] CGColor]];
	[cell.contentView addSubview:imageView];
	[imageView release];
	
	return cell;
	
}


-(void) configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath{
	
	UILabel *label;
	
	UIImageView *imageView;
	
	int newEntryIndex = [indexPath indexAtPosition:[indexPath length] -1];
	
	
	label = (UILabel *)[cell viewWithTag:TITLE_TAG];
	label.text = [[newEntries objectAtIndex:newEntryIndex] objectForKey:@"title"];
	
	
	label = (UILabel *)[cell viewWithTag:TIME_TAG];
	//label.text = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate *date = [NSDate dateFromInternetDateTimeString:[[newEntries objectAtIndex:newEntryIndex ] objectForKey:@"pubDate"] formatHint:DateFormatHintRFC822];
    
    label.text = [formatter stringFromDate:date];
    
	
	label = (UILabel *)[cell viewWithTag:DESCRIPTION_TAG];
	label.text = [[[newEntries objectAtIndex:newEntryIndex] objectForKey:@"description"] stringByConvertingHTMLToPlainText];

	
	NSString *imgUrl = [self getFirstImageUrl:[[newEntries objectAtIndex:newEntryIndex] objectForKey:@"description"]];
	
	NSLog(@"imgUrl content is:%@",imgUrl);
	
	if (imgUrl != nil) {
		NSData *imgData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imgUrl]];
		UIImage *img = [[UIImage alloc] initWithData:imgData];
		imageView = (UIImageView *)[cell viewWithTag:IMAGE_TAG];
		imageView.image = img;
	}
		
	
	

}




@end



