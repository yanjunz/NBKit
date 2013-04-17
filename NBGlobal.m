//
//  GSYGlobal.m
//  GouShenYang
//
//  Created by zhuangyanjun on 13/11/12.
//  Copyright (c) 2012年 Xu Hui. All rights reserved.
//

#import "NBGlobal.h"

const CGFloat nbkDefaultTransitionDuration      = 0.3f;

BOOL NBIsPad() {
#ifdef __IPHONE_3_2
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#else
    return NO;
#endif
}

BOOL NBIsDevice4Inches()
{
    return [UIScreen mainScreen].applicationFrame.size.height >= 568.0f;
}

int NBSysMajorVersion()
{
    NSString *ver = [UIDevice currentDevice].systemVersion;
    NSArray *verAry = [ver componentsSeparatedByString:@"."];
    assert(([verAry count] >= 2));
    int sysMajorVersion = [(NSString *) [verAry objectAtIndex:0] intValue];
    return sysMajorVersion;
}

int NBSysMinorVersion()
{
    NSString *ver = [UIDevice currentDevice].systemVersion;
    NSArray *verAry = [ver componentsSeparatedByString:@"."];
    assert(([verAry count] >= 2));
    int sysMinorVersion = [(NSString *) [verAry objectAtIndex:1] intValue];
    return sysMinorVersion;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void NBAlert(NSString* message) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", @"")
                                                     message:message delegate:nil
                                           cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                           otherButtonTitles:nil];
    [alert show];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
void NBAlertNoTitle(NSString* message) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                           otherButtonTitles:nil];
    [alert show];
}

void NBAlertWithTitle(NSString *title, NSString *message)
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title
                                                     message:message delegate:nil
                                           cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                           otherButtonTitles:nil];
    [alert show];
}

CGRect NBApplicationFrame() {
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    return CGRectMake(0, 0, frame.size.width, frame.size.height);
}

// FIXME
CGRect NBApplicationFrameWithoutStatusBar() {
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    CGRect statusFrame = [UIApplication sharedApplication].statusBarFrame;
    return CGRectMake(0, statusFrame.size.height, frame.size.width, frame.size.height);
}


// Rect related
///////////////////////////////////////////////////////////////////////////////////////////////////
CGRect NBRectContract(CGRect rect, CGFloat dx, CGFloat dy) {
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - dx, rect.size.height - dy);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGRect NBRectShift(CGRect rect, CGFloat dx, CGFloat dy) {
    return CGRectOffset(NBRectContract(rect, dx, dy), dx, dy);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGRect NBRectInset(CGRect rect, UIEdgeInsets insets) {
    return CGRectMake(rect.origin.x + insets.left, rect.origin.y + insets.top,
                      rect.size.width - (insets.left + insets.right),
                      rect.size.height - (insets.top + insets.bottom));
}