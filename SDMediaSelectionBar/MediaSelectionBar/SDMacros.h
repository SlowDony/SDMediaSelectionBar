//
//  SDMacros.h
//  SDInKe
//
//  Created by slowdony on 2018/1/10.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#ifndef SDMacros_h
#define SDMacros_h
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height


#define KWeakself __weak typeof(self) weakSelf = self;

//log扩展
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif

#endif /* SDMacros_h */
