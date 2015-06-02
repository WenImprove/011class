//
//  setView.m
//  011class
//
//  Created by suez on 15/5/12.
//  Copyright (c) 2015年 suez. All rights reserved.
//

#import "setView.h"
#import "AppDelegate.h"

@interface setView ()
{
    NSMutableArray *week;
    UIView *shadowView;
    UIPickerView *pickView;
    CGRect frame0,frame1,pframe;
    CGFloat screenWidth,screenHeight;
    NSUserDefaults *defaults;
    NSString *num;
    AppDelegate *delegate;

}
@end

@implementation setView

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];

    defaults = [NSUserDefaults standardUserDefaults];
    num = [defaults objectForKey:@"nowWeek"];
    _weeklabel.text = [NSString stringWithFormat:@"第 %@ 周",num];
    
    screenWidth = self.view.bounds.size.width;
    screenHeight = self.view.bounds.size.height;
    
    frame0 = CGRectMake(0, screenHeight, screenWidth, 270);
    frame1 = CGRectMake(0, screenHeight-270, screenWidth, 270);
    
    [_setweek addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pick)]];
     
    week = [NSMutableArray new];
    for (int i = 1; i<=25; i++) {
        [week addObject:[NSString stringWithFormat:@"第 %d 周",i]];
    }
    pickView = [[UIPickerView alloc]initWithFrame:frame0];
    pickView.dataSource = self;
    pickView.delegate = self;
}

-(void)pick{
    
    pickView.backgroundColor = [UIColor whiteColor];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        shadowView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.35];
        [self.view addSubview:shadowView];
        [shadowView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remove)]];
        
        [pickView setFrame:frame1];
        [self.view addSubview:pickView];
    }];
}

- (IBAction)done:(id)sender {
    //设置当前是第几周
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:num forKey:@"nowWeek"];
    
    //获取当前是今年第几周
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"w"];
    NSString* yearWeek = [dateFormatter stringFromDate:[NSDate date]];
    //计算差距
    NSString *nowweek = [defaults objectForKey:@"nowWeek"];
    NSString *cross = [NSString stringWithFormat:@"%d",yearWeek.intValue - nowweek.intValue];
    [defaults setObject:cross forKey:@"cross"];
    
    [self remove];
    delegate.change = YES;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"设置成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _weeklabel.text = [week objectAtIndex:row];
    num = [NSString stringWithFormat:@"%ld",row+1];

}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [week objectAtIndex:row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return week.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(void)remove{
    [shadowView removeFromSuperview];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [pickView setFrame:frame0];
    }completion:^(BOOL finished){
        
    }];
}















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

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
