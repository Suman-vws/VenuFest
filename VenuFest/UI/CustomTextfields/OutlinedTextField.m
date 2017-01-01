//
//  OutlinedTextField.m
//  Mock
//
//  Created by Sayan Chatterjee on 04/02/2016.
//  Copyright © 2016 XYRALITY. All rights reserved.
//

#import "OutlinedTextField.h"

static CGFloat const OTLineAlpha                            = 1.0f;
static CGFloat const OTShowHideAnimationDuration            = 0.3f;
static CGFloat const OTTextChangeAnimationDuration          = 0.6f;
static CGFloat const OTTextChangeVelocity                   = 0.6f;
static CGFloat const OTTextDampingRatio                     = 1.0f;

@implementation OutlinedTextField{
    UIView *line;
    UILabel *placeHolderLabel;
    BOOL showError;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self commonSetup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
        [self commonSetup];
    }
    
    return self;
}


#pragma mark - Custom Setup

- (void)commonInit {
    _enablePlaceHolder = YES;
    _lineColor = [UIColor whiteColor];
    _errorColor = [UIColor colorWithRed:0.910 green:0.329 blue:0.271 alpha:1.000]; // FLAT RED COLOR
}

- (void)commonSetup {
    line = [[UIView alloc] init];
    line.backgroundColor = [_lineColor colorWithAlphaComponent:OTLineAlpha];
    [self addSubview:line];
    self.clipsToBounds = NO;
    [self setEnablePlaceHolder:self.enablePlaceHolder];
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    line.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
}


#pragma mark - Pubic

- (void)showError {
    showError = YES;
    line.backgroundColor = _errorColor;
}

- (void)hideError {
    showError = NO;
    line.backgroundColor = _lineColor;
}

#pragma mark - Properties

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textFieldDidChange:self];
}

- (void)setPlaceholderAttributes:(NSDictionary *)placeholderAttributes {
    _placeholderAttributes = placeholderAttributes;
    [self setPlaceholder:self.placeholder];
}

-(void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    
    NSDictionary *atts = @{NSForegroundColorAttributeName: [self.textColor colorWithAlphaComponent:OTLineAlpha], NSFontAttributeName : [self.font fontWithSize: self.font.pointSize]};
    
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder ?: @"" attributes: self.placeholderAttributes ?: atts];
    
    [self setEnablePlaceHolder:self.enablePlaceHolder];
}

- (void)setEnablePlaceHolder:(BOOL)enablePlaceHolder {
    _enablePlaceHolder = enablePlaceHolder;
    
    if (!placeHolderLabel) {
        placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 0, self.frame.size.height)];
        [self addSubview:placeHolderLabel];
    }
    placeHolderLabel.alpha = 0;
    placeHolderLabel.attributedText = self.attributedPlaceholder;
    [placeHolderLabel sizeToFit];
    
}

#pragma mark - Private

- (IBAction)textFieldDidChange:(id)sender {
    if (self.enablePlaceHolder) {
        if (!self.text || self.text.length > 0) {
            placeHolderLabel.alpha = 1;
            self.attributedPlaceholder = nil;
        }
        
        [UIView animateWithDuration:OTTextChangeAnimationDuration
                              delay:0.0f
             usingSpringWithDamping:OTTextDampingRatio
              initialSpringVelocity:OTTextChangeVelocity
                            options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                if (!self.text || self.text.length <= 0) {
                                    placeHolderLabel.transform = CGAffineTransformMakeTranslation(self.leftView.frame.size.width,6);
  
                                }
                                else {
                                    placeHolderLabel.transform = CGAffineTransformMakeTranslation(0, -placeHolderLabel.frame.size.height - 10);
                                }
                            }
                         completion:^(BOOL finished) {
                             
                         }];
        
    }
}

-(IBAction)clearAction:(id)sender {
    self.text = @"";
    [self textFieldDidChange:self];
}

-(void)highlight {
    [UIView animateWithDuration: OTShowHideAnimationDuration
                          delay: 0 // without delay before starting
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (showError) {
                             line.backgroundColor = _errorColor;
                         }
                         else {
                             line.backgroundColor = _lineColor;
                         }
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
}

-(void)unhighlight {
    [UIView animateWithDuration: OTShowHideAnimationDuration
                          delay: 0 // without delay before starting
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         if (showError) {
                             line.backgroundColor = _errorColor;
                         }
                         else {
                             line.backgroundColor = [_lineColor colorWithAlphaComponent:OTLineAlpha];
                         }
                     }
                     completion:^(BOOL finished) {
                
                     }];
    
}

#pragma mark - Override

- (BOOL)becomeFirstResponder {
    BOOL returnValue = [super becomeFirstResponder];
    
    [self highlight];
    
    return returnValue;
}

- (BOOL)resignFirstResponder {
    BOOL returnValue = [super resignFirstResponder];
    
    [self unhighlight];
    
    return returnValue;
}

@end
