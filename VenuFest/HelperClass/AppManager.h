//
//  AppManager.h
//  TablePouncer
//
//  Created by Md Aftabuddin on 28/05/13.
//  Copyright (c) 2013 Digital Avenues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <CoreLocation/CoreLocation.h>

typedef void(^tokenCompletion)(BOOL);

@interface AppManager : NSObject


@property (nonatomic, strong) NSMutableDictionary *userInfo;
@property (nonatomic, strong) NSDictionary *restaurantInfo;
@property (nonatomic, strong) NSMutableDictionary *orderInfo;
@property (nonatomic, strong) NSMutableArray *arrUserMenuList;
@property (nonatomic, strong) NSMutableArray *arrInviteeList;
@property (nonatomic, strong) NSString *strDeviceToken;
@property (nonatomic, strong) NSString *strUUID;
@property (nonatomic, strong) NSString *strCurrentUUID;
@property (nonatomic, strong) NSString *strPaymentUUID;
@property (nonatomic, strong) NSString *selectedRestaurantId;
@property (nonatomic) BOOL isFromPushNotification;
@property (nonatomic) BOOL isPickUpOptionMe;

@property (nonatomic, strong) NSArray *arrInvitees;

@property (nonatomic) int iEditMenuIndex;

@property (nonatomic, strong) NSString *senderId;
@property (nonatomic, strong) NSString *senderName;

@property (nonatomic, strong) NSString *picupId;
@property (nonatomic, strong) NSString *picupName;
@property (nonatomic, strong) NSString *pickupVenmoAccount;
@property (nonatomic) float lastOrderAmount;
@property (nonatomic) BOOL isUserCreateOrder;


@property (nonatomic) float latitudeLast;
@property (nonatomic) float longitudeLast;

@property (nonatomic) BOOL isInvitationActive;

//@property (nonatomic, strong) SBRRightMenu *viewRightMenu;

+ (AppManager *) sharedDataAccess;
-(void)initalization;
-(void)clearInstance;

+ (NSString*)getTodayTomorrowFormat:(NSString*)day;

+ (Boolean)writeFile:(NSString*)filePath Content:(NSString*)fileContent;
+ (Boolean)truncateFile:(NSString*)filePath;
+ (NSString*)readFile:(NSString*)filePath;
+ (NSString *)contentTypeForImageData:(NSData *)data ;

- (Boolean)isValidPhoneNumber:(NSString*)phoneNumber;
- (Boolean)validateEmailWithString:(NSString*)email;
- (Boolean)isEmptyString:(NSString*) textToCheck;
- (Boolean)isValidUserName:(NSString *)string;
-(void)clearUserLoginData;

-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;
-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message fromViewController:(UIViewController *)vc;
//-(SBRRightMenu*)getRightMenu:(CGRect)rc;

-(void) connectionAuth:(tokenCompletion) compblock;
- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size;

@end
