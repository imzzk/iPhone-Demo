//
//  CustomBar.h
//  NavDemo
//
//  Created by 坤坤 on 11-8-12.
//  Copyright 2011年 博客园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBar : UITabBarController
{
    UIImageView *backgroundImage;
    UIImageView *selectedImage;
    UIImageView *tabBarImage;
    
    NSMutableArray *tabText;
    NSMutableArray *tabButtonText;
    
    UIButton *btnTabbar;
}

-(void)initTab;
-(void)tabBarUnSelected;
-(void)addCustomBarElements;
-(void)tabBarSelected:(int)tabId;


@end
