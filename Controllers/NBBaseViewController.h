//
//  NBKeyboardAwareViewController.h
//  DDMJArt
//
//  Created by zhuangyanjun on 4/2/13.
//  Copyright (c) 2013年 jiyue.cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBBaseViewController : UIViewController
/**
 * The view has appeared at least once and hasn't been removed due to a memory warning.
 */
@property (nonatomic, readonly) BOOL hasViewAppeared;

/**
 * The view is about to appear and has not appeared yet.
 */
@property (nonatomic, readonly) BOOL isViewAppearing;

/**
 * Determines if the view will be resized automatically to fit the keyboard.
 */
@property (nonatomic) BOOL autoresizesForKeyboard;


/**
 * Sent to the controller before the keyboard slides in.
 */
- (void)keyboardWillAppear:(BOOL)animated withBounds:(CGRect)bounds;

/**
 * Sent to the controller before the keyboard slides out.
 */
- (void)keyboardWillDisappear:(BOOL)animated withBounds:(CGRect)bounds;

/**
 * Sent to the controller after the keyboard has slid in.
 */
- (void)keyboardDidAppear:(BOOL)animated withBounds:(CGRect)bounds;

/**
 * Sent to the controller after the keyboard has slid out.
 */
- (void)keyboardDidDisappear:(BOOL)animated withBounds:(CGRect)bounds;
@end
