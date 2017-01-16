//
//  ProfileVC.h
//  RP
//
//  Created by Mac on 02/09/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "RootVC.h"

@interface ProfileVC : RootVC


//Top View
@property (weak, nonatomic) IBOutlet UIImageView *imgVwProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIButton *btnEditProfile;


//Scroll Section
//Place Tab Selection
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollVw;
@property (weak, nonatomic) IBOutlet UIScrollView *outerScrollVw;

//For Friends profile
@property (weak, nonatomic) IBOutlet UIView *topView;   //Header
@property (weak, nonatomic) IBOutlet UILabel *lblTopTitle;


@end
