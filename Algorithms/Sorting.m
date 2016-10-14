//
//  Sorting.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 9/30/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "Sorting.h"

@implementation Sorting

+ (NSArray<NSNumber *> *)insertionSortOnArray:(NSArray<NSNumber *> *)array {
    
    NSMutableArray<NSNumber *> *sortedArray = @[].mutableCopy;
    
    for(NSNumber *num in array) {
        
        NSUInteger index = 0;
        for(NSNumber *sortedNum in sortedArray) {
            if(num.integerValue <= sortedNum.integerValue) {
                break;
            }
            index++;
        }
        [sortedArray insertObject:num atIndex:index];
    }
    
    
    return [NSArray arrayWithArray:sortedArray];
}

+ (NSMutableArray<NSNumber *> *)inPlaceinsertionSortOnArray:(NSMutableArray<NSNumber *> *)array {
    
    for(NSUInteger index = 1; index < array.count; index++) {
        for(NSUInteger sortedIndex = 0; sortedIndex < index; sortedIndex++) {
            if(array[index].integerValue < array[sortedIndex].integerValue) {
                NSNumber *num1 = array[sortedIndex];
                array[sortedIndex] = array[index];
                array[index] = num1;
                break;
            }
        }
    }
    return array;
}

+ (NSArray<NSNumber *> *)mergeSortOnArray:(NSArray<NSNumber *> *)array {
    NSUInteger count = array.count;
    if(count == 1) {
        return array;
    }
    
    NSUInteger mid = array.count / 2;
    
    NSArray<NSNumber *> *leftArray = [array subarrayWithRange:NSMakeRange(0, mid)];
    NSArray<NSNumber *> *rightArray = [array subarrayWithRange:NSMakeRange(mid, count - mid)];

    NSArray<NSNumber *> *leftSorted = [Sorting mergeSortOnArray: leftArray];

    NSArray<NSNumber *> *rightSorted = [Sorting mergeSortOnArray: rightArray];

    NSMutableArray<NSNumber *> *result = @[].mutableCopy;
    
    NSUInteger leftIndex = 0;
    NSUInteger rightIndex = 0;
    
    while ((leftIndex < leftSorted.count) && (rightIndex < rightSorted.count)){
        
        if(leftSorted[leftIndex].integerValue < rightSorted[rightIndex].integerValue) {
            [result addObject:leftSorted[leftIndex]];
            leftIndex++;
        }
        else {
            [result addObject:rightSorted[rightIndex]];
            rightIndex++;
        }
    }
    
    while(leftIndex < leftSorted.count) {
        [result addObject:leftSorted[leftIndex]];
        leftIndex++;
    }
    
    while(rightIndex < rightSorted.count) {
        [result addObject:rightSorted[rightIndex]];
        rightIndex++;
    }
    return result;
}
+ (NSArray<NSNumber *> *)mergeSortWithLessSpaceOnArray:(NSArray<NSNumber *> *)array {
    NSMutableArray *mutArray = array.mutableCopy;
     [Sorting mergeSortWithLessSpaceOnArray:mutArray atStartIndex:0 endIndex:array.count - 1];
    return [NSArray arrayWithArray:mutArray];
}

+ (void)mergeSortWithLessSpaceOnArray:(NSMutableArray<NSNumber *> *)array atStartIndex:(NSUInteger)startIndex endIndex:(NSUInteger)endIndex {
    
    if(startIndex >= endIndex) {
        return;
    }
    
    NSUInteger mid = startIndex + ((endIndex - startIndex) / 2);
    //Left
    [Sorting mergeSortWithLessSpaceOnArray:array atStartIndex:startIndex endIndex:mid];
    
    //Right
    [Sorting mergeSortWithLessSpaceOnArray:array atStartIndex:mid + 1 endIndex:endIndex];
    
    NSUInteger leftIndex = startIndex;
    NSUInteger rightIndex = mid + 1;
    while(leftIndex < rightIndex && leftIndex < endIndex && rightIndex < endIndex) {
        if(array[leftIndex].integerValue >= array[rightIndex].integerValue) {
            NSNumber *rightNum = array[rightIndex];
            [array removeObjectAtIndex:rightIndex];
            [array insertObject:rightNum atIndex:leftIndex];

            rightIndex++;
        }
        leftIndex++;
    }
}

+ (void)quickSortOnArray:(NSMutableArray<NSNumber *> *)array withStartIndex:(NSUInteger)startIndex endIndex:(NSUInteger)endIndex {
    if(startIndex >= endIndex) {
        return;
    }
    NSUInteger pivot = [Sorting modifyArray:array withStartIndex:startIndex endIndex:endIndex];
    Log(@"StartIndex = %lu, pivot = %lu, endIndex = %lu", startIndex, pivot, endIndex);
    Log(@"ARRAY = %@", array);
    if(pivot >= 1) {
        [Sorting quickSortOnArray:array withStartIndex:startIndex endIndex:pivot-1];
    }
    if(pivot + 1 <= endIndex) {
        [Sorting quickSortOnArray:array withStartIndex:pivot + 1 endIndex:endIndex];
    }
}

+ (NSUInteger)modifyArray:(NSMutableArray<NSNumber *> *)array withStartIndex:(NSUInteger)startIndex endIndex:(NSUInteger)endIndex {
    NSUInteger pivotValue = array[endIndex].integerValue;
    NSUInteger index = startIndex;
    
    for(NSUInteger j = startIndex; j <= endIndex ; ++j) {
        if(j == endIndex) {
            [array insertObject:@(pivotValue) atIndex:index];
            [array removeObjectAtIndex:endIndex + 1];
            break;
        }
        if(array[j].integerValue < pivotValue) {
            [array insertObject:array[j] atIndex:index];
            [array removeObjectAtIndex:j+1];
            index++;
        }
    }
    return index;
}

+ (NSArray<NSNumber *> *)countingSortOnArray:(NSArray<NSNumber *> *)array numbersLessThan:(NSUInteger)k {
    
    NSMutableArray<NSNumber *> *countArray = @[].mutableCopy;
    for(NSUInteger i = 0; i <= k; ++i) {
        [countArray addObject:@(0)];
    }
    
    NSMutableArray<NSNumber *> *resultArray = @[].mutableCopy;
    
    for(NSNumber *num in array) {
        [resultArray addObject:@(0)];
        countArray[num.integerValue] = @(countArray[num.integerValue].integerValue + 1);
    }

    for(NSUInteger i = 1; i <= k; ++i) {
        countArray[i] = @(countArray[i].integerValue + countArray[i-1].integerValue);
    }
    Log(@"counting array, %@",countArray);

    for(NSNumber *num in array.reverseObjectEnumerator) {
        resultArray[countArray[num.integerValue].integerValue] = num;
        countArray[num.integerValue] = @(countArray[num.integerValue].integerValue - 1);
    }
    [resultArray removeObjectAtIndex:0];
    return [NSArray arrayWithArray:resultArray];
}

+ (NSArray<NSNumber *> *)radixSortOn:(NSArray<NSNumber *> *)array {
    
    //Find maximum
    NSUInteger max = array[0].integerValue;
    for(NSNumber *num in array) {
        if(num.integerValue > max) {
            max = num.integerValue;
        }
    }
    
    NSUInteger numOfDigits = floor(log(max)) + 1;
    NSArray<NSNumber *> *intermediateArray = array;
    for(NSUInteger i = 0; i < numOfDigits; ++i) {
        intermediateArray = [Sorting sortArray:intermediateArray basedOnDigitNum:i];
    }
    return intermediateArray;
}

+ (NSArray<NSNumber *> *)sortArray:(NSArray<NSNumber *> *)mutArray basedOnDigitNum:(NSUInteger)digitNum {
    NSMutableArray<NSNumber *> *countArray = @[].mutableCopy;
    NSMutableArray<NSNumber *> *resultArray = @[].mutableCopy;

    for(NSUInteger i = 0; i < 10; ++i) {
        [countArray addObject:@(0)];
    }

    for(NSUInteger i = 0; i < mutArray.count; ++i) {
        [resultArray addObject:@(0)];
        NSUInteger digit = (int)(mutArray[i].integerValue / pow(10, digitNum)) % 10;
        countArray[digit] = @(countArray[digit].integerValue + 1);
    }

    for(NSUInteger i = 1; i < 10; ++i) {
        countArray[i] = @(countArray[i-1].integerValue + countArray[i].integerValue);
    }
    
    for(NSInteger j = mutArray.count - 1; j >= 0; --j) {
        NSUInteger digit = (int)(mutArray[j].integerValue / pow(10, digitNum)) % 10;
        resultArray[countArray[digit].integerValue] = mutArray[j];
        countArray[digit] = @(countArray[digit].integerValue - 1);
    }
    [resultArray removeObjectAtIndex:0];
    return resultArray;
}

+ (void)selectionSort:(NSMutableArray<NSNumber *> *)mutArray {
    
    for(NSUInteger start = 0; start < mutArray.count; ++start) {
        Log(@"Inter Selection Sort = %@", mutArray);

        NSInteger max = mutArray[start].integerValue;
        NSInteger maxIndex = start;
        for(NSUInteger i = start + 1; i < mutArray.count; ++i) {
            if(mutArray[i].integerValue > max) {
                max = mutArray[i].integerValue;
                maxIndex = i;
            }
        }

        [mutArray insertObject:mutArray[maxIndex] atIndex: 0];
        [mutArray removeObjectAtIndex:maxIndex + 1];
    }
    
}

@end
