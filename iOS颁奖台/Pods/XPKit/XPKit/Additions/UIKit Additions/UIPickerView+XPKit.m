//
//  UIPickerView+XPKit.m
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

#import "UIPickerView+XPKit.h"

typedef void (^XP_RowPickedBlock)(NSString *title);

static NSString *contentKeyPath = @"UIPickerViewKey";
static XP_RowPickedBlock _rowPickedBlock;

@implementation UIPickerView (XPKit)

+ (instancetype)pickerViewWithContent:(NSArray *)content
                           showInView:(UIView *)view
                      onShouldDismiss:(XP_RowPickedBlock)rowPickedBlock {
	_rowPickedBlock = [rowPickedBlock copy];

	UIPickerView *picker = [[UIPickerView alloc] init];
	picker.showsSelectionIndicator = YES;
	picker.dataSource = [self class];
	picker.delegate = [self class];

	[[NSUserDefaults standardUserDefaults] setObject:content forKey:contentKeyPath];
	[[NSUserDefaults standardUserDefaults] synchronize];

	return picker;
}

+ (NSArray *)content {
	return [[NSUserDefaults standardUserDefaults] objectForKey:contentKeyPath];
}

#pragma mark - pickerView delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [[UIPickerView content] count];
}

+ (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [[UIPickerView content] count];
}

+ (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [[UIPickerView content] objectAtIndex:row];
}

+ (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	_rowPickedBlock([[UIPickerView content] objectAtIndex:row]);
}

@end
