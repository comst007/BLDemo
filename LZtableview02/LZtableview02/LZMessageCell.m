//
//  LZMessageCell.m
//  LZtableview02
//
//  Created by comst on 15/9/23.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMessageCell.h"

@interface LZMessageCell ()<UIAlertViewDelegate>
@property (nonatomic, strong) UIImageView *iconview;
@property (nonatomic, strong) UIButton *imgbutton;
@property (nonatomic, strong) UILabel *namelabel;
@property (nonatomic, strong) UILabel *textlabel;
@property (nonatomic, strong) UILabel *datelabel;


@end


@implementation LZMessageCell

+ (instancetype)messageCellWithTableview:(UITableView *)tableview{
    LZMessageCell *cell;
    
    cell = [tableview dequeueReusableCellWithIdentifier:@"LZCell"];
    
    if (cell == nil) {
        cell = [[LZMessageCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *iconview = [[UIImageView alloc] init];
        iconview.userInteractionEnabled = YES;
        
        UIButton *imgbutton = [[UIButton alloc] init];
        [imgbutton addTarget:cell action:@selector(btnclick:) forControlEvents:UIControlEventTouchDown];
        
        UILabel *namelabel = [[UILabel alloc] init];
        namelabel.textColor = [UIColor blueColor];
        UILabel *textlabel = [[UILabel alloc] init];
        textlabel.font = [UIFont systemFontOfSize:17];
        textlabel.numberOfLines = 0;
        
        UILabel *datelabel = [[UILabel alloc] init];
        
        datelabel.textColor = [UIColor colorWithRed:0.6 green:0.7 blue:0.9 alpha:1];
        
        [cell.contentView addSubview:imgbutton];
        [cell.contentView addSubview:namelabel];
        [cell.contentView addSubview:textlabel];
        [cell.contentView addSubview:datelabel];
        
        cell.namelabel = namelabel;
        //cell.iconview = iconview;
        cell.textlabel = textlabel;
        cell.datelabel = datelabel;
        
        cell.imgbutton = imgbutton;
        
        
        
    }
    
    return cell;
}

- (void)setMsg:(LZMessage *)msg{
    _msg = msg;
    self.namelabel.text = msg.user.name;
    [self.imgbutton setImage:[[UIImage alloc] initWithContentsOfFile:msg.user.iconPath] forState:UIControlStateNormal];
    
    self.textlabel.text = msg.text;
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    self.datelabel.text = [formater stringFromDate:msg.date] ;
    
    [self subviewsFrame:msg];
    
}

- (void)subviewsFrame:(LZMessage *)msg{
    
    CGFloat leftMargin = 10;
    CGFloat topMargin = 10;
    
    // icon frame
    CGFloat iconW = 50;
    CGFloat iconH = 50;
    CGRect iconFrame = CGRectMake(leftMargin, topMargin, iconW, iconH);
    self.imgbutton.frame = iconFrame;
    
    //name frame
    CGFloat nameX = CGRectGetMaxX(iconFrame) + 5;
    CGFloat nameY = topMargin;
    CGFloat nameH = 20;
    CGFloat nameW = 150;
    CGRect nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    self.namelabel.frame = nameFrame;
    //text frame
    
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(nameFrame) + 10;
    CGSize textsize = [msg.text boundingRectWithSize:CGSizeMake(self.msg.viewwidth - 50 - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    CGRect textFrame = CGRectMake(textX, textY, textsize.width, textsize.height);
    
    self.textlabel.frame = textFrame;
    
    // date
    CGFloat dateH = 30;
    CGFloat dateW = 200;
    CGFloat dateX = CGRectGetMaxX(textFrame) - dateW;
    
    CGFloat dateY = CGRectGetMaxY(textFrame) + 10;
    
    CGRect dateFrame = CGRectMake(dateX, dateY, dateW, dateH);
    
    self.datelabel.frame = dateFrame;
    
}

- (void)btnclick:(UIButton *)btn{
    
    if (self.Msgdelegate && [self.Msgdelegate respondsToSelector:@selector(messagecell:didClickUserIcon:)]) {
        [self.Msgdelegate messagecell:self didClickUserIcon:self.msg.user];
    }
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"btn click" message:self.msg.user.lifephotoPath delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    
//    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}
@end
