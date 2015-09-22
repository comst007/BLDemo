//
//  ViewController.m
//  LZTableView01
//
//  Created by comst on 15/9/22.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self tableview];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LZCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableview{
    
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = [UIColor colorWithRed:0.4 green:0.6 blue:0.8 alpha:1];
        _tableview.rowHeight = 50;
        UIView *headerview  = [[UIView alloc] init];
        headerview.backgroundColor = [UIColor redColor];
        headerview.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
        _tableview.tableHeaderView = headerview;
        
        UIView *footerview = [[UIView alloc] init];
        footerview.backgroundColor = [UIColor purpleColor];
        footerview.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
        _tableview.tableFooterView = footerview;
        
        [self.view addSubview:_tableview];
    }
    return _tableview;
}


# pragma mark - tableview datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCell"];
    cell.backgroundColor = [UIColor clearColor];
    NSString *text = [NSString stringWithFormat:@"name ---%li, class --------%li", indexPath.section, indexPath.row];
    cell.textLabel.text = text;
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"footer:  section - %li", section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"header:  section - %li", section];
}
#pragma mark - tableview delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view ;
    view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0.5 green:0.7 blue:0.1 alpha:1];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view ;
    
    view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor colorWithRed:0.9 green:0.5 blue:0.9 alpha:1];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello World" message:[NSString stringWithFormat:@"section-%li, row-%li", indexPath.section, indexPath.row] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}
@end
