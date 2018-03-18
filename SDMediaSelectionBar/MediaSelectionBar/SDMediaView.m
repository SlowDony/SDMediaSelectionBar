//
//  SDMediaView.m
//  SDMediaSelectionBar
//
//  Created by slowdony on 2018/3/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

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
    playImage.image = [UIImage imageNamed:@"YomoFreezeVideoSelect"];
   
    playImage.hidden = YES;
    
    self.playImage = playImage;
    [self addSubview:playImage];
    
    
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

- (void)layoutSubviews{
    [super layoutSubviews];
    self.buttonBgImage.frame = self.bounds;
    self.playImage.frame = CGRectMake((CGRectGetWidth(self.buttonBgImage.frame)-40)/2,(CGRectGetHeight(self.buttonBgImage.frame)-40)/2 , 40, 40);
}

@end
