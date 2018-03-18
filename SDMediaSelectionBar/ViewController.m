//
//  ViewController.m
//  SDMediaSelectionBar
//
//  Created by slowdony on 2018/3/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "ViewController.h"
#import "SDMacros.h"
#import "SDSendTwitterViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupUI{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textColor = [UIColor blackColor];
    titleLab.text = @"主页";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.numberOfLines = 0;
    [self.view addSubview:titleLab];
    
    //
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCREEN_WIDTH-50, 20, 44, 44);
    [addBtn setImage:[UIImage imageNamed:@"add_Image_Btn"] forState:UIControlStateNormal];
    [addBtn  addTarget:self action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: addBtn];
    //分割线
    UIImageView *spLine = [[UIImageView alloc] init];
    spLine.frame = CGRectMake(0,64, SCREEN_WIDTH, 0.5);
    spLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:spLine];
}


/**
 添加图
 */
- (void)addImageClick:(UIButton *)sender{
    SDSendTwitterViewController * sendTwitter = [[SDSendTwitterViewController alloc]init];
    [self presentViewController:sendTwitter animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
