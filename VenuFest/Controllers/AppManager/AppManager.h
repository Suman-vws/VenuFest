//
//  AppManager.h
//  TablePouncer
//
//  Created by Md Aftabuddin on 28/05/13.
//  Copyright (c) 2013 Digital Avenues. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RPConstants.h"
#import "SocialUser.h"

@interface AppManager : NSObject

@property (assign) userType loggedInUserType;
@property (nonatomic, strong) SocialUser *socialUser;
@property (nonatomic) BOOL isUserLoggedIN;
@property (nonatomic) BOOL isuserLoggedinFirstTime;




//initialization
+ (AppManager *) sharedDataAccess;
-(void)initalization;
-(void)clearInstance;

//File Operation
+ (Boolean)writeFile:(NSString*)filePath Content:(NSString*)fileContent;
+ (Boolean)truncateFile:(NSString*)filePath;
+ (NSString*)readFile:(NSString*)filePath;

//validation checking
- (Boolean)isValidPhoneNumber:(NSString*)phoneNumber;
- (Boolean)validateEmailWithString:(NSString*)email;
- (Boolean)isEmptyString:(NSString*) textToCheck;
- (Boolean)isAlphaNumericStringWith_8_DigitLetter:(NSString *)string;
- (Boolean)isValidUserName:(NSString *)string;

//Show Alert
-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message fromViewController:(UIViewController *)vc;
-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;

//Utility
-(NSString *)getUserGenderTypeWithValue:(genderType)gender;
-(NSString *)getDateFromJsonwithValue:(NSNumber *)value;
-(NSArray *)getDateTimeFromJsonwithValue:(NSNumber *)value;


@end
