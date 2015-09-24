//
//  ViewController.m
//  LZtableview02
//
//  Created by comst on 15/9/23.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZMessageCell.h"
#import "LZDetailViewController.h"
@interface ViewController ()<UIAlertViewDelegate, MessageCellDelegate>

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
    cell.Msgdelegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleInsert){
        [LZMessage addNewMessage];
        NSIndexPath *newindexpath = [NSIndexPath indexPathForRow:[[LZMessage arrayOfMessage] count] - 1 inSection: indexPath.section];
        
        [self.tableView insertRowsAtIndexPaths:@[newindexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView scrollToRowAtIndexPath:newindexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LZMessage *msg = [[LZMessage arrayOfMessage] objectAtIndex:indexPath.row];
    
    msg.viewwidth = tableView.bounds.size.width;
    
    return msg.height;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 == 0) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleInsert;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakself = self;
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"comst" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"!!!!!!!" message:@"++++++++" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
        [[LZMessage arrayOfMessage]  removeObjectAtIndex:indexPath.row];
        [weakself.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    action1.backgroundColor = [UIColor purpleColor];
    return @[action1];
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

#pragma mark = alertview delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%s", __func__);
}

#pragma mark - cell delegate

- (void)messagecell:(LZMessageCell *)cell didClickUserIcon:(LZUserAccount *)useraccount{
    LZDetailViewController *dvc = [[LZDetailViewController alloc] init];
    dvc.useraccount = useraccount;
    
    [self.navigationController pushViewController:dvc animated:YES];
}
@end
