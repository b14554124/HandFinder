//
//  SMHandFinder.h
//  SMHoroscope
//
//  Created by BCZ on 2018/11/26.
//  Copyright © 2018 SM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HandFinderModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^valueChange)(HandFinderModel *model);


@interface HandFinder : NSObject

+(instancetype)shareInstance;

//摄像头
- (void)startSessionWithView:(UIView *)superView ValueChange:(valueChange)block;

//图片
- (void)startSessionWithSourceIMG:(UIImage *)img ValueChange:(valueChange)block;
/**
 停止会话, 页面离开时使用
 */
- (void)stopSession;


@end

NS_ASSUME_NONNULL_END
