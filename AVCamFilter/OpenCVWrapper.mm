//
//  OpenCVWrapper.m
//  edgeDetector
//
//  Created by HYEONJUN PARK on 2020/09/09.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import "OpenCVWrapper.h"

@implementation OpenCVWrapper
+(UIImage*) detectEdge:(UIImage*) image {
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    if(imageMat.channels() == 1) {
        return image;
    }
    
    cv::Mat noise(imageMat.size(), CV_16SC3);
    
    double mean = 0.0;
    double dev = 50.0;
    
    randn(noise, mean, dev);
    
    cv::Mat temp_image;
    
    imageMat.convertTo(temp_image, CV_16SC3);
    
    add(temp_image, noise, temp_image);
//    addWeighted(temp_image, 1.0, noise, 1.0, 0.0, temp_image);
    
    temp_image.convertTo(temp_image, imageMat.type());
    
    return MatToUIImage(temp_image);
}
@end
