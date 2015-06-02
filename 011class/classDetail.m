//
//  classDetail.m
//  011class
//
//  Created by suez on 15/5/11.
//  Copyright (c) 2015年 suez. All rights reserved.
//

#import "classDetail.h"
#import "XRHttpTool.h"
#import "AppDelegate.h"

@interface classDetail ()
{
    NSString *fieldPath;
    AppDelegate *delegate;

}


@end

@implementation classDetail

- (IBAction)delete:(id)sender {
    
    
    NSString *url = @"teachmanage_c/teach_delCurriculum";
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:_user_no,@"user_no",[_thedict objectForKey:@"school_sn"],@"school_sn",[_thedict objectForKey:@"stu_no"],@"stu_no",[_thedict objectForKey:@"term"],@"term",[_thedict objectForKey:@"term_num"],@"term_num",[_thedict objectForKey:@"time_week"],@"time_week",[_thedict objectForKey:@"period"],@"period",[_thedict objectForKey:@"period_num"],@"period_num", nil];
    
    
    
    
    [XRHttpTool postEncodeWithUrl:url withParams:dict success:^(id json){

        NSLog(@"%@",json);
        [_classArr removeObject:_thedict];
        [_classArr writeToFile:fieldPath atomically:YES];
        delegate.change = YES;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"删除成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }failure:^(NSError *error){
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];

    
    int x,y;
    int z = (int)_z;
    if (z%7!=0) {
        x = z%7;
        y = z/7;
    }
    else{
        x = 7;
        y = z/7-1;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    if (!docDir) {
        NSLog(@"目录未找到");
    }
    
    fieldPath = [docDir stringByAppendingString:@"class.plist"];
    _classArr = [[NSMutableArray alloc]initWithContentsOfFile:fieldPath];
    
    for (NSDictionary *dict in _classArr) {
        NSString *classInfo = [NSString stringWithFormat:@"%@@%@",[dict objectForKey:@"course"],[dict objectForKey:@"classroom"]];
        //NSLog(@"%d-----%d",[[dict objectForKey:@"period"]intValue ],[[dict objectForKey:@"period"]intValue ]);
        if ([classInfo isEqualToString:_name]&&[[dict objectForKey:@"period"]intValue ]==y&&[[dict objectForKey:@"time_week"]intValue]==x) {
            
            _thedict = dict;
            NSString *x = [dict objectForKey:@"course"];
            _coursename.text = x;
            self.title = x;
            x = [dict objectForKey:@"classroom"];
            _classroom.text = x;
            x = [dict objectForKey:@"teacher"];
            _teacher.text = x;
            x = [dict objectForKey:@"period"];
            NSInteger y = [x integerValue]+[[dict objectForKey:@"period_num"]integerValue];
            _period.text = [NSString stringWithFormat:@"第%@-%ld节课",x,(long)y-1];
            
            x = [dict objectForKey:@"weeknumstr"];
            _weeknum.text = x;
            break;
        
        }
        
    }
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
