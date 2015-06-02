//
//  addView.m
//  011class
//
//  Created by suez on 15/5/8.
//  Copyright (c) 2015年 suez. All rights reserved.
//

#import "addView.h"
#import "zhouButton.h"
#import "XRHttpTool.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface addView ()
{
    CGFloat screenWidth,screenHeight,addZhouViewH;
    CGFloat w0;
    CGRect frameFirst;
    CGRect frameShow;
    UIView *add,*shadowView;
    NSMutableArray *addNum,*classArr;
    NSArray *arr;
    NSString *weeknumstr,*weeknum;
    AppDelegate *delegate;
}
@end

@implementation addView

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];

    screenWidth = self.view.bounds.size.width;
    screenHeight = self.view.bounds.size.height;
    
    w0 = screenWidth/17;
    addZhouViewH = w0*12.5+20;
    
    frameFirst = CGRectMake(0, screenHeight, screenWidth, addZhouViewH);
    frameShow = CGRectMake(0,screenHeight-addZhouViewH-64, screenWidth, addZhouViewH);
    [_addZhou addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createZhouView)]];
    
    addNum = [NSMutableArray new];

    
}



//点击背景-
-(void)remove{
    [shadowView removeFromSuperview];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [add setFrame:frameFirst];
    }completion:^(BOOL finished){
        
    }];
}

//点击添加完毕按钮
-(void)addDone{
    [shadowView removeFromSuperview];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [add setFrame:frameFirst];
    }completion:^(BOOL finished){
        
        arr = [addNum sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1,NSNumber *obj2){
            if ([obj1 intValue]>[obj2 intValue]) {
                return NSOrderedDescending;
            }else{
                return NSOrderedAscending;
            }
        }];
        weeknumstr = [self changetype:arr];
        _zhouNum.text = [NSString stringWithFormat:@"第%@周",weeknumstr];
    }];
}



- (IBAction)done:(id)sender {
    
    if (_className.text.length != 0 && _teacher.text.length !=0 && _classroom.text.length !=0 && _length.text.length != 0 && weeknumstr !=nil) {
        
        
        NSLog(@"%@,%@,%@,%@",_className.text,_teacher.text,_classroom.text,_length.text);
        
        weeknum = [arr componentsJoinedByString:@","];
        weeknum = [weeknum stringByAppendingString:@","];
        NSString *url = @"teachmanage_c/teach_addCurriculum";
        NSLog(@"%@",weeknum);
        NSString *theweeknumstr = [NSString stringWithFormat:@"第%@周",weeknumstr];
        NSMutableDictionary *postDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:_user_no,@"user_no",_school_sn,@"school_sn",_stu_no,@"stu_no",_term,@"term",_term_num,@"term_num",_time_week,@"time_week",_period,@"period",_length.text,@"period_num",_className.text,@"course",weeknum,@"weeknum",theweeknumstr,@"weeknumstr",_teacher.text,@"teacher",_classroom.text,@"classroom", nil];
        
        //NSLog(@"%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--%@--",_user_no,_school_sn,_stu_no,_term,_term_num,_time_week,_period,_length.text,_className.text,weeknum,theweeknumstr,_teacher.text,_classroom.text);
        
        //本地要添加的数据
        NSDictionary *addDict = [NSDictionary dictionaryWithObjectsAndKeys:_school_sn,@"school_sn",_stu_no,@"stu_no",_term,@"term",_term_num,@"term_num",_time_week,@"time_week",_period,@"period",_length.text,@"period_num",_className.text,@"course",weeknum,@"weeknum",theweeknumstr,@"weeknumstr",_teacher.text,@"teacher",_classroom.text,@"classroom", nil];
        
        [XRHttpTool postEncodeWithUrl:url withParams:postDict success:^(id json){
            NSLog(@"%@",json);
            delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
            //delegate.change = YES;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
            NSString *docDir = [paths objectAtIndex:0];
            if (!docDir) {
                NSLog(@"目录未找到");
            }
            NSString *fieldPath = [docDir stringByAppendingString:@"class.plist"];
            classArr = [[NSMutableArray alloc]initWithContentsOfFile:fieldPath];
            [classArr addObject:addDict];
            //写入数据
            [classArr writeToFile:fieldPath atomically:YES];
            
            delegate.change = YES;
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"添加成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
        }failure:^(NSError *error){
            
        }];

        
        
        
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"信息不完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    
            }
}

-(NSString*)changetype:(NSArray *)zhouArr{
    NSString *x,*y,*result = [NSString new];
    x = [zhouArr objectAtIndex:0];
    result = [result stringByAppendingString:[NSString stringWithFormat:@"%@",x]];
    for (int i = 0; i<zhouArr.count-1; i++) {
        
        if ([[zhouArr objectAtIndex:i+1]intValue] - [[zhouArr objectAtIndex:i]intValue] ==1) {
            y = [zhouArr objectAtIndex:i+1];
        }
        else{
            if ([[zhouArr objectAtIndex:i]intValue] == [x intValue]) {
                
                x = [zhouArr objectAtIndex:i+1];
                result = [result stringByAppendingString:[NSString stringWithFormat:@" %@",x]];
            }
            else{
                result = [result stringByAppendingString:[NSString stringWithFormat:@"-%@",y]];
                x = [zhouArr objectAtIndex:i+1];
                result = [result stringByAppendingString:[NSString stringWithFormat:@" %@",x]];

            }
        }
    }
    if (y!=nil && [y intValue]>[x intValue]) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"-%@",y]];
    }
    
    return result;
}


//点击取消添加按钮
-(void)addCancel{
    [shadowView removeFromSuperview];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [add setFrame:frameFirst];
    }completion:^(BOOL finished){
        [addNum removeAllObjects];
    }];
}

//创建添加周板-
-(void)createZhouView{
    
    
    
    
    add = [[UIView alloc]initWithFrame:frameFirst];
    add.backgroundColor = [UIColor redColor];
    UIButton *left = [[UIButton alloc]initWithFrame:CGRectMake(w0, w0/2-5, 46, 30)];
    [left setTitle:@"取消" forState:normal];
    [left setTitleColor:[UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1] forState:normal];
    left.titleLabel.font = [UIFont systemFontOfSize:15];
    [left addTarget:self action:@selector(addCancel) forControlEvents:UIControlEventTouchUpInside];
    [add addSubview:left];
    
    UIButton *right = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth-w0-46, w0/2-5, 46, 30)];
    [right setTitle:@"确定" forState:normal];
    [right setTitleColor:[UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1] forState:normal];
    [right addTarget:self action:@selector(addDone) forControlEvents:UIControlEventTouchUpInside];
    [add addSubview:right];
    right.titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIView *navDividingLine = [[UIView alloc] init];
    if (navDividingLine != nil)
    {
        navDividingLine.frame = CGRectMake(0, w0+20, screenWidth, 1);
        navDividingLine.backgroundColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1];
        [add addSubview:navDividingLine];
    }
    
    for (int i = 1; i<=5; i++) {
        for (int j = 1; j<=5; j++) {
            
            zhouButton *btn = [zhouButton new];
            [btn initWithTitle:[NSString stringWithFormat:@"%d",(i-1)*5+j] andFrame:CGRectMake(w0+(j-1)*w0*3, w0+20+w0*3/4+(i-1)*w0*2, w0*3, w0*2)];
            [add addSubview:btn];
            [btn addTarget:self action:@selector(addNum:) forControlEvents:UIControlEventTouchUpInside];
            
            for (NSString* num in addNum) {
                if ([num isEqualToString:btn.titleLabel.text]) {
                    btn.selected = YES;
                    btn.backgroundColor = [UIColor colorWithRed:70/255.0 green:200/255.0 blue:60/255.0 alpha:1];
                }
            }
            
        }
    }
    

    add.backgroundColor = [UIColor whiteColor];
    [self showAddZhou];
}



//点击某周按钮
-(void)addNum:(UIButton*)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        btn.backgroundColor = [UIColor colorWithRed:70/255.0 green:200/255.0 blue:60/255.0 alpha:1];
        [addNum addObject:btn.titleLabel.text ];
    }else{
        
        btn.backgroundColor = [UIColor whiteColor];
        for (NSString* num in addNum) {
            if ([num isEqualToString:btn.titleLabel.text]) {
                [addNum removeObject:num];
                break;
            }
        }
    }
}

//滑出周板-
-(void)showAddZhou{

    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [_className resignFirstResponder];
        [_teacher resignFirstResponder];
        [_classroom resignFirstResponder];
        [_length resignFirstResponder];
        shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        shadowView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.35];
        [self.view addSubview:shadowView];
        [shadowView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remove)]];
        
        [self.view addSubview:add];

        [add setFrame:frameShow];
        
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
