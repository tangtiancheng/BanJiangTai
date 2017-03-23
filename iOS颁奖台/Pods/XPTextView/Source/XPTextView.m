//
//  XPTextView.m
//  ShareMerge
//
//  Created by huangxp on 12-1-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "XPTextView.h"

#define PLACEHOLDER_HIDDE_APPEAR_ANIMATION_DURATION 0.1f

@interface NSString (XP_TextView_Extras)
- (NSTextAlignment)naturalTextAligment;
@end

@implementation NSString (XP_TextView_Extras)

/*
 * This is from here: http://stackoverflow.com/questions/18744447/autolayout-rtl-uilabel-text-alignment
 */
- (NSTextAlignment)naturalTextAligment
{
    if(self.length == 0) {
        return NSTextAlignmentNatural;
    }
    
    NSArray *tagschemes = [NSArray arrayWithObjects:NSLinguisticTagSchemeLanguage, nil];
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:tagschemes options:0];
    [tagger setString:self];
    NSString *language = [tagger tagAtIndex:0 scheme:NSLinguisticTagSchemeLanguage tokenRange:NULL sentenceRange:NULL];
    if([language rangeOfString:@"he"].location != NSNotFound || [language rangeOfString:@"ar"].location != NSNotFound) {
        return NSTextAlignmentRight;
    } else {
        return NSTextAlignmentLeft;
    }
}

@end

@interface XPTextView ()<UIScrollViewDelegate>

@end

@implementation XPTextView
{
    UILabel *_placeholderLabel;
    UILabel *_inputtingLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self _setup];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self _setup];
}

- (void)_setup
{
    self.font = [UIFont systemFontOfSize:13.f];
    //    [self setTextContainerInset:UIEdgeInsetsMake(0, 0, 100, 0)];
    self.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    if(!_placeholderColor) {
        _placeholderColor = [UIColor lightGrayColor];
    }
    if(!_placeholder) {
        _placeholder = @"";
    }
    if(0 == _maxInputLength) {
        _maxInputLength = INT_MAX;
    }
    
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
    [self addSubview:_placeholderLabel];
    [self sendSubviewToBack:_placeholderLabel];
    
    _inputtingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
    [self addSubview:_inputtingLabel];
    [self bringSubviewToFront:_inputtingLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    [self _updatePlaceholderLabel];
    [self _updateInputtingLabel];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)_updateInputtingLabel
{
    _inputtingLabel.hidden = !_showInputting;
    if(!_showInputting) {
        return;
    }
    if(INT_MAX == _maxInputLength) {
        return;
    }
    
    _inputtingLabel.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)self.text.length, (long)_maxInputLength];
}

- (void)_updatePlaceholderLabel
{
    if(self.text.length) {
        if(!_placeholderLabel.hidden) {
            [UIView animateWithDuration:PLACEHOLDER_HIDDE_APPEAR_ANIMATION_DURATION
                             animations:^{
                                 _placeholderLabel.alpha = 0.0;
                             }
                             completion:^(BOOL finished) {
                                 _placeholderLabel.hidden = YES;
                             }];
        }
    } else {
        [self _configPlaceholderLabel];
        _placeholderLabel.hidden = NO;
        _placeholderLabel.alpha = 0.0f;
        [UIView animateWithDuration:PLACEHOLDER_HIDDE_APPEAR_ANIMATION_DURATION
                         animations:^{
                             _placeholderLabel.alpha = 1.0;
                         }
                         completion:^(BOOL finished) {
                         }];
    }
}

- (void)textChanged:(NSNotification *)notification
{
    if(self.text.length >= _maxInputLength) {
        self.text = [self.text substringToIndex:_maxInputLength];
    }
    
    [self _updateInputtingLabel];
    if(self.placeholder.length == 0) {
        return;
    }
    
    [self _updatePlaceholderLabel];
}

- (CGRect)_placeholderRectForBounds:(CGRect)bounds
{
    CGRect rect = UIEdgeInsetsInsetRect(bounds, self.contentInset);
    if([self respondsToSelector:@selector(textContainer)]) {
        rect = UIEdgeInsetsInsetRect(rect, self.textContainerInset);
        CGFloat padding = self.textContainer.lineFragmentPadding;
        rect.origin.x += padding;
        rect.size.width -= padding * 2.0f;
    } else {
        if(self.contentInset.left == 0.0f) {
            rect.origin.x += 8.0f;
        }
        
        rect.origin.y += 8.0f;
    }
    
    return rect;
}

- (void)_configInputtingLabel
{
    _inputtingLabel.numberOfLines = 1;
    _inputtingLabel.font = self.font;
    _inputtingLabel.backgroundColor = [UIColor clearColor];
    _inputtingLabel.textColor = self.placeholderColor;
    _inputtingLabel.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)self.text.length, (long)_maxInputLength];
    _inputtingLabel.textAlignment = NSTextAlignmentRight;
    //    [_inputtingLabel sizeToFit];
    
    //    _inputtingLabel.frame = CGRectMake(0, self.bounds.size.height-self.font.lineHeight-5, self.bounds.size.width-8, self.font.lineHeight);
    _inputtingLabel.frame = CGRectMake(0, self.contentOffset.y+self.bounds.size.height-self.font.lineHeight, self.bounds.size.width-8, self.font.lineHeight);
}

- (void)_configPlaceholderLabel
{
    _placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _placeholderLabel.numberOfLines = 0;
    _placeholderLabel.font = self.font;
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    _placeholderLabel.textColor = self.placeholderColor;
    _placeholderLabel.text = self.placeholder;
    //    _placeholderLabel.textAlignment = [_placeholderLabel.text naturalTextAligment];
    _placeholderLabel.textAlignment = NSTextAlignmentLeft;
    [_placeholderLabel sizeToFit];
    
    CGRect rect = [self _placeholderRectForBounds:self.bounds];
    rect.size.height = _placeholderLabel.frame.size.height;
    _placeholderLabel.frame = rect;
}

- (void)setText:(NSString *)string
{
    [super setText:string];
    [self _updatePlaceholderLabel];
    [self _updateInputtingLabel];
}

- (void)setShowInputting:(BOOL)showInputting
{
    _showInputting = showInputting;
    [self _updateInputtingLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self _configPlaceholderLabel];
    [self _configInputtingLabel];
}

//- (void)insertText:(NSString *)string {
//    [super insertText:string];
//    [self _updatePlaceholderLabel];
//}
//
//
//- (void)setAttributedText:(NSAttributedString *)attributedText {
//    [super setAttributedText:attributedText];
//    [self _updatePlaceholderLabel];
//}

- (void)setPlaceholder:(NSString *)string
{
    if([string isEqual:_placeholder]) {
        return;
    }
    
    _placeholder = string;
    [self _updatePlaceholderLabel];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self _updatePlaceholderLabel];
}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    [super setContentInset:contentInset];
    [self _updatePlaceholderLabel];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self _updatePlaceholderLabel];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    [self _updatePlaceholderLabel];
}

- (void)setCursorToEnd
{
    NSUInteger length = self.text.length;
    
    self.selectedRange = NSMakeRange(length, 0);
}

@end
