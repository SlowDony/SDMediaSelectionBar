//
//  SDMediaView.h
//  SDMediaSelectionBar
//
//  Created by slowdony on 2018/3/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDMediaModel.h"
@interface SDMediaView : UIButton
@property (nonatomic,strong)  UIImageView *buttonBgImage;//按钮背景
@property (nonatomic,strong)  UIImageView *playImage;//视频播放按钮
- (void)setImageButtonDatas:(SDMediaModel *)model;
@end
