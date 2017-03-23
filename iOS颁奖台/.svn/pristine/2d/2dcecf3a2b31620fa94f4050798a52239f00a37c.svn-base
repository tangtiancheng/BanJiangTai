//
//  UIApplication+XPKit.m
//  XPKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 - 2015 Fabrizio Brancati. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "UIApplication+XPKit.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "UIDevice+XPKit.h"

@implementation UIApplication (XPKit)

+ (NSString *)applicationName {
	NSString *result = nil;

	result = [UIApplication nameForBundle:[NSBundle mainBundle]];
	return result;
}

+ (CGRect)referenceBounds {
	CGRect bounds = [[UIScreen mainScreen] bounds]; // portrait bounds

	if ([UIDevice isiPad]) {
		if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
			bounds.size = CGSizeMake(bounds.size.height, bounds.size.width);
		}
	}

	return bounds;
}

+ (NSString *)nameForBundle:(NSBundle *)bundle {
	NSString *result = nil;

	if (bundle != nil) {
		UIApplication *application = [UIApplication sharedApplication];
		// Use the bundle path as the key for associated storage
		NSString *bundleKey = [bundle bundlePath];
		result = objc_getAssociatedObject(application, (__bridge const void *)(bundleKey));

		if (result == nil) {
			NSDictionary *bundleInfo = [bundle infoDictionary];
			result = [bundleInfo objectForKey:@"CFBundleName"];
			objc_setAssociatedObject(application, (__bridge const void *)(bundleKey), result, OBJC_ASSOCIATION_RETAIN);
		}
	}

	return result;
}

+ (NSString *)applicationVersion {
	NSString *result = [UIApplication versionForBundle:[NSBundle mainBundle]];

	return result;
}

+ (NSString *)versionForBundle:(NSBundle *)bundle {
	NSString *result = nil;

	if (bundle != nil) {
#if TARGET_OS_IPHONE
		UIApplication *application = [UIApplication sharedApplication];
#else
		NSApplication *application = [NSApplication sharedApplication];
#endif
		// Use the bundle path as the key for associated storage
		NSString *bundleKey = [bundle bundlePath];
		result = objc_getAssociatedObject(application, (__bridge const void *)(bundleKey));

		if (result == nil) {
			// We don't have the value, look it up from the bundle info dictionary.
			NSDictionary *bundleInfo = nil;
			NSString *appVersion = nil;
			bundleInfo = [bundle infoDictionary];
			appVersion = [bundleInfo objectForKey:@"CFBundleShortVersionString"];

			if (appVersion != nil) {
				appVersion = [bundleInfo objectForKey:@"CFBundleVersion"];
			}

			result = appVersion;
			objc_setAssociatedObject(application, (__bridge const void *)(bundleKey), result, OBJC_ASSOCIATION_RETAIN);
		}
	}

	return result;
}

+ (NSString *)applicationIdentifier {
	NSString *result = nil;

	result = [UIApplication identifierForBundle:[NSBundle mainBundle]];
	return result;
}

+ (NSString *)identifierForBundle:(NSBundle *)bundle {
	NSString *result = nil;

	if (bundle != nil) {
		UIApplication *application = [UIApplication sharedApplication];
		// Use the bundle path as the key for associated storage
		NSString *bundleKey = [bundle bundlePath];
		result = objc_getAssociatedObject(application, (__bridge const void *)(bundleKey));

		if (result == nil) {
			result = [bundle bundleIdentifier];
			objc_setAssociatedObject(application, (__bridge const void *)(bundleKey), result, OBJC_ASSOCIATION_RETAIN);
		}
	}

	return result;
}

- (UIView *)keyboardView {
	NSArray *windows = [self windows];

	for (UIWindow *window in[windows reverseObjectEnumerator]) {
		for (UIView *view in[window subviews]) {
			if (!strcmp(object_getClassName(view), "UIKeyboard")) {
				return view;
			}
		}
	}

	return nil;
}

- (void)setApplicationStyle:(UIStatusBarStyle)style animated:(BOOL)animated {
	[self setApplicationStyle:style animated:animated defaultBackgroundColor:[UIColor whiteColor]];
}

- (void)setApplicationStyle:(UIStatusBarStyle)style animated:(BOOL)animated defaultBackgroundColor:(UIColor *)defaultBackgroundColor {
	[self setStatusBarStyle:style animated:animated];
	UIColor *newBackgroundColor = style == UIStatusBarStyleDefault ? defaultBackgroundColor : [UIColor blackColor];
	UIColor *oldBackgroundColor = style == UIStatusBarStyleDefault ? [UIColor blackColor] : defaultBackgroundColor;

	if (animated) {
		[CATransaction setValue:[NSNumber numberWithFloat:0.3f] forKey:kCATransactionAnimationDuration];
		CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
		fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
		fadeAnimation.fromValue = (id)oldBackgroundColor.CGColor;
		fadeAnimation.toValue = (id)newBackgroundColor.CGColor;
		fadeAnimation.fillMode = kCAFillModeForwards;
		fadeAnimation.removedOnCompletion = NO;
		[self.keyWindow.layer addAnimation:fadeAnimation forKey:@"fadeAnimation"];
		[CATransaction commit];
	}
	else {
		self.keyWindow.backgroundColor = newBackgroundColor;
	}
}

- (void)sendSock {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (BOOL)isJailbroken {
	BOOL jailbroken = NO;
	NSString *cydiaPath = @"/Applications/Cydia.app";
	NSString *aptPath = @"/private/var/lib/apt/";

	if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
		jailbroken = YES;
	}

	if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
		jailbroken = YES;
	}

	return jailbroken;
}

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)urlPath {
	if (![[NSFileManager defaultManager] fileExistsAtPath:[urlPath path]]) {
		return NO;
	}

	NSError *error = nil;
	BOOL success = [urlPath setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
	return success;
}

- (void)registerApplicationBackgroundRun {
	UIApplication *app = [UIApplication sharedApplication];

	__block UIBackgroundTaskIdentifier bgTask;

	bgTask = [app beginBackgroundTaskWithExpirationHandler: ^{
	    [app endBackgroundTask:bgTask];
	    bgTask = UIBackgroundTaskInvalid;
	}];

	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	    dispatch_async(dispatch_get_main_queue(), ^{
	        [app endBackgroundTask:bgTask];
	        bgTask = UIBackgroundTaskInvalid;
		});
	});
}

- (void)setIdleDisable:(BOOL)disable {
	[[UIApplication sharedApplication] setIdleTimerDisabled:disable];
}

@end
