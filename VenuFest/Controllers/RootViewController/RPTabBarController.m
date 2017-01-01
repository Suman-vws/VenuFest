//
//  RPTabBarController.m
//  RP
//
//  Created by Mac on 30/08/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "RPTabBarController.h"
#import "RPConstants.h"

@implementation RPTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configTabBarUI];
}


//Config UI For TabBar Controller

-(void)configTabBarUI
{
    UITabBar *tabBar = self.tabBar;
    
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor greenColor] }
//                                             forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }
//                                             forState:UIControlStateSelected];
    
    // Change the title color of tab bar items
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TAB_BAR_DE_SELECTED_COLOR, NSForegroundColorAttributeName,  TAB_BAR_TITLE_LABLE_FONT,  NSFontAttributeName, nil] forState: UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TAB_BAR_SELECTED_COLOR, NSForegroundColorAttributeName, TAB_BAR_TITLE_LABLE_FONT,  NSFontAttributeName, nil] forState: UIControlStateSelected];
    
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UIImage *deselectedImage = [[UIImage imageNamed:@"blog.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:@"blog.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //changed name  9.11.2016
    tabBarItem1 =[tabBarItem1 initWithTitle:@"" image:deselectedImage selectedImage:selectedImage];
    
    
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
   deselectedImage = [[UIImage imageNamed:@"man_small.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   selectedImage = [[UIImage imageNamed:@"man_small.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //changed name  9.11.2016
   tabBarItem2 =[tabBarItem2 initWithTitle:@"" image:deselectedImage selectedImage:selectedImage];
    
    
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    deselectedImage = [[UIImage imageNamed:@"market.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage = [[UIImage imageNamed:@"market.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //changed name  9.11.2016
    tabBarItem3 =[tabBarItem3 initWithTitle:@"" image:deselectedImage selectedImage:selectedImage];
    
    
    // Change the tab bar background
    UIImage* tabBarBackground = [UIImage imageNamed:@"footerbar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabBarSelected_New.png"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
