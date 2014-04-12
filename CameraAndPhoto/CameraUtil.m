//
//  CameraUtil.m
//  CameraAndPhoto
//
//  Created by wststar on 14-4-12.
//  Copyright (c) 2014年 wststar. All rights reserved.
//

#import "CameraUtil.h"

@implementation CameraUtil

+(BOOL)isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+(BOOL)isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

+(BOOL)isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

+(BOOL) isFlashAvailableOnFrontCamera{
    return [UIImagePickerController isFlashAvailableForCameraDevice:
            UIImagePickerControllerCameraDeviceFront];
}
+(BOOL) isFlashAvailableOnRearCamera{
    return [UIImagePickerController isFlashAvailableForCameraDevice: UIImagePickerControllerCameraDeviceRear];
}



+(BOOL)cameraSupportsMedia:(NSString *)paramMediaType
                sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        NSLog(@"Media type is empty");
        return  NO;
    }
    
    NSArray * availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString * mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]) {
            result = YES;
            *stop = YES;
        }
    }];
    
    return result;
}

+(BOOL)doesCameraSupportShootingVideos{
    BOOL result = (BOOL)[self cameraSupportsMedia:(__bridge NSString *)kUTTypeVideo sourceType:UIImagePickerControllerSourceTypeCamera];
    return  result;
}

+(BOOL) doesCameraSupportTakingPhotos{
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}


@end
