//
//  ViewController.m
//  retainCycleDemo
//
//  Created by 刘毅-B10037 on 2018/2/24.
//  Copyright © 2018年 halohily. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [button addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"tap" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btn
{
    SecondViewController *vc = [[SecondViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
