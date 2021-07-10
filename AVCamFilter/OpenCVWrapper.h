//
//  OpenCVWrapper.h
//  edgeDetector
//
//  Created by HYEONJUN PARK on 2020/09/09.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class UIImage;
@interface OpenCVWrapper : NSObject
+(UIImage*) detectEdge:(UIImage*) image;
@end

NS_ASSUME_NONNULL_END
