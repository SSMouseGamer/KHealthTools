//
//  KHSelPhotoView+FuncCategory.h
//  KHealthModules
//
//  Created by kim on 2019/3/19.
//  Copyright © 2019年 李云新. All rights reserved.
//

#import "KHSelPhotoView.h"
#import "KHPhotoLibraryVC.h"
#import "KHShowPhotoVC.h"

@interface KHSelPhotoView (FuncCategory)<UIImagePickerControllerDelegate, UINavigationControllerDelegate,KHPhotoLibraryVCDelegate,KHShowPhotoVCDelegate>
///打开摄像机
- (void)c_openCameraVC;
///打开图片库
- (void)c_openPhotoLibVCWithMaxCount:(NSInteger)maxCount;

///
- (void)c_getImageArray:(void (^)(NSArray <NSData *> *pDataS, NSArray *pIndexS, NSArray *pUrlS))cOption;

///获取当前视图的图片资源
- (void)c_getImageImageArray:(void(^)(NSArray <UIImage *> *pImgS))cOption;

@end
