//
//  CareerCupAlgorithms.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/8/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "CareerCupAlgorithms.h"

@implementation CareerCupAlgorithms

+ (void)squareAndSortArray:(NSMutableArray<NSNumber *> *)array {
    
    __block NSUInteger negativeEndingIndex = NSNotFound;
    
    [array enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.integerValue > 0){
            return;
        }
        negativeEndingIndex = idx;
    }];
    
    negativeEndingIndex = negativeEndingIndex == NSNotFound ? 0 : negativeEndingIndex;
    
    for(NSUInteger i = 0; i < array.count; ++i) {
        NSNumber *num = array[i];
        array[i] = @(num.integerValue * num.integerValue);
    }
    
    NSUInteger leftIndex = 0;
    NSUInteger rightIndex = negativeEndingIndex;
    
    while(leftIndex < rightIndex) {
        NSNumber *left = array[leftIndex];
        array[leftIndex] = array[rightIndex];
        array[rightIndex] = left;
        leftIndex++;
        rightIndex--;
    }
    
    leftIndex = 0;
    rightIndex = negativeEndingIndex + 1;
    while(leftIndex < rightIndex && leftIndex < array.count && rightIndex < array.count) {
        if(array[leftIndex] > array[rightIndex]) {
            NSNumber *right = array[rightIndex];
            [array insertObject:right atIndex:leftIndex];
            [array removeObjectAtIndex:rightIndex + 1];
            rightIndex++;
        }
        leftIndex++;
    }
}

+ (BOOL)doesThereExistSubsequenceInArray:(NSArray<NSNumber *> *)array withSum:(NSInteger)sum {
    NSUInteger leftIndex = 0;
    NSUInteger rightIndex = 0;
    while(leftIndex <= rightIndex && leftIndex < array.count && rightIndex < array.count && sum != 0) {
        Log(@"Left = %lu, Right = %lu, sum = %lu", leftIndex, rightIndex, sum);
        if(array[rightIndex].integerValue <= sum && leftIndex <= rightIndex){
            sum = sum - array[rightIndex].integerValue;
            rightIndex++;
        }
        else if(array[rightIndex].integerValue > sum && leftIndex < rightIndex){
            sum = sum + array[leftIndex].integerValue;
            leftIndex++;
        }
        else if(array[rightIndex].integerValue > sum && leftIndex == rightIndex) {
            leftIndex++;
            rightIndex++;
        }
    }
    
    return sum == 0;
}

+ (void)doubleGraphTraversalWithAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat root:(NSUInteger)i {
    
    NSMutableArray<NSNumber *> *visited = @[].mutableCopy;
    NSMutableArray<NSNumber *> *depth = @[].mutableCopy;

    for(NSUInteger j = 0; j < mat.count; ++j) {
        visited[j] = @(NO);
        depth[j] = @(0);
    }
    
    [[self class] doubleGraphTraversalWithAdjacencyMatrix:mat root:i visited:visited depth:depth];
}

+ (void)doubleGraphTraversalWithAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat root:(NSUInteger)i visited:(NSMutableArray<NSNumber *> *)visited depth:(NSMutableArray<NSNumber *> *)depth {
    Log(@"%lu", i);

    visited[i] = @(YES);
    
    for(NSUInteger idx = 0; idx < mat.count; ++idx) {
        
        if([mat[i][idx] isEqualToNumber:@(YES)] && !(visited[idx].boolValue)) {
            depth[idx] = @(depth[i].integerValue + 1);

            [[self class] doubleGraphTraversalWithAdjacencyMatrix:mat root:idx visited:visited depth:depth];
            Log(@"%lu", i);
        }
        else if(depth[idx] > depth[i] && [mat[i][idx] isEqualToNumber:@(YES)]) {
            Log(@"%lu", idx);
            Log(@"%lu", i);
        }
    }
}

@end
