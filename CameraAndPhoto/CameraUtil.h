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

/**
 *	@brief	摄头是否有效
 *
 *	@return
 */
+(BOOL)isCameraAvailable;


/**
 *	@brief	前置摄头是否有效
 *
 *	@return
 */
+(BOOL)isFrontCameraAvailable;


/**
 *	@brief	后置摄头是否有效
 *
 *	@return
 */
+(BOOL)isRearCameraAvailable;



/**
 *	@brief	前置摄头是否装配了闪光灯
 *
 *	@return
 */
+(BOOL) isFlashAvailableOnFrontCamera;



/**
 *	@brief	后置摄头是否装配了闪光灯
 *
 *	@return
 */
+(BOOL) isFlashAvailableOnRearCamera;


/**
 *	@brief	摄头是否支持拍摄视频
 *
 *	@return
 */
+(BOOL)doesCameraSupportShootingVideos;


/**
 *	@brief 摄头是否支持照相
 *
 *	@return
 */
+(BOOL) doesCameraSupportTakingPhotos;


@end
