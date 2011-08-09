//
//  GetWebContentViewController.m
//  GetWebContent
//
//  Created by 坤坤 on 11-8-4.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "GetWebContentViewController.h"

@implementation GetWebContentViewController

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
    NSLog(@"Started");
    CGRect frameText = CGRectMake(10, 10, 300, 100);
    resultText = [[UITextView alloc] initWithFrame:frameText];
    resultText.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:resultText];
    
    NSString *symbol = @"AAPL,GOOG,MSFT,YHOO,PALM";
    NSString *urlString = [NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?f=no&s=%@",symbol];
    
    NSURL *url = [NSURL URLWithString:urlString];
    //NSString *quotes = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    receivedData = [[NSMutableData alloc] initWithData:nil];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [request release];
    [con release];
    
    
    NSLog(@"End");
    //resultText.text = receivedData;
    [super viewDidLoad];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView   release];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *quotes = [[NSString alloc] initWithBytes:[receivedData bytes] length:[receivedData length] encoding:NSASCIIStringEncoding];
    resultText.text = quotes;
    [quotes release];

}

- (void)viewDidUnload
{
    [receivedData release];
    [resultText release];
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
