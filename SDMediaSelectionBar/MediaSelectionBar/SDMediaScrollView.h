//
//  SDMediaScrollView.h
//  SDMediaSelectionBar
//
//  Created by slowdony on 2018/4/1.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDMediaModel;

@protocol  SDMediaScrollViewDelegate<NSObject>
@optional

/**
 删除按钮的回调
 */
- (void)SDMediaScrollViewDeleteBtnClick:(UIButton *)sender;
@end
@interface SDMediaScrollView : UIView


@property (nonatomic,weak) id<SDMediaScrollViewDelegate>mediaScrollViewDelegate;

@property (nonatomic,strong) NSMutableArray <SDMediaModel *>*dataImageArr; //从相册直接拿图片资源

/**
 设置数据

 @param dataImageArr 数据
 */
-(void)setDataImageArr:(NSMutableArray <SDMediaModel *>*)dataImageArr;
@end
