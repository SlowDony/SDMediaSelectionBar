//
//  SDMediaSelectionTool.m
//  SDMediaSelectionBar
//
//  Created by slowdony on 2018/3/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDMediaSelectionTool.h"
#import "SDMacros.h"
#import "SDMediaModel.h"
@implementation SDMediaSelectionTool

+ (BOOL)authorizationStatus{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

/**
 获取系统相册数据源
 */
+ (NSMutableArray <SDMediaModel *>*)getNewPhotoAlbum
{
    NSMutableArray *emtypArr  = [NSMutableArray array];
    
    if ([[self class] authorizationStatus]){
        // 获得相机胶卷
        PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        // 同步获得图片, 只会返回1张图片
        options.synchronous = YES;
        
        // 获得某个相簿中的所有PHAsset对象
        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:cameraRoll options:nil];
        
        NSMutableArray *photos = [NSMutableArray array];
        for (PHAsset *phasset in assets){
            //2.2.0 把视频取消了
            if (phasset.mediaType ==PHAssetMediaTypeImage){
                [photos addObject:phasset];
            }
        }
        
        NSArray *photosArr  =[[photos reverseObjectEnumerator] allObjects];
        
        if (photosArr.count >10){
            photosArr = [photosArr subarrayWithRange:NSMakeRange(0, 10)];
        }
        KWeakself
        [photosArr enumerateObjectsUsingBlock:^(PHAsset *phasset, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (phasset.mediaType == PHAssetMediaTypeVideo){
                [[self class]movieToInfoWithPHAsset:phasset Handler:^(NSURL *movieUrl, int seconds, NSData *moiveData, UIImage *movieImage) {
                    
                        SDMediaModel *picsModel = [[SDMediaModel alloc]init];
                        picsModel.isVideo = YES;
                        picsModel.videoUrl = movieUrl;
                        picsModel.videoImage = movieImage;
                        picsModel.totalDuration =seconds;
                        picsModel.videoData = moiveData;
                        [emtypArr insertObject:picsModel atIndex:idx];
                        NSDictionary *userInfo =
                        @{SDMediaSelectionKey:emtypArr};
                        [[NSNotificationCenter defaultCenter]postNotificationName:SDMediaSelectionNotification object:weakSelf userInfo:userInfo];
                }];
            }else if (phasset.mediaType == PHAssetMediaTypeImage){
                [[self class]imageInfoWithPHAsset:phasset Handle:^(UIImage *image, CGSize size) {
                    SDMediaModel *picsModel = [[SDMediaModel alloc]init];
                    picsModel.picture = image;
                    picsModel.pictureSize = size;
                    picsModel.isVideo = NO;
                    [emtypArr addObject:picsModel];
                }];
                
            }
        }];
    }
    return emtypArr;
    
}

/**
 通过PHAsset获取图片信息
 */
+ (void)imageInfoWithPHAsset:(PHAsset *)asset Handle:(void (^)(UIImage *image ,CGSize size))handler{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    CGSize size =CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    // 从asset中获得图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {

        if (handler) {
            handler(result,size);
        }
    }];
}

/**
 通过PHAsset获取视频信息
 */
+ (void)movieToInfoWithPHAsset:(PHAsset *)asset Handler:(void (^)(NSURL *movieUrl ,int seconds,NSData *moiveData,UIImage *movieImage))handler {
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc]init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.networkAccessAllowed = YES;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    [[PHImageManager defaultManager]requestAVAssetForVideo:asset options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        AVURLAsset *urlAsset = (AVURLAsset *)asset;
        CMTime   time = [asset duration];
        int seconds = ceil(time.value/time.timescale);
        NSData *moiveData = [NSData dataWithContentsOfURL:urlAsset.URL];
        NSURL *url = urlAsset.URL;
        UIImage *movieImage = [[self class] movieToImageWithUrl:url];
        if (handler) {
            dispatch_async(dispatch_get_main_queue(), ^{
            handler(url,seconds,moiveData,movieImage);
            });
        }
    }];
}



+ (UIImage *)movieToImageWithUrl:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}


/**
 获取秒数
 */
+ (NSString * )durationSeconds:(NSURL*)urlString {
    __block  NSString * videoSeconds = @"0"; dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        AVURLAsset*audioAsset=[AVURLAsset URLAssetWithURL:urlString options:nil];
        
        CMTime audioDuration=audioAsset.duration;
        
        float audioDurationSeconds=CMTimeGetSeconds(audioDuration);
        NSInteger  Seconds = (NSInteger)audioDurationSeconds;
        
        if (Seconds <= 60) {
            videoSeconds = [NSString stringWithFormat:@"00:%02ld",(long)Seconds];
        }else {
            videoSeconds = [NSString stringWithFormat:@"%02ld:%02ld",(long)Seconds/60,(long)Seconds%60];
        }
        
    });
    
    return videoSeconds;
    
}
@end
