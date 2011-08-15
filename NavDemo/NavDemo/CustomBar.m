//
//  CustomBar.m
//  NavDemo
//
//  Created by 坤坤 on 11-8-12.
//  Copyright 2011年 博客园. All rights reserved.
//

#import "CustomBar.h"

@implementation CustomBar


-(void)initTab
{
    backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbg.png"]];
    selectedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbg.png"]];
    tabBarImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbg.png"]];
    tabText = [[NSMutableArray alloc] initWithObjects:@"最新新闻",@"推荐新闻",@"热门新闻",@"最新评论",@"设置", nil];
}

-(void)tabBarUnSelected
{
    for (UIView *view in self.view.subviews) {
        if([view isKindOfClass:[UITabBar class]])
        {
            view.hidden = YES;
            break;
        }
    }
}

-(void)addCustomBarElements
{
    int tabNum = 5;
    
    UIImageView *tabBarBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 430, 320, 50)];
    [tabBarBg setImage:tabBarImage.image];
    [self.view addSubview:tabBarBg];
    
    tabButtonText= [[NSMutableArray alloc] initWithCapacity:0];
    for (int i =0; i < tabNum; i++) {
        btnTabbar = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnTabbar setFrame:CGRectMake(10 + i*75, 430 , 75, 50)];
        [btnTabbar setBackgroundImage:backgroundImage.image forState:UIControlStateNormal];
        [btnTabbar setBackgroundImage:selectedImage.image forState:UIControlStateNormal];
        [btnTabbar setTitle:[tabText objectAtIndex:i] forState:UIControlStateNormal];
        [btnTabbar.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
        if (i == 0) {
            btnTabbar.selected = YES;
        }
        [btnTabbar setTag:i];
        [tabButtonText addObject:btnTabbar];
        [self.view addSubview:btnTabbar];
        [btnTabbar addTarget:self action:@selector(btnClickedTag:) forControlEvents:UIControlEventTouchUpInside];
        [btnTabbar release];
    }
}

-(void)btnClickedTag:(id)sender
{
    int tagNum = [sender tag];
    [self tabBarSelected:tagNum];
}

-(void)tabBarSelected:(int)tabId
{
    switch (tabId) {
        case 0:
            [[tabButtonText objectAtIndex:0] setSelected:true];
            [[tabButtonText objectAtIndex:1] setSelected:false];
            [[tabButtonText objectAtIndex:2] setSelected:false];
            [[tabButtonText objectAtIndex:3] setSelected:false];
            [[tabButtonText objectAtIndex:4] setSelected:false];
            break;
        case 1:
            [[tabButtonText objectAtIndex:0] setSelected:false];
            [[tabButtonText objectAtIndex:1] setSelected:true];
            [[tabButtonText objectAtIndex:2] setSelected:false];
            [[tabButtonText objectAtIndex:3] setSelected:false];
            [[tabButtonText objectAtIndex:4] setSelected:false];
            break;
        case 2:
            [[tabButtonText objectAtIndex:0] setSelected:false];
            [[tabButtonText objectAtIndex:1] setSelected:false];
            [[tabButtonText objectAtIndex:2] setSelected:true];
            [[tabButtonText objectAtIndex:3] setSelected:false];
            [[tabButtonText objectAtIndex:4] setSelected:false];
            break;
        case 3:
            [[tabButtonText objectAtIndex:0] setSelected:false];
            [[tabButtonText objectAtIndex:1] setSelected:false];
            [[tabButtonText objectAtIndex:2] setSelected:false];
            [[tabButtonText objectAtIndex:3] setSelected:true];
            [[tabButtonText objectAtIndex:4] setSelected:false];
            break;
        case 4:
            [[tabButtonText objectAtIndex:0] setSelected:false];
            [[tabButtonText objectAtIndex:1] setSelected:false];
            [[tabButtonText objectAtIndex:2] setSelected:false];
            [[tabButtonText objectAtIndex:3] setSelected:false];
            [[tabButtonText objectAtIndex:4] setSelected:true];
            break;
    }
    self.selectedIndex = tabId;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initTab];
    [self tabBarUnSelected];
    [self addCustomBarElements];
}


#pragma mark - View lifecycle

-(void)dealloc
{

    [backgroundImage release];
    [selectedImage release];
    [tabBarImage release];
    [tabButtonText release];
    [tabText release];
    [super dealloc];
}

@end
