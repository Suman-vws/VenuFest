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

@synthesize socialUser  = _socialUser;
@synthesize  isUserLoggedIN = _isUserLoggedIN;
@synthesize isuserLoggedinFirstTime = _isuserLoggedinFirstTime;

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

-(void)initalization
{
    self.socialUser = [SocialUser new];
}

-(void)clearInstance
{
    self.socialUser = nil;
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

#pragma mark - Utility Methods

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

+ (NSString*)getTodayTomorrowFormat:(NSString*)day{
    
    NSDate *dtBooking = [NSDate date];
    
    if([day isEqualToString:@"Tomorrow"])
        dtBooking = [[NSDate date] dateByAddingTimeInterval:60*60*24*1];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM"];
    day = [formatter stringFromDate:dtBooking];
    
    return day;
}

-(NSString *)getUserGenderTypeWithValue:(genderType)gender
{
    NSString *userGender;
    
    switch (gender) {
        case userGenderTypeFemale:
            userGender = @"FEMALE";
            break;
            
        case userGenderTypeMale:
            userGender = @"MALE";
            break;
            
        case userGenderTypeOther:
            userGender = @"OTHER";
            break;
            
        case userGenderTypeNone:
            userGender = @"NONE";
            break;
            
        default:
            userGender = @"NONE";
            break;
    }
    
    return userGender;
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


@end
