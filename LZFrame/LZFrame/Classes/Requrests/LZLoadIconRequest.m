//
//  LZLoadIconRequest.m
//  LZFrame
//
//  Created by comst on 15/10/12.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZLoadIconRequest.h"


@interface LZLoadIconRequest ()<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *connection;
@end

@implementation LZLoadIconRequest

- (void)sendRequestWithURL:(NSString *)iconURL delegate:(id<LZLoadIconRequestProtocal>)delegate{
    [self cancel];
    self.delegate = delegate;
    NSString *URLString = [iconURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *loadURL = [NSURL URLWithString:URLString];
    
    NSMutableURLRequest *loadIconRequest = [[NSMutableURLRequest alloc] initWithURL:loadURL];
    loadIconRequest.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    loadIconRequest.timeoutInterval = 60;
    
    self.connection = [[NSURLConnection alloc] initWithRequest:loadIconRequest
                                                      delegate:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    if ([self.delegate respondsToSelector:@selector(loadIconRequestDidFail:error:)]) {
        [self.delegate loadIconRequestDidFail:self error:error];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        
        self.totalLength = (NSInteger)httpResponse.expectedContentLength;
        self.recvData = [NSMutableData data];
        
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.recvData appendData:data];
    self.recvSum = self.recvSum + data.length;
    if ([self.delegate respondsToSelector:@selector(loadIconRequestDidReceiveData:)]) {
        [self.delegate loadIconRequestDidReceiveData:self];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if ([self.delegate respondsToSelector:@selector(loadIconRequestDidSuccess:)]) {
        [self.delegate loadIconRequestDidSuccess:self];
    }
}

/**
 *  在开启新的下载之前取消之前的下载
 */
- (void)cancel{
    [self.connection cancel];
    self.recvSum = 0;
    self.totalLength = 0;
}

@end
