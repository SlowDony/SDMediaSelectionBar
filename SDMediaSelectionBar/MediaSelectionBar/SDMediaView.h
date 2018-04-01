//
//  SDMediaView.h
//  SDMediaSelectionBar
//
//  Created by slowdony on 2018/3/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDMediaModel.h"
typedef NS_ENUM( NSInteger ,MediaType){
    MediaTypeScrollView,
    MediaTypeSelectionBar,
};

@interface SDMediaView : UIButton

@property (nonatomic,assign)  MediaType mediaType ;//类型

@property (nonatomic,strong)  UIButton *deleteBtn; //删除按钮
@property (nonatomic,strong)  UIImageView *buttonBgImage;//按钮背景
@property (nonatomic,strong)  UIImageView *playImage;//视频播放按钮
- (void)setImageButtonDatas:(SDMediaModel *)model;
@end
