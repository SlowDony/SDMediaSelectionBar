//
//  SDSendTwitterViewController.m
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

#import "SDSendTwitterViewController.h"
#import "SDMediaSelectionBar.h"
#import "SDMediaView.h"
#import "SDBaseTextView.h"
#import "SDMediaSelectionTool.h"
#import "SDMediaScrollView.h"
@interface SDSendTwitterViewController ()
<SDMediaSelectionBarDelegate,SDMediaScrollViewDelegate>
/**
 选择栏
 */
@property (nonatomic,strong) SDMediaSelectionBar  *selectionBar;

/**
 输入框
 */
@property (nonatomic,strong) SDBaseTextView  *textView;

/**
 选择view
 */
@property (nonatomic,strong) SDMediaView *mediaView;


/**
 最终选择的图片数据源
 */
@property (nonatomic,strong) NSMutableArray <SDMediaModel *> *selectArr;

/**
 选择图片栏中的数据源
 */
@property (nonatomic,strong) NSMutableArray <SDMediaModel *> *selectionBarArr;


/**
 滚动试图
 */
@property (nonatomic,strong) SDMediaScrollView *mediaScrollView;

@end

@implementation SDSendTwitterViewController

#pragma mark - lazy

- (NSMutableArray <SDMediaModel *> *)selectionBarArr {
    if (!_selectionBarArr){
        _selectionBarArr = [NSMutableArray array];
    }
    return _selectionBarArr;
}

- (NSMutableArray <SDMediaModel *> *)selectArr{
    if (!_selectArr){
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
}

-(SDMediaScrollView *)mediaScrollView{
    if (!_mediaScrollView){
        _mediaScrollView = [[SDMediaScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.textView.frame), SCREEN_WIDTH, 170)];
        _mediaScrollView.mediaScrollViewDelegate = self;
    }
    return _mediaScrollView;
}

-(SDMediaSelectionBar *)selectionBar{
    if (!_selectionBar){
        _selectionBar = [[SDMediaSelectionBar alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 80)];
        _selectionBar.barDelegate = self;
       
    }
    return _selectionBar;
}

- (SDBaseTextView *)textView{
    if (!_textView) {
        _textView = [[SDBaseTextView alloc]init];
        _textView.frame =CGRectMake(60, SafeAreaTopHeight, SCREEN_WIDTH-70, 100);
        _textView.placeholder = @"有什么新鲜事?";
        _textView.placeholderColor = [UIColor grayColor];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.font = [UIFont systemFontOfSize:18];
        _textView.inputAccessoryView = self.selectionBar;
        [_textView becomeFirstResponder];
    }
    return _textView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    self.selectionBarArr = [SDMediaSelectionTool getNewPhotoAlbum];
    [self.selectionBar setDataImageArr:self.selectionBarArr];
    [self addObserver];
   
    // Do any additional setup after loading the view.
}


/**
 添加通知
 */
- (void)addObserver{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updatePhotoAlbum:) name:SDMediaSelectionNotification object:nil];
}

-(void)dealloc{
    [self removeObserver];
}
- (void)removeObserver{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:SDMediaSelectionNotification object:nil];
}
#pragma mark - actions

/**
 更新视频
 */
- (void)updatePhotoAlbum:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSArray *arr = [userInfo objectForKey:SDMediaSelectionKey];
    self.selectionBarArr = [NSMutableArray arrayWithArray:arr];
    [self.selectionBar setDataImageArr:self.selectionBarArr];
}

- (void)setupUI{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftBtn.frame = CGRectMake(10, 20+(SafeAreaTopHeight==88?20:0), 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"shut_Down_Btn"] forState:UIControlStateNormal];
    [leftBtn  addTarget:self action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: leftBtn];
    
    UIImageView *headImage = [[UIImageView alloc] init];
    headImage.frame = CGRectMake(10, SafeAreaTopHeight , 40, 40);
    headImage.image = [UIImage imageNamed:@"headImage"];
    headImage.layer.cornerRadius = 20;
    headImage.layer.masksToBounds = YES;
    [self.view addSubview:headImage];
    
    [self.view addSubview:self.textView];
    [self.view addSubview:self.mediaScrollView];
}

- (void)popView:(UIButton *)sender{
    [self.view endEditing:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - SDMediaSelectionBarDelegate

/**
 MediaSelectionBar选择点击

 @param sender 按钮
 */
-(void)SDMediaSelectionBarImageSelect:(UIButton *)sender{
    
    NSInteger index = sender.tag -123;
     SDMediaModel *mediaModel =  self.selectionBarArr [index];
    
    NSArray *selectArr = @[mediaModel];
    self.selectArr = [NSMutableArray arrayWithArray:selectArr];
    [self.mediaScrollView setDataImageArr:self.selectArr];
    [self.view endEditing:YES];
}

/**
 相机和相册选择

 @param sender 按钮
 */
- (void)SDMediaPhotoAndCameraBtnClick:(UIButton *)sender{
    
}

#pragma mark - SDMediaScrollViewDelegate

/**
 删除按钮点击
 */
-(void)SDMediaScrollViewDeleteBtnClick:(UIButton *)sender{
    NSInteger index = sender.tag-200;
    if (self.selectArr.count>index){
        [self.selectArr removeObjectAtIndex:index];
    }
    [self.mediaScrollView setDataImageArr:self.selectArr];
    
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

@end
