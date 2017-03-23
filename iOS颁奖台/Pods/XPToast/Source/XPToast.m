/**
 *  XPToast.h
 *  huangxinping
 *
 *  Created by huangxp on 12-04-13.
 *
 *  toast提示
 *
 *  Copyright (c) 2012年 www.sharemerge.com. All rights reserved.
 */

/** @file */    // Doxygen marker

#import "XPToast.h"
#import <QuartzCore/QuartzCore.h>

#ifndef SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#endif

@implementation XPToast

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flipViewAccordingToStatusBarOrientation:) name:UIDeviceOrientationDidChangeNotification object:nil];
	}
	return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)show {
	__block typeof(self) weakSelf = self;

	[UIView animateWithDuration:0.3f
	                 animations: ^{
	    weakSelf.alpha = 1.0f;
	    weakSelf.transform = CGAffineTransformScale(weakSelf.transform, 1.0f, 1.0f);
	}

	                 completion: ^(BOOL finished) {
	    [weakSelf performSelector:@selector(hide)
	                   withObject:nil
	                   afterDelay:1];
	}];
}

- (void)hide {
	__block typeof(self) weakSelf = self;

	[UIView animateWithDuration:0.4f
	                 animations: ^{
	    weakSelf.alpha = 0.0f;
	    weakSelf.transform = CGAffineTransformScale(weakSelf.transform, 0.1f, 0.1f);
	}

	                 completion: ^(BOOL finished) {
	    [weakSelf removeFromSuperview];
	}];
}

+ (XPToast *)createWithText:(NSString *)text {
	UILabel *textLabel = [[UILabel alloc] init];
	textLabel.backgroundColor = [UIColor clearColor];
	textLabel.textAlignment = NSTextAlignmentCenter;
	textLabel.font = [UIFont systemFontOfSize:14];
	textLabel.textColor = [UIColor whiteColor];
	textLabel.numberOfLines = 0;
	textLabel.lineBreakMode = NSLineBreakByCharWrapping;
	textLabel.text = text;

	CGSize size = CGSizeZero;
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
		NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
		                            textLabel.font, NSFontAttributeName,
		                            [NSParagraphStyle defaultParagraphStyle], NSParagraphStyleAttributeName,
		                            nil];
		CGRect rect = [textLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 50) options:NSLineBreakByWordWrapping | NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
		size.width = rect.size.width;
		size.height = rect.size.height;
	}
	else {
		size = [textLabel.text sizeWithFont:textLabel.font forWidth:MAXFLOAT lineBreakMode:NSLineBreakByWordWrapping];
	}
	if (size.width < 50) {
		size.width = 50;
	}
	if (size.height < 20) {
		size.height = 20;
	}
	XPToast *toast = [[XPToast alloc] initWithFrame:CGRectMake(0, 0, size.width + 30, size.height + 30)];
	toast.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8f];
	CALayer *layer = toast.layer;
	layer.masksToBounds = YES;
	layer.cornerRadius = 5.0f;

	textLabel.frame = CGRectMake(5, 5, toast.bounds.size.width - 10, toast.bounds.size.height - 10);
	[toast addSubview:textLabel];


	toast.alpha = 0.0f;
	return toast;
}

- (void)flipViewAccordingToStatusBarOrientation:(id)sender {
	float angle = 0.0f;
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
	CGSize screenSize = [UIScreen mainScreen].bounds.size;
	float x = 0.0f, y = 0.0f;
	switch (orientation) {
		case UIInterfaceOrientationPortraitUpsideDown:
		{
			angle = M_PI;
			break;
		}

		case UIInterfaceOrientationLandscapeLeft:
		{
			angle = -M_PI / 2.0f;
			x = screenSize.width / 2.0f;
			y = screenSize.height / 2.0f;
			break;
		}

		case UIInterfaceOrientationLandscapeRight:
		{
			angle = M_PI / 2.0f;
			x = screenSize.width / 2.0f;
			y = screenSize.height / 2.0f;
			break;
		}

		default:
		{
			angle = 0.0;
			x = screenSize.width / 2.0f;
			y = screenSize.height / 2.0f;
			break;
		}
	}

	float duration = 0.3f;
	if ([sender isKindOfClass:[NSNumber class]]) {
		BOOL type = [(NSNumber *)sender boolValue];
		if (!type) {
			duration = 0.0f;
		}
	}
	[UIView animateWithDuration:duration animations: ^{
	    self.center = CGPointMake(x, y);
	    self.transform = CGAffineTransformMakeRotation(angle);
	} completion: ^(BOOL finished) {
	}];
}

+ (void)showWithText:(NSString *)text {
	XPToast *toast = [XPToast createWithText:text];
	UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
	if (!mainWindow) {
		mainWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	}
	[mainWindow addSubview:toast];
	[toast flipViewAccordingToStatusBarOrientation:@(NO)];
	[toast show];
}

@end
