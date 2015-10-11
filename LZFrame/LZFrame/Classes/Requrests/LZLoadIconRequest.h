//
//  LZLoadIconRequest.h
//  LZFrame
//
//  Created by comst on 15/10/12.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LZLoadIconRequest;

@protocol LZLoadIconRequestProtocal <NSObject>

@optional
- (void)loadIconRequestDidSuccess:(LZLoadIconRequest *)loadIconRequest;

@optional
- (void)loadIconRequestDidFail:(LZLoadIconRequest *)loadIconRequest error:(NSError *)error;

@optional
- (void)loadIconRequestDidReceiveData:(LZLoadIconRequest *)loadIconRequest;

@end

@interface LZLoadIconRequest : NSObject
@property (nonatomic, assign) NSInteger totalLength;
@property (nonatomic, assign) NSInteger recvSum;
@property (nonatomic, strong) NSMutableData *recvData;
@property (nonatomic, weak) id<LZLoadIconRequestProtocal> delegate;

- (void)sendRequestWithURL:(NSString *)iconURL delegate:(id<LZLoadIconRequestProtocal>)delegate;
@end
