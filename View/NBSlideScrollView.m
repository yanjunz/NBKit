//
//  NBSlideScrollView.m
//  GouShenYang
//
//  Created by zhuangyanjun on 5/12/12.
//  Copyright (c) 2012年 Xu Hui. All rights reserved.
//

#import "NBSlideScrollView.h"

@implementation NBReusableSlideCell
@synthesize reusableIndentifier = _reusableIndentifier;

- (void)dealloc
{
    self.reusableIndentifier = nil;
}

@end

@interface NBSlideScrollView() {
    NSMutableArray *_views;
    BOOL _firstLayout;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *views;
@end

@implementation NBSlideScrollView
@synthesize scrollView  = _scrollView;
@synthesize delegate    = _delegate;
@synthesize firstPageIndex  = _firstPageIndex;
@synthesize views       = _views;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _firstLayout = YES;
        _firstPageIndex = 0;
    }
    return self;
}

- (void)awakeFromNib
{
    _firstLayout = YES;
}

- (void)dealloc
{
    self.scrollView     = nil;
    self.views          = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_firstLayout) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        int pageCount = [_delegate numberOfViewsInSlideScrollView:self];
        self.views = [NSMutableArray arrayWithCapacity:pageCount];
        for (int i = 0; i < pageCount; ++i) {
            [_views addObject:[NSNull null]];
        }
        _firstLayout = NO;
        self.scrollView.contentOffset = CGPointMake(_firstPageIndex * self.scrollView.frame.size.width, 0);
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * MAX(_views.count, 1), self.scrollView.frame.size.height);
    int currentPage = self.currentPage;
    [self loadPage:currentPage-1];
    [self loadPage:currentPage];
    [self loadPage:currentPage+1];
}

- (void)loadPage:(int)index
{
    if (index < 0 || index >= _views.count) {
        return;
    }
    
    UIView *view = _views[index];
    if ((NSNull *)view == [NSNull null]) {
        view = [_delegate slideScrollView:self viewForIndex:index];
        _views[index] = view;
    }
    
    if (view.superview == nil) {
        [self.scrollView addSubview:view];
    }

    CGRect viewFrame = view.frame;
    viewFrame.origin.x = self.scrollView.frame.size.width * index + (self.scrollView.frame.size.width - viewFrame.size.width) / 2;
    viewFrame.origin.y = (self.scrollView.frame.size.height - viewFrame.size.height) / 2;
    view.frame = viewFrame;
}

- (NSInteger)currentPage
{
	// Calculate which page is visible
	CGFloat pageWidth = self.scrollView.frame.size.width;
	int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	
	return page;
}

- (void)reloadData
{
    for (UIView *view in self.views) {
        if ((NSNull *)view == [NSNull null]) {
            continue;
        }
        [view removeFromSuperview];
    }
    
    int pageCount = [_delegate numberOfViewsInSlideScrollView:self];
    self.views = [NSMutableArray arrayWithCapacity:pageCount];
    for (int i = 0; i < pageCount; ++i) {
        [_views addObject:[NSNull null]];
    }
    [self setNeedsLayout];
}

- (UIView<NBReusableSlideCell> *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    for (int i = 0; i < self.views.count; ++i) {
        UIView *view = self.views[i];
        if ((NSNull *)view == [NSNull null]) {
            continue;
        }
        else if ([view conformsToProtocol:@protocol(NBReusableSlideCell)]) {
            UIView<NBReusableSlideCell> *cell = (UIView<NBReusableSlideCell> *)view;
            if ([[cell reusableIndentifier] isEqualToString:identifier] &&
                ![self isVisibleInScrollView:view.frame]) {
                self.views[i] = [NSNull null];
                return cell;
            }
        }
    }
    return nil;
}

- (BOOL)isVisibleInScrollView:(CGRect)frame
{
    CGRect visibleFrame;
    visibleFrame.origin = self.scrollView.contentOffset;
    visibleFrame.size = self.scrollView.frame.size;
    return CGRectIntersectsRect(frame, visibleFrame);
}

- (void)reloadAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.views.count) {
        return;
    }
    
    UIView *oldView = self.views[index];
    if ((NSNull *)oldView != [NSNull null]) {
        [oldView removeFromSuperview];
    }
    self.views[index] = [NSNull null];
    [self loadPage:index];
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

-(void)scrollViewDidScroll:(UIScrollView *)sv
{
	int page = [self currentPage];
	if ([_delegate respondsToSelector:@selector(slideScrollView:slideToIndex:)]) {
        [_delegate slideScrollView:self slideToIndex:page];
    }
	// Load the visible and neighbouring pages
	[self loadPage:page-1];
	[self loadPage:page];
	[self loadPage:page+1];
}

#pragma mark -
#pragma mark Memory management

// didReceiveMemoryWarning is not called automatically for views,
// make sure you call it from your view controller
- (void)didReceiveMemoryWarning
{
	// Calculate the current page in scroll view
    int currentPage = [self currentPage];
	
	// unload the pages which are no longer visible
	for (int i = 0; i < [_views count]; i++)
	{
		UIView *viewController = [_views objectAtIndex:i];
        if((NSNull *)viewController != [NSNull null])
		{
			if(i < currentPage-1 || i > currentPage+1)
			{
				[viewController removeFromSuperview];
				[_views replaceObjectAtIndex:i withObject:[NSNull null]];
			}
		}
	}
	
}

@end
