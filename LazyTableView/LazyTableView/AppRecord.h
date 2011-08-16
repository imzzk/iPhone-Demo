//
//  AppRecord.h
//  LazyTableView
//
//  Created by 坤坤 on 11-8-15.
//  Copyright 2011年 博客园. All rights reserved.
//

@interface AppRecord : NSObject
{
    NSString *appName;
    UIImage  *appIcon;
    NSString *artist;
    NSString *imageURLString;
    NSString *appURLString;
    
}

@property(nonatomic, retain)NSString *appName;
@property(nonatomic, retain)UIImage *appIcon;
@property(nonatomic, retain)NSString *artist;
@property(nonatomic, retain)NSString *imageURLString;
@property(nonatomic, retain)NSString *appURLString;
@end
