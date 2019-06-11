//
//  KHSelPhotoView.h
//  KHealthModules
//
//  Created by kim on 2018/12/28.
//

#import <UIKit/UIKit.h>
#import "KHPhotoModel.h"

@interface KHSelPhotoView : UICollectionView

/**
 初始化
 @param count 一行展示多少个
 @param frame 位置大小
 @return KHSelPhotoView
 */
- (instancetype)initWithLineCount:(NSInteger)count style:(KHSelPhotoViewStyle)style maxCount:(NSInteger)maxCount frame:(CGRect)frame imageArr:(NSArray *)imageArray updateUIBlock:(void(^)(void))updateUIBlock;

///获取当前视图的图片数据，若传入tipMsg，则必须在外部隐藏，包括从本地相册选中的图片数组：pDataS，外部进来的imageUrl数组:pUrlS（删除过或者未删除）,本地选中的图片下标:pIndexS
- (void)getImageDataArrayWithTipMsg:(NSString *)tipMsg CompleteOption:(void (^)(NSArray <NSData *> *pDataS, NSArray *pIndexS, NSArray *pUrlS))cOption;
///获取当前视图的图片资源
- (void)getImageImageArray:(void(^)(NSArray <UIImage *> *pImgS))cOption;

///根据图片数据更新UI imageArr目前只解析NSString、UIImage类型 即图片url和图片对象
- (void)updateUIWithImageArr:(NSArray *)imageArr;
///刷新UI
- (void)reloadUI;

///数据模型
@property (nonatomic, strong) NSMutableArray <KHPhotoModel *>*modelArray;

///风格 - 请初始化时设置
@property (nonatomic, assign) KHSelPhotoViewStyle style;

@end
