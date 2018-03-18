//
//  SDMediaSelectionBar.h
//  SDMediaSelectionBar
//
//  Created by slowdony on 2018/3/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDMacros.h"
#import "SDMediaModel.h"



@protocol  SDMediaSelectionBarDelegate<NSObject>

/**
 图片点击回调 //tag 123为图片选择
 */
-(void)SDMediaSelectionBarImageSelect:(UIButton *)sender;

/**
 相册相机按钮点击回调 //tag 121相册.122相机,
 */
-(void)SDMediaPhotoAndCameraBtnClick:(UIButton *)sender;
@end

@interface SDMediaSelectionBar : UIView

@property (nonatomic,weak) id<SDMediaSelectionBarDelegate >barDelegate;

@property (nonatomic,strong) UIButton *photoAlbumBtn;//上传图片按钮
@property (nonatomic,strong) UIButton *cameraBtn;//拍照按钮

@property (nonatomic,strong) NSMutableArray <SDMediaModel *>*dataImageArr; //从相册直接拿图片资源
@end
