//
//  WXGMenuViewController.m
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "HomeMenuViewController.h"
#import "WXGMenuCell.h"
#import "WXGMenuItem.h"

@interface HomeMenuViewController ()

@property (nonatomic, copy) NSArray *menuItems;

@end

@implementation HomeMenuViewController

- (NSArray *)menuItems {
    if (!_menuItems) {
        NSArray *dicts = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuItems" ofType:@"plist"]];
        NSMutableArray *array = @[].mutableCopy;
        for (NSDictionary *dict in dicts) {
            WXGMenuItem *item = [WXGMenuItem itemWithDict:dict];
            [array addObject:item];
        }
        _menuItems = array.copy;
    }
    return _menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去掉导航条下面的阴影效果的那条线
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    // 加载后默认点击第一行，让detailView显示第一行的内容
    self.menuDidClick(self.menuItems[0], NO);
    
    // 为菜单的旋转设置锚点
    self.view.layer.anchorPoint = CGPointMake(1, 0.5);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WXGMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WXGMenuCell class]) forIndexPath:indexPath];
    cell.item = self.menuItems[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MAX(80, CGRectGetHeight(self.tableView.bounds) / self.menuItems.count);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.menuDidClick) {
        self.menuDidClick(self.menuItems[indexPath.row], YES);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
