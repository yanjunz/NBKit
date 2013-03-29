//
//  NBTableView.h
//  DDMJArt
//
//  Created by zhuangyanjun on 29/3/13.
//  Copyright (c) 2013年 jiyue.cc. All rights reserved.
//
#ifdef NB_FEATURE_PullRefresh_PushLoad
#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "NBPushLoadMoreTableFooterView.h"

@class NBTableView;
@protocol NBTableViewDelegate <UITableViewDelegate>
- (void)tableViewDidRefresh:(UITableView *)tableView;
- (void)tableViewDidLoadMore:(UITableView *)tableView;
@end

@interface NBTableView : UITableView<EGORefreshTableHeaderDelegate, NBPushLoadMoreTableFooterDelegate>

@property (nonatomic) BOOL refreshEnabled;
@property (nonatomic) BOOL loadMoreEnabled;
@property (nonatomic, strong) EGORefreshTableHeaderView     *refreshHeaderView;
@property (nonatomic, strong) NBPushLoadMoreTableFooterView *loadMoreFooterView;
@property (nonatomic, assign) IBOutlet id<NBTableViewDelegate> delegate;
- (void)finishLoadMore;
- (void)finishRefresh;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
@end

#endif // NB_FEATURE_PullRefresh_PushLoad