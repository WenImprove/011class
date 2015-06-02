//
//  XRAuthenticationTool.h
//  KnowerParty
//
//  Created by 董欣然 on 15/1/29.
//  Copyright (c) 2015年 cn.chuangxue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRAuthentication.h"
typedef void (^GetKeySuccess)(NSString *keys);
@interface XRAuthenticationTool : NSObject
//-(void)get:(void (^)())animations
+(void)getKeySuccess:(GetKeySuccess)success failure:(void (^)(NSError *error))faiulre;


@end
