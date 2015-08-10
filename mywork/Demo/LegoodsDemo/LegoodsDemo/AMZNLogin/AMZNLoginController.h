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


@interface AMZNLoginController : UIViewController

#pragma mark -Login access token
@property (strong, nonatomic) NSString *paramAccessToken;
@property (strong, nonatomic) IBOutlet UITextField *subPageData;
- (IBAction)closeAndReturn:(id)sender;

@property (strong, nonatomic) id userLoginController;


- (IBAction)checkIfLogged:(id)sender;

#pragma mark -Navigation Item
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextView *infoField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *logoutButton; // leftBarButton of Nav Item

@property (strong, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;

#pragma mark -Amazon user profile
@property (strong) NSDictionary* userProfile;


#pragma mark -View show helper
- (void)showLogInPage;
- (void)loadSignedInUser;
- (void)checkIsUserSignedIn;

@end