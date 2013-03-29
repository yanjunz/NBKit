//
//  NBTableView.m
//  DDMJArt
//
//  Created by zhuangyanjun on 29/3/13.
//  Copyright (c) 2013年 jiyue.cc. All rights reserved.
//
#ifdef NB_FEATURE_PullRefresh_PushLoad
#import "NBTableView.h"

#define kLoadMoreFooterHeight 65.0f

@interface NBTableView ()
@property (nonatomic) BOOL refreshing;
@end

@implementation NBTableView

- (void)setRefreshEnabled:(BOOL)refreshEnabled
{
    if (_refreshEnabled != refreshEnabled) {
        if (refreshEnabled) {
            [self addSubview:self.refreshHeaderView];
        }
        else {
            if (_refreshHeaderView) {
                [_refreshHeaderView removeFromSuperview];
            }
        }
    }
}

- (void)setLoadMoreEnabled:(BOOL)loadMoreEnabled
{
    if (_loadMoreEnabled != loadMoreEnabled) {
        if (loadMoreEnabled) {
            [self addSubview:self.loadMoreFooterView];
            [self bringSubviewToFront:self.loadMoreFooterView];
        }
        else {
            if (_loadMoreFooterView) {
                [_loadMoreFooterView removeFromSuperview];
            }
        }
    }
}

- (EGORefreshTableHeaderView *)refreshHeaderView
{
    if (_refreshHeaderView == nil) {
        CGRect rect = self.bounds;
        rect.origin.y = -rect.size.height;
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:rect];
        _refreshHeaderView.backgroundColor = [UIColor whiteColor];        
        _refreshHeaderView.delegate = self;
    }
    return _refreshHeaderView;
}

- (NBPushLoadMoreTableFooterView *)loadMoreFooterView
{
    if (_loadMoreFooterView == nil) {
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height;
        rect.size.height = kLoadMoreFooterHeight;
        _loadMoreFooterView = [[NBPushLoadMoreTableFooterView alloc] initWithFrame:rect];
        _loadMoreFooterView.delegate = self;
    }
    return _loadMoreFooterView;
}

- (void)updateLoadMoreFooterView
{
    CGFloat height = self.contentSize.height;
    if (_loadMoreFooterView) {
        CGRect frame = _loadMoreFooterView.frame;
        frame.origin.y = height;
        _loadMoreFooterView.frame = frame;
    }
}

- (void)reloadData
{
    [super reloadData];
    [self updateLoadMoreFooterView];
}

- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [super reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self updateLoadMoreFooterView];
}

#pragma mark - EGORefreshTableHeaderDelegate methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    [self refresh];
}


- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
    return self.refreshing;
}


- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
	return [NSDate date];
}


#pragma mark - NBPushLoadMoreTableFooterDelegate methods

- (void)pushLoadMoreTableFooterDidTriggerLoadMore: (NBPushLoadMoreTableFooterView*)view {
    [self loadMore];
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [self.loadMoreFooterView loadMoreScrollViewDidScroll:scrollView];

    NBDebugShowFrame(@"footer ", self.loadMoreFooterView.frame);
    NBDebugShowFrame(@"tableView", self.frame);
    NBDebugShowSize(@"contentSize ", self.contentSize);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.refreshHeaderView egoRefreshScrollViewDidEndDragging: scrollView];
    [self.loadMoreFooterView loadMoreScrollViewDidEndDragging: scrollView];
}

#pragma mark - Refresh and load more methods

- (void)refresh
{
    self.refreshing = YES;
    if ([self.delegate respondsToSelector:@selector(tableViewDidRefresh:)]) {
        [self.delegate tableViewDidRefresh:self];
    }
}

- (void)loadMore
{
    if ([self.delegate respondsToSelector:@selector(tableViewDidLoadMore:)]) {
        [self.delegate tableViewDidLoadMore:self];
    }
}

- (void)finishLoadMore {
    [self.loadMoreFooterView performSelector:@selector(loadMoreScrollViewDataSourceDidFinishedLoading:)
                                  withObject:self
                                  afterDelay:0.6f];
}

- (void)finishRefresh {
    self.refreshing = NO;
    [self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    
}

@end
#endif // NB_FEATURE_PullRefresh_PushLoad