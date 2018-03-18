//
//  SDMediaSelectionTool.h
//  SDMediaSelectionBar
//
//  Created by slowdony on 2018/3/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

#define SDMediaSelectionNotification @"SDMediaSelectionNotification"
#define SDMediaSelectionKey @"SDMediaSelectionKey"

@class SDMediaModel;
@interface SDMediaSelectionTool : NSObject

+ (BOOL)authorizationStatus;

/**
 获取相册最新的前十张
 */
+ (NSMutableArray <SDMediaModel *>*)getNewPhotoAlbum;


/**
 通过PHAsset获取图片信息
 */
+ (void)imageInfoWithPHAsset:(PHAsset *)asset Handle:(void (^)(UIImage *image ,CGSize size))handler;

/**
 通过PHAsset获取视频信息
 */
+ (void)movieToInfoWithPHAsset:(PHAsset *)asset Handler:(void (^)(NSURL *movieUrl ,int seconds,NSData *moiveData,UIImage *movieImage))handler ;

/**
 根据视频URL获取第一帧图片
 */
+ (UIImage*)movieToImageWithUrl:(NSURL *)path;
@end
