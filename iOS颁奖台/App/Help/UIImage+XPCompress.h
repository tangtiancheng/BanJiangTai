//
//  UIImage+XPCompress.h
//  XPApp
//
//  Created by xinpinghuang on 12/24/15.
//  Copyright © 2015 ShareMerge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XPCompress)

/**
 *  @author huangxinping, 16-02-26
 *
 *  压缩图片（<20kb则不压缩了）
 *
 *  @return 压缩后的数据流
 *
 *  @since 1.0
 */
- (NSData *)xp_compress;

/**
 *  @author huangxinping, 16-02-26
 *
 *  压缩图片根据给定的阈值（当压缩后的大小<=阈值时，则停止压缩）
 *
 *  @param threshold 阈值
 *
 *  @return 压缩后的数据量
 *
 *  @since 1.0
 */
- (NSData *)xp_compressWithThreshold:(CGFloat)threshold;

@end
