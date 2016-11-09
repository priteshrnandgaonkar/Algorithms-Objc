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

@end
