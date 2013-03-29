//
//  NBSlideScrollView.h
//  GouShenYang
//
//  Created by zhuangyanjun on 5/12/12.
//  Copyright (c) 2012年 Xu Hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NBSlideScrollView;

@protocol NBSlideScrollViewDelegate <NSObject>
@required
- (UIView *)slideScrollView:(NBSlideScrollView *)slideScrollView viewForIndex:(NSInteger)index;

- (NSInteger)numberOfViewsInSlideScrollView:(NBSlideScrollView *)slideScrollView;

@optional
- (void)slideScrollView:(NBSlideScrollView *)slideScrollView slideToIndex:(NSInteger)index;
@end

@protocol NBReusableSlideCell<NSObject>
- (NSString *)reusableIndentifier;
@end

@interface NBReusableSlideCell : UIView<NBReusableSlideCell>
@property (nonatomic, copy) NSString *reusableIndentifier;
@end

@interface NBSlideScrollView : UIView<UIScrollViewDelegate>
@property (nonatomic, assign) IBOutlet id<NBSlideScrollViewDelegate> delegate;
@property (nonatomic) int firstPageIndex;
@property (nonatomic, readonly) NSInteger currentPage;

- (void)reloadData;
- (UIView<NBReusableSlideCell> *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
- (void)reloadAtIndex:(NSInteger)index;
@end
