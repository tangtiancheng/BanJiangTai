//
//  XPDatePicker.h
//  Yang
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XPDatePicker;

typedef enum{
    
    UUDateStyle_YearMonthDayHourMinute = 0,
    UUDateStyle_YearMonthDay,
    UUDateStyle_MonthDayHourMinute,
    UUDateStyle_HourMinute
    
}DateStyle;

typedef void (^FinishBlock)(NSString * year,
                            NSString * month,
                            NSString * day,
                            NSString * hour,
                            NSString * minute,
                            NSString * weekDay);


//  说明，XPDatePicker的Size最小是320x216的。
@protocol XPDatePickerDelegate <NSObject>

- (void)XPDatePicker:(XPDatePicker *)datePicker
                year:(NSString *)year
               month:(NSString *)month
                 day:(NSString *)day
                hour:(NSString *)hour
              minute:(NSString *)minute
             weekDay:(NSString *)weekDay;
@end


@interface XPDatePicker : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, assign) id <XPDatePickerDelegate> delegate;

@property (nonatomic, assign) DateStyle datePickerStyle;

@property (nonatomic, retain) NSDate *scrollToDate;//滚到指定日期
@property (nonatomic, retain) NSDate *maxLimitDate;//限制最大时间（没有设置默认2049）
@property (nonatomic, retain) NSDate *minLimitDate;//限制最小时间（没有设置默认1970）

- (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
- (id)initWithframe:(CGRect)frame Delegate:(id<XPDatePickerDelegate>)delegate PickerStyle:(DateStyle)uuDateStyle;
- (id)initWithframe:(CGRect)frame PickerStyle:(DateStyle)uuDateStyle didSelected:(FinishBlock)finishBlock;

@end
