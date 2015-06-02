//
//  myTextField.m
//  011class
//
//  Created by suez on 15/5/7.
//  Copyright (c) 2015年 suez. All rights reserved.
//

#import "myTextField.h"

@implementation myTextField


-(void)initText:(NSString *)text andFrame:(CGRect)rect{
    
    self.text = text;
    self.textAlignment = NSTextAlignmentCenter;
    self.frame = rect;
    self.textColor = [UIColor colorWithRed:45.0/255.0 green:155.0/255.0 blue:255.0/255.0 alpha:1];
    self.borderStyle = UITextBorderStyleLine;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor colorWithRed:90.0/255.0 green:200.0/255.0 blue:240.0/255.0 alpha:1]CGColor];
    
}







// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
}


@end
