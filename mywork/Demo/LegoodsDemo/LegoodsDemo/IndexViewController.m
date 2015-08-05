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

#import "WXGMenuViewController.h"
#import "WXGDetailViewController.h"
#import "WXGMenuItem.h"

#import "AMZNLoginController.h"

static NSString *const menuCellIdentifier = @"rotationCell";

@interface IndexViewController () <UITabBarDelegate, UITableViewDataSource, YALContextMenuTableViewDelegate>



#pragma mark -YALContextMenu
@property (strong, nonatomic) YALContextMenuTableView *contextMenuTableView;
@property (strong, nonatomic) NSArray *menuTitles;
@property (strong, nonatomic) NSArray *menuIcons;

#pragma mark -WXGSlideMenu
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *menuContainerView;
@property (nonatomic, weak) WXGMenuViewController *menuViewController;
@property (nonatomic, weak) WXGDetailViewController *detailViewController;
@property (nonatomic, getter=isShowMenu) BOOL showMenu;

@end

@implementation IndexViewController

#pragma mark -View Lifecycle
// See https://github.com/Yalantis/Context-Menu.iOS for more information

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize menu
    [self initiateMenuOptions];
    // Set custom nabigation bar with a bigger height
    [self.navigationController setValue:[[YALNavigationBar alloc] init] forKeyPath:@"navigationBar"];

//    NSURL *url = [NSURL URLWithString:@"http://www.legoods.com/mindex"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
//    
 
    // 注册菜单视图的点击事件
    self.menuViewController.menuDidClick = ^(WXGMenuItem *item, BOOL animated) {
        self.detailViewController.item = item;
        [self showOrHideMenu:NO animated:animated];
    };
    
    // 注册顶部按钮的点击事件
    self.detailViewController.leftBarButtonDidClick = ^() {
        [self showOrHideMenu:!self.isShowMenu animated:YES];
    };

}
//
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

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

#pragma mark - Slide menu
//@interface WXGContainerViewController () <UIScrollViewDelegate>


static const CGFloat kMenuWidth = 80;

// 控制菜单视图显示与隐藏
- (void)showOrHideMenu:(BOOL)showOrHide animated:(BOOL)animated {
    [self.scrollView setContentOffset:showOrHide ? CGPointZero : CGPointMake(kMenuWidth, 0) animated:animated];
}

// 监听视图滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 解决菜单隐藏后点击detailView会自动显示菜单的bug，bug原因与pagingEnabled有关，还没太弄清楚，感兴趣的同学可自行查看
    // http://stackoverflow.com/questions/4480512/uiscrollview-single-tap-scrolls-it-to-top
    scrollView.pagingEnabled = scrollView.contentOffset.x < kMenuWidth;
    
    // 控制菜单显示与否的状态
    self.showMenu = scrollView.contentOffset.x < kMenuWidth;
    
    CGFloat scale = scrollView.contentOffset.x / kMenuWidth;
    
    // 菜单视图的翻页效果
    self.menuViewController.view.layer.transform = [self transformWithScale:scale];
    self.menuViewController.view.alpha = 1 - scale;
    
    // 顶部按钮的滚动效果
    [self.detailViewController rotateLeftBarButtonWithScale:scale];
}

// 菜单视图的翻页效果
- (CATransform3D)transformWithScale:(CGFloat)scale {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 1000.0;
    CGFloat angle = -M_PI_2 * scale;
    CATransform3D rotation = CATransform3DRotate(transform, angle, 0, 1, 0);
    return rotation;
}

// 获取两个子控制器
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MenuViewControllerSegue"]) {
        self.menuViewController = (WXGMenuViewController *)[segue.destinationViewController topViewController];
    }
    else if ([segue.identifier isEqualToString:@"DetailViewControllerSegue"]) {
        self.detailViewController = (WXGDetailViewController *)[segue.destinationViewController topViewController];
    }
//    else if ([[segue identifier] isEqualToString:@"MainToCheck"]){
//        AMZNLoginController *amazonVC = [segue destinationViewController];
//        amazonVC.showArray = [[NSArray alloc] initWithArray:_currentAction];
//        
//        amazonVC.delegate = self;
//    }
}

// 更改状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


#pragma mark -Navigation Item login subview

// backButton
- (IBAction)unwindSegue:(UIStoryboardSegue *)sender
{
    NSLog(@"unwindSegue: backButton pressed down");
}
//#pragma mark -Data delegate handle
//- (void)IndexDataViewController:(AMZNLoginController *)controller didFinishLoadData:(NSMutableArray *)loadedArray
//{
//    self.currentArray = loadedArray;
//}
@end
