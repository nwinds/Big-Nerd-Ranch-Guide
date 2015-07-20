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

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNameField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end




@implementation BNRDetailViewController

- (IBAction)takePicture:(id)sender
{
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
    [self presentViewController:imagePicker animated: YES completion:nil];
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
    
    // Use itemKey as key, store photo into BNRImageStore object
    [[BNRImageStore sharedStore] setImage:image
                                   forKey:self.item.itemKey];
    
    // Put photo into UIImage object
    self.imageView.image = image;
    
    // Close UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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


@end
