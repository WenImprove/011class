//
//  setView.h
//  011class
//
//  Created by suez on 15/5/12.
//  Copyright (c) 2015年 suez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setView : UITableViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *setweek;
@property (weak, nonatomic) IBOutlet UILabel *weeklabel;
- (IBAction)done:(id)sender;

@end
