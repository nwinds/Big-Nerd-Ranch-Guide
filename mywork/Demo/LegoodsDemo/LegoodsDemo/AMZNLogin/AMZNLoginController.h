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



// @class AMZNLoginController;


@interface AMZNLoginController : UIViewController

#pragma mark -Demo for test
@property (retain, nonatomic) NSString *param;
@property (retain, nonatomic) id firstViewController;


#pragma mark -Login access token
@property (retain, nonatomic) NSString *paramAccessToken;// var
@property (retain, nonatomic) IBOutlet UITextField *subPageData;// page2Data
@property (retain, nonatomic) id parentViewController;

- (IBAction)closeView:(id)sender;


#pragma mark -Navigation Item
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (retain, nonatomic) IBOutlet UITextView *infoField;
@property (retain, nonatomic) IBOutlet UIButton *logoutButton; // leftBarButton of Nav Item
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;


#pragma mark -Amazon user profile
@property (retain) NSDictionary* userProfile;


#pragma mark -UIView show helper
- (void)showLogInPage;

- (void)loadSignedInUser;

- (void)checkIsUserSignedIn;

@end