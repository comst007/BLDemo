//
//  LZParser.h
//  LZFrame
//
//  Created by comst on 15/10/11.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZUserInfo.h"
@interface LZParser : NSObject

- (LZUserInfo *)parseXML:(NSData *)XMLData;

- (LZUserInfo *)parseJSON:(NSData *)JSONData;
@end
