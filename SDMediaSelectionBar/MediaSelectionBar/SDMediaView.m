//
//  SDMediaView.m
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
#import "SDMediaView.h"


@implementation SDMediaView

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
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    UIImageView *buttonImage = [[UIImageView alloc] init];
    buttonImage.frame = self.bounds;
    buttonImage.contentMode = UIViewContentModeScaleAspectFill;
    buttonImage.layer.cornerRadius = 10;
    buttonImage.layer.masksToBounds = YES;
    buttonImage.clipsToBounds = YES;
    self.buttonBgImage = buttonImage;
    [self addSubview:buttonImage];
    
    UIImageView *playImage = [[UIImageView alloc] init];
    playImage.image = [UIImage imageNamed:@"VideoPlay"];
    playImage.hidden = YES;
    self.playImage = playImage;
    [self addSubview:playImage];
    
    //删除按钮
    UIButton *deletebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deletebtn setImage:[UIImage imageNamed:@"ImageDelete"] forState:UIControlStateNormal];
    self.deleteBtn = deletebtn;
    [self addSubview: deletebtn];
   
    
}

- (void)setImageButtonDatas:(SDMediaModel *)model{
    
    if (model.isVideo){
        self.playImage.hidden = NO;
        self.buttonBgImage.image = model.videoImage;
    }else
    {
        self.playImage.hidden = YES;
        self.buttonBgImage.image = model.picture;
    }
    
}

-(void)setMediaType:(MediaType)mediaType{
    _mediaType = mediaType;
    if (mediaType == MediaTypeScrollView){
        self.deleteBtn.hidden = NO;
    }else {
        self.deleteBtn.hidden = YES;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.buttonBgImage.frame = self.bounds;
    CGFloat width = 0;
    if (self.mediaType ==MediaTypeSelectionBar){
        width = 20;
    }else {
         width = 40;
    }
    
    self.playImage.frame = CGRectMake((CGRectGetWidth(self.buttonBgImage.frame)-width)/2,(CGRectGetHeight(self.buttonBgImage.frame)-width)/2 , width, width);
    self.deleteBtn.frame = CGRectMake(self.bounds.size.width-40, 0, 40, 40);
}

@end
