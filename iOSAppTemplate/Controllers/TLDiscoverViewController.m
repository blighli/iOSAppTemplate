//
//  TLDiscoverViewController.m
//  iOSAppTemplate
//
//  Created by h1r0 on 15/9/17.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "TLDiscoverViewController.h"
#import "TLFounctionCell.h"

@interface TLDiscoverViewController ()

@end

@implementation TLDiscoverViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self setHidesBottomBarWhenPushed:NO];
    [self.navigationItem setTitle:@"发现"];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[TLFounctionCell class] forCellReuseIdentifier:@"FunctionCell"];
    
    [self initTestData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
}

#pragma mark - UITableView

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLFounctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FunctionCell" forIndexPath:indexPath];
    NSDictionary *dic = [_data objectAtIndex:indexPath.row];
    
    if ([dic objectForKey:@"empty"] != nil) {
        [cell setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
        [cell setUserInteractionEnabled:NO];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setBottomLineStyle:CellLineStyleNone];
        [cell setTopLineStyle:CellLineStyleNone];
    }
    else {
        [cell setImageName:[dic objectForKey:@"image"]];
        [cell setTitle:[dic objectForKey:@"title"]];
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell setUserInteractionEnabled:YES];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        if (indexPath.row > 0) {
            NSDictionary *preDic = [_data objectAtIndex:indexPath.row - 1];
            if ([preDic objectForKey:@"empty"] != nil) {
                [cell setTopLineStyle:CellLineStyleFill];
            }
            else {
                [cell setTopLineStyle:CellLineStyleNone];
            }
        }
        if (indexPath.row == _data.count - 1) {
            [cell setBottomLineStyle:CellLineStyleFill];
        }
        else {
            NSDictionary *nextDic = [_data objectAtIndex:indexPath.row + 1];
            if ([nextDic objectForKey:@"empty"] != nil) {
                [cell setBottomLineStyle:CellLineStyleFill];
            }
            else {
                [cell setBottomLineStyle:CellLineStyleDefault];
            }
        }
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_data objectAtIndex:indexPath.row];;
    if (indexPath.row == 0) {
        return 15.0f;
    }
    if ([dic objectForKey:@"empty"] != nil) {
        return 20.0f;
    }
    else {
        return 45.0f;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - 初始化
- (void) initTestData
{
    NSDictionary *dic = @{@"title" : @"朋友圈",
                          @"image" : @"ff_IconShowAlbum"};
    NSDictionary *dic1 = @{@"title" : @"扫一扫",
                          @"image" : @"ff_IconQRCode"};
    NSDictionary *dic2 = @{@"title" : @"摇一摇",
                           @"image" : @"ff_IconShake"};
    NSDictionary *dic3 = @{@"title" : @"附近的人",
                           @"image" : @"ff_IconLocationService"};
    NSDictionary *dic4 = @{@"title" : @"漂流瓶",
                           @"image" : @"ff_IconBottle"};
    NSDictionary *dic5 = @{@"title" : @"购物",
                          @"image" : @"CreditCard_ShoppingBag"};
    NSDictionary *dic6 = @{@"title" : @"游戏",
                           @"image" : @"MoreGame"};
    NSDictionary *empty = @{@"empty" : @"YES"};
    
    _data = [[NSMutableArray alloc] initWithObjects:empty, dic, empty, dic1, dic2, empty, dic3, dic4, empty, dic5, dic6, nil];
    
    [self.tableView reloadData];
}

@end