//
//  XPADView.m
//  XPApp
//
//  Created by huangxinping on 15/10/25.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "XPADView.h"

@interface NSArray (ad_SafeOject)

- (id)ad_SafeObjectAtIndex:(NSUInteger)index;

@end

@implementation NSArray (ad_SafeOject)

- (id)ad_SafeObjectAtIndex:(NSUInteger)index {
    if ([self count] > 0 && [self count] > index)
        return [self objectAtIndex:index];
    else
        return nil;
}

@end

@interface XPADView ()<UIScrollViewDelegate>

@property (assign, nonatomic) BOOL                          isCircle;
@property (strong, nonatomic) UIScrollView                  *scrollview;
@property (assign, nonatomic) NSTimeInterval                timeInterval;
@property (strong, nonatomic) NSMutableArray                *unusedImageViewArray;
@property (strong, nonatomic) NSMutableArray                *usedImageViewArray;
@property (unsafe_unretained, nonatomic)  dispatch_source_t timer;
@property (strong, nonatomic)  UITapGestureRecognizer       *tapGestureRecognizer;
@property (readwrite, nonatomic) UIPageControl              *pageControl;

@end

@implementation XPADView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.isCircle    = YES;
        self.isWebImage  = YES;
        self.displayTime = 2;
        
        self.unusedImageViewArray = [NSMutableArray array];
        self.usedImageViewArray   = [NSMutableArray array];
        
        self.scrollview  = [[UIScrollView alloc]initWithFrame:CGRectZero];
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
        
        [self addSubview:self.scrollview];
        [self addSubview:self.pageControl];
        
        self.scrollview.delegate      = self;
        self.scrollview.scrollsToTop  = NO;
        self.scrollview.pagingEnabled = YES;
        [self.scrollview setShowsVerticalScrollIndicator:NO];
        [self.scrollview setShowsHorizontalScrollIndicator:NO];
        
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapGesture:)];
        [self.scrollview addGestureRecognizer:self.tapGestureRecognizer];
    }
    
    return self;
}

- (void)didTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (self.dataArray.count) {
        NSUInteger index = self.scrollview.contentOffset.x/self.scrollview.frame.size.width;
        if (self.isCircle) {
//            if (index == 0) {
//                index = self.dataArray.count - 1;
//            } else if (index == self.dataArray.count-1) {
//                index = 0;
//            } else {
                index -= 1;
//            }
        }
        
        NSString    *imagePath = [self.dataArray ad_SafeObjectAtIndex:index];
        UIImageView *imageView = [self.usedImageViewArray ad_SafeObjectAtIndex:index];
        if (self.selectedBlock) {
            self.selectedBlock(imageView, imagePath, index);
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(adView:didSelectedAtIndex:imageView:imagePath:)]) {
            [self.delegate adView:self didSelectedAtIndex:index imageView:imageView imagePath:imagePath];
        }
    }
}

- (void)setDataArray:(NSArray *)dataArray {
    if (dataArray == _dataArray && dataArray != nil) {
        return;
    }
    
    _dataArray = nil;
    _dataArray = dataArray;
    if (dataArray == nil) {
        self.scrollview.hidden = YES;
        
        return;
    } else {
        self.scrollview.hidden = NO;
    }
    
    [self.unusedImageViewArray addObjectsFromArray:self.usedImageViewArray ];
    [self.usedImageViewArray removeAllObjects];
    
    NSUInteger count = dataArray.count;
    self.pageControl.numberOfPages = (int)count;
    if (self.isCircle == YES) {
        count += 2;
    }
    
    for (NSUInteger i = 0; i < count; i++) {
        UIImageView *imageView = [self.unusedImageViewArray ad_SafeObjectAtIndex:i];
        if (imageView == nil) {
            imageView = [[UIImageView alloc]init];
        } else {
        }
        
        imageView.frame             = CGRectMake(i  * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        self.scrollview.contentSize = CGSizeMake((i +1)* self.frame.size.width, self.frame.size.height);
        [self.scrollview addSubview:imageView];
        [self.usedImageViewArray addObject:imageView];
        
        NSString *imagePath = [self.dataArray ad_SafeObjectAtIndex:i];
        if (self.isCircle) {
            if (i == 0) {
                imagePath = [self.dataArray lastObject];
            } else if (i == count-1) {
                imagePath = [self.dataArray firstObject];
            } else {
                imagePath = [self.dataArray ad_SafeObjectAtIndex:i-1];
            }
        }
        
        if (self.isWebImage) {
            imageView.image = self.defalutADImage;
            if (self.delegate && [self.delegate respondsToSelector:@selector(adView:lazyLoadAtIndex:imageView:imageURL:)]) {
                [self.delegate adView:self lazyLoadAtIndex:i imageView:imageView imageURL:imagePath];
            } else {
                imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]]];
            }
        } else {
            imageView.image = [UIImage imageNamed:imagePath];
        }
    }
    [self.unusedImageViewArray removeObjectsInArray:self.scrollview.subviews];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    if (_timeInterval == timeInterval) {
        return;
    }
    _timeInterval = timeInterval;
    
    __block int      timeout = timeInterval;
    dispatch_queue_t queue   = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), timeout*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
            });
        } else {
            if (self.scrollview.tracking) {
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.scrollview.contentOffset.x >= self.scrollview.contentSize.width) {
                    self.scrollview.contentOffset = CGPointZero;
                } else {
                    self.scrollview.contentOffset = CGPointMake(self.scrollview.contentOffset.x + self.scrollview.frame.size.width, 0);
                }
            });
        }
    });
    dispatch_resume(_timer);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isCircle) {
        int page = scrollView.contentOffset.x/scrollView.frame.size.width;
        if (page == self.dataArray.count+1) {
            page = 0;
        } else {
            page -= 1;
        }
        
        self.pageControl.currentPage = page;
        if (scrollView.contentOffset.x == 0) {
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width *self.dataArray.count, 0);
        } else if (scrollView.contentOffset.x == scrollView.frame.size.width *(self.dataArray.count+1)) {
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width *1, 0);
        }
    } else {
        int page = scrollView.contentOffset.x/scrollView.frame.size.width;
        self.pageControl.currentPage = page;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollview.frame  = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.pageControl.frame = CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30);
    
    NSUInteger count = self.usedImageViewArray.count;
    self.scrollview.contentSize = CGSizeMake(count * self.frame.size.width, self.frame.size.height);
    
    for (NSUInteger i = 0; i < count; i++) {
        UIImageView *imageView = [self.usedImageViewArray ad_SafeObjectAtIndex:i];
        if (imageView) {
            imageView.frame = CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        }
    }
}

- (void)perform {
    [self setTimeInterval:self.displayTime];
}

@end
