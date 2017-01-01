//
//  OutlinedButton.h
//  Mock
//
//  Created by Sayan Chatterjee on 04/02/2016.
//  Copyright © 2016 XYRALITY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OutlinedButton : UIButton

// Corner radius of the button to make it rounded rect. Default 5.0f.
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

// Border width of the button. Default is 1.0f.
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

@end
