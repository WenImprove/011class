//
//  XRKeyManager.m
//  KnowerParty
//
//  Created by 董欣然 on 15/1/29.
//  Copyright (c) 2015年 cn.chuangxue. All rights reserved.
//

#import "XRAuthentication.h"

@implementation XRAuthentication
single_implementation(XRAuthentication)

#pragma mark - NSCoding
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.key = [aDecoder decodeObjectForKey:@"key"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.key forKey:@"key"];
}

-(NSString *)key
{
    if (_key) {
        return _key;
    }
    _key = (NSString*)[NSKeyedUnarchiver unarchiveObjectWithFile:@""];
    if (_key) {
        return _key;
    }
    return _key;
}






@end
