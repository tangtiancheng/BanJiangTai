//
//  calendarView.m
//  XPApp
//
//  Created by Pua on 16/3/22.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "calendarView.h"
#import "dateTool.h"
@implementation calendarView
{
    UIButton *_selectButton;
    NSMutableArray *_daysArray;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _daysArray = [NSMutableArray arrayWithCapacity:12];
        for (int i = 0 ; i < 42; i++) {
            UIButton *button = [[UIButton alloc]init];
            [self addSubview:button];
            [_daysArray addObject:button];
        }
    }
    return self;
}
#pragma mark - create View
-(void)setDate:(NSDate *)date
{
    _date = date;
    [self createCalendarViewWith:date withModel:_model];
}
-(void)createCalendarViewWith:(NSDate *)date withModel:(XPMainSignInModel *)model
{
    self.layer.cornerRadius = 10;
    
//    CGFloat itemW  =  39;
//    CGFloat itemH  =  33;
    UIImageView *headBgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"calendar_head"]];
    headBgView.frame = CGRectMake(0, 0, self.frame.size.width, 45);
    [self addSubview:headBgView];
    //year month
    
    UILabel *headLabel = [[UILabel alloc]init];
    headLabel.text = [NSString stringWithFormat:@"签到成功!今日领取"];
    headLabel.font = [UIFont systemFontOfSize:12];
    headLabel.textColor = RGBA(249, 237, 138, 1);
    headLabel.textAlignment = NSTextAlignmentLeft;
    [headBgView addSubview:headLabel];
    UILabel *CoinLabel = [[UILabel alloc]init];
    CoinLabel.font = [UIFont boldSystemFontOfSize:12];
    CoinLabel.text = model.dayGolds;
    CoinLabel.textColor = RGBA(211, 255, 61, 1);
    [headBgView addSubview:CoinLabel];
    UILabel *textLable =[[UILabel alloc]init];
    textLable.text = @"个奖金币";
    textLable.font = [UIFont systemFontOfSize:12];
    textLable.textColor = RGBA(249, 237, 138, 1);
    [headBgView addSubview:textLable];
    UIView* headBackView=[[UIView alloc]init];
    [headBgView addSubview:headBackView];
    [headBackView addSubview:headLabel];
    [headBackView addSubview:CoinLabel];
    [headBackView addSubview:textLable];
    
    
    [headBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headBgView.mas_centerX);
        make.top.mas_equalTo(headBgView.mas_top);
        
        make.height.equalTo(@45);
    }];
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headBackView.mas_top);
        make.left.mas_equalTo(headBackView.mas_left);
        make.bottom.mas_equalTo(headBackView.mas_bottom);
//        make.right.equalTo(CoinLabel.mas_left);
    }];
    [CoinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headLabel.mas_right);
        make.top.mas_equalTo(headBackView.mas_top);
        make.bottom.mas_equalTo(headBackView.mas_bottom);
    }];
    [textLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headBackView.mas_top);
        make.bottom.mas_equalTo(headBackView.mas_bottom);
        make.left.mas_equalTo(CoinLabel.mas_right);
        make.right.mas_equalTo(headBackView.mas_right);
    }];
 
    /**
     10天签到
     */
    
    if ([model.isContinuous isEqualToString:@"Y"]) {
        UIView* backView=[[UIView alloc]init];
      
        
        
        UILabel *footlabel = [[UILabel alloc]init];
        footlabel.text = [NSString stringWithFormat: @"您已连续签到"];
        footlabel.font = [UIFont systemFontOfSize:12];
        
//        footlabel.frame = CGRectMake(50, 298, 80, 30);
        footlabel.textColor = RGBA(209, 87, 6, 1);
//        footlabel.textAlignment = NSTextAlignmentLeft;
        UILabel *dateLabel = [[UILabel alloc]init];
//        dateLabel.frame = CGRectMake(126, 306, 24, 30);
        dateLabel.backgroundColor = [UIColor redColor];
//        dateLabel.textAlignment = NSTextAlignmentLeft;
        dateLabel.textColor = RGBA(211, 255, 61, 1);
        dateLabel.text =[NSString stringWithFormat:@" %@ ", model.continuousDays];
        dateLabel.font = [UIFont systemFontOfSize:12];
        dateLabel.backgroundColor=RGBA(255, 94, 92, 1);
        dateLabel.layer.masksToBounds=YES;
        dateLabel.layer.cornerRadius=3;
        
        UILabel *footTextLabel = [[UILabel alloc]init];
        footTextLabel.text = [NSString stringWithFormat: @"天,再获得%@个奖金币",model.continuousGolds];
//        footTextLabel.frame = CGRectMake(150, 306, 150, 30);
        footTextLabel.textColor = RGBA(209, 87, 6, 1);
        footTextLabel.font = [UIFont systemFontOfSize:12];
       
        
        
      
        
        [self addSubview:backView];
        
        [backView addSubview:footTextLabel];
        [backView addSubview:dateLabel];
        [backView addSubview:footlabel];
       
        //backView约束
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).with.offset(298);
            
            make.height.equalTo(@20);
        }];
        [footlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(backView.mas_top);
            make.bottom.mas_equalTo(backView.mas_bottom);
            make.left.mas_equalTo(backView.mas_left);
        }];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(backView.mas_top);
            make.bottom.mas_equalTo(backView.mas_bottom);
            make.left.mas_equalTo(footlabel.mas_right);
        }];
        [footTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(backView.mas_top);
            make.bottom.mas_equalTo(backView.mas_bottom);
            make.left.mas_equalTo(dateLabel.mas_right);
            make.right.mas_equalTo(backView.mas_right);
        }];
        

        
        
        UILabel *footFightLabel = [[UILabel alloc]init];
        footFightLabel.text = @"继续加油哦！";
        footFightLabel.frame = CGRectMake(0, 326, self.frame.size.width, 12);
        footFightLabel.textColor = RGBA(209, 87, 6, 1);
        footFightLabel.textAlignment = NSTextAlignmentCenter;
        footFightLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:footFightLabel];
        
    }else{
//        UILabel*footLabel = [[UILabel alloc]init];
//        footLabel.text = [NSString stringWithFormat:@"您已连续签到%@天",model.continuousDays];
//        footLabel.textColor = RGBA(209, 87, 6, 1);
//        footLabel.frame = CGRectMake(85, 298, 150, 30);
//        footLabel.textAlignment = NSTextAlignmentLeft;
//        footLabel.font = [UIFont systemFontOfSize:12];

        UIView* backView=[[UIView alloc]init];
        
        
        
        UILabel *footlabel = [[UILabel alloc]init];
        footlabel.text = [NSString stringWithFormat: @"您已连续签到"];
        footlabel.font = [UIFont systemFontOfSize:12];
        
        //        footlabel.frame = CGRectMake(50, 298, 80, 30);
        footlabel.textColor = RGBA(209, 87, 6, 1);
        //        footlabel.textAlignment = NSTextAlignmentLeft;
        UILabel *dateLabel = [[UILabel alloc]init];
        //        dateLabel.frame = CGRectMake(126, 306, 24, 30);
        dateLabel.backgroundColor = [UIColor redColor];
        //        dateLabel.textAlignment = NSTextAlignmentLeft;
        dateLabel.textColor = RGBA(211, 255, 61, 1);
        dateLabel.text =[NSString stringWithFormat:@" %@ ",  model.continuousDays];
        dateLabel.font = [UIFont systemFontOfSize:12];
        dateLabel.backgroundColor=RGBA(255, 94, 92, 1);
        dateLabel.layer.masksToBounds=YES;
        dateLabel.layer.cornerRadius=3;
        
        UILabel *footTextLabel = [[UILabel alloc]init];
        footTextLabel.text =  @"天";
        //        footTextLabel.frame = CGRectMake(150, 306, 150, 30);
        footTextLabel.textColor = RGBA(209, 87, 6, 1);
        footTextLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:backView];
        [backView addSubview:footlabel];
        [backView addSubview:footTextLabel];
        [backView addSubview:dateLabel];
        //backView约束
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).with.offset(298);
            
            make.height.equalTo(@20);
        }];
        [footlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(backView.mas_top);
            make.bottom.mas_equalTo(backView.mas_bottom);
            make.left.mas_equalTo(backView.mas_left);
        }];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(backView.mas_top);
            make.bottom.mas_equalTo(backView.mas_bottom);
            make.left.mas_equalTo(footlabel.mas_right);
        }];
        [footTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(backView.mas_top);
            make.bottom.mas_equalTo(backView.mas_bottom);
            make.left.mas_equalTo(dateLabel.mas_right);
            make.right.mas_equalTo(backView.mas_right);
        }];
        

//        UILabel *dateLabel = [[UILabel alloc]init];
        //暂时删除
//        dateLabel.text=model.continuousDays;
//        dateLabel.textColor = RGBA(211, 255, 61, 1);
//        dateLabel.font = [UIFont systemFontOfSize:12];
//        dateLabel.textAlignment = NSTextAlignmentLeft;
//        dateLabel.frame = CGRectMake(200, 298, 30, 12);
        UILabel *footTextLableF = [[UILabel alloc]init];
        footTextLableF.text = [NSString stringWithFormat: @"连续签到%@天可在活动%@个奖金币",model.continuousTotalDays,model.continuousGolds];
        footTextLableF.frame = CGRectMake(0, 326, self.frame.size.width, 12);
        footTextLableF.textAlignment = NSTextAlignmentCenter;
        footTextLableF.textColor = RGBA(209, 87, 6, 1);
        footTextLableF.font = [UIFont systemFontOfSize:12];
        [self addSubview:footTextLableF];
        
//        [self addSubview:footLabel];
//        [self addSubview:dateLabel];
    }
  
    
    //weekday
    NSArray *array = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    UIView *weekBg = [[UIView alloc]init];
    weekBg.layer.borderWidth = 1;
    weekBg.layer.borderColor = RGBA(227, 227, 227, 1).CGColor;
    weekBg.backgroundColor = RGBA(242, 242, 241, 1);
    weekBg.frame = CGRectMake(15, 60,self.frame.size.width-30 ,35);
    [self addSubview:weekBg];
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc]init];
        
        week.text = array[i];
        week.font = [UIFont systemFontOfSize:14];
        week.frame = CGRectMake(weekBg.width/7*i, 0, weekBg.width/7, 32);
        week.textAlignment = NSTextAlignmentCenter;
        week.backgroundColor = [UIColor clearColor];
        
        week.textColor = [UIColor blackColor];
        [weekBg addSubview:week];
    }
    CGFloat itemW=(self.width-30)/7;
    CGFloat itemH=33;
    for (int i = 0; i < 42; i++) {
        
        int x = (i % 7)*itemW;
        int y = (i / 7)*itemH +CGRectGetMaxY(weekBg.frame);
        UIButton *dayButton = _daysArray[i];
        dayButton.frame = CGRectMake(x+15, y, itemW, itemH);
        dayButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        dayButton.layer.cornerRadius = 5.0f;
        dayButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [dayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [dayButton addTarget:self action:@selector(logDate:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger daysInLastMonth = [dateTool totaldaysInMonth:[dateTool lastMonth:date]];
        NSInteger daysInThisMonth = [dateTool totaldaysInMonth:date];
        NSInteger firstWeekDay = [dateTool firstWeekdayInThisMonth:date];
        NSInteger day = 0;
        if (i < firstWeekDay) {
            day = daysInLastMonth - firstWeekDay + i + 1;
            [self setStyle_BeyondThisMonth:dayButton with:day];
        }else if (i > firstWeekDay + daysInThisMonth - 1){
            day = i + 1 - firstWeekDay - daysInThisMonth;
            [self setStyle_BeyondThisMonth:dayButton with:day];
        }else{
            day = i - firstWeekDay + 1;
            [self setStyle_AfterToday:dayButton];
        }
        [dayButton setTitle:[NSString stringWithFormat:@"%li",day] forState:UIControlStateNormal];
        if ([dateTool month:date] == [dateTool month:[NSDate date]]) {
            NSInteger todayIndex = [dateTool day:date] + firstWeekDay - 1;
            if (i < todayIndex && i >= firstWeekDay) {
                [self setstyle_BeforeToday:dayButton];
                [self setSign:i andBtn:dayButton];
            }else if (i == todayIndex){
                [self setStyle_Today:dayButton];
                _dayButton = dayButton;
                
            }
        }
    }
}

#pragma mark 设置已经签到
-(void)setSign:(int)i andBtn:(UIButton *)dayButton
{
    [_signArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        int now = i-4+1;
        int now2 = [obj intValue];
        if (now2 == now) {
            [self setStyle_SignEd:dayButton];
        }
    }];
    
    
}

#pragma mark - output date
-(void)logDate:(UIButton *)dayBtn
{
    _selectButton.selected = NO;
    dayBtn.selected = YES;
    _selectButton = dayBtn;
    NSInteger day = [[dayBtn titleForState:UIControlStateNormal]integerValue];
    NSDateComponents *comp = [[NSCalendar currentCalendar]components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self.date];
    if (self.calendarBlock) {
        self.calendarBlock(day,[comp month],[comp year]);
    }
    
}
#pragma mark - date button style
//设置不是本月的日期字体颜色   ---白色  看不到
-(void)setStyle_BeyondThisMonth:(UIButton *)btn with:(NSInteger)day
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    for (int i = 0; i<_lastMonthSingDaysArr.count; i++) {
        NSInteger lastM = [_lastMonthSingDaysArr[i] integerValue];
        if (day+1 == lastM) {
            UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"calendar_check"]];
            image.frame = CGRectMake(10, 12, 20, 20);
            [btn addSubview:image];
            [btn setBackgroundColor:[UIColor whiteColor]];
        }
    }
}
//这个月 今日之前的日期style
-(void)setstyle_BeforeToday:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
}
//今日已签到
-(void)setStyle_Today_Signed:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"calendar_check"]];
    image.frame = CGRectMake(10, 12, 20, 20);
    [btn addSubview:image];
    [btn setBackgroundColor:[UIColor whiteColor]];

}
//今日没签到
-(void)setStyle_Today:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"calendar_check"]];
    image.frame = CGRectMake(10, 12, 20, 20);
    [btn addSubview:image];
    [btn setBackgroundColor:[UIColor whiteColor]];
    
}
//这个月 今天之后的日期style
-(void)setStyle_AfterToday:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

//已经签过的 日期style
- (void)setStyle_SignEd:(UIButton *)btn
{
//    btn.enabled = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"calendar_check"]];
    image.frame = CGRectMake(10, 12, 20, 20);
    [btn addSubview:image];
//    [btn setBackgroundColor:[UIColor whiteColor]];
}

@end
