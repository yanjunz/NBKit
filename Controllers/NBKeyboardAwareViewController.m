//
//  NBKeyboardAwareViewController.m
//  DDMJArt
//
//  Created by zhuangyanjun on 4/2/13.
//  Copyright (c) 2013年 jiyue.cc. All rights reserved.
//

#import "NBKeyboardAwareViewController.h"
#import "NBGlobal.h"

@interface NBKeyboardAwareViewController (){
    CGSize _previousKeyboardSize;
}

@end

@implementation NBKeyboardAwareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NBBaseViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardDidAppear:(BOOL)animated withBounds:(CGRect)bounds {
    [super keyboardDidAppear:animated withBounds:bounds];
    
    if (_previousKeyboardSize.height == 0) {
        self.contentView.frame = NBRectContract(self.contentView.frame, 0, bounds.size.height);
        _previousKeyboardSize = bounds.size;
    }
    else {
        self.contentView.frame = NBRectContract(self.contentView.frame, 0,
                                                bounds.size.height - _previousKeyboardSize.height);
        _previousKeyboardSize = bounds.size;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardWillDisappear:(BOOL)animated withBounds:(CGRect)bounds {
    [super keyboardWillDisappear:animated withBounds:bounds];
    
    // If we do this when there is currently no content view, we can get into a weird loop where the
    // content view gets doubly-initialized. self.contentView will try to initialize it; this will call
    // self.view, which will call -loadView, which often calls self.contentView, which initializes it.
    if (self.contentView) {
        CGRect previousFrame = self.contentView.frame;
        self.contentView.frame = NBRectContract(self.contentView.frame, 0, -bounds.size.height);
        
        // There's any number of edge cases wherein a content view controller will get this callback but
        // it shouldn't resize itself -- e.g. when a controller has the keyboard up, and then drills
        // down into this controller. This is a sanity check to avoid situations where the content
        // extends way off the bottom of the screen and becomes unusable.
        if (self.contentView.bounds.size.height > self.view.bounds.size.height) {
            self.contentView.frame = previousFrame;
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardDidDisappear:(BOOL)animated withBounds:(CGRect)bounds {
    [super keyboardDidDisappear:animated withBounds:bounds];
    _previousKeyboardSize = CGSizeZero;
}

@end
