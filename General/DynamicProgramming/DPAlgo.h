//
//  DPAlgo.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 11/5/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPAlgo : NSObject

+ (NSNumber  *)nthFibonacciNumber:(NSUInteger)n;

+ (NSArray<NSNumber *> *)allPossibleValues:(NSString *)expr;

+ (NSUInteger)maximumIncreasingSubSequence:(NSArray<NSNumber *> *)arr;

+ (NSUInteger)maximumIncreasingSubSequence:(NSArray<NSNumber *> *)arr dict:(NSMutableDictionary<NSNumber *, NSNumber *> *)dict;

+ (NSArray<NSNumber *> *)longestIncreasingSubSequence:(NSArray<NSNumber *> *)arr;
@end
