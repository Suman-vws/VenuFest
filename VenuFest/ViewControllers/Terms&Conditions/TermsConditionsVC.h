//
//  TermsConditionsVC.h
//  VenuFest
//
//  Created by Sayan Chatterjee on 06/12/16.
//  Copyright © 2016 Sayan Chatterjee. All rights reserved.
//

#import "RPConstants.h"
#import "OutlinedButton.h"

@interface TermsConditionsVC : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UITextView *txtVwTermsConditions;
@property (weak, nonatomic) IBOutlet UILabel *lblWelcome;
@property (weak, nonatomic) IBOutlet UITextView *txtVwWelcome;


//buttons
@property (weak, nonatomic) IBOutlet OutlinedButton *btnAccept;
@property (weak, nonatomic) IBOutlet OutlinedButton *btnReject;
@property (weak, nonatomic) IBOutlet OutlinedButton *btnNext;

@end
