//
//  LZMessage.h
//  LZtableview02
//
//  Created by comst on 15/9/23.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LZUserAccount.h"
@interface LZMessage : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) LZUserAccount *user;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat viewwidth;

+ (LZMessage *)messageWithSender:(LZUserAccount *)aSender text:(NSString *)aText sendDate:(NSDate *)aDate;

+ (NSMutableArray *)arrayOfMessage;

+ (void)addNewMessage;

- (void)caculateHeight:(CGFloat)viewWidth;
@end
