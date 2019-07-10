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

- (void)startSessionWithView:(UIView *)superView ValueChange:(valueChange)block;

- (void)startSessionWithSourceIMG:(UIImage *)img ValueChange:(valueChange)block;

- (void)stopSession;

@end

NS_ASSUME_NONNULL_END
