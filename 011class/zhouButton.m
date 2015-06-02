//
//  zhouButton.m
//  011class
//
//  Created by suez on 15/5/9.
//  Copyright (c) 2015年 suez. All rights reserved.
//

#import "zhouButton.h"
#import "ViewController.h"
@implementation zhouButton


-(void)initWithTitle:(NSString *)title andFrame:(CGRect)frame{
    [self setFrame:frame];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setTitle:title forState:normal];
    [self setTitleColor: [UIColor blackColor] forState:normal];
    [self setTitleColor: [UIColor whiteColor] forState:UIControlStateSelected];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    //self.contentEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 4);
    //self.titleLabel.numberOfLines=0;
    self.layer.borderColor = [[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.8]CGColor];
    self.layer.borderWidth = 1;
    [self.layer setCornerRadius:0.0];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
