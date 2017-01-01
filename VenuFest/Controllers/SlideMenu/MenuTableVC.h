//
//  MenuTableVC.h
//  testSlideMenu
//
//  Created by Sayan Chatterjee on 24/07/16.
//  Copyright © 2016 Sayan Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableVC : UITableViewController

//Table View Header View
@property (weak, nonatomic) IBOutlet UIView *VwTblHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;

@end
