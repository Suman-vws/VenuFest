//
//  OutlinedTextField.h
//  Mock
//
//  Created by Sayan Chatterjee on 04/02/2016.
//  Copyright © 2016 XYRALITY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OutlinedTextField : UITextField

// Attributes that are optionally applied to the placeholder text. Default is nil (i.e no additional styling will applied to the placeholder and the placeholder will be styled the same as the textfield except its color will be a 0.8 alpha version of the textfield text color.
@property (nonatomic, strong, nullable) NSDictionary *placeholderAttributes;

// The color of the line when there is an error.
@property (nonatomic, strong, nullable) IBInspectable UIColor *errorColor;

// The color of the line when the textfield is active.  Default is [UIColor lightGrayColor];
@property (nonatomic, strong, nullable) IBInspectable UIColor *lineColor;

//  makes the line the error color.
- (void)showError;

//  makes the line to normal.
- (void)hideError;

// Enables or disables the material placeholder. Default is YES.
@property (nonatomic) IBInspectable BOOL enablePlaceHolder;

@end
