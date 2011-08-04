//
//  MovieDetailViewController.h
//  SectionTable
//
//  Created by 坤坤 on 11-8-4.
//  Copyright 2011年 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController
{

    UILabel *label;
    NSString *selectedMovie;
    
}

@property (nonatomic, retain)NSString *selectedMovie;

@end
