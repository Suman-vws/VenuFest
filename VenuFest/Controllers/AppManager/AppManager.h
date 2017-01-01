//
//  AppManager.h
//  TablePouncer
//
//  Created by Md Aftabuddin on 28/05/13.
//  Copyright (c) 2013 Digital Avenues. All rights reserved.
//

typedef enum RequestTypes{
    
    GET,
    POST,
    PUT,
    DELETE
    
}RequestType;


#import <Foundation/Foundation.h>
#import  <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "RPConstants.h"

@interface AppManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *dictOfflineImage;
@property (nonatomic, strong) NSString *strUserName;
@property (nonatomic, strong) NSString *strUserImagePath;
@property(nonatomic, strong) NSString *strUserId;
@property(nonatomic, strong) NSString *strUserPassword;
@property(nonatomic, strong) NSString *strUserEmailId;
@property (nonatomic, strong) NSString *strDeviceToken;

@property (nonatomic, strong) NSString *strAuthToken;
@property (assign) BOOL IsLoggedIn;


//for social login

@property (nonatomic, strong) NSString *strSocialLoginID;
@property (nonatomic, strong) NSString *strSocialImageURL;
//@property (nonatomic, assign) profileListType scrollListType;

+ (AppManager *) sharedDataAccess;
-(void)initalization;
-(void)clearInstance;


+ (Boolean)writeFile:(NSString*)filePath Content:(NSString*)fileContent;
+ (Boolean)truncateFile:(NSString*)filePath;
+ (NSString*)readFile:(NSString*)filePath;

- (Boolean)isValidPhoneNumber:(NSString*)phoneNumber;
- (Boolean)validateEmailWithString:(NSString*)email;
- (Boolean)isEmptyString:(NSString*) textToCheck;
- (Boolean)isAlphaNumericStringWith_8_DigitLetter:(NSString *)string;
- (Boolean)isValidUserName:(NSString *)string;

-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message fromViewController:(UIViewController *)vc;
-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;

//returns the API request Type
-(NSString *)getStringForRequestType:(RequestType)type;
-(void)clearUserLoginData;
-(NSString *)getUserGenderTypeWithValue:(genderType)gender;
-(NSString *)getDateFromJsonwithValue:(NSNumber *)value;
-(NSArray *)getDateTimeFromJsonwithValue:(NSNumber *)value;
-(genderType)getUserGenderTypeWithText:(NSString *)text;

@end
