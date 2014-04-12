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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    static BOOL beenHereBefore = NO;
    if (beenHereBefore) {
        return;
    }else{
        beenHereBefore = YES;
    }
    
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
        
        /*视频高质量 */
        controller.videoQuality = UIImagePickerControllerQualityTypeHigh;
        /* 视频记录最大10秒 */
        controller.videoMaximumDuration = 10.0f;
        
        [self presentViewController:controller animated:YES completion:nil];
        
    }else{
        NSLog(@"Camera is not available.");
    }
    
}

#pragma mark --UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"Picker returned successfully.");
    NSLog(@"%@",info);
    
    NSString * mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        NSURL * urlOfVideo = info[UIImagePickerControllerMediaURL];
        NSLog(@"Viewo url = %@",urlOfVideo);
        
        NSError *dataReadingError = nil;
        NSData *videoData =[NSData dataWithContentsOfURL:urlOfVideo
                              options:NSDataReadingMapped
                                error:&dataReadingError];
        if (videoData != nil){
            NSLog(@"Successfully loaded the data.");
        }else{
            NSLog(@"Failed to load the data with error = %@",dataReadingError);
        }
    }else if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]){
        NSDictionary * metadata = info[UIImagePickerControllerMediaMetadata];
        UIImage * theImage = info[UIImagePickerControllerOriginalImage];
        NSLog(@"Image Metadata = %@", metadata);
        NSLog(@"Image = %@", theImage);
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
