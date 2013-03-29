//
//  NBKeyboardAwareViewController.m
//  DDMJArt
//
//  Created by zhuangyanjun on 4/2/13.
//  Copyright (c) 2013年 jiyue.cc. All rights reserved.
//

#import "NBBaseViewController.h"
#import "NBGlobal.h"

@interface NBBaseViewController ()

@end

@implementation NBBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.autoresizesForKeyboard = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    if (_hasViewAppeared && !_isViewAppearing) {        
        // This will come around to calling viewDidUnload
        [super didReceiveMemoryWarning];
        
        _hasViewAppeared = NO;
        
    } else {
        [super didReceiveMemoryWarning];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _isViewAppearing = YES;
    _hasViewAppeared = YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    _isViewAppearing = NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)resizeForKeyboard:(NSNotification*)notification appearing:(BOOL)appearing {
	CGRect keyboardBounds;
	[[notification.userInfo objectForKey:UIKeyboardBoundsUserInfoKey] getValue:&keyboardBounds];
    
	CGPoint keyboardStart;
	[[notification.userInfo objectForKey:UIKeyboardCenterBeginUserInfoKey] getValue:&keyboardStart];
    
	CGPoint keyboardEnd;
	[[notification.userInfo objectForKey:UIKeyboardCenterEndUserInfoKey] getValue:&keyboardEnd];
    
	BOOL animated = keyboardStart.y != keyboardEnd.y;
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:NB_TRANSITION_DURATION];
    }
    
    if (appearing) {
        [self keyboardWillAppear:animated withBounds:keyboardBounds];
        
    } else {
        [self keyboardDidDisappear:animated withBounds:keyboardBounds];
    }
    
    if (animated) {
        [UIView commitAnimations];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIKeyboardNotifications


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardWillShow:(NSNotification*)notification {
    if (self.isViewAppearing) {
        [self resizeForKeyboard:notification appearing:YES];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardDidShow:(NSNotification*)notification {
#ifdef __IPHONE_3_21
    CGRect frameStart;
    [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&frameStart];
    
    CGRect keyboardBounds = CGRectMake(0, 0, frameStart.size.width, frameStart.size.height);
#else
    CGRect keyboardBounds;
    [[notification.userInfo objectForKey:UIKeyboardBoundsUserInfoKey] getValue:&keyboardBounds];
#endif
    
    [self keyboardDidAppear:YES withBounds:keyboardBounds];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardDidHide:(NSNotification*)notification {
    if (self.isViewAppearing) {
        [self resizeForKeyboard:notification appearing:NO];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardWillHide:(NSNotification*)notification {
#ifdef __IPHONE_3_21
    CGRect frameEnd;
    [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&frameEnd];
    
    CGRect keyboardBounds = CGRectMake(0, 0, frameEnd.size.width, frameEnd.size.height);
#else
    CGRect keyboardBounds;
    [[notification.userInfo objectForKey:UIKeyboardBoundsUserInfoKey] getValue:&keyboardBounds];
#endif
    
    [self keyboardWillDisappear:YES withBounds:keyboardBounds];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setAutoresizesForKeyboard:(BOOL)autoresizesForKeyboard {
    if (autoresizesForKeyboard != _autoresizesForKeyboard) {
        _autoresizesForKeyboard = autoresizesForKeyboard;
        
        if (_autoresizesForKeyboard) {
            [[NSNotificationCenter defaultCenter] addObserver: self
                                                     selector: @selector(keyboardWillShow:)
                                                         name: UIKeyboardWillShowNotification
                                                       object: nil];
            [[NSNotificationCenter defaultCenter] addObserver: self
                                                     selector: @selector(keyboardWillHide:)
                                                         name: UIKeyboardWillHideNotification
                                                       object: nil];
            [[NSNotificationCenter defaultCenter] addObserver: self
                                                     selector: @selector(keyboardDidShow:)
                                                         name: UIKeyboardDidShowNotification
                                                       object: nil];
            [[NSNotificationCenter defaultCenter] addObserver: self
                                                     selector: @selector(keyboardDidHide:)
                                                         name: UIKeyboardDidHideNotification
                                                       object: nil];
            
        } else {
            [[NSNotificationCenter defaultCenter] removeObserver: self
                                                            name: UIKeyboardWillShowNotification
                                                          object: nil];
            [[NSNotificationCenter defaultCenter] removeObserver: self
                                                            name: UIKeyboardWillHideNotification
                                                          object: nil];
            [[NSNotificationCenter defaultCenter] removeObserver: self
                                                            name: UIKeyboardDidShowNotification
                                                          object: nil];
            [[NSNotificationCenter defaultCenter] removeObserver: self
                                                            name: UIKeyboardDidHideNotification
                                                          object: nil];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardWillAppear:(BOOL)animated withBounds:(CGRect)bounds {
    // Empty default implementation.
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardWillDisappear:(BOOL)animated withBounds:(CGRect)bounds {
    // Empty default implementation.
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardDidAppear:(BOOL)animated withBounds:(CGRect)bounds {
    // Empty default implementation.
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardDidDisappear:(BOOL)animated withBounds:(CGRect)bounds {
    // Empty default implementation.
}
@end
