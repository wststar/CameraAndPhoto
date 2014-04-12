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
    
    /**调用相册
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
    **/
    
    /**加载图片
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
        [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                          usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result,
                                               NSUInteger index,
                                               BOOL *stop) {
                __block BOOL foundThePhoto = NO;
                if (foundThePhoto){
                    *stop = YES;
                }
                // Get the asset type //
                NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                if ([assetType isEqualToString:ALAssetTypePhoto]){
                    NSLog(@"This is a photo asset");
                    foundThePhoto = YES;
                    *stop = YES;
                    // Get the asset's representation object
                    ALAssetRepresentation *assetRepresentation =[result defaultRepresentation];
                    // We need the scale and orientation to be able to
                     //construct a properly oriented and scaled UIImage
                     //out of the representation object
                    CGFloat imageScale = [assetRepresentation scale];
                    UIImageOrientation imageOrientation = (UIImageOrientation)[assetRepresentation orientation];
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        CGImageRef imageReference = [assetRepresentation fullResolutionImage];
                        // Construct the image now //
                        UIImage  *image = [[UIImage alloc] initWithCGImage:imageReference
                                                   scale:imageScale
                                             orientation:imageOrientation];
                        if (image != nil){
                            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
                            imageView.contentMode = UIViewContentModeScaleAspectFit;
                            imageView.image = image;
                            [self.view addSubview:imageView];
                        }else{
                            NSLog(@"Failed to create the image.");
                        }
                    });
                }
            }]; }
                                        failureBlock:^(NSError *error) {
                                            NSLog(@"Failed to enumerate the asset groups.");
                                        }];

    });
    */
    
    /**加载视频
    self.assetsLibrary = [[ALAssetsLibrary alloc] init]; dispatch_queue_t dispatchQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); dispatch_async(dispatchQueue, ^(void) {
        [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            __block BOOL foundTheVideo = NO;
            [group enumerateAssetsUsingBlock:^(ALAsset *result,
                                               NSUInteger index,
                                               BOOL *stop) {
                // Get the asset type //
                NSString *assetType = [result
                                       valueForProperty:ALAssetPropertyType];
                if ([assetType isEqualToString:ALAssetTypeVideo]){ NSLog(@"This is a video asset");
                    foundTheVideo = YES;
                    *stop = YES;
                    //Get the asset's representation object
                    ALAssetRepresentation *assetRepresentation =
                    [result defaultRepresentation];
                    const NSUInteger BufferSize = 1024; uint8_t buffer[BufferSize]; NSUInteger bytesRead = 0;
                    long long currentOffset = 0; NSError *readingError = nil;
                    //Construct the path where the video has to be saved
                    NSString *videoPath =
                    [[self documentFolderPath]
                     stringByAppendingPathComponent:@"Temp.MOV"];
                    NSFileManager *fileManager = [[NSFileManager alloc] init];
                    // Create the file if it doesn't exist already
                    if ([fileManager fileExistsAtPath:videoPath] == NO){ [fileManager createFileAtPath:videoPath
                                                                                              contents:nil
                                                                                            attributes:nil];
                    }
                    // We will use this file handle to write the contents
                     //of the media assets to the disk
                    NSFileHandle *fileHandle =
                    [NSFileHandle
                     fileHandleForWritingAtPath:videoPath]; do{
                        //Read as many bytes as we can put in the buffer
                        bytesRead =
                        [assetRepresentation getBytes:(uint8_t *)&buffer
                                           fromOffset:currentOffset
                                               length:BufferSize
                                                error:&readingError];
                        //If we couldn't read anything, we will
                         //exit this loop
                        if (bytesRead == 0){ break;
                        }
                        // Keep the offset up to date //
                        currentOffset += bytesRead;
                        /// Put the buffer into an NSData //
                        NSData *readData = [[NSData alloc] initWithBytes:(const void *)buffer
                                                                  length:bytesRead];
                        // And write the data to file //
                        [fileHandle writeData:readData];
                    } while (bytesRead > 0);
                    NSLog(@"Finished reading and storing the \
                          video in the documents folder");
                } }];
            if (foundTheVideo){ *stop = YES;
            }
        }
                                        failureBlock:^(NSError *error) {
                                            NSLog(@"Failed to enumerate the asset groups.");
                                        }];
    });
     **///
    
    /**编辑视频*/
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    if ([CameraUtil isPhotoLibraryAvailable] && [CameraUtil canUserPickVideosFromPhotoLibrary]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        /* Set the source type to photo library */
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        /* And we want our user to be able to pick movies from the library */
        imagePicker.mediaTypes = @[(__bridge NSString *)kUTTypeMovie];
        /* Set the delegate to the current view controller */
        imagePicker.delegate = self;
        /* Present our image picker */
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark --UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"Picker returned successfully.");
    NSLog(@"%@",info);
    
    NSString * mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        self.videoURLToEdit = info[UIImagePickerControllerMediaURL];
        [picker dismissViewControllerAnimated:YES completion:^{
            if (self.videoURLToEdit != nil){
                NSString *videoPath = [self.videoURLToEdit path];
                /* First let's make sure the video editor is able to edit the
                 video at the path in our documents folder */
                if ([UIVideoEditorController canEditVideoAtPath:videoPath]){
                    /* Instantiate the video editor */
                    UIVideoEditorController *videoEditor = [[UIVideoEditorController alloc] init];
                    /* We become the delegate of the video editor */
                    videoEditor.delegate = self;
                    /* Make sure to set the path of the video */
                    videoEditor.videoPath = videoPath;
                    /* And present the video editor */
                    [self presentViewController:videoEditor
                                       animated:YES
                                     completion:nil];
                    self.videoURLToEdit = nil;
                }else{
                    NSLog(@"Cannot edit the video at this path");
                } }
        }];
        
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
         [picker dismissViewControllerAnimated:YES completion:nil];
    }
   
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"Picker was cancelled");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *) documentFolderPath{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSURL *url = [fileManager URLForDirectory:NSDocumentDirectory
                  inDomain:NSUserDomainMask
                  appropriateForURL:nil
                  create:NO
                  error:nil];
     return url.path;
}

#pragma mark --UIVideoEditorControllerDelegate
- (void)videoEditorController:(UIVideoEditorController *)editor didSaveEditedVideoToPath:(NSString *)editedVideoPath{
    NSLog(@"The video editor finished saving video");
    NSLog(@"The edited video path is at = %@", editedVideoPath);
    [editor dismissViewControllerAnimated:YES completion:nil];
}
- (void)videoEditorController:(UIVideoEditorController *)editor didFailWithError:(NSError *)error{
    NSLog(@"Video editor error occurred = %@", error);
    [editor dismissViewControllerAnimated:YES completion:nil];
}
- (void)videoEditorControllerDidCancel:(UIVideoEditorController *)editor{
    NSLog(@"The video editor was cancelled");
    [editor dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
