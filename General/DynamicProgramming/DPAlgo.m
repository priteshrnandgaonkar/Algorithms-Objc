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
//    Takes O(n) time and O(n) space
    
//    NSMutableArray<NSNumber *> *mutArray = @[].mutableCopy;
//    
//    for (NSUInteger i = 0; i < n; ++i) {
//        [mutArray addObject:@(0)];
//    }
//    mutArray[0] = @(1);
//    mutArray[1] = @(1);
//    
//    for (NSUInteger j = 2; j < n; ++j) {
//        mutArray[j] = @(mutArray[j - 1].integerValue + mutArray[j - 2].integerValue);
//    }
    
//    Takes O(n) time and O(1) space
    
    NSNumber *first = @(1);
    NSNumber *second = @(1);
    
    if (n == 1) {
        return first;
    }
    else if (n == 2) {
        return second;
    }
    NSNumber *temp = nil;
    for (NSUInteger j = 3; j < n; ++j) {
         temp = @(first.integerValue + second.integerValue);
        
        if (j % 2 == 0) {
            first = temp;
        }
        else {
            second = temp;
        }
    }
    
    return @(first.integerValue + second.integerValue);
}

+ (NSArray<NSNumber *> *)allPossibleValues:(NSString *)expr {
    return [self allPossibleValues:expr memo:@{}.mutableCopy];
}

+ (NSArray<NSNumber *> *)allPossibleValues:(NSString *)expr memo:(NSMutableDictionary<NSString *, NSArray<NSNumber *> *> *)dict {
    
    if(dict[expr]) {
        return dict[expr];
    }
    
    NSString *operator = nil;
    NSString *leftExpr = nil;
    NSString *rightExpr = nil;
    NSMutableArray *mutArray = @[].mutableCopy;

    for (NSUInteger i = 0; i < expr.length; ++i) {
        operator = [NSString stringWithFormat: @"%C", [expr characterAtIndex:i]];
        if ([self isOperator: operator]) {
            
            leftExpr = [expr substringToIndex:i];
            rightExpr = [expr substringFromIndex:i + 1];
            
            NSArray<NSNumber *> *leftValues = [self allPossibleValues:leftExpr memo:dict];
            NSArray *rightValues = [self allPossibleValues:rightExpr memo:dict];

            for (NSNumber *leftNum in leftValues) {
                for (NSNumber *rightNum in rightValues) {
                    [mutArray addObject:[self operateLeft:leftNum toRight:rightNum withOperator:operator]];
                }
            }
        }
    }
    if(mutArray.count == 0) {
        [mutArray addObject:expr];
    }
    
    NSArray *arr = [NSArray arrayWithArray:mutArray];
    dict[expr] = arr;
    
    return arr;
}

+ (NSNumber *)operateLeft:(NSNumber *)leftNum toRight:(NSNumber *)rightNum  withOperator:(NSString *)operator {
    NSNumber *resultNum = nil;
    if ([operator isEqualToString:@"+"]) {
        resultNum = @(leftNum.integerValue + rightNum.integerValue);
    }
    else if ([operator isEqualToString:@"-"]) {
        resultNum = @(leftNum.integerValue - rightNum.integerValue);
    }
    else if ([operator isEqualToString:@"*"]) {
        resultNum = @(leftNum.integerValue * rightNum.integerValue);
    }
    else if ([operator isEqualToString:@"/"]) {
        resultNum = @(leftNum.integerValue / rightNum.integerValue);
    }
    return resultNum;
}

+ (BOOL)isOperator:(NSString *)operator {
    BOOL isOperator = NO;
    
    if ([operator isEqualToString:@"+"]) {
        isOperator = YES;
    }
    else if ([operator isEqualToString:@"-"]) {
        isOperator = YES;

    }
    else if ([operator isEqualToString:@"*"]) {
        isOperator = YES;

    }
    else if ([operator isEqualToString:@"/"]) {
        isOperator = YES;
    }
    return isOperator;
}

+(NSUInteger)maximumIncreasingSubSequence:(NSArray<NSNumber *> *)arr {
    return [self maximumIncreasingSubSequence:arr dict: @{}.mutableCopy history:@[].mutableCopy];
}

+ (NSArray<NSNumber *> *)longestIncreasingSubSequence:(NSArray<NSNumber *> *)arr {
    
    NSMutableArray<NSNumber *> *mutArray = @[].mutableCopy;
    NSMutableDictionary<NSNumber *, NSNumber *> *mutDict = @{}.mutableCopy;
    
    NSUInteger count = [self maximumIncreasingSubSequence:arr dict:mutDict history:mutArray];
    
    NSNumber *max = @(count);
    NSUInteger maxIndex = [mutArray indexOfObject:max];
    
    NSMutableArray<NSNumber *> *subSeq = @[].mutableCopy;
    
    for (NSUInteger i = 0; i < max.integerValue; ++i) {
        [subSeq addObject:arr[maxIndex]];
        maxIndex = mutDict[@(maxIndex)].integerValue;
    }
    return [NSArray arrayWithArray:subSeq];
}

+ (NSUInteger)maximumIncreasingSubSequence:(NSArray<NSNumber *> *)arr dict:(NSMutableDictionary<NSNumber *, NSNumber *> *)dict history:(NSMutableArray<NSNumber *> *)history {
    
    for (NSNumber *num in arr) {
        [history addObject:@(1)];
    }
    
    NSUInteger max = 1;
    NSUInteger index = NSNotFound;
    for (NSUInteger i = 1; i < arr.count; ++i) {
        max = 0;
        index = i;
        for (NSUInteger j = 0; j < i; ++j) {
            if (arr[i].integerValue > arr[j].integerValue) {
                if(max < history[j].integerValue) {
                    max = history[j].integerValue;
                    index = j;
                }
            }
        }
        
        dict[@(i)] = @(index);
        history[i] = @(max + 1);
    }
    NSNumber *maxInArray = [self maxInArray:history];
    
    return maxInArray.integerValue;
}

+ (NSNumber *)maxInArray:(NSArray<NSNumber *> *)arr {
    NSNumber *maxNum = @(0);
    
    for (NSNumber *num in arr) {
        if ([maxNum compare:num] == NSOrderedAscending) {
            maxNum = num;
        }
    }
    
    return maxNum;
}

@end
