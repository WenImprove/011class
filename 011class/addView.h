//
//  addView.h
//  011class
//
//  Created by suez on 15/5/8.
//  Copyright (c) 2015年 suez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addView : UITableViewController


@property(nonatomic,strong)NSString *user_no;
@property(nonatomic,strong)NSString *school_sn;
@property(nonatomic,strong)NSString *stu_no;
@property(nonatomic,strong)NSString *term;
@property(nonatomic,strong)NSString *term_num;
@property(nonatomic,strong)NSString *time_week;
@property(nonatomic,strong)NSString *period;

@property (weak, nonatomic) IBOutlet UITextField *className;
@property (weak, nonatomic) IBOutlet UITextField *teacher;
@property (weak, nonatomic) IBOutlet UITextField *classroom;
@property (weak, nonatomic) IBOutlet UITextField *length;
- (IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UITableViewCell *addZhou;
@property (weak, nonatomic) IBOutlet UILabel *zhouNum;

@end
