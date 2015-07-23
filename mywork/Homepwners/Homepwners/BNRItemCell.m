//
//  BNRItemCell.m
//  Homepwners
//
//  Created by jyl on 15/7/22.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "BNRItemCell.h"

@interface BNRItemCell ()
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
//@property (nonatomic, weak) IBOutlet NSLayoutConstraint *imageViewWidthConstraint;

@end


@implementation BNRItemCell

- (IBAction)showImage:(id)sender
{
    // Check it block exists before calling
    if (self.actionBlock) {
        self.actionBlock();
    }
}

#pragma mark -Fonts
- (void)updateInterfaceForDynamicTypeSize
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.nameLabel.font = font;
    self.serialNumberLabel.font = font;
    self.valueLabel.font = font;
    
    static NSDictionary *imageSizeDictionary;
    
    if (!imageSizeDictionary) {
        imageSizeDictionary = @{
                                UIContentSizeCategoryExtraSmall : @40,
                                UIContentSizeCategorySmall : @40,
                                UIContentSizeCategoryMedium : @40,
                                UIContentSizeCategoryLarge : @40,
                                UIContentSizeCategoryExtraLarge : @45,
                                UIContentSizeCategoryExtraExtraLarge : @55,
                                UIContentSizeCategoryExtraExtraExtraLarge : @65 };
    }
    
    NSString *userSize = [[UIApplication sharedApplication] preferredContentSizeCategory];
    
    NSNumber *imageSize = imageSizeDictionary[userSize];
    self.imageViewHeightConstraint.constant = imageSize.floatValue;
//    self.imageViewWidthConstraint.constant = imageSize.floatValue;
    
}

- (void)awakeFromNib
{
    [self updateInterfaceForDynamicTypeSize];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(updateInterfaceForDynamicTypeSize)
               name:UIContentSizeCategoryDidChangeNotification
             object:nil];
    // Add placehoder constraints
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint constraintWithItem:self.thumbnailView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.thumbnailView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1
                                  constant:0];
    [self.thumbnailView addConstraint:constraint];
}

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

@end
