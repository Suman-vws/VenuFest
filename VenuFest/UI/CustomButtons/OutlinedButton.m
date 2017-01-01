//
//  OutlinedButton.m
//  Mock
//
//  Created by Sayan Chatterjee on 04/02/2016.
//  Copyright © 2016 XYRALITY. All rights reserved.
//

#import "OutlinedButton.h"
#import <QuartzCore/QuartzCore.h>

//static CGFloat const OBDefaultFontSize        = 18.0f;
static CGFloat const OBCornerRadius           = 0.0f; // changed
static CGFloat const OBBorderWidth            = 0.0f;
static CGFloat const OBAnimationDuration      = 0.3f;
static CGFloat const OBTouchableGuidelineDimension = 44;
static UIEdgeInsets const SWContentEdgeInsets = {5, 0, 5, 0};

@interface OutlinedButton ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation OutlinedButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self commonSetup];
        
        // Set default font when init in code
 //       [self.titleLabel setFont:[UIFont boldSystemFontOfSize:OBDefaultFontSize]];;   //changed
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

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundImageView.image = [self obbackgroundImage];
}

#pragma mark - Custom Setup

- (void)commonInit {
    _cornerRadius = OBCornerRadius;
    _borderWidth = OBBorderWidth;
}

- (void)commonSetup {
    self.adjustsImageWhenHighlighted = NO;
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.tintColor.CGColor;
    [self setContentEdgeInsets:SWContentEdgeInsets];
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.backgroundImageView.alpha = 0;
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self insertSubview:self.backgroundImageView atIndex:0];
    self.selected = self.selected;
}

#pragma mark - Properties

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    
    self.layer.borderWidth = borderWidth;
}

- (void)setHighlightedTintColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateSelected];
    [self setTitleColor:color forState:UIControlStateSelected|UIControlStateHighlighted];
    
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    if (enabled) {
        self.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
    } else {
        self.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    }
}

#pragma mark - Override

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (self.selected) {
        if (self.highlighted) {
            self.backgroundImageView.alpha = 0.5;
            self.titleLabel.alpha = 0;
            self.imageView.alpha = 0;
            self.imageView.tintColor = [UIColor clearColor];
            self.layer.borderColor = [UIColor clearColor].CGColor;
        } else {
            self.backgroundImageView.alpha = 1;
            self.titleLabel.alpha = 0;
            self.imageView.alpha = 0;
            self.imageView.tintColor = [UIColor clearColor];
        }
    } else {
        [UIView animateWithDuration:OBAnimationDuration animations:^{
            if (highlighted) {
                
                self.backgroundImageView.alpha = 1;
                self.titleLabel.alpha = 0;
                self.imageView.alpha = 0;
                self.imageView.tintColor = [UIColor clearColor];
                self.layer.borderWidth = 1.0f;
                //added new
                self.layer.borderColor = [UIColor lightGrayColor].CGColor;
            } else {
                self.layer.borderColor =  self.tintColor.CGColor;
                self.backgroundImageView.alpha = 0;
                self.titleLabel.alpha = 1;
                self.imageView.alpha = 1;
                self.layer.borderWidth = self.borderWidth;
                self.imageView.tintColor = self.tintColor;
            }
        }];
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.backgroundImageView.alpha = 1;
        self.titleLabel.alpha = 0;
        self.imageView.alpha = 0;
        self.imageView.tintColor = [UIColor clearColor];
    }
}

- (void)tintColorDidChange {
    self.layer.borderColor = self.tintColor.CGColor;
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    self.backgroundImageView.image = [self obbackgroundImage];
}

#pragma mark - helper

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGSize buttonSize = self.bounds.size;
    CGFloat widthToAdd = MAX(OBTouchableGuidelineDimension - buttonSize.width, 0);
    CGFloat heightToAdd = MAX(OBTouchableGuidelineDimension - buttonSize.height, 0);
    CGRect newFrame = CGRectInset(self.bounds, -widthToAdd, -heightToAdd);
    
    return CGRectContainsPoint(newFrame, point);
}


- (UIImage *)obbackgroundImage {
    CGRect rect = self.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSRange range =NSMakeRange(0, self.titleLabel.text.length);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];
    CGContextSetFillColorWithColor(context, self.tintColor.CGColor);
    [path fill];
    NSAttributedString *attributedString =    self.titleLabel.attributedText;
    
    NSDictionary *dict = [attributedString attributesAtIndex:0 effectiveRange:&range];
    
    CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
    
    [self.titleLabel.text drawInRect:self.titleLabel.frame withAttributes:dict];
    UIImage *i = self.imageView.image;
    [i drawAtPoint:self.imageView.frame.origin blendMode:kCGBlendModeDestinationOut alpha:1];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
