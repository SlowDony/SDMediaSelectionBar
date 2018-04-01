//
//  SDMediaScrollView.m
//  SDMediaSelectionBar
//
//  Created by slowdony on 2018/4/1.
//  Copyright © 2018年 slowdony. All rights reserved.
//

/*
 
 github地址https://github.com/SlowDony/SDMediaSelectionBar
 仿Twitter 选择照片栏
 
 
 我的邮箱：devslowdony@gmail.com
 
 如果有好的建议或者意见 ,欢迎指出 , 您的支持是对我最大的鼓励,谢谢. 求STAR ..😆
 */

#import "SDMediaScrollView.h"
#import "SDMacros.h"
#import "SDMediaView.h"
@interface SDMediaScrollView()
<
UIScrollViewDelegate
>
@property (nonatomic,strong)  UIScrollView *imageScrollView;
@property (nonatomic,strong)  NSMutableArray *imageViewAllArrs;//所有图片
@property (nonatomic,strong) NSMutableArray *photos;


@end
@implementation SDMediaScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        {
            
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
-(NSMutableArray *)photos{
    if (!_photos){
        _photos = [NSMutableArray array];
    }
    return _photos;
}

#pragma mark - setUI
-(void)setUI{
    //
    UIScrollView *imageScrollView = [[UIScrollView alloc] init];
    imageScrollView.frame = CGRectMake(0,0,SCREEN_WIDTH,170);
    imageScrollView.delegate = self;
    imageScrollView.contentSize = CGSizeMake(SCREEN_WIDTH,170);
    imageScrollView.backgroundColor = [UIColor whiteColor];
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.showsVerticalScrollIndicator = NO;
    imageScrollView.pagingEnabled = NO;
    imageScrollView.bounces = YES;
    self.imageScrollView = imageScrollView;
    [self addSubview:imageScrollView];
    
}

-(void)setDataImageArr:(NSMutableArray <SDMediaModel *>*)dataImageArr{
    _dataImageArr = dataImageArr;
    //当前图片个数
    NSInteger count =dataImageArr.count;
    //当前页显示图片的个数
    NSInteger currentImageViewsCount =self.imageViewAllArrs.count;
    
    for (int i =0 ; i<count ;i++){
        SDMediaView *imageBtn =nil;
        if (i>=currentImageViewsCount) { //imageV不够用需要创建
            imageBtn =[[SDMediaView alloc]init];
            imageBtn.mediaType = MediaTypeScrollView;
            imageBtn.deleteBtn.tag = 200+i;
            [imageBtn.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageView:)];
            imageBtn.tag = 300+i;
            [imageBtn addGestureRecognizer:pan];
            [self.imageScrollView addSubview:imageBtn];
            [self.imageViewAllArrs addObject:imageBtn];
        }else {
            imageBtn =self.imageViewAllArrs[i];
        }
        
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


/**
 删除按钮
 */
- (void)deleteBtnClick:(UIButton *)sender{
    if ([self.mediaScrollViewDelegate respondsToSelector:@selector(SDMediaScrollViewDeleteBtnClick:)]){
        [self.mediaScrollViewDelegate SDMediaScrollViewDeleteBtnClick:sender];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //排列所有图片
    CGFloat imageVX = 0;
    CGFloat imageVY = 10;
    CGFloat imageVWidth = 0;
    CGFloat imageVHeight = 0;
    CGFloat lastWidth = 15;
    
    for (int i =0; i<self.dataImageArr.count ;i++){
        SDMediaModel *model = self.dataImageArr[i];
        CGSize size  = model.picture.size;
        
        BOOL isWidePicture;
        if (size.height>0){
            isWidePicture =(model.picture.size.width/model.picture.size.height) >=1 ?YES :NO;
        }else {
            isWidePicture = YES;
        }
        if (model.isVideo){
            imageVWidth = 150;
            imageVHeight = 150;
            
        }else {
            if (isWidePicture){ //宽图
                imageVWidth = 200;
                imageVHeight = 150;
            }else{
                imageVWidth = 113;
                imageVHeight = 150;
            }
        }
        imageVX = (lastWidth+10*i);
        SDMediaView * imageV = self.imageViewAllArrs[i];
        imageV.frame = CGRectMake(imageVX, imageVY, imageVWidth, imageVHeight);
        lastWidth = imageVWidth +lastWidth;
    }
    self.imageScrollView.contentSize = CGSizeMake(lastWidth+self.dataImageArr.count*10,170);
}


/**
 点击图片 浏览大图
 */
- (void)showImageView:(UITapGestureRecognizer *)paramSender{}


@end
