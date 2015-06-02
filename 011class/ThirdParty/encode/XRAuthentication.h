//
//  XRKeyManager.h
//  KnowerParty
//
//  Created by 董欣然 on 15/1/29.
//  Copyright (c) 2015年 cn.chuangxue. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "Singleton.h"


@interface XRAuthentication : NSObject <NSCoding>
single_interface(XRAuthentication)

/**
 *  网络通信用的key
 */
@property (nonatomic,copy) NSString *key;

@end
