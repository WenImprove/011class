//
//  myButton.m
//  011class
//
//  Created by suez on 15/5/8.
//  Copyright (c) 2015年 suez. All rights reserved.
//

#import "myButton.h"

@implementation myButton

-(void)setTitle:(NSString *)title andFrame:(CGRect)frame{
    [self setFrame:frame];
    [self setTitle:title forState:normal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.contentEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 3);
    self.titleLabel.numberOfLines=0;
    [self.titleLabel sizeToFit];
    [self.layer setCornerRadius:8.0];
}

-(void)setTitle:(NSString *)title andframe:(CGRect)frame{
    [self setFrame:frame];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setTitle:title forState:normal];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    //self.contentEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 3);
    self.titleLabel.numberOfLines=0;
    [self.layer setCornerRadius:8.0];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
