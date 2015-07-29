//
//  IndexViewController.m
//  LegoodsDemo
//
//  Created by jyl on 15/7/24.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "IndexViewController.h"

#import "ContextMenuCell.h"
#import "YALContextMenuTableView.h"
#import "YALNavigationBar.h"

static NSString *const menuCellIdentifier = @"rotationCell";

@interface IndexViewController () <UITabBarDelegate, UITableViewDataSource, YALContextMenuTableViewDelegate>

#pragma mark -UIWebView
@property (retain, nonatomic) IBOutlet UIWebView *webView;


#pragma mark -YALContextMenu
@property (strong, nonatomic) YALContextMenuTableView *contextMenuTableView;
@property (strong, nonatomic) NSArray *menuTitles;
@property (strong, nonatomic) NSArray *menuIcons;

@end

@implementation IndexViewController

#pragma mark -View Lifecycle
// See https://github.com/Yalantis/Context-Menu.iOS for more information

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize menu
//    [self initiateMenuOptions];
//    // Set custom nabigation bar with a bigger height
//    [self.navigationController setValue:[[YALNavigationBar alloc] init] forKeyPath:@"navigationBar"];
//
    NSURL *url = [NSURL URLWithString:@"http://www.legoods.com/mindex"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    

    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.contextMenuTableView reloadData];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.contextMenuTableView updateAlongsideRotation];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext>context){
        //should be called after rotation animation completed
        [self.contextMenuTableView reloadData];
    }];
    
    [self.contextMenuTableView updateAlongsideRotation];
}


#pragma mark -IBAction
- (IBAction)presentMenuButtonTapped:(UIBarButtonItem *)sender
{
    // Init YALContextMenuTableView tableView
    if (!self.contextMenuTableView) {
        self.contextMenuTableView = [[YALContextMenuTableView alloc] initWithTableViewDelegateDataSource:self];
        
        self.contextMenuTableView.animationDuration = 0.15;
        
        // Optional - implement custom YALContextMenuTableView custom protocol
        self.contextMenuTableView.yalDelegate = self;
        
        // Regist nib
        UINib *cellNib = [UINib nibWithNibName:@"ContextMenuCell" bundle:nil];
        [self.contextMenuTableView registerNib:cellNib forCellReuseIdentifier:menuCellIdentifier];
    }
    
    // It is better to use this method only for proper animation
    [self.contextMenuTableView showInView:self.navigationController.view withEdgeInsets:UIEdgeInsetsZero animated:YES];
}



#pragma mark -local methods
- (void)initiateMenuOptions
{
    self.menuTitles = @[@"",
                        @"Send message",
                        @"Like profile",
                        @"Add to friends",
                        @"Add to favourites",
                        @"Block user"];
    
    self.menuIcons = @[[UIImage imageNamed:@"Icnclose"],
                       [UIImage imageNamed:@"SendMessageIcn"],
                       [UIImage imageNamed:@"LikeIcn"],
                       [UIImage imageNamed:@"AddToFriendsIcn"],
                       [UIImage imageNamed:@"AddToFavouritesIcn"],
                       [UIImage imageNamed:@"BlockUserIcn"]];
}


#pragma mark -YALContextMenuTableViewDelegate
- (void)contextMenuTableView:(YALContextMenuTableView *)contextMenuTableView didDismissWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Menu dismissed with indexpath = %@", indexPath);
}

#pragma mark -UITableViewDataSource, UITableViewDelegate
- (void)tableView:(YALContextMenuTableView *)tableView
        didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView dismisWithIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView
        heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContextMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
    
    if (cell) {
        cell.backgroundColor = [UIColor clearColor];
        cell.menuTitleLabel.text = [self.menuTitles objectAtIndex:indexPath.row];
        cell.menuImageView.image = [self.menuIcons objectAtIndex:indexPath.row];
    }
    
    return cell;
}
@end
