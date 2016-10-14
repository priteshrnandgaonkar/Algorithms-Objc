//
//  Sorting.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 9/30/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Sorting : NSObject

//Complexity O(n2) = 1+2+3+4.....n, Space-Compexity O(n)
+ (NSArray<NSNumber *> *)insertionSortOnArray:(NSArray<NSNumber *> *)array;

//Complexity O(n2) = 1+2+3+4.....n , Space-Compexity O(1)
+ (NSMutableArray<NSNumber *> *)inPlaceinsertionSortOnArray:(NSMutableArray<NSNumber *> *)array;

//Complexity Theta(nlogn), Space-Compexity O(n)
+ (NSArray<NSNumber *> *)mergeSortOnArray:(NSArray<NSNumber *> *)array;

//Complexity Theta(nlogn), Space-Compexity O(1)
+ (NSArray<NSNumber *> *)mergeSortWithLessSpaceOnArray:(NSArray<NSNumber *> *)array;

//Complexity O(nlogn), Space-Compexity O(1)
+ (void)quickSortOnArray:(NSMutableArray<NSNumber *> *)array withStartIndex:(NSUInteger)startIndex endIndex:(NSUInteger)endIndex;

+ (NSUInteger)modifyArray:(NSMutableArray<NSNumber *> *)array withStartIndex:(NSUInteger)startIndex endIndex:(NSUInteger)endIndex;

+ (NSArray<NSNumber *> *)countingSortOnArray:(NSArray<NSNumber *> *)array numbersLessThan:(NSUInteger)k;

// Given n d-digit numbers in which each digit can take on up to k possible values, Complexity:- Theta(d(n+k))
// When d is constant and k = O(n), radix sort runs in linear time
+ (NSArray<NSNumber *> *)radixSortOn:(NSArray<NSNumber *> *)array;

+ (NSNumber *)nthSmallestNumberinArray:(NSArray<NSNumber *> *)array n:(NSUInteger)n;

+ (void)selectionSort:(NSMutableArray<NSNumber *> *)mutArray;
@end



