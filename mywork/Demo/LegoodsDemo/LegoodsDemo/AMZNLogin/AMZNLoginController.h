/**
 * Copyright 2012-2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy
 * of the License is located at
 *
 * http://aws.amazon.com/apache2.0/
 *
 * or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class AMZNLoginController;

//@protocol AMZNLoginDelegate <NSObject>
//
//- (void)IndexDataViewController:(AMZNLoginController *)controller didFinishLoadData:(NSMutableArray *)loadedArray;
//
//@end

@interface AMZNLoginController : UIViewController
#pragma mark -Data trans
@property (strong, nonatomic) NSString *param;

@property (strong, nonatomic) id detailViewController;
- (IBAction)closeButton:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *page2Data;

#pragma mark -Login access token
@property (strong, nonatomic) NSString *paramAccessToken;
@property (strong, nonatomic) IBOutlet UITextField *subPageData;
- (IBAction)closeAndReturn:(id)sender;


#pragma mark -Navigation Item
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextView *infoField; // alie: page2Data

@property (strong, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationItem;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
#pragma mark -Amazon user profile
@property (strong) NSDictionary* userProfile;


//#pragma mark -Data transformation
//@property (strong, nonatomic) NSArray *showArray;

- (void)showLogInPage;

- (void)loadSignedInUser;

- (void)checkIsUserSignedIn;

//#pragma mark -Data delegate
//@property (nonatomic, weak) id <AMZNLoginDelegate> delegate;

@end