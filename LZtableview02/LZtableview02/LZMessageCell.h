//
//  LZMessageCell.h
//  LZtableview02
//
//  Created by comst on 15/9/23.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZMessage.h"

@class LZMessageCell;

@protocol MessageCellDelegate <NSObject>

- (void)messagecell:(LZMessageCell *)cell didClickUserIcon:(LZUserAccount*)useraccount;

@end


@interface LZMessageCell : UITableViewCell

@property (nonatomic, strong) LZMessage *msg;

@property (nonatomic, weak) id<MessageCellDelegate>  Msgdelegate;

+ (instancetype)messageCellWithTableview:(UITableView *)tableview;

@end
