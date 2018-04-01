//
//  SDMediaSelectionBar.m
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

#import "SDMediaSelectionBar.h"
#import "SDMacros.h"
#import "SDMediaView.h"
@interface SDMediaSelectionBar()
<
UIScrollViewDelegate
>
@property (nonatomic,strong)  UIScrollView *imageScrollView;

@property (nonatomic,strong)  NSMutableArray *imageViewAllArrs;//所有图片包含拍照按钮和相册

@end
@implementation SDMediaSelectionBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        {
            [self setBackgroundColor:[UIColor whiteColor]];
            [self setUI];
        }
    }
    return self;
}

#pragma mark - lazy
-(NSMutableArray *)imageViewAllArrs{
    if(!_imageViewAllArrs){
        _imageViewAllArrs = [NSMutableArray array];
    }
    return _imageViewAllArrs;
    
}

#pragma mark - setUI
-(void)setUI{
    //
    UIScrollView *imageScrollView = [[UIScrollView alloc] init];
    imageScrollView.frame = CGRectMake(0,0,SCREEN_WIDTH,80);
    imageScrollView.delegate = self;
    imageScrollView.contentSize = CGSizeMake(SCREEN_WIDTH,80);
    imageScrollView.backgroundColor = [UIColor whiteColor];
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.showsVerticalScrollIndicator = NO;
    imageScrollView.pagingEnabled = NO;
    imageScrollView.bounces = YES;
    self.imageScrollView = imageScrollView;
    [self addSubview:imageScrollView];
    
    //相册按钮
    UIButton *photoAlbumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.photoAlbumBtn = photoAlbumBtn;
    [photoAlbumBtn setImage:[UIImage imageNamed:@"image_Btn"] forState:UIControlStateNormal];
    photoAlbumBtn.layer.borderColor = [UIColor colorWithWhite:0.4 alpha:0.3].CGColor;
    photoAlbumBtn.layer.borderWidth = 0.5;
    
    photoAlbumBtn.layer.cornerRadius = 10;
    photoAlbumBtn.layer.masksToBounds = YES;
    photoAlbumBtn.tag = 121;
    [photoAlbumBtn addTarget:self action:@selector(updateImageClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageScrollView addSubview: photoAlbumBtn];
    
    //相机按钮
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cameraBtn = cameraBtn;
    cameraBtn.tag = 122;
    cameraBtn.layer.borderColor = [UIColor colorWithWhite:0.4 alpha:0.3].CGColor;
    cameraBtn.layer.borderWidth = 0.5;
    cameraBtn.layer.cornerRadius = 10;
    cameraBtn.layer.masksToBounds = YES;
    [cameraBtn setImage:[UIImage imageNamed:@"camera_Btn"] forState:UIControlStateNormal];
    [cameraBtn  addTarget:self action:@selector(updateImageClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageScrollView addSubview: cameraBtn];
    
}

-(void)updateImageClick:(UIButton *)sender{
    
    if ([self.barDelegate respondsToSelector:@selector(SDMediaPhotoAndCameraBtnClick:)]) {
        [self.barDelegate SDMediaPhotoAndCameraBtnClick:sender];
    }
}

- (void)imageBtnClick:(UIButton *)sender{
    
    if ([self.barDelegate respondsToSelector:@selector(SDMediaSelectionBarImageSelect:)]) {
        [self.barDelegate SDMediaSelectionBarImageSelect:sender];
    }
}

-(void)setDataImageArr:(NSMutableArray <SDMediaModel *> *)dataImageArr{
    _dataImageArr = dataImageArr;
    //当前图片个数
    NSInteger count = dataImageArr.count;
    //当前页显示图片的个数(含相册按钮和相机按钮)
    NSInteger currentImageViewsCount =self.imageViewAllArrs.count;
    
    for (int i =0 ; i<count ;i++){
        SDMediaView *imageBtn =nil;
        if (i>=currentImageViewsCount) { //imageV不够用需要创建
            imageBtn =[[SDMediaView alloc]init];
            imageBtn.mediaType = MediaTypeSelectionBar;
            [self.imageScrollView addSubview:imageBtn];
            [self.imageViewAllArrs addObject:imageBtn];
            
        }else {
            imageBtn =self.imageViewAllArrs[i];
        }
        
        imageBtn.tag = 123+i;
        [imageBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [imageBtn setImageButtonDatas:dataImageArr[i]];
        imageBtn.hidden=NO;
    }
    for (int i=(int)count ;i<currentImageViewsCount;i++){
        SDMediaView *imageBtn =self.imageViewAllArrs[i];
        imageBtn.hidden=YES;
    }
    //重新布局子控件
    [self setNeedsLayout];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    //排列所有图片
    NSInteger count =self.imageViewAllArrs.count;
    
    CGFloat imageVY = 10;
    CGFloat imageVWidth = 60;
    CGFloat imageVHeight = imageVWidth;
    
    for (int i =0; i<count ;i++){
        CGFloat imageVX = 15+(i+1)*70;
        SDMediaView * imageV = self.imageViewAllArrs[i];
        imageV.frame = CGRectMake(imageVX, imageVY, imageVWidth, imageVHeight);
    }
    //布局相机按钮
    self.cameraBtn.frame =CGRectMake(15, imageVY, imageVWidth, imageVHeight);
    //布局相册按钮
    self.photoAlbumBtn.frame =CGRectMake(15+(count+1)*70, imageVY, imageVWidth, imageVHeight);
    
    self.imageScrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.photoAlbumBtn.frame)+30,80);
    
}
@end
