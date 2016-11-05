//
//  DPAlgo.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 11/5/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "DPAlgo.h"

@implementation DPAlgo

+ (NSNumber  *)nthFibonacciNumber:(NSUInteger)n {
    NSMutableArray<NSNumber *> *mutArray = @[].mutableCopy;
    
    for (NSUInteger i = 0; i < n; ++i) {
        [mutArray addObject:@(0)];
    }
    mutArray[0] = @(1);
    mutArray[1] = @(1);
    
    for (NSUInteger j = 2; j < n; ++j) {
        mutArray[j] = @(mutArray[j - 1].integerValue + mutArray[j - 2].integerValue);
    }
    return mutArray[n-1];
}

@end
