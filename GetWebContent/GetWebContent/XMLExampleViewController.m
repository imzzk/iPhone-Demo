//
//  XMLExampleViewController.m
//  GetWebContent
//
//  Created by 坤坤 on 11-8-8.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "XMLExampleViewController.h"

@implementation XMLExampleViewController

-(void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:validationError.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [myAlert show];
    [myAlert release];
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Fatal Error" message:parseError.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [myAlert show];
    [myAlert release];
}

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    [articles removeAllObjects];
}

-(void)parser:(NSXMLParser *)parser didStartElement:
    (NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    currentElement = elementName;
    
    if ([elementName isEqualToString: @"item"]) {
        itemActive = YES;
        currentTitle =[[NSMutableArray alloc] init];
        currentGuid = [[NSMutableArray alloc] init];
        pudDate = [[NSMutableArray alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

    if (itemActive) {
        NSString *fixedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([currentElement isEqualToString:@"title"]) {
            [currentTitle appendString:fixedString];
        }
        if ([currentElement isEqualToString:@"guid"]) {
            [currentGuid appendString:fixedString];
        }
        if ([currentElement isEqualToString:@"pubDate"]) {
            [pudDate appendString:fixedString];
        }
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"]) {
        NSDictionary *record = [NSDictionary dictionaryWithObjectsAndKeys:currentTitle,@"articleTitle",
                                currentGuid,@"articleURL",
                                pudDate,@"publicationDate",nil];
        [articles addObject:record];
        [currentElement release];
        [currentGuid release];
        [currentTitle release];
    }
    itemActive = NO;
}
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%@",articles);
}

-(void)retriveXML:(id)sender{
    [parser parse];
}

-(void)CreateUI{

    UIButton *btnShowQuickLook = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnShowQuickLook.frame = CGRectMake(100, 200, 120, 34);
    [btnShowQuickLook setTitle:@"RetriveXML" forState:UIControlStateNormal];
    [btnShowQuickLook addTarget:self action:@selector(retriveXML:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnShowQuickLook];
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
    articles = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"http://rss.cnn.com/rss/edition.rss"];
    
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    parser.delegate = self;
    
    UIButton *btnShowQuickLook = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnShowQuickLook.frame = CGRectMake(100, 200, 120, 34);
    [btnShowQuickLook setTitle:@"RetriveXML" forState:UIControlStateNormal];
    [btnShowQuickLook addTarget:self action:@selector(retriveXML:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnShowQuickLook];

    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [articles release];
    [parser release];
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
