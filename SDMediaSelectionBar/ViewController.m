//
//  ViewController.m
//  SDMediaSelectionBar
//
//  Created by slowdony on 2018/3/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//
/*
 
 github地址https://github.com/SlowDony/SDMediaSelectionBar
 仿Twitter 选择照片栏
 
 
 我的邮箱：devslowdony@gmail.com
 
 如果有好的建议或者意见 ,欢迎指出 , 您的支持是对我最大的鼓励,谢谢. 求STAR ..😆
 */
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
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight);
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *navLab = [[UILabel alloc] init];
    navLab.frame = CGRectMake(0, 20+(SafeAreaTopHeight==88?20:0), SCREEN_WIDTH, 44);
    navLab.backgroundColor = [UIColor clearColor];
    navLab.textColor = [UIColor blackColor];
    navLab.text = @"主页";
    navLab.textAlignment = NSTextAlignmentCenter;
    navLab.font = [UIFont systemFontOfSize:18];
    navLab.numberOfLines = 0;
    [self.view addSubview:navLab];
    
    UIImageView *headImage = [[UIImageView alloc] init];
    headImage.frame = CGRectMake(10, 22+(SafeAreaTopHeight==88?22:0) ,40,40);
    headImage.image = [UIImage imageNamed:@"headImage"];
    headImage.layer.cornerRadius = 20;
    headImage.layer.masksToBounds = YES;
    [self.view addSubview:headImage];
    
    //
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCREEN_WIDTH-50, 20+(SafeAreaTopHeight==88?20:0), 44, 44);
    [addBtn setImage:[UIImage imageNamed:@"add_Image_Btn"] forState:UIControlStateNormal];
    [addBtn  addTarget:self action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: addBtn];
    //分割线
    UIImageView *spLine = [[UIImageView alloc] init];
    spLine.frame = CGRectMake(0,SafeAreaTopHeight, SCREEN_WIDTH, 0.5);
    spLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:spLine];
    
    //
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.frame = CGRectMake(0, CGRectGetMaxY(spLine.frame),SCREEN_WIDTH , 70);
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textColor = [UIColor blackColor];
    titleLab.text = @"欢迎来到Twitter!";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont boldSystemFontOfSize:18];
    titleLab.numberOfLines = 1;
    [self.view addSubview:titleLab];
    
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.frame = CGRectMake(0, CGRectGetMaxY(titleLab.frame),SCREEN_WIDTH , 50);
    detailLab.backgroundColor = [UIColor clearColor];
    detailLab.textColor = [UIColor colorWithWhite:0.7 alpha:0.9];
    detailLab.text = @"随时来这里看看你关注的人发布的推文。";
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.font = [UIFont systemFontOfSize :13];
    detailLab.numberOfLines = 1;
    [self.view addSubview:detailLab];
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
