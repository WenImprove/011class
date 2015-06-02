//
//  classDetail.h
//  011class
//
//  Created by suez on 15/5/11.
//  Copyright (c) 2015年 suez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface classDetail : UITableViewController

@property(nonatomic,strong)NSMutableArray *classArr;
@property(nonatomic,strong)NSDictionary *thedict;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *theperiod;
@property(nonatomic)NSInteger z;
@property(nonatomic,strong)NSString *user_no;
@property (weak, nonatomic) IBOutlet UILabel *coursename;
@property (weak, nonatomic) IBOutlet UILabel *classroom;
@property (weak, nonatomic) IBOutlet UILabel *teacher;
@property (weak, nonatomic) IBOutlet UILabel *period;
@property (weak, nonatomic) IBOutlet UILabel *weeknum;
- (IBAction)delete:(id)sender;


@end
