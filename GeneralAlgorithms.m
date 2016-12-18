//
//  GeneralAlgorithms.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 11/9/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "GeneralAlgorithms.h"

@implementation PNInterval

- (instancetype)init {
    self = [super init];
    if (self) {
        _start = nil;
        _end = nil;
    }
    return self;
}

- (instancetype)initWithStart:(NSNumber *)start end:(NSNumber *)end {
    self = [super init];
    
    if (self) {
        _start = start;
        _end = end;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"start: %@, end: %@", self.start, self.end];
}

@end

@implementation GeneralAlgorithms

+ (NSUInteger)numberOfSetBits:(NSUInteger)num {
    
    NSUInteger numOfBits = ceil(log(num)) + 1;
    NSUInteger count = 0;
    
    NSUInteger temp = 1;
    for (NSUInteger i = 0; i < numOfBits; ++i) {
        count += (num & temp << i) > 0;
    }
    return count;
}

+ (void)mergeIntervals:(NSMutableArray<PNInterval *> *)intervals {
    [intervals sortUsingComparator:^NSComparisonResult(PNInterval *  _Nonnull obj1, PNInterval *  _Nonnull obj2) {
        return [obj1.start compare: obj2.start];
    }];
    
    for (NSUInteger i = 1; i < intervals.count; ++i) {
        if ([intervals[i - 1].end compare: intervals[i].start] == NSOrderedDescending) {
            //OVERLAP
            if ([intervals[i - 1].end compare: intervals[i].end] == NSOrderedAscending) {
                intervals[i - 1].end = intervals[i].end;
            }
            else {
                intervals[i] = intervals[i - 1];
            }
        }
    }
    
    [self removeSubIntervals:intervals];
    
}

+ (void)removeSubIntervals:(NSMutableArray<PNInterval *> *)intervals {
    NSUInteger index = 1;
    while (index < intervals.count) {
        if ([intervals[index].end compare: intervals[index - 1].end] == NSOrderedSame) {
            [intervals removeObjectAtIndex: index];
        }
        else {
            index++;
        }
    }
}

+ (NSArray<NSArray<NSString *> *> *)powerSet:(NSArray<NSString *> *)values {
    // Iterative
    NSUInteger count = values.count;
    NSMutableArray<NSArray<NSString *> *> *mutArray = @[].mutableCopy;
    
    for (NSUInteger i = 0; i < pow(2, count); ++i) {
        [mutArray addObject:[self arrayForNumber:i inValues:values]];
    }
    return [NSArray arrayWithArray: mutArray];
}

+ (NSArray<NSString *> *)arrayForNumber:(NSUInteger)i inValues:(NSArray<NSString *> *)values {

    NSMutableArray<NSString *> *mutArray = @[].mutableCopy;
    NSUInteger count = values.count;
    NSUInteger temp = 1;
    
    while (temp <= pow(2, count) - 1) {
        if ((temp & i) != 0) {
            [mutArray addObject: values[(NSUInteger)ceil(log(temp))]];
        }
        temp = temp << 1;
    }
    
    return [NSArray arrayWithArray: mutArray];
}

+ (BOOL)isNumberChar:(NSString *)alphabetString {
    
    BOOL result = NO;
    if([alphabetString isEqualToString:@"0"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"1"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"2"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"3"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"4"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"5"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"6"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"7"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"8"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"9"]) {
        result = YES;
    }
    return result;
}

+ (BOOL)checkPatternOnString:(NSString *)str pattern:(NSString *)pattern {
    
    NSInteger stringIndex = 0;
    BOOL isNumber = YES;
    NSInteger count = 0;
    
    BOOL result = YES;
    
    for(NSInteger patternIndex = 0; patternIndex < pattern.length; ++patternIndex) {
        
        unichar alphabetChar = [pattern characterAtIndex:patternIndex];
        NSString *alphabet = [NSString stringWithCharacters:&alphabetChar length:1];
        isNumber = [self isNumberChar: alphabet];
        
        if (isNumber) {
            count = (count * 10) + alphabet.intValue;
        }
        else {
            
            if (count > 0) {
                stringIndex += count;
            }
            if(stringIndex >= str.length || alphabetChar != [str characterAtIndex: stringIndex]) {
                result = NO;
                break;
            }
            stringIndex++;
            count = 0;
        }
    }
    
    if (count > 0 && count != str.length - stringIndex) {
        result = NO;
    }
    
    return result;
}

+ (NSArray<NSNumber *> *)binaryRepresentationOfNumber:(NSNumber *)num {
    NSMutableArray<NSNumber *> *mutArray = @[].mutableCopy;
    
    NSMutableArray<NSNumber *> *resultArray = @[].mutableCopy;

    NSInteger temp = num.integerValue;
    while(temp > 0) {
        [mutArray addObject:@(temp % 2)];
        temp = temp / 2;
    }
    
    for (num in mutArray.reverseObjectEnumerator) {
        [resultArray addObject:num];
    }
    
    return [NSArray arrayWithArray:resultArray];
}

@end
