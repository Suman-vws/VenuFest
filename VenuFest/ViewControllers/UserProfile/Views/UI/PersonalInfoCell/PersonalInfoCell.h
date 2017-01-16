//
//  PersonalInfoCell.h
//  RP
//
//  Created by Mac on 13/10/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTag;
@property (weak, nonatomic) IBOutlet UILabel *lblValues;
@property (weak, nonatomic) IBOutlet UIButton *btnLogout;

@end
