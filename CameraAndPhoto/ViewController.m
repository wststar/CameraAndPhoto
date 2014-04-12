//
//  ViewController.m
//  CameraAndPhoto
//
//  Created by wststar on 14-4-11.
//  Copyright (c) 2014年 wststar. All rights reserved.
//

#import "ViewController.h"
#import "CameraUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

/**
 *	@brief	保存图片后回调
 *
 *	@param 	paramImage 	图片信息
 *	@param 	paramError 错误信息
 *  @param  paramContextInfo
 
 */
-(void)imageWasSavedSuccessfully:(UIImage *)paramImage
        didFinishSavingWithError:(NSError *)paramError
                     contextInfo:(void *)paramContextInfo{
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
    }else{
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", paramError);
    }
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    static BOOL beenHereBefore = NO;
    if (beenHereBefore) {
        return;
    }else{
        beenHereBefore = YES;
    }
    
    /** 调用摄头
     
    if ([CameraUtil isCameraAvailable] && [CameraUtil doesCameraSupportTakingPhotos]) {
        UIImagePickerController * controller = [[UIImagePickerController alloc]init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //照片
        //NSString * requiredMediaType = (__bridge NSString *)kUTTypeImage;
        //视频
        NSString * requiredMediaType = (__bridge NSString *)kUTTypeMovie;
        controller.mediaTypes = [[NSArray alloc]initWithObjects:requiredMediaType, nil];
        
        controller.allowsEditing = YES;
        controller.delegate = self;
        
        //视频高质量
        controller.videoQuality = UIImagePickerControllerQualityTypeHigh;
        //视频记录最大10秒
        controller.videoMaximumDuration = 10.0f;
        
        [self presentViewController:controller animated:YES completion:nil];
        
    }else{
        NSLog(@"Camera is not available.");
    }
     **/
    
    //调用相册
    if ([CameraUtil isPhotoLibraryAvailable]) {
        UIImagePickerController * controller = [[UIImagePickerController alloc]init];
        
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        NSMutableArray * mediaTypes = [[NSMutableArray alloc]init];
        
        if ([CameraUtil canUserPickPhotosFromPhotoLibrary]) {
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        }
        if ([CameraUtil canUserPickVideosFromPhotoLibrary]) {
            [mediaTypes addObject:(__bridge NSString *)kUTTypeMovie];
        }
        
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        
    }
}

#pragma mark --UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"Picker returned successfully.");
    NSLog(@"%@",info);
    
    NSString * mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        self.assetsLibrary = [[ALAssetsLibrary alloc] init];
        NSURL * videoURL = info[UIImagePickerControllerMediaURL];
        NSLog(@"Viewo url = %@",videoURL);
        if (videoURL != nil){
            [self.assetsLibrary writeVideoAtPathToSavedPhotosAlbum:videoURL
                               completionBlock:^(NSURL *assetURL, NSError *error) {
                                   if (error == nil){
                                       NSLog(@"no errors happened");
                                   }else{
                                       NSLog(@"Error happened while saving the video.");
                                       NSLog(@"The error is = %@", error);
                                   }
                               }];
        }else{
            NSLog(@"Could not find the video in the app bundle.");
            
        }
       
    }else if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]){
        UIImage *theImage = nil;
        if ([picker allowsEditing]){
            theImage = info[UIImagePickerControllerEditedImage];
        }else{
            theImage = info[UIImagePickerControllerOriginalImage];
        }
        SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
        UIImageWriteToSavedPhotosAlbum(theImage,
                                       self,
                                       selectorToCall,
                                       NULL);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"Picker was cancelled");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
