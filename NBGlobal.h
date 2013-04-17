//
//  GSYGlobal.h
//  GouShenYang
//
//  Created by zhuangyanjun on 13/11/12.
//  Copyright (c) 2012年 Xu Hui. All rights reserved.
//

#import <Foundation/Foundation.h>

// Global Functions
BOOL NBIsPad();
BOOL NBIsDevice4Inches();
int NBSysMajorVersion();
int NBSysMinorVersion();

void NBAlert(NSString* message);
void NBAlertNoTitle(NSString* message);
void NBAlertWithTitle(NSString *title, NSString *message);

CGRect NBApplicationFrame();
CGRect NBApplicationFrameWithoutStatusBar();

// ***************************** Device Utils ******************************
#define IS_WIDESCREEN   ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE       ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])
#define IS_IPHONE5      (IS_IPHONE && IS_WIDESCREEN)

// ***************************** Color Utils *******************************
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]
#define gDefaultTableCellSeparatorColor RGBCOLOR(224, 224, 224)

// **************************** Directory Utils ****************************
#define NBDocumentDirectoryURL (NSURL *)[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]
#define NBAssetDirectoryURL NBDocumentDirectoryURL


// ***************************** Array Utils *******************************
#define countof(x) (sizeof(x)/sizeof(x[0]))

// ************************** String Localization **************************
#define LANG(x) NSLocalizedString(x, x)

// ************************** JSON-Object Mapping **************************
#define DECLARE_MAPPING(mapping)    +(NSMutableDictionary *) mapping;
#define BEGIN_MAPPING()             +(NSMutableDictionary *) mapping {return [NSMutableDictionary dictionaryWithObjectsAndKeys:
#define ITEM_MAPPING(jsonKey, attrKey, attrClass)   [attrClass mappingWithKey:attrKey], jsonKey,
#define ITEM_MAPPING2(key, attrClass)   ITEM_MAPPING(key, key, attrClass)
#define FAST_MAPPING(jsonKey, attrKey)  attrKey,jsonKey,
#define END_MAPPING()               nil];}

/**
 * The standard duration length for a transition.
 * @const 0.3 seconds
 */
extern const CGFloat nbkDefaultTransitionDuration;

// Macro
#define NB_TRANSITION_DURATION      nbkDefaultTransitionDuration

// Rect related
/**
 * @return a rectangle with dx and dy subtracted from the width and height, respectively.
 *
 * Example result: CGRectMake(x, y, w - dx, h - dy)
 */
CGRect NBRectContract(CGRect rect, CGFloat dx, CGFloat dy);

/**
 * @return a rectangle whose origin has been offset by dx, dy, and whose size has been
 * contracted by dx, dy.
 *
 * Example result: CGRectMake(x + dx, y + dy, w - dx, h - dy)
 */
CGRect NBRectShift(CGRect rect, CGFloat dx, CGFloat dy);

/**
 * @return a rectangle with the given insets.
 *
 * Example result: CGRectMake(x + left, y + top, w - (left + right), h - (top + bottom))
 */
CGRect NBRectInset(CGRect rect, UIEdgeInsets insets);