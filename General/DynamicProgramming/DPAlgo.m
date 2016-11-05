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

@end
