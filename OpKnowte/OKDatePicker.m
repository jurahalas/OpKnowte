//
//  OKDatePicker.m
//  OpKnowte
//
//  Created by Eugene on 05.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKDatePicker.h"
#import "OKConstants.h"
const NSUInteger NUM_COMPONENTS = 3;

typedef enum {
    kSBDatePickerInvalid = 0,
    kSBDatePickerYear,
    kSBDatePickerMonth,
    kSBDatePickerDay
} SBDatePickerComponent;

@interface OKDatePicker () <UIPickerViewDataSource, UIPickerViewDelegate> {
    SBDatePickerComponent _components[NUM_COMPONENTS];
}

@property (nonatomic, strong, readwrite) NSCalendar *calendar;
@property (nonatomic, strong, readwrite) UIPickerView *picker;

@property (nonatomic, strong, readwrite) NSDateFormatter *dateFormatter;

@property (nonatomic, strong, readwrite) NSDateComponents *currentDateComponents;

@property (nonatomic, strong, readwrite) UIFont *font;

@property (nonatomic, strong) UIColor *textColor;

@end

@implementation OKDatePicker

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (!self) {
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (!self) {
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit {
    if (IS_IOS7) {
        self.tintColor = [UIColor whiteColor];
    }
    
    self.font = [UIFont systemFontOfSize:23.0f];
    self.textColor = [UIColor blackColor];
    
    self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [self setLocale:[NSLocale currentLocale]];
    
    self.picker = [[UIPickerView alloc] initWithFrame:self.bounds];
    self.picker.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.picker.dataSource = self;
    self.picker.delegate = self;
    if (IS_IOS7) {
        self.picker.tintColor = [UIColor whiteColor];
    }
    
    self.date = [NSDate date];
    
    [self addSubview:self.picker];
}

- (void)dealloc {
    self.calendar = nil;
    self.dateFormatter = nil;
    self.currentDateComponents = nil;
    
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(320.0f, 216.0f);
}

#pragma mark - Setup

- (void)setMinimumDate:(NSDate *)minimumDate {
    
    _minimumDate = minimumDate;
    [self updateComponents];
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    
    _maximumDate = maximumDate;
    [self updateComponents];
}

- (void)setDate:(NSDate *)date {
    [self setDate:date animated:NO];
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated {
    self.currentDateComponents = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                  fromDate:date];
    
    [self.picker reloadAllComponents];
    [self setIndicesAnimated:YES];
}

- (NSDate *)date {
    return [self.calendar dateFromComponents:self.currentDateComponents];
}

- (void)setLocale:(NSLocale *)locale {
    self.calendar.locale = locale;
    
    [self updateComponents];
}

- (SBDatePickerComponent)componentFromLetter:(NSString *)letter {
    if ([letter isEqualToString:@"y"]) {
        return kSBDatePickerYear;
    }
    else if ([letter isEqualToString:@"m"]) {
        return kSBDatePickerMonth;
    }
    else if ([letter isEqualToString:@"d"]) {
        return kSBDatePickerDay;
    }
    else {
        return kSBDatePickerInvalid;
    }
}

- (SBDatePickerComponent)thirdComponentFromFirstComponent:(SBDatePickerComponent)component1
                                       andSecondComponent:(SBDatePickerComponent)component2 {
    
    NSMutableIndexSet *set = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(kSBDatePickerInvalid + 1, NUM_COMPONENTS)];
    [set removeIndex:component1];
    [set removeIndex:component2];
    
    return (SBDatePickerComponent) [set firstIndex];
}

- (void)updateComponents {
    NSString *componentsOrdering = [NSDateFormatter dateFormatFromTemplate:@"yMMMMd" options:0 locale:self.calendar.locale];
    componentsOrdering = [componentsOrdering lowercaseString];
    
    NSString *firstLetter = [componentsOrdering substringToIndex:1];
    NSString *lastLetter = [componentsOrdering substringFromIndex:(componentsOrdering.length - 1)];
    
    _components[0] = [self componentFromLetter:firstLetter];
    _components[2] = [self componentFromLetter:lastLetter];
    _components[1] = [self thirdComponentFromFirstComponent:_components[0] andSecondComponent:_components[2]];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.calendar = self.calendar;
    self.dateFormatter.locale = self.calendar.locale;
    
    [self.picker reloadAllComponents];
    
    [self setIndicesAnimated:NO];
}

- (void)setIndexForComponentIndex:(NSUInteger)componentIndex animated:(BOOL)animated {
    SBDatePickerComponent component = [self componentForIndex:componentIndex];
    NSRange unitRange = [self rangeForComponent:component];
    
    NSInteger value;
    
    if (component == kSBDatePickerYear) {
        value = self.currentDateComponents.year;
    }
    else if (component == kSBDatePickerMonth) {
        value = self.currentDateComponents.month;
    }
    else if (component == kSBDatePickerDay) {
        value = self.currentDateComponents.day;
    }
    else {
        assert(NO);
    }
    
    NSInteger index = (value - unitRange.location);
    NSInteger middleIndex = (INT16_MAX / 2) - (INT16_MAX / 2) % unitRange.length + index;
    
    [self.picker selectRow:middleIndex inComponent:componentIndex animated:animated];
}

- (void)setIndicesAnimated:(BOOL)animated {
    for (NSUInteger componentIndex = 0; componentIndex < NUM_COMPONENTS; componentIndex++) {
        [self setIndexForComponentIndex:componentIndex animated:animated];
    }
}

- (SBDatePickerComponent)componentForIndex:(NSInteger)componentIndex {
    return _components[componentIndex];
}

- (NSCalendarUnit)unitForComponent:(SBDatePickerComponent)component {
    if (component == kSBDatePickerYear) {
        return NSYearCalendarUnit;
    }
    else if (component == kSBDatePickerMonth) {
        return NSMonthCalendarUnit;
    }
    else if (component == kSBDatePickerDay) {
        return NSDayCalendarUnit;
    }
    else {
        assert(NO);
    }
}

- (NSRange)rangeForComponent:(SBDatePickerComponent)component {
    NSCalendarUnit unit = [self unitForComponent:component];
    
    return [self.calendar maximumRangeOfUnit:unit];
}

#pragma mark - Data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)componentIndex {
    return INT16_MAX;
}

#pragma mark - Delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)componentIndex {
    SBDatePickerComponent component = [self componentForIndex:componentIndex];
    
    if (component == kSBDatePickerYear) {
       // CGSize size = [@"0000" sizeWithAttributes:@{NSFontAttributeName : self.font}];
        CGSize size;
        if (IS_IOS7) {
            size = [@"0000" sizeWithAttributes:@{NSFontAttributeName : self.font}];
        } else {
            size = [@"0000" sizeWithFont:self.font];
        }

        return size.width + 25.0f;
    }
    else if (component == kSBDatePickerMonth) {
        CGFloat maxWidth = 0.0f;
        
        for (NSString *monthName in self.dateFormatter.monthSymbols) {
            CGFloat monthWidth;
            if (IS_IOS7) {
                monthWidth = [monthName sizeWithAttributes:@{NSFontAttributeName : self.font}].width;
            } else {
                monthWidth = [monthName sizeWithFont:self.font].width;
            }
            //CGFloat monthWidth = [monthName sizeWithAttributes:@{NSFontAttributeName : self.font}].width;
            
            maxWidth = MAX(monthWidth, maxWidth);
        }
        
        return maxWidth + 25.0f;
    }
    else if (component == kSBDatePickerDay) {
        //CGSize size = [@"00" sizeWithAttributes:@{NSFontAttributeName : self.font}];
        CGSize size;
        if (IS_IOS7) {
            size = [@"00" sizeWithAttributes:@{NSFontAttributeName : self.font}];
        } else {
            size = [@"00" sizeWithFont:self.font];
        }
        return size.width + 25.0f;
    }
    else {
        return 0.01f;
    }
}

- (NSString *)titleForRow:(NSInteger)row forComponent:(SBDatePickerComponent)component {
    NSRange unitRange = [self rangeForComponent:component];
    NSInteger value = unitRange.location + (row % unitRange.length);
    
    if (component == kSBDatePickerYear) {
        return [NSString stringWithFormat:@"%li", (long) value];
    }
    else if (component == kSBDatePickerMonth) {
        return [self.dateFormatter.monthSymbols objectAtIndex:(value - 1)];
    }
    else if (component == kSBDatePickerDay) {
        return [NSString stringWithFormat:@"%li", (long) value];
    }
    else {
        return @"";
    }
}

- (NSInteger)valueForRow:(NSInteger)row andComponent:(SBDatePickerComponent)component {
    NSRange unitRange = [self rangeForComponent:component];
    
    return (row % unitRange.length) + unitRange.location;
}

- (BOOL)isEnabledRow:(NSInteger)row forComponent:(NSInteger)componentIndex {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = self.currentDateComponents.year;
    dateComponents.month = self.currentDateComponents.month;
    dateComponents.day = self.currentDateComponents.day;
    
    SBDatePickerComponent component = [self componentForIndex:componentIndex];
    NSInteger value = [self valueForRow:row andComponent:component];
    
    if (component == kSBDatePickerYear) {
        dateComponents.year = value;
    }
    else if (component == kSBDatePickerMonth) {
        dateComponents.month = value;
    }
    else if (component == kSBDatePickerDay) {
        dateComponents.day = value;
    }
    
    NSDate *rowDate = [self.calendar dateFromComponents:dateComponents];
    
    if (self.minimumDate != nil && [self.minimumDate compare:rowDate] == NSOrderedDescending) {
        return NO;
    }
    else if (self.maximumDate != nil && [rowDate compare:self.maximumDate] == NSOrderedDescending) {
        return NO;
    }
    
    return YES;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)componentIndex reusingView:(UIView *)view {
    UILabel *label;
    
    if ([view isKindOfClass:[UILabel class]]) {
        label = (UILabel *) view;
    }
    else {
        label = [[UILabel alloc] init];
        label.font = self.font;
    }
    
    SBDatePickerComponent component = [self componentForIndex:componentIndex];
    NSString *title = [self titleForRow:row forComponent:component];
    
    UIColor *color;
    
    BOOL enabled = [self isEnabledRow:row forComponent:componentIndex];
    
    if (enabled) {
        color = [UIColor blackColor];
    }
    else {
        color = [UIColor colorWithWhite:0.0f alpha:0.5f];
    }

    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] init];
    [attributedTitle appendAttributedString:[[NSAttributedString alloc ]initWithString:title]];
    [attributedTitle addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0,title.length)];

    label.attributedText = attributedTitle;
    
    if (component == kSBDatePickerMonth) {
        label.textAlignment = NSTextAlignmentLeft;
    }
    else {
        label.textAlignment = NSTextAlignmentRight;
    }
    if (IS_IOS6) {
        label.textColor= [UIColor blackColor];
    }
    
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)componentIndex {
    SBDatePickerComponent component = [self componentForIndex:componentIndex];
    NSInteger value = [self valueForRow:row andComponent:component];
    
    if (component == kSBDatePickerYear) {
        self.currentDateComponents.year = value;
    }
    else if (component == kSBDatePickerMonth) {
        self.currentDateComponents.month = value;
    }
    else if (component == kSBDatePickerDay) {
        self.currentDateComponents.day = value;
    }
    else {
        assert(NO);
    }
    
    [self setIndexForComponentIndex:componentIndex animated:NO];
    
    NSDate *datePicked = self.date;
    
    if (self.minimumDate != nil && [datePicked compare:self.minimumDate] == NSOrderedAscending) {
        [self setDate:self.minimumDate animated:YES];
    }
    else if (self.maximumDate != nil && [datePicked compare:self.maximumDate] == NSOrderedDescending) {
        [self setDate:self.maximumDate animated:YES];
    }
    else {
        [self.picker reloadAllComponents];
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end