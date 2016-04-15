//
//  ViewController.m
//  RunTimeThing
//
//  Created by Linzhixiao on 16/4/15.
//  Copyright © 2016年 Linzhixiao. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h> // 包含对类、成员变量、属性、方法的操作
#import <objc/message.h> // 包含消息机制
#import "RunTimeUtility.h"
#import "ResultViewController.h"
#import "Person+addProperty.h"

static NSString * const cellIdentifier = @"cell";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) NSMutableArray *allresultArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"runtime那些事";
    [self dealWithDataSource];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Accessors

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - Private

- (void)dealWithDataSource {
    self.dataSourceArray = @[@"1.获取类成员变量",@"2.获取类全部属性名",@"3.获取类全部方法",@"4.获取类全部协议",@"5.动态改变成员变量的值(name改为张三)",@"6.动态交换类的方法顺序:sing->drink",@"7.动态添加新方法(fromCity:)",@"8.category添加属性"];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _dataSourceArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            self.allresultArray = [RunTimeUtility getClassAllMemberProperty];
        }
            break;
        case 1:
        {
            self.allresultArray = [RunTimeUtility getClassAllPropertyName];
        }
            break;
        case 2:
        {
            self.allresultArray = [RunTimeUtility getClassAllMethod];
        }
            break;
        case 3:
        {
            self.allresultArray = [RunTimeUtility getClassAllProtocolWithClass:[self class]];
        }
            break;
        case 4:
        {
            Person *person = [[Person alloc] init];
            person.name = @"李四";
            RunTimeUtility *runTimeUtility = [[RunTimeUtility alloc] init];
            [runTimeUtility changeClassPropertyValueWithPersonObject:person];
            self.allresultArray= [NSMutableArray arrayWithObjects:person.name, nil];
        }
            break;
        case 5:
        {
            [RunTimeUtility exchangeClassMethod];
            Person *person = [[Person alloc] init];
            self.allresultArray= [NSMutableArray arrayWithObjects:[person sing],[person drink], nil];
        }
            break;
        case 6:
        {
            NSString *methodValue = [RunTimeUtility addAndDoFromCityMethodWithPersonObject:[[Person alloc] init]];
            self.allresultArray= [NSMutableArray arrayWithObjects:methodValue, nil];
        }
            break;
        case 7:
        {
            Person*person = [[Person alloc] init];
            person.englishName = @"Xiao Wang";
            self.allresultArray= [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"englishName: %@",person.englishName], nil];
        }
            break;
        default:
            break;
    }
    ResultViewController *resultViewController = [[ResultViewController alloc] init];
    resultViewController.resultDataSourceArray = self.allresultArray;
    resultViewController.title = _dataSourceArray[indexPath.row];
    [self.navigationController pushViewController:resultViewController animated:YES];
}

@end
