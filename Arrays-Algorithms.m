//
//  Arrays-Algorithms.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/5/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "Arrays-Algorithms.h"

@implementation Arrays_Algorithms

+ (NSArray<NSNumber *> *)permuteArray:(NSArray<NSNumber *> *)array {
    
    NSMutableArray *mArray = array.mutableCopy;
    NSUInteger count = array.count;
    NSUInteger maxIntegerForRandom = pow(count, 3);
    NSMutableArray<NSNumber *> *mutArray = @[].mutableCopy;
    for(NSNumber *num in array) {
        NSInteger n = (NSInteger)(arc4random_uniform(maxIntegerForRandom));
        [mutArray addObject:@(n)];
    }
    Log(@"Priority Array = %@", mutArray);
    [Arrays_Algorithms sortArray1:mArray basedOnArray2:mutArray withStartIndex:0 andEndIndex:array.count - 1];
    return [NSArray arrayWithArray:mArray];
}

+ (void)sortArray1:(NSMutableArray<NSNumber *> *)array1 basedOnArray2:(NSMutableArray<NSNumber *> *)array2 withStartIndex:(NSUInteger)startIndex andEndIndex:(NSUInteger)endIndex {
    NSUInteger mid = startIndex + (endIndex - startIndex) / 2;
    
    if(startIndex >= endIndex) {
        return;
    }
    
    [Arrays_Algorithms sortArray1:array1 basedOnArray2:array2 withStartIndex:startIndex andEndIndex:mid];
    [Arrays_Algorithms sortArray1:array1 basedOnArray2:array2 withStartIndex:mid + 1 andEndIndex:endIndex];
    
    NSUInteger leftIndex = startIndex;
    NSUInteger rightIndex = mid + 1;
    while(leftIndex < rightIndex && leftIndex <= endIndex && rightIndex <= endIndex) {
        if(array2[rightIndex].integerValue < array2[leftIndex].integerValue) {
            
            [array2 insertObject:array2[rightIndex] atIndex:leftIndex];
            [array2 removeObjectAtIndex:rightIndex + 1];
            
            [array1 insertObject:array1[rightIndex] atIndex:leftIndex];
            [array1 removeObjectAtIndex:rightIndex + 1];
            
            rightIndex++;
        }
        leftIndex++;
    }
}

+ (NSNumber *)ithSmallestNumberinArray:(NSMutableArray<NSNumber *> *)array fori:(NSUInteger)idx withStartIndex:(NSUInteger)startIndex andEndIndex:(NSUInteger)endIndex {
    
    NSUInteger pivot = startIndex + (NSUInteger)arc4random_uniform((uint32_t)(endIndex - startIndex + 1));
    NSNumber *pivotValue = array[pivot];
    array[pivot] = array[endIndex];
    array[endIndex] = pivotValue;
    
    NSUInteger index = startIndex;
    NSUInteger currentIndex = startIndex;
    while(currentIndex <= endIndex) {
        if(currentIndex == endIndex){
            [array insertObject:array[endIndex] atIndex:index];
            [array removeObjectAtIndex:endIndex + 1];
            break;
        }
        if(array[currentIndex] < array[endIndex]) {
            NSNumber *temp = array[currentIndex];
            [array insertObject:temp atIndex:index];
            [array removeObjectAtIndex:currentIndex + 1];
            index++;
        }
        currentIndex++;
    }
    
    NSUInteger lowerPartitionCount = index - startIndex + 1;
    if(lowerPartitionCount == idx) {
        return array[index];
    }
    else if(idx < lowerPartitionCount) {
        return [Arrays_Algorithms ithSmallestNumberinArray:array fori:idx withStartIndex:startIndex andEndIndex: index - 1];
    }
    else {
        return [Arrays_Algorithms ithSmallestNumberinArray:array fori:idx - lowerPartitionCount withStartIndex:index + 1 andEndIndex: endIndex];
    }
}

@end
