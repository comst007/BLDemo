//
//  main.m
//  LZSingleton
//
//  Created by comst on 15/9/26.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZSingleton.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        LZSingleton *obj1 = [[LZSingleton alloc] init];
        
       // [obj1 release];
        
        LZSingleton *obj2 = [[LZSingleton alloc] init];
        
      //  [obj2 retain];
        
        LZSingleton *obj3 = [LZSingleton sharedSingleton];
        
        
        LZSingleton *obj4 = [obj3 copy];
        NSLog(@"%p, %p, %p, %p", obj1, obj2, obj3, obj4);
    }
    return 0;
}
