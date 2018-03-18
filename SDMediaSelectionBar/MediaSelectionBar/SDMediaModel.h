//
//  SDMediaModel.h
//  SDMediaSelectionBar
//
//  Created by slowdony on 2018/3/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface SDMediaModel : NSObject

/**
 图片名字
 */
@property (nonatomic,copy) NSString *pictureName;
/**
 图片
 */
@property (nonatomic,strong) UIImage  *picture;

/**
 图片尺寸
 */
@property (nonatomic,assign) CGSize pictureSize;

/**
 图片data
 */
@property (nonatomic,strong) NSData *pictureData;

/**
 是否是视频 yes是 (限于本地图片)
 */
@property (nonatomic,assign) BOOL isVideo;

/**
 视频Url
 */
@property (nonatomic,strong) NSURL *videoUrl;

/**
 视频名字
 */
@property (nonatomic,copy) NSString *videoName;
/**
 视频封面
 */
@property (nonatomic,strong) UIImage *videoImage;

/**
 视频时长
 */
@property (nonatomic,assign) int totalDuration;;

/**
 视频data
 */
@property (nonatomic,strong) NSData *videoData;

@end
