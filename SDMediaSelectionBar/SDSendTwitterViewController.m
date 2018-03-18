//
//  SDSendTwitterViewController.m
//  SDMediaSelectionBar
//
//  Created by slowdony on 2018/3/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDSendTwitterViewController.h"
#import "SDMediaSelectionBar.h"
#import "SDBaseTextView.h"
#import "SDMediaSelectionTool.h"
@interface SDSendTwitterViewController ()
<SDMediaSelectionBarDelegate>
/**
 选择栏
 */
@property (nonatomic,strong) SDMediaSelectionBar  *selectionBar;

/**
 输入框
 */
@property (nonatomic,strong) SDBaseTextView  *textView;


/**
 最终选择的图片数据源
 */
@property (nonatomic,strong) NSMutableArray <SDMediaModel *> *selectArr;

/**
 选择图片栏中的数据源
 */
@property (nonatomic,strong) NSMutableArray <SDMediaModel *> *selectionBarArr;

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
        _textView.frame =CGRectMake(0, 65, SCREEN_WIDTH, 100);
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
    leftBtn.frame = CGRectMake(10, 20, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"shut_Down_Btn"] forState:UIControlStateNormal];
    [leftBtn  addTarget:self action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: leftBtn];
    [self.view addSubview:self.textView];
}

- (void)popView:(UIButton *)sender{
    [self.view endEditing:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - SDMediaSelectionBarDelegate
-(void)SDMediaSelectionBarImageSelect:(UIButton *)sender{
    
    NSInteger index = sender.tag -123;
      self.selectionBarArr [index];
    
    
}
- (void)SDMediaPhotoAndCameraBtnClick:(UIButton *)sender{
    
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
