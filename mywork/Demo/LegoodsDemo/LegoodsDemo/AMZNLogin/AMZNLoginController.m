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

#import <LoginWithAmazon/LoginWithAmazon.h>

#import "AMZNLoginController.h"
#import "AMZNGetAccessTokenDelegate.h"
#import "AMZNGetProfileDelegate.h"
#import "AMZNAuthorizeUserDelegate.h"
#import "AMZNLogoutDelegate.h"

@implementation AMZNLoginController
#pragma mark -Data trans
@synthesize param;
@synthesize page2Data;

@synthesize detailViewController;


#pragma mark -Navigation Item
@synthesize infoField; // page2Data

@synthesize userProfile, navigationItem, logoutButton, loginButton;

NSString* userLoggedOutMessage = @"Welcome to Login with Amazon!\nIf this is your first time logging in, you will be asked to give permission for this application to access your profile data.";
NSString* userLoggedInMessage = @"Welcome, %@ \n Your email is %@.";
BOOL isUserSignedIn;

- (IBAction)onLogInButtonClicked:(id)sender
{
    // Make authorize call to SDK to get authorization from the user. While making the call you can specify the scopes for which the user authorization is needed.
    
    // Requesting 'profile' scopes for the current user.
    
    // research test
    NSLog(@"Amazon login: login button clicked");
    
    NSArray *requestScopes = [NSArray arrayWithObjects:@"profile", @"postal_code", nil];
    
    AMZNAuthorizeUserDelegate* delegate = [[AMZNAuthorizeUserDelegate alloc] initWithParentController:self];
    
    // Allows the user to login and, if necessary, authorize the app for the requested scopes.
    [AIMobileLib authorizeUserForScopes:requestScopes delegate:delegate];
    NSLog(@"Amazon login: user login authorized");
}

- (IBAction)logoutButtonClicked:(id)sender
{
    // For tracing
    NSLog(@"Amazon logged checking...");
    [self checkIsUserSignedIn];
    NSLog(@"Amazon logged check success");
    
    AMZNLogoutDelegate* delegate = [[AMZNLogoutDelegate alloc] initWithParentController:self];
    
    [AIMobileLib clearAuthorizationState:delegate];
}



- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark View controller specific functions
- (void)checkIsUserSignedIn
{
    NSLog(@"Amazon login: check if user is login");
    AMZNGetAccessTokenDelegate* delegate = [[AMZNGetAccessTokenDelegate alloc] initWithParentController:self];
    
    NSArray *requestScopes = [NSArray arrayWithObjects:@"profile", @"postal_code", nil];
    [AIMobileLib getAccessTokenForScopes:requestScopes withOverrideParams:nil delegate:delegate];
    NSLog(@"Amazon login: AccessToken in delegate: %@", delegate.description);
}

//- (void)setWebView:
//{

//}

- (void)loadSignedInUser {
    isUserSignedIn = true;
    self.loginButton.hidden = true;
    self.navigationItem.rightBarButtonItem = self.logoutButton;
    self.infoField.text = [NSString stringWithFormat:@"Welcome, %@ \n Your email is %@.", [userProfile objectForKey:@"name"], [userProfile objectForKey:@"email"]];
    self.infoField.hidden = false;
}

- (void)showLogInPage {
    isUserSignedIn = false;
    self.loginButton.hidden = false;
    self.navigationItem.rightBarButtonItem = nil;
    self.infoField.text = userLoggedOutMessage;
//    self.param = userLoggedOutMessage;
    self.infoField.hidden = false;
}

- (void)viewDidLoad {
    self.navigationItem.leftBarButtonItem = self.backButton;
    
    // test for data trans
    self.page2Data.text = param;
    
    if (isUserSignedIn)
        [self loadSignedInUser];
    
    else {
        [self showLogInPage];
    }
    float systemVersion=[[[UIDevice currentDevice] systemVersion] floatValue];
    if(systemVersion>=7.0f)
    {
        CGRect tempRect;
        for(UIView *sub in [[self view] subviews])
        {
            tempRect = [sub frame];
            tempRect.origin.y += 20.0f; //Height of status bar
            [sub setFrame:tempRect];
        }
    }
}

#pragma mark -Data trans
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([detailViewController respondsToSelector:@selector(setEditData:)]) {
        [page2Data endEditing:YES];
        [detailViewController setValue:page2Data.text forKey:@"editData"];
    }
}

- (IBAction)closeButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
