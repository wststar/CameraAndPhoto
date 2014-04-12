//
//  CameraUtil.h
//  CameraAndPhoto
//
//  Created by wststar on 14-4-12.
//  Copyright (c) 2014年 wststar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CameraUtil : NSObject

+(BOOL)isCameraAvailable;

+(BOOL)isFrontCameraAvailable;

+(BOOL)isRearCameraAvailable;

+(BOOL) isFlashAvailableOnFrontCamera;

+(BOOL) isFlashAvailableOnRearCamera;

+(BOOL)doesCameraSupportShootingVideos;

+(BOOL) doesCameraSupportTakingPhotos;

@end
