//
//  ViewController.h
//  CameraAndPhoto
//
//  Created by wststar on 14-4-11.
//  Copyright (c) 2014年 wststar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIVideoEditorControllerDelegate>

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSURL *videoURLToEdit;

@end
