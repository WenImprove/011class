//
//  ViewController1.m
//  011class
//
//  Created by suez on 15/5/9.
//  Copyright (c) 2015年 suez. All rights reserved.
//

#import "ViewController1.h"
#import "zhouButton.h"
@interface ViewController1 ()
{
    NSInteger screenWidth,screenHeight;
}
- (IBAction)add:(id)sender;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    screenWidth = self.view.bounds.size.width;
    screenHeight = self.view.bounds.size.height;
    NSInteger w0 = screenWidth/17;
    NSInteger viewH = w0*12.5+20;
    UIView *a = [[UIView alloc]initWithFrame:CGRectMake(0,screenHeight-viewH, screenWidth, viewH)];
    NSLog(@"%ld",screenHeight-viewH);
    a.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.35];
    
    UIButton *left = [[UIButton alloc]initWithFrame:CGRectMake(w0, w0/2-5, 46, 30)];
    [left setTitle:@"取消" forState:normal];
    left.backgroundColor = [UIColor redColor];
    [a addSubview:left];
    UIButton *right = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth-w0-46, w0/2-5, 46, 30)];
    [right setTitle:@"确定" forState:normal];
    right.backgroundColor = [UIColor redColor];
    [a addSubview:right];
    
    UIView *navDividingLine = [[UIView alloc] init];
    if (navDividingLine != nil)
    {
        navDividingLine.frame = CGRectMake(0, w0+20, screenWidth, 1);
        navDividingLine.backgroundColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1];
        [a addSubview:navDividingLine];
    }
    
    for (int i = 1; i<=5; i++) {
        for (int j = 1; j<=5; j++) {
            
            zhouButton *btn = [zhouButton new];
            [btn initWithTitle:[NSString stringWithFormat:@"%d",(i-1)*5+j] andFrame:CGRectMake(w0+(j-1)*w0*3, w0+20+w0*3/4+(i-1)*w0*2, w0*3, w0*2)];
            [a addSubview:btn];
        }
    }
    
    [self.view addSubview:a];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*
- (IBAction)add:(id)sender {
    
    UIScrollView *s = [UIScrollView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
}
 */
@end
