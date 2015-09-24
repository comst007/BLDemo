//
//  LZMessage.m
//  LZtableview02
//
//  Created by comst on 15/9/23.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMessage.h"

@implementation LZMessage

+ (LZMessage *)messageWithSender:(LZUserAccount *)aSender text:(NSString *)aText sendDate:(NSDate *)aDate{
    LZMessage *msg;
    
    msg = [[LZMessage alloc] init];
    msg.user = aSender;
    msg.text = aText;
    msg.date = aDate;
    
    [msg caculateHeight];
    
    return msg;
}

- (void)caculateHeight{
    CGFloat leftMargin = 10;
    CGFloat topMargin = 10;
    
    // icon frame
    CGFloat iconW = 50;
    CGFloat iconH = 50;
    CGRect iconFrame = CGRectMake(leftMargin, topMargin, iconW, iconH);
    
    //name frame
    CGFloat nameX = CGRectGetMaxX(iconFrame) + 5;
    CGFloat nameY = topMargin;
    CGFloat nameH = 20;
    CGFloat nameW = 150;
    CGRect nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    //text frame
    
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(nameFrame) + 10;
    CGSize textsize = [self.text boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    CGRect textFrame = CGRectMake(textX, textY, textsize.width, textsize.height);
    
    // date
    CGFloat dateH = 30;
    CGFloat dateW = 200;
    CGFloat dateX = CGRectGetMaxX(textFrame) - dateW;
    
    CGFloat dateY = CGRectGetMaxY(textFrame) + 10;
    
    CGRect dateFrame = CGRectMake(dateX, dateY, dateW, dateH);
    
    
    self.height = CGRectGetMaxY(dateFrame) + 5;

}

+ (NSMutableArray *)arrayOfMessage{
    
   static NSMutableArray *_messageArray = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _messageArray = [[NSMutableArray alloc] init];
        [_messageArray addObject:[LZMessage messageWithSender:[LZUserAccount userWithName:@"Steve Jobs"
                                                                            headImagePath:[[NSBundle mainBundle]
                                                                                           pathForResource:@"headImage1"
                                                                                           ofType:@"png"]
                                                                            lifePhotoPath:[[NSBundle mainBundle]
                                                                                           pathForResource:@"jobs"
                                                                                           ofType:@"png"]]
                                                         text:@"乔布斯是改变世界的天才，他凭敏锐的触觉和过人的智慧，勇于变革，不断创新，引领全球资讯科技和电子产品的潮流，把电脑和电子产品变得简约化、平民化，让曾经是昂贵稀罕的电子产品变为现代人生活的一部分。"
                                                     sendDate:[NSDate date]]];
        
        [_messageArray addObject:[LZMessage messageWithSender:[LZUserAccount userWithName:@"李小龙"
                                                                            headImagePath:[[NSBundle mainBundle]
                                                                                           pathForResource:@"headImage2"
                                                                                           ofType:@"png"]
                                                                            lifePhotoPath:[[NSBundle mainBundle]
                                                                                           pathForResource:@"li"
                                                                                           ofType:@"png"]]
                                                         text:@"李小龙，原名李振藩，乳名细凤，为美籍华人，祖籍中国广东省佛山市顺德区均安镇，身高173厘米，体重64公斤。他是一位武术技击家、武术哲学家、全球范围内具有影响力的著名华人武打电影演员、世界武道改革先驱者，UFC起源者，MMA之父，截拳道武道哲学的创立人。"
                                                     sendDate:[NSDate date]]];
        
        [_messageArray addObject:[LZMessage messageWithSender:[LZUserAccount userWithName:@"成龙"
                                                                            headImagePath:[[NSBundle mainBundle]
                                                                                           pathForResource:@"headImage3"
                                                                                           ofType:@"png"]
                                                                            lifePhotoPath:[[NSBundle mainBundle]
                                                                                           pathForResource:@"cheng"
                                                                                           ofType:@"png"]]
                                                         text:@"成龙，1954年4月7日生于香港太平山，国家一级演员，大中华区影坛巨星和国际功夫电影巨星，在华人世界享有极高声望与影响。他与周星驰、周润发并称“双周一成”，意为香港电影的票房保证。成龙以功夫片著称，曾经多次打破香港电影票房纪录，目前其主演的电影全球总票房已经超过100亿元，为华人演员之首。成龙的成名作是功夫喜剧《醉拳》，1994年由他主演的《红番区》在美国公映后反响强烈，使其成功打入美国好莱坞，而接下的《尖峰时刻》系列电影亦获得极高的票房，并奠定其国际电影巨星的地位。"
                                                     sendDate:[NSDate date]]];
        
        
        [_messageArray addObject:[LZMessage messageWithSender:[LZUserAccount userWithName:@"赵本山"
                                                                            headImagePath:[[NSBundle mainBundle]
                                                                                           pathForResource:@"headImage4"
                                                                                           ofType:@"png"]
                                                                            lifePhotoPath:[[NSBundle mainBundle]
                                                                                           pathForResource:@"zhao"
                                                                                           
                                                                                           ofType:@"png"]]
                                                         text:@"赵本山，男，生于1957年10月2日，籍贯是辽宁省铁岭市开原县莲花乡莲花村石嘴沟。著名表演艺术家、国家一级演员、“德艺双馨”艺术家、国家级非物质文化遗产项目代表性传承人。全国青联委员、全国总工会代表、中国曲艺家协会理事、辽宁省曲艺家协会副主席、第十届全国人大代表、辽宁省政协委员、辽宁大学本山艺术学院院长、本山传媒集团董事长。赵本山在央视春晚上享有极高声望，深受人民喜爱，连续10余年蝉联春晚“小品王”。创立本山传媒集团，演出、影视制作、电视栏目和艺术教育等方面大有作为，佳作频出，均创下骄人业绩，广受好评。"
                                                     sendDate:[NSDate date]]];
        
        
        [_messageArray addObject:[LZMessage messageWithSender:[LZUserAccount userWithName:@"甄子丹"
                                                                            headImagePath:[[NSBundle mainBundle]
                                                                                           pathForResource:@"headImage5"
                                                                                           ofType:@"png"]
                                                                            lifePhotoPath:[[NSBundle mainBundle]
                                                                                           pathForResource:@"zhen"
                                                                                           ofType:@"png"]]
                                                         text:@"甄子丹（Donnie Yen，1963年7月27日－），武术家、演员、导演。参与多部西方电影的演出与幕后，与成龙、李连杰同为国际知名的华人武打演员，还担任香港李小龙协会理事、世界明星厨师联合会副主席。2003年5月与年龄相距19岁的多伦多三料华埠小姐冠军汪诗诗结为连理，育有一子一女。"
                                                     sendDate:[NSDate date]]];
    });
   
    

    
    return _messageArray;
}
@end

/*
 
 [_messageArray addObject:[BLMessage messageWithSender:[BLUser userWithName:@"Steve Jobs"
 headImagePath:[[NSBundle mainBundle]
 pathForResource:@"headImage1"
 ofType:@"png"]
 lifePhotoPath:[[NSBundle mainBundle]
 pathForResource:@"jobs"
 ofType:@"png"]]
 text:@"乔布斯是改变世界的天才，他凭敏锐的触觉和过人的智慧，勇于变革，不断创新，引领全球资讯科技和电子产品的潮流，把电脑和电子产品变得简约化、平民化，让曾经是昂贵稀罕的电子产品变为现代人生活的一部分。"
 sendDate:[NSDate date]]];
 
 [_messageArray addObject:[BLMessage messageWithSender:[BLUser userWithName:@"李小龙"
 headImagePath:[[NSBundle mainBundle]
 pathForResource:@"headImage2"
 ofType:@"png"]
 lifePhotoPath:[[NSBundle mainBundle]
 pathForResource:@"li"
 ofType:@"png"]]
 text:@"李小龙，原名李振藩，乳名细凤，为美籍华人，祖籍中国广东省佛山市顺德区均安镇，身高173厘米，体重64公斤。他是一位武术技击家、武术哲学家、全球范围内具有影响力的著名华人武打电影演员、世界武道改革先驱者，UFC起源者，MMA之父，截拳道武道哲学的创立人。"
 sendDate:[NSDate date]]];
 
 [_messageArray addObject:[BLMessage messageWithSender:[BLUser userWithName:@"成龙"
 headImagePath:[[NSBundle mainBundle]
 pathForResource:@"headImage3"
 ofType:@"png"]
 lifePhotoPath:[[NSBundle mainBundle]
 pathForResource:@"cheng"
 ofType:@"png"]]
 text:@"成龙，1954年4月7日生于香港太平山，国家一级演员，大中华区影坛巨星和国际功夫电影巨星，在华人世界享有极高声望与影响。他与周星驰、周润发并称“双周一成”，意为香港电影的票房保证。成龙以功夫片著称，曾经多次打破香港电影票房纪录，目前其主演的电影全球总票房已经超过100亿元，为华人演员之首。成龙的成名作是功夫喜剧《醉拳》，1994年由他主演的《红番区》在美国公映后反响强烈，使其成功打入美国好莱坞，而接下的《尖峰时刻》系列电影亦获得极高的票房，并奠定其国际电影巨星的地位。"
 sendDate:[NSDate date]]];
 
 
 [_messageArray addObject:[BLMessage messageWithSender:[BLUser userWithName:@"赵本山"
 headImagePath:[[NSBundle mainBundle]
 pathForResource:@"headImage4"
 ofType:@"png"]
 lifePhotoPath:[[NSBundle mainBundle]
 pathForResource:@"zhao"
 ofType:@"png"]]
 text:@"赵本山，男，生于1957年10月2日，籍贯是辽宁省铁岭市开原县莲花乡莲花村石嘴沟。著名表演艺术家、国家一级演员、“德艺双馨”艺术家、国家级非物质文化遗产项目代表性传承人。全国青联委员、全国总工会代表、中国曲艺家协会理事、辽宁省曲艺家协会副主席、第十届全国人大代表、辽宁省政协委员、辽宁大学本山艺术学院院长、本山传媒集团董事长。赵本山在央视春晚上享有极高声望，深受人民喜爱，连续10余年蝉联春晚“小品王”。创立本山传媒集团，演出、影视制作、电视栏目和艺术教育等方面大有作为，佳作频出，均创下骄人业绩，广受好评。"
 sendDate:[NSDate date]]];
 
 
 [_messageArray addObject:[BLMessage messageWithSender:[BLUser userWithName:@"甄子丹"
 headImagePath:[[NSBundle mainBundle]
 pathForResource:@"headImage5"
 ofType:@"png"]
 lifePhotoPath:[[NSBundle mainBundle]
 pathForResource:@"zhen"
 ofType:@"png"]]
 text:@"甄子丹（Donnie Yen，1963年7月27日－），武术家、演员、导演。参与多部西方电影的演出与幕后，与成龙、李连杰同为国际知名的华人武打演员，还担任香港李小龙协会理事、世界明星厨师联合会副主席。2003年5月与年龄相距19岁的多伦多三料华埠小姐冠军汪诗诗结为连理，育有一子一女。"
 sendDate:[NSDate date]]];

 
 
 
 */
