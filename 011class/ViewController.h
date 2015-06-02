//
//  ViewController.h
//  011class
//
//  Created by suez on 15/5/7.
//  Copyright (c) 2015年 suez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *topTitle;
@property(nonatomic,strong)NSString* user_no;
@property(nonatomic,strong)NSString* is_bind;
@property(nonatomic,strong)NSString* school_sn;
@property(nonatomic,strong)NSMutableArray *classArr;
- (IBAction)set:(id)sender;
- (IBAction)choiceZhou:(id)sender;
@property(nonatomic,strong)NSString* test;
@end

