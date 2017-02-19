//
//  SocialUser.h
//  VenuFest
//
//  Created by Sayan Chatterjee on 18/02/17.
//  Copyright © 2017 Sayan Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocialUser : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userSocialID;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSString *userProfileImg;

@property(nonatomic) BOOL isSocialSignup;

@end
