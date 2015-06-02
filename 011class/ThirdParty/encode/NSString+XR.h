//
//  NSString+XR.h
//  KnowerParty
//
//  Created by 董欣然 on 15/1/17.
//  Copyright (c) 2015年 cn.chuangxue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XR)
/**
 *  是否中文
 *
 *  @return
 */
-(BOOL)isChinese;

/**
 *  是否邮箱
 *
 *  @return
 */
-(BOOL)isEmail;

/**
 *  去掉字符中的回车
 */
-(NSString*)clearEnter;

/**
 *  去掉字符中的空格
 */
-(NSString*)clearSpace;

/**
 *  去掉空格和回车
 */
-(NSString*)clearEnterAndSpace;

//- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
