//
//  ViewController.m
//  LZtableview02
//
//  Created by comst on 15/9/23.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZMessageCell.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(editBtnClick:)];
    
    self.navigationItem.rightBarButtonItem = rightitem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[LZMessage arrayOfMessage] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LZMessageCell *cell = [LZMessageCell messageCellWithTableview:tableView];
    
    LZMessage *msg = [[LZMessage arrayOfMessage] objectAtIndex:indexPath.row];
    
    cell.msg = msg;
    
    return cell;
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LZMessage *msg = [[LZMessage arrayOfMessage] objectAtIndex:indexPath.row];
    
   
    
    return msg.height;
}


#pragma mark -  btnclick

- (void)editBtnClick:(UIBarButtonItem *)buttonitem{
    self.tableView.editing = !self.tableView.editing;
    
    if (self.tableView.editing) {
        buttonitem.title = @"done";
    }else{
        buttonitem.title = @"edit";
    }
}
@end
