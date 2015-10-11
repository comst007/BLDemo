//
//  LZLoginRequest.m
//  LZFrame
//
//  Created by comst on 15/10/12.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZLoginRequest.h"
#import "BLMultipartForm.h"
#import "LZParser.h"
@interface LZLoginRequest ()

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) LZUserInfo *userInfo;
@end

@implementation LZLoginRequest
/**
 *  通过回调的形式返回
 *
 *  @param username       要发送的用户名
 *  @param userpassword   要发送的密码，应该需要加密
 *  @param completeHandle 返回结果时的回掉函数
 */
- (void)sendLoginRequestWithName:(NSString *)username password:(NSString *)userpassword completeblock:(loginRequestCompleteBlock)completeHandle{
    
    static NSString *loginURLString = @"http://120.24.236.135/GeekBand/login.json";
    loginURLString = [loginURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *loginURL = [NSURL URLWithString:loginURLString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:loginURL];
    request.HTTPMethod = @"POST";
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    
    [form addValue:username forField:@"username"];
    [form addValue:userpassword forField:@"userpassword"];
    request.HTTPBody =  form.httpBody;
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    request.timeoutInterval = 60;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (httpResponse.statusCode == 200 && !connectionError) {
           
            LZParser *parser = [[LZParser alloc] init];
            
            self.userInfo = [parser parseJSON:data];
            
            
        }else{
            
        }
        
            completeHandle(self.userInfo, connectionError);

    }];
    
    
}
@end
