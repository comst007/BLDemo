//
//  LZLoginRequest.h
//  LZFrame
//
//  Created by comst on 15/10/12.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZUserInfo;
typedef void (^loginRequestCompleteBlock)(LZUserInfo *user, NSError *error);
@interface LZLoginRequest : NSObject

- (void)sendLoginRequestWithName:(NSString *)username password:(NSString *)userpassword completeblock:(loginRequestCompleteBlock)completeHandle;

@end
