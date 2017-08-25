//
//  ViewController.m
//  Today
//
//  Created by 憧憬云天888 on 2017/6/23.
//  Copyright © 2017年 lvzhijie. All rights reserved.
//

#import "ViewController.h"
#import "Today-Swift.h"
#import <CoreMotion/CoreMotion.h> 

@interface ViewController ()
@property(nonatomic,strong)CMPedometer *stepCounter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    my_block my = ^(NSString *str){
        NSLog(@"%@%@我在考虑考虑",str,my);
        
    };
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 90, 100, 30)];
    [btn addTarget:self action:@selector(lzj) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:btn];
    self.stepCounter = [[CMPedometer alloc]init];
    
    NSDate *toDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromDate =
    [dateFormatter dateFromString:[dateFormatter stringFromDate:toDate]];
    
    [self.stepCounter startPedometerUpdatesFromDate:fromDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        
        NSLog(@"numberOfSteps%@",pedometerData.numberOfSteps);
        [[NSUserDefaults standardUserDefaults]setObject:pedometerData.numberOfSteps forKey:@"pedometerSteps"];
        [[NSUserDefaults standardUserDefaults]setObject:pedometerData.distance forKey:@"pedometerdistance"];
        
        if(!pedometerData.numberOfSteps) {
            
        }else
        {
            NSLog(@"计算步数:%@ 计算距离: %@",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"pedometerSteps"]],[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"pedometerdistance"]]);
        }
        
    }];
}

- (void)lzj
{
    Lzj_ViewController *lzjVC = [Lzj_ViewController new];
    [self.navigationController pushViewController:lzjVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
