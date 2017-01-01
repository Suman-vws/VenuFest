//
//  ProfileVC.h
//  RP
//
//  Created by Mac on 02/09/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "RootVC.h"
//#import "DVSwitch.h"

@interface ProfileVC : RootVC


//Top View
@property (weak, nonatomic) IBOutlet UIImageView *imgVwProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTagDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblTagTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIButton *btnEditProfile;
@property (weak, nonatomic) IBOutlet OutlinedButton *btnUpload;

@property (assign, nonatomic) BOOL isVistingFriendProfile;



//Scroll Section
//Place Tab Selection
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *vwSegment;

//For Friends profile
@property (weak, nonatomic) IBOutlet UIView *topView;   //Header
@property (weak, nonatomic) IBOutlet UILabel *lblTopTitle;


@end
