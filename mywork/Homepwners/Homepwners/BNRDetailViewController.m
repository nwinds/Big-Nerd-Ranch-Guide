//
//  BNRDetailViewController.m
//  Homepwners
//
//  Created by jyl on 15/7/16.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *imagePickerPopover;

#pragma mark -View outlet
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNameField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@end




@implementation BNRDetailViewController


#pragma mark -Modal handling

- (instancetype)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                      target:self
                                                                                      action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                        target:self
                                                                                        action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
        
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self
                          selector:@selector(updateFonts)
                              name:UIContentSizeCategoryDidChangeNotification
                            object:nil];
        
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer"
                                   reason:@"Use initForNewItem:"
                                 userInfo:nil];
    return nil;
}


- (IBAction)save:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:self.dismissBlock];
}

- (void)cancel:(id)sender
{
    // If user press down Cancel button, then remove BNRItem from BNRItemStore object
    [[BNRItemStore sharedStore] removeItem:self.item];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -Previous

- (IBAction)takePicture:(id)sender
{
    if ([self.imagePickerPopover isPopoverVisible]) {
        // If imagePickerPopover pointing to effective UIPopoverController object
        // And its object's UIView is visible, then close it and set nil
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // If device support camera, enable photo
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        // Otherwise, select from local
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    // Modal: output UIImagePickerController
//    [self presentViewController:imagePicker animated: YES completion:nil];
    
    // Show UIImagePickerController objects
    // Check if currenr device is iPad
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        // Create UIPopoverController object, for showing UIImagePickerController object
        self.imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        
        self.imagePickerPopover.delegate = self;
        
        // Show UIPopover controller
        // sender pointing UIBarButtonItem object
        [self.imagePickerPopover presentPopoverFromBarButtonItem:sender
                                        permittedArrowDirections:UIPopoverArrowDirectionAny
                                                        animated:YES];
    } else {
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NSLog(@"User dismissed popover");
    self.imagePickerPopover = nil;
}

- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
    
//    // Check out ambiguous
//    for (UIView *subview in self.view.subviews) {
//        if ([subview hasAmbiguousLayout]) {
//            [subview exerciseAmbiguityInLayout];
//        }
//    }
}



- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Fetch selected photo through ditionar 'info'
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // Create thumbnail from full size image 
    [self.item setThumbnailFromImage:image];
    
    // Use itemKey as key, store photo into BNRImageStore object
    [[BNRImageStore sharedStore] setImage:image
                                   forKey:self.item.itemKey];
    
    // Put photo into UIImage object
    self.imageView.image = image;
       
    // Judge UIPopoverController object exists or not
    if (self.imagePickerPopover) {
        // Close UIPopoverController object
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
    } else {
        // Close UIImagePickerController object showned in modal
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Interface orientation
    UIInterfaceOrientation io = [[UIApplication sharedApplication] statusBarOrientation];
    [self prepareViewsForOrientation:io];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNameField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    // Create NSDateFormatter object to convert NSDate into simple date string
    static NSDateFormatter *dateFormater = nil;
    if (!dateFormater) {
        dateFormater = [[NSDateFormatter alloc] init];
        dateFormater.dateStyle = NSDateIntervalFormatterMediumStyle;
        dateFormater.timeStyle = NSDateIntervalFormatterNoStyle;
    }
    
    self.dateLable.text = [dateFormater stringFromDate:item.dateCreated];
    
    NSString *itemKey = self.item.itemKey;
    // Fetch photo according to itemKey
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:itemKey];
    
    self.imageView.image = imageToDisplay;
    
    [self updateFonts];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Cancel the first reacted object
    [self.view endEditing:YES];
    
    // "Save" the edited to BNRItem objects
    BNRItem *item = self.item;
    item.itemName  = self.nameField.text;
    item.serialNumber = self.serialNameField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

//// Auto layout debug
//- (void)viewDidLayoutSubviews
//{
//    for (UIView *subview in self.view.subviews) {
//        if ([subview hasAmbiguousLayout]) {
//            NSLog(@"AMBIGUOUS: %@", subview);
//        }
//    }
//}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}



#pragma mark -Auto layout constraints
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *iv = [[UIImageView alloc] initWithImage:nil];
    
    // Set UIImageView object's scaling mode
    iv.contentMode = UIViewContentModeScaleAspectFit;
    
    // Inform auto layout system not to translate to constraints
    iv.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Add UIImageView to view
    [self.view addSubview:iv];
    
    // Ste UIImageView object's value to imageView
    self.imageView = iv;
    
    // Create NSDictionary
    // Making name-value binding more readable
    NSDictionary *nameMap = @{ @"imageView" : self.imageView,
                               @"dateLable" : self.dateLable,
                               @"toolbar"   : self.toolbar};
    
    // imageView's left and right distance to parent viewis 0
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:nameMap];
    
    // imageView's top distance to dateLable is 8, bottom is 8
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLable]-[imageView]-[toolbar]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:nameMap];
    
    // Add constraints array to BNRDetailViewController's view
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];

}

#pragma mark -View controlling

// You can add animation effect here
- (void)prepareViewsForOrientation:(UIInterfaceOrientation)orientation
{
    // Ignore iPad
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return;
    }
    
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.imageView.hidden = YES;
        self.cameraButton.enabled = NO;
    } else {
        self.imageView.hidden = NO;
        self.cameraButton.enabled = YES;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self prepareViewsForOrientation:toInterfaceOrientation];
}

#pragma mark -Fonts setting

- (void)updateFonts
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    self.nameLabel.font = font;
    self.serialNumberLabel.font = font;
    self.valueLabel.font = font;
    self.dateLable.font = font;
    
    self.nameField.font = font;
    self.serialNumberLabel.font = font;
    self.valueField.font = font;
}


- (void)dealloc
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}


@end
