//
//  AppManager.m
//  TablePouncer
//
//  Created by Md Aftabuddin on 28/05/13.
//  Copyright (c) 2013 Digital Avenues. All rights reserved.
//

#import "AppManager.h"
#import "AppDelegate.h"

@implementation AppManager

@synthesize strDeviceToken = _strDeviceToken;
@synthesize strUserName=_strUserName;
@synthesize strUserId = _strUserId;
@synthesize strUserEmailId = _strUserEmailId;
@synthesize strUserPassword = _strUserPassword;
@synthesize IsLoggedIn = _IsLoggedIn;
@synthesize strAuthToken = _strAuthToken;
@synthesize strSocialLoginID = _strSocialLoginID;
@synthesize strSocialImageURL = _strSocialImageURL;
//@synthesize scrollListType = _scrollListType;
@synthesize strUserImagePath = _strUserImagePath;
//@synthesize user = _user;

static AppManager *sharedInstance_ = nil;


+ (AppManager *) sharedDataAccess{
    @synchronized(self){
		if (sharedInstance_ == nil) {
			sharedInstance_ = [[self alloc] init];
            [sharedInstance_ initalization];
            return sharedInstance_;
		}
        return sharedInstance_;
	}
}

-(void)initalization{

    _strDeviceToken = @"";
    self.strUserEmailId = @"";
    self.strUserPassword = @"";
    self.strSocialLoginID  = @"";
    self.strSocialImageURL = @"";
    _strUserName=@"";
//    _scrollListType = profileListTypeNone;
}

-(void)clearInstance{
    
    self.IsLoggedIn = NO;
    
    self.strUserId = @"";
    self.strAuthToken = @"";
    self.strUserPassword = @"";
    self.strUserEmailId = @"";
    _strUserName=@"";
    self.strUserImagePath = @"";
    
    //TODO: clear all the data save in NSUserDefaults for user account configuration
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"AuthToken"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userEmail"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userPassword"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userProfileImage"];

    [userInfo synchronize];
}

+ (NSString*)getTodayTomorrowFormat:(NSString*)day{
    
    NSDate *dtBooking = [NSDate date];
    
    if([day isEqualToString:@"Tomorrow"])
        dtBooking = [[NSDate date] dateByAddingTimeInterval:60*60*24*1];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM"];
    day = [formatter stringFromDate:dtBooking];
    
    return day;
}
#pragma mark - File handeling

+ (Boolean)writeFile:(NSString*)filePath Content:(NSString*)fileContent{
    
    @autoreleasepool {
        NSData *data = [fileContent dataUsingEncoding:NSUTF8StringEncoding];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath] == NO){
            [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
        }
        else{
            if ([[NSFileManager defaultManager] isWritableFileAtPath:filePath]) {
                NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
                [file writeData:data];
                [file closeFile];
            }
        }
    }
    
    return true;
}

+ (Boolean)truncateFile:(NSString*)filePath{
    @autoreleasepool {
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath] == YES){
            if ([[NSFileManager defaultManager] isWritableFileAtPath:filePath]) {
                NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
                [file truncateFileAtOffset:0];
                [file closeFile];
            }
        }
    }
    
    return true;
}

+ (NSString*)readFile:(NSString*)filePath{
    
    NSString *fileContent;
    @autoreleasepool {
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath] ==YES) {
            if ([[NSFileManager defaultManager] isReadableFileAtPath:filePath]) {
                NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
                fileContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
        }
    }
    return fileContent;
}

#pragma validation Checking

- (Boolean)isValidPhoneNumber:(NSString *)phoneNumber{
    bool result = false;

    if ([phoneNumber length]>=10) {
        NSString *mobileNumberPattern = @"[0-9]+";
        NSPredicate *mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];
        result = [mobileNumberPred evaluateWithObject:phoneNumber];
    }
    
    return result;
}



- (Boolean)isAlphaNumericStringWith_8_DigitLetter:(NSString *)string{
    bool result = false;
    
    if ([string length]>=8) {
        NSString *strPattern = @"^[a-zA-Z0-9]*$";
        NSPredicate *strPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strPattern];
        result = [strPred evaluateWithObject:string];
    }
    
    return result;
}

- (Boolean)isValidUserName:(NSString *)string{
    bool result = false;
    
    if ([string length] > 0 ) {
        NSString *strPattern = @"^[a-zA-Z ]*$";
        NSPredicate *strPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strPattern];
        result = [strPred evaluateWithObject:string];
    }
    
    return result;
}

- (Boolean)validateEmailWithString:(NSString*)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (Boolean)isEmptyString:(NSString*) textToCheck{
    BOOL blnReruntValue = false;
    
    textToCheck = [textToCheck stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([textToCheck length] <= 0) {
        return true;
    }
    
    return blnReruntValue;
}
-(void) checkPasswordValidation:(NSString *) password withConfirmedPassword:(NSString *) ConfirmedPassword{
    if([password  isEqualToString:ConfirmedPassword])
        return ;
    else
    {
        [self showAlertWithTitle:@"Alert" andMessage:@"Password Mismatch"];
    }
}


#pragma mark - Alert

// For ---> (Default Alert)
-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    [alertController addAction:cancelAction];
    
    //   Finally we can present the alert view controller as with any other view controller:
    
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate ;
    UIViewController *vc = [ appdelegate.window rootViewController];

    [vc presentViewController: alertController animated:YES completion:nil];
}

// For ---> (Default Alert)

-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message fromViewController:(UIViewController *)vc{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                   }];
    
    
    [alertController addAction:cancelAction];
    alertController.view.tintColor = [UIColor redColor];
    [vc presentViewController: alertController animated:YES completion:nil];
    
}

#pragma mark - GET Request type as string

-(NSString *)getStringForRequestType:(RequestType)type {
    
    NSString *requestTypeString;
    
    switch (type) {
        case GET:
            requestTypeString = @"GET";
            break;
            
        case POST:
            requestTypeString = @"POST";
            break;
            
        case PUT:
            requestTypeString = @"PUT";
            break;
            
        case DELETE:
            requestTypeString = @"DELETE";
            break;
            
        default:
            requestTypeString = @"GET";
            break;
    }
    
    return requestTypeString;
}

//convert millisecond to hr:mm:ss format
-(NSString *)getDateFromJsonwithValue:(NSNumber *)value
{
    NSMutableString * result;
    
    unsigned long milliseconds=[value longValue];
    unsigned long seconds = milliseconds / 1000;
    milliseconds %= 1000;
    unsigned long minutes = seconds / 60;
    seconds %= 60;
    unsigned long hours = minutes / 60;
    minutes %= 60;
    result = [NSMutableString new];
    
    [result appendFormat: @"%lu:", hours];
    
    [result appendFormat: @"%2lu:", minutes];
    [result appendFormat: @"%2lu", seconds];
     return result;
}

-(NSArray *)getDateTimeFromJsonwithValue:(NSNumber *)value
{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([value longValue] / 1000.0)];
    // NSLog(@"  date  is now==>>%@",  date);
    NSDateFormatter *dtfrm = [[NSDateFormatter alloc] init];
    [dtfrm setDateFormat:@"dd/MMM/yyyy HH:mm:ss"];
     NSString *str_getdate = [dtfrm stringFromDate:date];
     
     NSArray* arrDateTime = [str_getdate componentsSeparatedByString: @" "];
    
    return arrDateTime;
}

-(void)clearUserLoginData
{
    self.strUserEmailId = @"";
    self.strUserPassword = @"";
    self.strSocialLoginID  = @"";
    self.strSocialImageURL = @"";
    _strUserName=@"";
    
}

@end
