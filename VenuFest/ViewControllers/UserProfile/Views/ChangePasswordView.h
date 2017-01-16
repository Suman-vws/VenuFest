//
//  ChangePasswordView.h
//  VenuFest
//
//  Created by Sayan Chatterjee on 06/01/17.
//  Copyright © 2017 Sayan Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutlinedButton.h"
#import "OutlinedTextField.h"

@protocol ChangePasswordDelegate <NSObject>

-(void)animateScrollViewWithYpos:(CGFloat)Ypos andHeight:(CGFloat)height;
-(void)userPasswordChangedWithData:(NSDictionary *)dictPasswordData;

@end


@interface ChangePasswordView : UIView

@property (strong, nonatomic) id<ChangePasswordDelegate> passwordDelgate;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtCurrentPassword;
@property (weak, nonatomic) IBOutlet UIView *divCurrentPassword;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtNewPassword;
@property (weak, nonatomic) IBOutlet UIView *divNewPassword;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtConfirmPassword;
@property (weak, nonatomic) IBOutlet UIView *divConfirmPassword;

//buttons
@property (weak, nonatomic) IBOutlet OutlinedButton *btnChangePassword;



@end
