//
//  ViewController.m
//  Table
//
//  Created by 金贝恩资本 on 2018/3/24.
//  Copyright © 2018年 金贝恩资本. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *b=[[UIButton alloc]initWithFrame:CGRectMake(0,100, 200, 40)];
    [b setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [b setTitle:@"tiaoz" forState:UIControlStateNormal];
    [b addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
}

-(void)btnClick{
    TableViewController *tvc=[[TableViewController alloc]init];
    [self.navigationController pushViewController:tvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
