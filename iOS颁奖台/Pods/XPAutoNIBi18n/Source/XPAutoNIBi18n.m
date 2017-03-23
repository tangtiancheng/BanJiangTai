//
//  XPAutoNIBi18n.m
//  Huaban
//
//  Created by huangxinping on 4/23/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import "XPAutoNIBi18n.h"
//#import <Aspects/Aspects.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static const char _bundle = 0;

@interface BundleEx : NSBundle
@end

@implementation BundleEx

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    NSBundle *bundle = objc_getAssociatedObject(self, &_bundle);
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}

@end

@implementation NSBundle (Language)

+ (void)setLanguage:(NSString *)language
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      object_setClass([NSBundle mainBundle], [BundleEx class]);
                  });
    objc_setAssociatedObject([NSBundle mainBundle], &_bundle, language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

static inline NSString *localizedString(NSString *string
                                        );
static inline void localizedUIBarButtonItem(UIBarButtonItem *barButtonItem
                                            );
static inline void localizedUIBarItem(UIBarItem *barItem
                                      );
static inline void localizedUIButton(UIButton *button
                                     );
static inline void localizedUILabel(UILabel *label
                                    );
static inline void localizedUINavigationItem(UINavigationItem *navigationItem
                                             );
static inline void localizedUISearchBar(UISearchBar *searchBar
                                        );
static inline void localizedUISegmentedControl(UISegmentedControl *segmentedControl
                                               );
static inline void localizedUITextField(UITextField *textField
                                        );
static inline void localizedUITextView(UITextView *textView
                                       );
static inline void localizedUIViewController(UIViewController *viewController
                                             );

#define LocalizedIfClass(object, Cls) if([object isMemberOfClass:[Cls class]]) \
localized ## Cls((Cls *)object)

@interface NSObject (XPAutoNIBi18n)

- (void)localizeNibObject;

@end

@implementation NSObject (XPAutoNIBi18n)

- (void)localizeNibObject
{
    if([self isMemberOfClass:[UIBarButtonItem class]]) {
        localizedUIBarButtonItem((UIBarButtonItem *)self);
    } else if([self isMemberOfClass:[UIBarItem class]]) {
        localizedUIBarItem((UIBarItem *)self);
    } else if([self isMemberOfClass:[UIButton class]]) {
        localizedUIButton((UIButton *)self);
    } else if([self isMemberOfClass:[UILabel class]]) {
        localizedUILabel((UILabel *)self);
    } else if([self isMemberOfClass:[UINavigationItem class]]) {
        localizedUINavigationItem((UINavigationItem *)self);
    } else if([self isMemberOfClass:[UISearchBar class]]) {
        localizedUISearchBar((UISearchBar *)self);
    } else if([self isMemberOfClass:[UISegmentedControl class]]) {
        localizedUISegmentedControl((UISegmentedControl *)self);
    } else if([self isMemberOfClass:[UITextField class]]) {
        localizedUITextField((UITextField *)self);
    } else if([self isMemberOfClass:[UITextView class]]) {
        localizedUITextView((UITextView *)self);
    } else if([self isMemberOfClass:[UIViewController class]]) {
        localizedUIViewController((UIViewController *)self);
    }
    if(![self isKindOfClass:UITableView.class] && (self.isAccessibilityElement == YES)) {
        self.accessibilityLabel = localizedString(self.accessibilityLabel);
        self.accessibilityHint = localizedString(self.accessibilityHint);
    }
    
    [self localizeNibObject];
}

+ (void)load
{
    Method localizeNibObject = class_getInstanceMethod([NSObject class], @selector(localizeNibObject));
    Method awakeFromNib = class_getInstanceMethod([NSObject class], @selector(awakeFromNib));
    method_exchangeImplementations(awakeFromNib, localizeNibObject);
}

@end

static inline NSString *localizedString(NSString *string)
{
    if(!string || !string.length) {      // 如果nil或length为0，则直接返回
        return string;
    }
    if([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[string characterAtIndex:0]]) {      // 如果已数字开头的字符串
        return string;
    }
    // 只翻译[-????-]这种格式的字串
    if([string hasPrefix:@"[-"] && [string hasSuffix:@"-]"]) {
        string = [string substringWithRange:NSMakeRange(2, string.length - 4)];
        return _T(string);
    }
    
    return string;
}

static inline void localizedUIBarButtonItem(UIBarButtonItem *barButtonItem)
{
    localizedUIBarItem(barButtonItem);
    NSMutableSet *locTitles = [[NSMutableSet alloc] initWithCapacity:[barButtonItem.possibleTitles count]];
    for(NSString *str in barButtonItem.possibleTitles) {
        [locTitles addObject:localizedString(str)];
    }
    barButtonItem.possibleTitles = [NSSet setWithSet:locTitles];
}

static inline void localizedUIBarItem(UIBarItem *barItem)
{
    barItem.title = localizedString(barItem.title);
}

static inline void localizedUIButton(UIButton *button)
{
    NSString *title[4] = {
        [button titleForState:UIControlStateNormal],
        [button titleForState:UIControlStateHighlighted],
        [button titleForState:UIControlStateDisabled],
        [button titleForState:UIControlStateSelected]
    };
    [button setTitle:localizedString(title[0]) forState:UIControlStateNormal];
    if(title[1] == [button titleForState:UIControlStateHighlighted]) {
        [button setTitle:localizedString(title[1]) forState:UIControlStateHighlighted];
    }
    if(title[2] == [button titleForState:UIControlStateDisabled]) {
        [button setTitle:localizedString(title[2]) forState:UIControlStateDisabled];
    }
    if(title[3] == [button titleForState:UIControlStateSelected]) {
        [button setTitle:localizedString(title[3]) forState:UIControlStateSelected];
    }
}

static inline void localizedUILabel(UILabel *label)
{
    label.text = localizedString(label.text);
}

static inline void localizedUINavigationItem(UINavigationItem *navigationItem)
{
    navigationItem.title = localizedString(navigationItem.title);
    navigationItem.prompt = localizedString(navigationItem.prompt);
}

static inline void localizedUISearchBar(UISearchBar *searchBar)
{
    searchBar.placeholder = localizedString(searchBar.placeholder);
    searchBar.prompt = localizedString(searchBar.prompt);
    searchBar.text = localizedString(searchBar.text);
    
    NSMutableArray *locScopesTitles = [[NSMutableArray alloc] initWithCapacity:[searchBar.scopeButtonTitles count]];
    for(NSString *str in searchBar.scopeButtonTitles) {
        [locScopesTitles addObject:localizedString(str)];
    }
    searchBar.scopeButtonTitles = [NSArray arrayWithArray:locScopesTitles];
}

static inline void localizedUISegmentedControl(UISegmentedControl *segmentedControl)
{
    NSUInteger n = segmentedControl.numberOfSegments;
    for(NSUInteger idx = 0; idx < n; ++idx) {
        [segmentedControl setTitle:localizedString([segmentedControl titleForSegmentAtIndex:idx]) forSegmentAtIndex:idx];
    }
}

static inline void localizedUITextField(UITextField *textField)
{
    textField.text = localizedString(textField.text);
    textField.placeholder = localizedString(textField.placeholder);
}

static inline void localizedUITextView(UITextView *textView)
{
    textView.text = localizedString(textView.text);
}

static inline void localizedUIViewController(UIViewController *viewController)
{
    viewController.title = localizedString(viewController.title);
}

