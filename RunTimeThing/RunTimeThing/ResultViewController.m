//
//  ResultViewController.m
//  RunTimeThing
//
//  Created by Linzhixiao on 16/4/15.
//  Copyright © 2016年 Linzhixiao. All rights reserved.
//

#import "ResultViewController.h"

NSString * const cellIdentifier = @"cell";

@interface ResultViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *resultListTableView;


@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigationBackBarButtonItem];
    [self.view addSubview:self.resultListTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Accessors

- (UITableView *)resultListTableView {
    if (!_resultListTableView) {
        _resultListTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _resultListTableView.dataSource = self;
        _resultListTableView.delegate = self;
    }
    return _resultListTableView;
}

#pragma mark - Navigation

- (void)configNavigationBackBarButtonItem {
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
}

- (void)backBarButtonItemAction: (UIBarButtonItem *)backBarButtonItem {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultDataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _resultDataSourceArray[indexPath.row];
    return cell;
}

@end
