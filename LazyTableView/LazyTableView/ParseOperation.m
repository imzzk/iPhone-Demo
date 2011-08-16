//
//  ParseOperation.m
//  LazyTableView
//
//  Created by 坤坤 on 11-8-15.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "ParseOperation.h"
#import "AppRecord.h"
#import "LazyTableViewAppDelegate.h"


static NSString *kIDStr = @"id";
static NSString *kNameStr = @"im:name";
static NSString *kImageStr = @"im:image";
static NSString *kArtistStr = @"im:artist";
static NSString *kEntryStr = @"entry";

@interface ParseOperation()
@property(nonatomic, assign) id <ParseOperationDelegate>delegate;
@property(nonatomic, retain) NSData *dataToParse;
@property(nonatomic, retain) NSMutableArray *workingArray;
@property(nonatomic, retain) AppRecord *workingEntry;
@property(nonatomic, retain) NSMutableString *workingPropertyString;
@property(nonatomic, retain) NSArray *elementsToParse;
@property(nonatomic, assign) BOOL storingCharacterData;
@end

@implementation ParseOperation

@synthesize delegate,dataToParse,workingArray,workingEntry,workingPropertyString,elementsToParse,storingCharacterData;

- (id)initWithData:(NSData *)data delegate:(id<ParseOperationDelegate>)theDelegate
{
    self = [super init];
    if (self != nil) {
        // Initialization code here.
        self.dataToParse = data;
        self.delegate = theDelegate;
        self.elementsToParse = [NSArray arrayWithObjects:kIDStr,kNameStr,kImageStr,kArtistStr,nil];
    }
    
    return self;
}

-(void)dealloc
{
    [dataToParse release];
    [workingEntry release];
    [workingPropertyString  release];
    [workingArray release];
    
    [super dealloc];
}

-(void)main
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    
    self.workingArray =[NSMutableArray array];
    self.workingPropertyString = [NSMutableString string];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:dataToParse];
    [parser setDelegate:self];
    [parser parse];
    
    if (![self isCancelled]) {
        [self.delegate didFinishParsing:self.workingArray];
    }
    
    self.workingArray=nil;
    self.workingPropertyString = nil;
    self.dataToParse = nil;
    
    [parser release];
    [pool release];
}

#pragma mark - 
#pragma mark RSS processing

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
                                    namespaceURI:(NSString *)namespaceURI
                                    qualifiedName:(NSString *)qName
                                    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:kEntryStr]) {
        self.workingEntry = [[[AppRecord alloc] init] autorelease];
    }
    storingCharacterData = [elementsToParse containsObject:elementName];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
                                    namespaceURI:(NSString *)namespaceURI 
                                    qualifiedName:(NSString *)qName
{
    if (self.workingEntry) 
    {
        if (storingCharacterData) 
        {
            NSString *trimmedString = [workingPropertyString stringByTrimmingCharactersInSet:
                                        [NSCharacterSet whitespaceAndNewlineCharacterSet]] ;
            [workingPropertyString setString:@""];
            if ([elementName isEqualToString:kIDStr]) 
            {
                self.workingEntry.appURLString = trimmedString;
            }
            else if([elementName isEqualToString:kNameStr])
            {
                self.workingEntry.appName = trimmedString;
            }
            else if([elementName isEqualToString:kImageStr])
            {
                self.workingEntry.imageURLString = trimmedString;
            }
            else if([elementName isEqualToString:kArtistStr])
            {
                self.workingEntry.artist = trimmedString;
            }
        }
        else if([elementName isEqualToString:kEntryStr])
        {
            [self.workingArray addObject:self.workingEntry];
            self.workingEntry = nil;
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (storingCharacterData)
    {
        [workingPropertyString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    [delegate parseErrorOccurred:parseError];
}



@end
