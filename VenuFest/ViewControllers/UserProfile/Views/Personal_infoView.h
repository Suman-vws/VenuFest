//
//  Personal_infoView.h
//  RP
//
//  Created by Mac on 07/09/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Personal_infoView : UIView

@property (strong, nonatomic) NSString *strAbout;
@property (strong, nonatomic) NSString *strEmail;
@property (strong, nonatomic) NSString *strPhone;
@property (strong, nonatomic) NSString *strCity;
@property (strong, nonatomic) NSString *strGender;
@property (strong, nonatomic) NSString *strAge;
@property (strong, nonatomic) NSString *strHeight;
@property (strong, nonatomic) NSString *strWeight;


-(void)configData;

@end
