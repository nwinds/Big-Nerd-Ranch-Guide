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

#pragma mark -Login access token
@synthesize paramAccessToken;
@synthesize subPageData;
@synthesize userLoginController;

#pragma mark -Navigation Item
@synthesize toolBar, logoutButton, loginButton;

#pragma mark -Text View for user info
@synthesize infoField;

#pragma mark -Amazon user profile
@synthesize userProfile;


NSString* userLoggedOutMessage =
            @"Welcome to Login with Amazon!\nIf this is your first time logging in, you will be asked to give permission for this application to access your profile data.";
NSString* userLoggedInMessage =
            @"Welcome, %@ \n Your email is %@.";

BOOL isUserSignedIn;

#pragma mark -View show helper
- (IBAction)onLogInButtonClicked:(id)sender
{
    // Make authorize call to SDK to get authorization from the user. While making the call you can specify the scopes for which the user authorization is needed.
    // Requesting 'profile' scopes for the current user.
    
    NSArray *requestScopes = [NSArray arrayWithObject:@"profile"];
    AMZNAuthorizeUserDelegate* delegate = [[AMZNAuthorizeUserDelegate alloc] initWithParentController:self];
    [AIMobileLib authorizeUserForScopes:requestScopes delegate:delegate];
    
    // dissmiss current view (showing the parent view)
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)logoutButtonClicked:(id)sender
{
    AMZNLogoutDelegate* delegate = [[AMZNLogoutDelegate alloc] initWithParentController:self];
    
    [AIMobileLib clearAuthorizationState:delegate];
}



- (BOOL)shouldAutorotate
{
    return NO;
}


#pragma mark -View lifecycle
//check if user logged in before user loading the view
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkIsUserSignedIn];
}

- (void)viewDidLoad {
    // Amazon login data
    self.subPageData.text = paramAccessToken;
    
    // Display UIObjects
    if (isUserSignedIn)
        [self loadSignedInUser];
    
    else {
        [self showLogInPage];
    }
    
    // iOS version handle
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    if ([detailViewController respondsToSelector:@selector(setEditData:)]) {
//        [page2Data endEditing:YES];
//        [detailViewController setValue:page2Data.text forKey:@"editData"];
//    }
    
    if ([userLoginController respondsToSelector:@selector(setEditAccessToken:)]) {
        [subPageData endEditing:YES];
        [userLoginController setValue:subPageData.text forKey:@"editAccessToken"];
    }
}

#pragma mark -Amazon user login handler
- (void)checkIsUserSignedIn
{
//    NSLog(@"Amazon login: check if user is signed in");
    AMZNGetAccessTokenDelegate* delegate = [[AMZNGetAccessTokenDelegate alloc] initWithParentController:self];
    [AIMobileLib getAccessTokenForScopes:[NSArray arrayWithObject:@"profile"] withOverrideParams:nil delegate:delegate];
    //    NSLog(@"Amazon login: AccessToken in delegate: %@", delegate.description);
}


- (void)loadSignedInUser {
    isUserSignedIn = TRUE;
    self.loginButton.hidden = TRUE;     // hide login button
    self.infoField.text = [NSString stringWithFormat:@"Welcome, %@ \n Your email is %@.", [userProfile objectForKey:@"name"], [userProfile objectForKey:@"email"]];
    self.infoField.hidden = FALSE;
    
    // test code
    self.subPageData.text = [NSString stringWithFormat:@"user: %@", [userProfile objectForKey:@"name"]];
}

- (void)showLogInPage {
    isUserSignedIn = FALSE;
    self.loginButton.hidden = FALSE;    // show login button
    self.logoutButton.hidden = TRUE;    // hide logout button
    
    self.infoField.text = userLoggedOutMessage;
    self.infoField.hidden = FALSE;
}


#pragma mark -Sub view button clicked

- (IBAction)closeView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    self.toolBar = nil;
    self.infoField = nil;
    self.loginButton = nil;
    self.logoutButton = nil;
    self.userProfile = nil;
}

@end
