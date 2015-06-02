//
//  XRAuthenticationTool.m
//  KnowerParty
//
//  Created by 董欣然 on 15/1/29.
//  Copyright (c) 2015年 cn.chuangxue. All rights reserved.
//

#import "XRAuthenticationTool.h"
#import "XRHttpTool.h"
#import "XRAuthentication.h"

@implementation XRAuthenticationTool

+(void)getKeySuccess:(GetKeySuccess)success failure:(void (^)(NSError *))faiulre
{
    NSString *key = [XRAuthentication sharedXRAuthentication].key;
    if (key) {
        success(key);
    } else {
        [XRHttpTool postWithUrl:@"/firstlogin_c" success:^(NSString *result) {
            [[XRAuthentication sharedXRAuthentication] setKey:result];
            //设置key
            [XRAuthentication sharedXRAuthentication].key = result;
            success(result);
        } failure:^(NSError *error) {
            faiulre(error);
        }];
    }
}

//+(NSString *)getKeyFromLocal
//{
//    NSString *key  = (NSString*)[NSKeyedUnarchiver unarchiveObjectWithFile:@""];
//    if (key) {
//        return key;
//    }
//    return nil;
//}

@end
