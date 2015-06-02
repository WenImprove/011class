//
//  ViewController.m
//  011class
//
//  Created by suez on 15/5/7.
//  Copyright (c) 2015年 suez. All rights reserved.
//

#import "ViewController.h"
#import "myTextField.h"
#import "myButton.h"
#import "addView.h"
#import "XRHttpTool.h"
#import "ViewController1.h"
#import "classDetail.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    UIView *backgroundView;
    UIScrollView *t;
    UIView *d;
    BOOL showZhou;
    NSInteger screenWidth,screenHeight,single,keHeight;
    CGFloat btnW;
    NSMutableArray *colorArr;
    UIColor *blue1,*blue2,*blue3,*blue4,*red1,*red2,*red3,*green1,*green2,*green4,*green3,*orange1,*orange2,*orange3,*orange4,*color16,*color17,*color18,*color19;
    NSString *mouth;
    NSMutableArray *classArrBtn,*classArrBtn1;
    NSMutableArray *btnArr0;
    NSMutableArray *btnArr1;
    NSString *weekNow;
    UIScrollView *scrollView;
    UIView *topView;
    NSString *stu_no;
    NSString *stu_psw;
    NSString *term;
    NSString *term_num;
    
    CGRect tframe0,tframe;
    AppDelegate *delegate;
    NSUserDefaults *defaults;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    showZhou =NO;
    
    delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    delegate.change = YES;
    
    _user_no = @"110";
    _is_bind = @"0";
    _school_sn = @"10001";
    stu_no = @"3112006426";
    stu_psw = @"Oo01iL542134";
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    screenWidth = screenBounds.size.width;
    screenHeight = screenBounds.size.height;
    single = screenWidth/15;
    
    defaults = [NSUserDefaults standardUserDefaults];

    //获取当前是今年第几周
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"w"];
    NSString* yearWeek = [dateFormatter stringFromDate:[NSDate date]];
    //得出差距
    NSString *cross = [defaults objectForKey:@"cross"];
    NSString *thenowWeek = [NSString stringWithFormat:@"%d",yearWeek.intValue - cross.intValue];
    //设置当前
    [defaults setObject:thenowWeek forKey:@"nowWeek"];
    //如果首次启动
    if ([[defaults objectForKey:@"nowWeek"]intValue]==yearWeek.intValue) {
        [defaults setObject:@"1" forKey:@"nowWeek" ];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    if (delegate.change) {
        
    

    weekNow = [defaults objectForKey:@"nowWeek"];
    
    
    [_topTitle setTitle:[NSString stringWithFormat:@"第 %@ 周",weekNow] forState:normal];
    _topTitle.titleLabel.font = [UIFont systemFontOfSize:15];
    
    //[_topTitle setImage:[UIImage imageNamed:@"t.png"] forState:UIControlStateNormal];
    //_topTitle.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    //_topTitle.imageEdgeInsets = UIEdgeInsetsMake(12, 57, 12, 0);
    //_topTitle.backgroundColor = [UIColor redColor];
    [self gettime];
    [self createH];
    [self createW];
    [self initColor];
    [self createBasic];
    [self getField];
    delegate.change = NO;

    }
}


-(void)getField{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    if (!docDir) {
        NSLog(@"目录未找到");
    }
    NSString *fieldPath = [docDir stringByAppendingString:@"class.plist"];
    _classArr = [[NSMutableArray alloc]initWithContentsOfFile:fieldPath];

    if (_classArr.count <1) {
        [self startRequest];
    }
    else{
        [self createClass];
    }
}



-(void)createBasic{
    btnArr0 = [NSMutableArray new];
    btnArr1 = [NSMutableArray new];
    for (int x = 1; x<=7; x++) {
        for (int y = 1; y<=12; y++) {
            myButton *btn = [myButton buttonWithType:UIButtonTypeContactAdd];
            if (screenWidth>320) {
                btnW =(single+1+(x-1)*(single*2));
            }
            else{
                btnW = (single+1+(x-1)*(single*2+1));
            }
            CGRect frame = CGRectMake(btnW, (y-1)*(keHeight-1)+2, single*2-3, keHeight-4);
            [btn setTitle:@"" andFrame:frame];
            btn.backgroundColor = color19;
            [btn addTarget:self action:@selector(addClass:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTag:x+7*y];
            btn.hidden = YES;
            [scrollView addSubview:btn];
            [btnArr0 addObject:btn];
            
            
            myButton *btn1 = [myButton new];
            [btn1 setTitle:@"" andFrame:frame];
            //btn1.backgroundColor = [UIColor redColor];
            [btn1 addTarget:self action:@selector(addClass1:) forControlEvents:UIControlEventTouchUpInside];
            [btn1 setTag:x+7*y];
            [scrollView addSubview:btn1];
            [btnArr1 addObject:btn1];
        }
    }
}

-(void)addClass1:(id)sender{
    UIButton *btn = (UIButton*)sender;
    int x,y,T;
    int z = (int)btn.tag;
    if (z%7!=0) {
        x = z%7;
        y = z/7;
    }
    else{
        x = 7;
        y = z/7-1;
    }
    T = (x - 1)*12 + y;
    NSLog(@"%d---%d---%d",x,y,T);
    
    for (UIButton *btn1 in btnArr1) {
        btn1.hidden = NO;
    }
    btn.hidden = YES;
    
    for (UIButton *btn0 in btnArr0) {
        btn0.hidden = YES;
    }
    
    UIButton *btn0 = [btnArr0 objectAtIndex:T-1];
    btn0.hidden = NO;
}

-(void)addClass:(id)sender{
    UIButton *btn = (UIButton*)sender;
    int x,y;
    int z = (int)btn.tag;
    if (z%7!=0) {
        x = z%7;
        y = z/7;
    }
    else{
        x = 7;
        y = z/7-1;
    }
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    addView *addview = [board instantiateViewControllerWithIdentifier:@"addView"];
    
    addview.user_no = _user_no;
    addview.school_sn = _school_sn;
    addview.stu_no = stu_no;
    addview.term = term;
    addview.term_num = term_num;
    addview.time_week = [NSString stringWithFormat:@"%d",x];
    addview.period = [NSString stringWithFormat:@"%d",y];
     
    [self.navigationController pushViewController:addview animated:YES];
    //NSLog(@"%d---%d",x,y);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    for (UIButton *btn in btnArr0) {
        btn.hidden = YES;
    }
    for (UIButton *btn in btnArr1) {
        btn.hidden = NO;
    }
}

-(void)recreateClass{
    for (UIButton *btn in classArrBtn) {
        [btn removeFromSuperview];
    }
    [classArrBtn removeAllObjects];
    [self createClass];
}

-(void)createClass{
    classArrBtn = [NSMutableArray new];
    classArrBtn1 = [NSMutableArray new];

    int i = 0;
    for (NSDictionary *dict in _classArr) {
        BOOL creat = YES;
        BOOL have = NO;
        BOOL same = NO;
        term = [dict objectForKey:@"term"];
        term_num = [dict objectForKey:@"term_num"];
        NSString *classInfo = [NSString stringWithFormat:@"%@@%@",[dict objectForKey:@"course"],[dict objectForKey:@"classroom"]];
        NSString *classname = [dict objectForKey:@"course"];
        
        NSInteger x = [[dict objectForKey:@"time_week"]intValue];
        NSInteger y = [[dict objectForKey:@"period"]intValue];
        NSInteger length = [[dict objectForKey:@"period_num"]intValue];
        NSArray *zhou = [[dict objectForKey:@"weeknum"] componentsSeparatedByString:@","];
        
        
        
        myButton *btn = [myButton new];
        btn.tag = x+y*7;
        
        
        for (NSString *zhounow in zhou) {
            if ([zhounow isEqualToString:weekNow]) {
                have = YES;
            }
        }
        
        for (UIButton *bt in classArrBtn) {
            if (bt.tag == btn.tag && have==NO) {
                creat = NO;
            }
        }
        
        
        
        if (creat) {
            
            if (screenWidth>320) {
                btn.titleLabel.font = [UIFont systemFontOfSize:12];
                btnW =(single+1+(x-1)*(single*2));
            }
            else{
                btn.titleLabel.font = [UIFont systemFontOfSize:10];
                btnW = (single+1+(x-1)*(single*2+1));
            }
            CGRect frame = CGRectMake(btnW, (y-1)*(keHeight-1)+2, single*2-2.5, keHeight*length-4);
            [btn setTitle:classInfo andFrame:frame];
        
            if (have) {
                
                for (UIButton *bt in classArrBtn1) {
                    NSString *btinfo = bt.titleLabel.text;
                    NSRange l = [btinfo rangeOfString:@"@"];
                    NSString *btclass = [btinfo substringToIndex:l.location];
                    if ([classname isEqualToString:btclass]) {
                        
                        btn.backgroundColor = bt.backgroundColor;
                        [classArrBtn1 addObject:btn];
                        same = YES;
                        break;
                    }
                }
                
                if (!same) {
                    btn.backgroundColor = [colorArr objectAtIndex:i++];
                    [classArrBtn1 addObject:btn];
                }

            }
            else{
            
                btn.backgroundColor = [colorArr objectAtIndex:18];
            }
            
            [btn addTarget:self action:@selector(classDetail:) forControlEvents:UIControlEventTouchUpInside];
            [classArrBtn addObject:btn];
            [scrollView addSubview:btn];
            
        }
        
    }
    
}


-(void)classDetail:(UIButton*)btn{
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    classDetail *detailview = [board instantiateViewControllerWithIdentifier:@"classDetail"];
    detailview.user_no = _user_no;
    detailview.name = btn.titleLabel.text;
    detailview.z = btn.tag;
    [self.navigationController pushViewController:detailview animated:YES];
    
}


-(void)startRequest{
    NSString *url = @"teachmanage_c/teach_getCurriculum";
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:_user_no,@"user_no",_is_bind,@"is_bind",_school_sn,@"school_sn",stu_no,@"stu_no",stu_psw,@"stu_psw", nil];
    
    [XRHttpTool postEncodeWithUrl:url withParams:dict success:^(id json){
        
        _classArr = [json objectForKey:@"list"];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        if (!docDir) {
            NSLog(@"目录未找到");
        }
        NSString *fieldPath = [docDir stringByAppendingString:@"class.plist"];
        [_classArr writeToFile:fieldPath atomically:YES];
        
        [self createClass];
    }failure:^(NSError *error){
        
    }];
}


-(void)createH{
    
    if (screenHeight>480) {
        keHeight = single*8/3;
    }
    else{
        keHeight = single*2;
    }
    CGRect frame = CGRectMake(0, 64+single*4/3-1, screenWidth, screenHeight-64-single*4/3);
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight-64)];
    img.image = [UIImage imageNamed:@"3.PNG"];
    [self.view addSubview:img];
    scrollView = [[UIScrollView alloc]initWithFrame:frame];
    scrollView.contentSize = CGSizeMake(screenWidth, keHeight*12-12);
    scrollView.scrollEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    NSInteger y = 0;
    
    for (int i = 0; i<12; i++) {
        y--;
        myTextField *textfiele = [myTextField new];
        textfiele.font = [UIFont fontWithName:@"Arial" size:13.0f];
        [textfiele initText:[NSString stringWithFormat:@"%d",i+1] andFrame:CGRectMake(0, y, single, keHeight)];
        //NSLog(@"%ld--%ld",(long)y,keHeight);
        y = y+keHeight;
        [textfiele setEnabled:NO];
        [scrollView addSubview:textfiele];
    }
    
    
}


-(void)gettime{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = kCFCalendarUnitYear |
    kCFCalendarUnitMonth |
    kCFCalendarUnitDay |
    kCFCalendarUnitWeekday |
    kCFCalendarUnitHour |
    kCFCalendarUnitMinute |
    kCFCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    //int week = [comps weekday];
    //int year=[comps year];
    //inte month = [comps month];
    //int day = [comps day];
    mouth = [NSString stringWithFormat:@"%ld月",(long)[comps month]];
}

-(void)createW{
    NSArray *weekArr = [NSArray arrayWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日",nil];
    NSInteger x0 = 0;
    NSInteger fieldW;
    for (int i = 0; i < 8; i++) {
        myTextField *field = [myTextField new];
        if (i == 0) {
            [field initText:mouth andFrame:CGRectMake(0, 64, single, single*4/3)];
            if (screenWidth>320) {
                field.font = [UIFont fontWithName:@"Arial" size:12.0f];
            }
            else{
                field.font = [UIFont fontWithName:@"Arial" size:10.0f];
            }
            x0 = single;
        }
        else{
            x0--;
            if (screenWidth>320) {
                fieldW = single*2+1;
            }
            else{
                fieldW = single*2+2;
            }
            //[field initText:[weekArr objectAtIndex:i-1] andFrame:CGRectMake(x0, 64, single*2+2, single*4/3)];
            [field initText:[weekArr objectAtIndex:i-1] andFrame:CGRectMake(x0, 64, fieldW, single*4/3)];
            if (screenWidth>320) {
                field.font = [UIFont fontWithName:@"Arial" size:15.0f];
            }
            else{
                field.font = [UIFont fontWithName:@"Arial" size:13.0f];
            }
            //x0 = x0+single*2+2;
            x0 = x0+fieldW;
        }
        [field setEnabled:NO];
        [self.view addSubview:field];
    }
}

-(void)initColor{
    
    colorArr = [NSMutableArray new];
    
    green2 = [UIColor colorWithRed:70.0/255 green:200.0/255 blue:200.0/255 alpha:0.8];
    [colorArr addObject:green2];
    
    blue2 = [UIColor colorWithRed:0.0/255 green:200.0/255 blue:255.0/255 alpha:0.8];
    [colorArr addObject:blue2];
    
    orange2 = [UIColor colorWithRed:255.0/255 green:170.0/255 blue:0.0/255 alpha:0.8];
    [colorArr addObject:orange2];
    //7
    blue3 = [UIColor colorWithRed:0.0/255 green:180.0/255 blue:210.0/255 alpha:0.8];
    [colorArr addObject:blue3];
    
    green3 = [UIColor colorWithRed:70.0/255 green:200.0/255 blue:60.0/255 alpha:0.8];
    [colorArr addObject:green3];
    
    color16 = [UIColor colorWithRed:0.0/255 green:150.0/255 blue:170.0/255 alpha:0.8];
    [colorArr addObject:color16];
    
    red3 = [UIColor colorWithRed:255.0/255 green:130.0/255 blue:150.0/255 alpha:0.8];
    [colorArr addObject:red3];
    
    orange3 = [UIColor colorWithRed:255.0/255 green:165.0/255 blue:90.0/255 alpha:0.8];
    [colorArr addObject:orange3];
    
    blue4 = [UIColor colorWithRed:130.0/255 green:140.0/255 blue:255.0/255 alpha:0.8];
    [colorArr addObject:blue4];
    
    red2 = [UIColor colorWithRed:130.0/255 green:160.0/255 blue:0.0/255 alpha:0.8];
    [colorArr addObject:red2];
    
    green4 = [UIColor colorWithRed:0.0/255 green:170.0/255 blue:55.0/255 alpha:0.8];
    [colorArr addObject:green4];
    
    color17 = [UIColor colorWithRed:0.0/255 green:205.0/255 blue:180.0/255 alpha:0.8];
    [colorArr addObject:color17];
    
    orange4 = [UIColor colorWithRed:195.0/255 green:165.0/255 blue:50.0/255 alpha:0.8];
    [colorArr addObject:orange4];
    
    color18 = [UIColor colorWithRed:0.0/255 green:150.0/255 blue:180.0/255 alpha:0.8];
    [colorArr addObject:color18];
    
    blue1 = [UIColor colorWithRed:0.0/255.0 green:150.0/255.0 blue:255.0/255.0 alpha:0.8];
    [colorArr addObject:blue1];
    
    green1 = [UIColor colorWithRed:70.0/255 green:200.0/255 blue:100.0/255 alpha:0.8];
    [colorArr addObject:green1];
    
    red1 = [UIColor colorWithRed:255.0/255 green:70.0/255 blue:145.0/255 alpha:0.8];
    [colorArr addObject:red1];
    
    orange1 = [UIColor colorWithRed:255.0/255 green:180.0/255 blue:100.0/255 alpha:0.8];
    [colorArr addObject:orange1];
    
    color19 = [UIColor colorWithWhite:0.9 alpha:0.8];
    [colorArr addObject:color19];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tapB{
    _topTitle.imageView.transform = CGAffineTransformMakeRotation(0);
    showZhou = !showZhou;
    [backgroundView removeFromSuperview];
    [UIView animateWithDuration:0.2 animations:^{
        t.frame = tframe0;
    }];
}



-(void)createt{
    
    t = [[UIScrollView alloc]initWithFrame:tframe0];
    t.contentSize = CGSizeMake(screenWidth/3, 12+25*(screenWidth/12-2));
    for (int i = 1; i<=25; i++) {
        myButton *btn = [myButton new];
        [btn setTitle:[NSString stringWithFormat:@"第 %d 周",i] andframe:CGRectMake(0, 8+(i-1)*(screenWidth/12-2), screenWidth/3, screenWidth/12-2)];
        [btn setTitleColor: [UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1] forState:normal];
        [btn setTitleColor: [UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(choice:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [t addSubview:btn];
    }
    t.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
}

-(void)choice:(UIButton *)btn{
    [self tapB];
    [_topTitle setTitle:btn.titleLabel.text forState:normal];
    weekNow = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    [self recreateClass];
}


- (IBAction)set:(id)sender {
}

- (IBAction)choiceZhou:(id)sender {
    _topTitle.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    showZhou = !showZhou;
    
    if (showZhou) {
        
    tframe0 = CGRectMake(screenWidth/3, 64, screenWidth/3, 0);
    tframe = CGRectMake(screenWidth/3, 64, screenWidth/3, screenWidth*3/4-11);
    //t = [[UITableView alloc]initWithFrame:tframe0];
    [self createt];
    [UIView animateWithDuration:0.2 animations:^{
        backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        //backgroundView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        backgroundView.opaque = YES;
        [backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapB)]];
        [self.view addSubview:backgroundView];
        [self.view addSubview:t];
        t.frame = tframe;
    }];
    
    }else{
        _topTitle.imageView.transform = CGAffineTransformMakeRotation(0);
        [backgroundView removeFromSuperview];
        [UIView animateWithDuration:0.2 animations:^{
            t.frame = tframe0;
        }];
    }
}
@end
