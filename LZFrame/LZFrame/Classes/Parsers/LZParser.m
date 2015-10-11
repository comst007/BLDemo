//
//  LZParser.m
//  LZFrame
//
//  Created by comst on 15/10/11.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZParser.h"

@interface LZParser ()<NSXMLParserDelegate>
@property (nonatomic, strong) LZUserInfo *userInfo;
@property (nonatomic, strong) NSMutableString *currentItemStringValue;
@end
@implementation LZParser

- (LZUserInfo *)parseJSON:(NSData *)jsonData{
    
    NSError *error = nil;
    NSDictionary *JSONDict;
    JSONDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error: &error];
    
    if (error) {
        return nil;
    }
    
    return [LZUserInfo userInfoWithDic:JSONDict[@"user"]];
}

- (LZUserInfo *)parseXML:(NSData *)XMLData{
    NSXMLParser *XMLParser =  [[NSXMLParser alloc] initWithData:XMLData];
    XMLParser.delegate = self;
    [XMLParser parse];
    return self.userInfo;
}



- (void)parserDidStartDocument:(NSXMLParser *)parser{
    
    NSLog(@"XMLParseStart --------------------------");
    self.currentItemStringValue = [NSMutableString string];

    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    [self.currentItemStringValue setString:@""];
    
    if ([elementName isEqualToString:@"user"]) {
        self.userInfo = [[LZUserInfo alloc] init];
    }
    if ([elementName isEqualToString:@"address"]) {
        self.userInfo.address = [[LZAddress alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [self.currentItemStringValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"user"]) {
        
    }else{
        if ([elementName isEqualToString:@"id"]) {
            if (self.userInfo.address == nil) {
                self.userInfo.userID = self.currentItemStringValue;
            }else{
                self.userInfo.address.cityID = self.currentItemStringValue;
            }
        }
        if ([elementName isEqualToString:@"userName"]) {
            self.userInfo.userName = self.currentItemStringValue;
        }
        if ([elementName isEqualToString:@"age"]) {
            self.userInfo.age = [NSNumber numberWithInt:[self.currentItemStringValue intValue]];
        }
        if ([elementName isEqualToString:@"headImageUrl"]) {
            self.userInfo.headImageURL = self.currentItemStringValue;
        }
        if ([elementName isEqualToString:@"city"]) {
            self.userInfo.address.cityName = self.currentItemStringValue;
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
    NSLog(@"XMLParseEnd --------------------------");
}
@end
