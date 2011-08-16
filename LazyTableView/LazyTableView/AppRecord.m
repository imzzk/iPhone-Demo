//
//  AppRecord.m
//  LazyTableView
//
//  Created by 坤坤 on 11-8-15.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "AppRecord.h"

@implementation AppRecord

@synthesize appName,appIcon,appURLString,artist,imageURLString;

-(void)dealloc
{
    [appIcon release];
    [appName release];
    [appURLString release];
    [artist release];
    [imageURLString release];
    [super dealloc];
}

@end
